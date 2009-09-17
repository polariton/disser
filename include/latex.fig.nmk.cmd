@echo off

rem nomake script for EPS figures
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%bmtoeps%"=="" set bmtoeps=sam2p
if "%e2e%"=="" set e2e=eps2eps
if "%epstool%"=="" set epstool=epstool
if "%epstopdf%"=="" set epstopdf=epstopdf
if "%gs%"=="" set gs=gswin32c

if "%e2eflags%"=="" set e2eflags=-dSAFER
if "%etflags%"=="" set etflags=--quiet --copy --bbox
if "%res%"=="" set res=600

if "%bmtoepsfiles%"=="" set bmtoepsfiles==*.jpg *.png *.tif
if "%e2efiles%"=="" set e2efiles=*.eps
if "%e2pfiles%"=="" set e2pfiles=*.eps
if "%pdf2pngfiles%"=="" set pdf2pngfiles=*.pdf
if "%pdf2tiffiles%"=="" set pdf2tiffiles=*.pdf
if "%fbbfiles%"=="" set fbbfiles=*.eps
if "%figclfiles%"=="" set figclfiles=*.pdf *.jpg *.png *.tif
if "%suffix%"=="" set suffix=~

rem end of configuration

setlocal enabledelayedexpansion

if "%1"=="" (
:default
	call :help
goto :eof
) else if "%1"=="help" (
:help
	echo   bmtoeps      convert bitmap images to EPS format
	echo   clean        clean converted files
	echo   epstoeps     optimize EPS files using Ghostscript
	echo   epstopdf     convert EPS to PDF
	echo   fixbb        fix BoundingBox of EPS files
	echo   help         ^(default^) show description of targets
	echo   pdftopng256  convert PDF to PNG ^(256-color^)
	echo   pdftotiffg4  convert PDF to TIFF ^(b/w CCITT Group 4^)
goto :eof
) else if "%1"=="bmtoeps" (
:bmtoeps
	for %%f in (!bmtoepsfiles!) do (
		if not exist "%%~nf.eps" (
			%bmtoeps% %bmtoepsflags% "%%f" "%%~nf.eps" > nul 2>&1
			echo bmtoeps: %%f
		)
	)

goto :eof	
) else if "%1"=="clean" (
:clean
	del /s %figclfiles%
goto :eof
) else if "%1"=="epstoeps" (
:epstoeps
	for %%f in (!e2efiles!) do (
		%e2e% %e2eflags% "%%f" "%%f%suffix%"
		move "%%f%suffix%" "%%f" > nul
		echo epstoeps: %%f
	)
goto :eof
) else if "%1"=="epstopdf" (
:epstopdf
	for %%f in (!e2pfiles!) do (
		if not exist "%%~nf.pdf" (
			%epstopdf% "%%f"
			echo epstopdf: %%f
		)
	)
goto :eof	
) else if "%1"=="fixbb" (
:fixbb
	for %%f in (!fbbfiles!) do (
		%epstool% %etflags% "%%f" "%%f%suffix%"
		move "%%f%suffix%" "%%f" > nul
		echo fixbb: %%f
	)
goto :eof
) else if "%1"=="pdftopng256" (
:pdftopng256
	if "%2" neq "" set pdf2pngfiles=%2 %3 %4 %5 %6 %7 %8 %9
	for %%f in (!pdf2pngfiles!) do (
		if not exist "%%~nf.png" (
			%gs% -sDEVICE=png256 -r%res% -q -sOutputFile=%%~nf.png -dNOPAUSE -dBATCH -dSAFER "%%f"
			echo pdftopng256: %%f
		)
	)
goto :eof	
) else if "%1"=="pdftotiffg4" (
:pdftotiffg4
	if "%2" neq "" set pdf2tiffiles=%2 %3 %4 %5 %6 %7 %8 %9
	for %%f in (!pdf2tiffiles!) do (
		if not exist "%%~nf.tif" (
			%gs% -sDEVICE=tiffg4 -r%res% -q -sOutputFile=%%~nf.tif -dNOPAUSE -dBATCH -dSAFER "%%f"
			echo pdftotiffg4: %%f
		)
	)
goto :eof	
) else (
	echo Don't know how to make %1
)
