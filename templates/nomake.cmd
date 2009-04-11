@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

setlocal enabledelayedexpansion

if "!texmf!"=="" set texmf=%programfiles%\miktex
if "!docdir!"=="" set tdir=!texmf!\doc\latex\%target%

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%1"=="help" (
	set subdirs=bachelor
) else (
	set subdirs=bachelor ..\master ..\candidate ..\doctor
)

if "%1"=="install" (
:install
	if not exist "%docdir%" md "%docdir%"
	xcopy /y /e /i /f ..\templates "%tdir%\templates"
	xcopy /y /e /i /f ..\include "%tdir%\include"
goto :eof
)

for %%i in (%subdirs%) do @cd %%i & call nomake %*