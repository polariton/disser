@echo off

rem nomake script for EPS figures
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%e2e%"=="" set e2e=eps2eps
if "%epstool%"=="" set epstool=epstool
if "%epstopdf%"=="" set epstopdf=epstopdf

if "%e2eflags%"=="" set e2eflags=-dSAFER
if "%etflags%"=="" set etflags=--quiet --copy --bbox

if "%e2efiles%"=="" set e2efiles=*.eps
if "%e2pfiles%"=="" set e2pfiles=*.eps
if "%fbbfiles%"=="" set fbbfiles=*.eps
if "%figclfiles%"=="" set figclfiles=*.pdf
if "%suffix%"=="" set suffix=~

rem end of configuration

if "%1"=="" (
:default
	call :help
goto :eof
)

:start
if "%1"=="" goto :eof

if "%1"=="help" (
:help
	echo List of targets:
	echo   clean      clean PDF files
	echo   epstoeps   optimize EPS files
	echo   epstopdf   convert all figures to PDF
	echo   fixbb      fix BoundingBox of EPS files
	echo   help       ^(default^) show this message
goto :eof
)

if "%1"=="clean" (
:clean
	del /s %figclfiles% 2> nul
goto :eof
)

if "%1"=="epstopdf" (
:epstopdf
	for %%f in (%e2pfiles%) do (
		if not exist "%%~nf.pdf" (
			%epstopdf% "%%f"
			echo epstopdf: %%f
		)
	)
goto :eof	
)

if "%1"=="fixbb" (
:fixbb
	for %%f in (%fbbfiles%) do (
		%epstool% %etflags% "%%f" "%%f%suffix%"
		move "%%f%suffix%" "%%f" > nul
		echo fixbb: %%f
	)
goto :eof
)

if "%1"=="epstoeps" (
:epstoeps
	for %%f in (%e2efiles%) do (
		%e2e% %e2eflags% "%%f" "%%f%suffix%"
		move "%%f%suffix%" "%%f" > nul
		echo epstoeps: %%f
	)
goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
