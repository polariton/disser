@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

set target=thesis
if "!texmf!"==""   set texmf=%programfiles%\miktex
if "!destdir!"=="" set destdir=!texmf!
if "!docdir!"==""  set docdir=!destdir!\doc\latex\disser
if "!subdirs!"=="" set subdirs=bachelor ..\master ..\candidate ..\doctor

if "%1"=="help" (
	call :%1
) else if "%1"=="install" (
	call :%1
) else if "%1"=="uninstall" (
	call :%1
) else if "%1"=="reinstall" (
	call :%1
) else (
	for %%i in (%subdirs%) do @cd %%i & call nomake %%f
)

exit /b

:help
	cd candidate & call nomake help & cd ..
	echo   install    install templates to TeX tree
	echo   uninstall  uninstall templates
	echo   reinstall  reinstall templates
goto :eof

:install
	if not exist "%docdir%" md "%docdir%"
	xcopy /y /e /i /f ..\templates "%docdir%\templates"
	xcopy /y /e /i /f ..\include "%docdir%\include"
goto :eof

:uninstall
	rmdir /s /q %docdir%\templates
	rmdir /s /q %docdir%\include
	rmdir %docdir%
goto :eof

:reinstall
	call :uninstall
	call :install
goto :eof

