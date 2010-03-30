@echo off

rem nomake script for EPS figures
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

if "%bmtoeps%"==""  set bmtoeps=sam2p
if "%e2e%"==""      set e2e=eps2eps
if "%epstool%"==""  set epstool=epstool
if "%epstopdf%"=="" set epstopdf=epstopdf
if "%gs%"==""       set gs=gswin32c

if "%e2eflags%"=="" set e2eflags=-dSAFER -dNOCACHE
if "%etflags%"==""  set etflags=--quiet --copy --bbox
if "%res%"==""      set res=600

if "%bmtoepsfiles%"=="" set bmtoepsfiles==*.jpg *.png *.tif
if "%e2pfiles%"==""     set e2pfiles=*.eps
if "%fbbfiles%"==""     set fbbfiles=*.eps
if "%figclfiles%"==""   set figclfiles=*.pdf *.jpg *.png *.tif
if "%optfiles%"==""     set optfiles=*.eps
if "%pdf2pngfiles%"=="" set pdf2pngfiles=*.pdf
if "%pdf2tiffiles%"=="" set pdf2tiffiles=*.pdf
if "%prefix%"==""       set prefix=~


if "%1"=="" (
	call :help
) else (
	for %%f in (%*) do call :%%f
)

exit /b

:help
	echo   bmtoeps      convert bitmap images to EPS format
	echo   clean        remove output files
	echo   epstoeps     alias for optimize target
	echo   epstopdf     convert EPS to PDF
	echo   fixbb        fix BoundingBox of EPS files
	echo   help         show description of targets
	echo   optimize     optimize EPS files ^(implies fixbb^)
	echo   pdftopng256  convert PDF to PNG ^(256-color^)
	echo   pdftotiffg4  convert PDF to TIFF ^(b/w CCITT Group 4^)
goto :eof

:bmtoeps
	for %%f in (!bmtoepsfiles!) do (
		if not exist "%%~nf.eps" (
			%bmtoeps% %bmtoepsflags% "%%f" "%%~nf.eps" > nul 2>&1
			echo bmtoeps: %%f
		)
	)
goto :eof

:clean
	del /s !figclfiles!
goto :eof

:epstoeps
	call :optimize
goto :eof

:epstopdf
	for %%f in (!e2pfiles!) do (
		call :cmptimes %%~nf.pdf %%f
		if !_ctres!==1 (
			%epstopdf% "%%f"
			echo epstopdf: %%f
		)
	)
goto :eof

:fixbb
	for %%f in (!fbbfiles!) do (
		%epstool% %etflags% "%%f" "%prefix%%%f"
		move "%prefix%%%f" "%%f" > nul
		echo fixbb: %%f
	)
goto :eof

:optimize
	for %%f in (!optfiles!) do (
		%e2e% %e2eflags% "%%f" "%prefix%%%f"
		%epstool% %etflags% "%prefix%%%f" "%prefix%1%%f"
		move "%prefix%1%%f" "%prefix%%%f" > nul
		call :cmpsizes "%%f" "%prefix%%%f"
		if !_csres!==1 (
			move "%prefix%%%f" "%%f" > nul
			echo optimize: %%f
		) else (
			del /q "%prefix%%%f"
			echo optimize: %%f does not need optimization
		)
	)
goto :eof

:pdftopng256
	for %%f in (!pdf2pngfiles!) do (
		call :cmptimes "%%~nf.png" "%%f"
		if !_ctres!==1 (
			%gs% -sDEVICE=png256 -r%res% -q -sOutputFile=%%~nf.png -dNOPAUSE ^
				-dBATCH -dSAFER "%%f"
			echo pdftopng256: %%f
		)
	)
goto :eof

:pdftotiffg4
	for %%f in (!pdf2tiffiles!) do (
		call :cmptimes "%%~nf.tif" "%%f"
		if !_ctres!==1 (
			%gs% -sDEVICE=tiffg4 -r%res% -q -sOutputFile=%%~nf.tif -dNOPAUSE ^
				-dBATCH -dSAFER "%%f"
			echo pdftotiffg4: %%f
		)
	)
goto :eof

:cmptimes
	set _ctfiles=%*
	set _ctoutf=%~1
	if not exist %_ctoutf% (
		set _ctres=1
		goto :eof
	)
	for /f "usebackq" %%f in (`dir /b /t:w /o:-d %_ctfiles%`) do (
		set _ctnewest=%%f
		goto :_ctbreak
	)
	:_ctbreak

	if "%_ctoutf%"=="%_ctnewest%" (
		set _ctres=0
	) else (
		set _ctres=1
	)
goto :eof

:cmpsizes
	if %~z1 GTR %~z2 (
		set _csres=1
	) else (
		set _csres=0
	)
goto :eof
