@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

set target=thesis
if "!texmf!"==""   set texmf=%allusersprofile%\Application Data\MiKTeX\2.9
if "!destdir!"=="" set destdir=!texmf!
if "!docdir!"==""  set docdir=!destdir!\doc\latex\disser
if "!subdirs!"=="" set subdirs=bachelor ..\specialist ..\master ..\candidate ..\doctor


if "%1"=="help" (
	call :%1
) else if "%1"=="install" (
	call :%1
) else if "%1"=="uninstall" (
	call :%1
) else if "%1"=="reinstall" (
	call :%1
) else (
	for %%i in (%subdirs%) do @cd %%i & call nomake %*
)

exit /b

:help
	cd candidate & call nomake help & cd ..
	echo   install    install templates to TeX tree
	echo   uninstall  uninstall templates
	echo   reinstall  reinstall templates
goto :eof

:install
	if not exist "!docdir!" mkdir "!docdir!"
	xcopy /y /e /i /f ..\templates "!docdir!\templates"
	xcopy /y /e /i /f ..\templates-utf8 "!docdir!\templates-utf8"
	xcopy /y /e /i /f ..\include "!docdir!\include"
goto :eof

:uninstall
	rmdir /s /q "!docdir!"
goto :eof

:reinstall
	call :uninstall
	call :install
goto :eof
