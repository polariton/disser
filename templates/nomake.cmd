@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

setlocal enabledelayedexpansion

set target=thesis
if "!texmf!"=="" set texmf=%programfiles%\miktex
if "!docdir!"=="" set docdir=!texmf!\doc\latex\disser
if "!subdirs!"=="" set subdirs=bachelor ..\master ..\candidate ..\doctor

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%1"=="help" (
:help
	cd bachelor & call nomake help & cd ..
	echo   install    install templates to TeX tree
	echo   uninstall  uninstall templates
	echo   reinstall  reinstall templates
goto :eof
)

if "%1"=="install" (
:install
	if not exist "%docdir%" md "%docdir%"
	xcopy /y /e /i /f ..\templates "%docdir%\templates"
	xcopy /y /e /i /f ..\include "%docdir%\include"
goto :eof
)

if "%1"=="uninstall" (
:uninstall
	rmdir /s /q %docdir%\templates
	rmdir /s /q %docdir%\include
	rmdir %docdir%
goto :eof
)

if "%1"=="reinstall" (
:reinstall
	call :uninstall
	call :install
goto :eof
)

for %%i in (%subdirs%) do @cd %%i & call nomake %*