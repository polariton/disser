@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

set target=disser

if "%ver%"=="" set ver=1.1.0
set hg=hg
set archext=zip
set archive=%target%-%ver%.%archext%

if "%1"=="" (
:default
	call :class
	call :doc
goto :eof
)

:start
if "%1"=="" goto :eof

if "%1"=="all" (
:all
	cd src & nomake
	cd ..\templates & nomake
	cd ..
goto :eof
)

if "%1"=="class" (
:class
	cd src & nomake & cd ..
goto :eof
)

if "%1"=="clean" (
:clean
	cd src & nomake clean
	cd ..\templates & nomake clean
	cd ..\..
goto :eof
)

if "%1"=="doc" (
:doc
	cd src & nomake doc & cd ..
goto :eof
)

if "%1"=="install" (
:install
	cd src & nomake install & cd ..
goto :eof
)

if "%1"=="srcdist" (
:srcdist
	if exist %archive% del /q %archive%
	%hg% archive -X .hgignore -X .hg_archival.txt -X .hgtags -t %archext% %target%.%archext%
	if exist %target%.%archext% move %target%.%archext% %archive%
goto :eof
)

if "%1"=="template" (
:template
	set target=thesis
	cd templates & nomake
	cd ..\..
goto :eof
)

if "%1"=="help" (
:help
	echo List of targets:
	echo   all        build classes, documentation and templates
	echo   class      ^(default^) build classes and documentation
	echo   clean      remove ouptut files
	echo   doc        build DVI and PDF versions of documentation
	echo   help       show help
	echo   install    install package and documentation
	echo   srcdist    create source distribution
	echo   template   build all templates
goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
