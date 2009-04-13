@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

set target=disser

if "%ver%"=="" set ver=1.1.1
set hg=hg
set archext=zip
set archive=%target%-%ver%.%archext%
set tdsdir=..\disser-tds

setlocal enabledelayedexpansion

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
	cd src & nomake & cd ..
	cd templates & nomake & cd ..
goto :eof
)

if "%1"=="class" (
:class
	cd src & nomake & cd ..
goto :eof
)

if "%1"=="clean" (
:clean
	cd src & call nomake clean & cd ..
	cd templates & call nomake clean & cd ..
goto :eof
)

if "%1"=="doc" (
:doc
	cd src & call nomake doc
goto :eof
)

if "%1"=="install" (
:install
	cd src & call nomake install & cd ..
	cd templates & call nomake install & cd ..
	echo.
	echo Don't forget to run 'mktexlsr' if you install this class first time
	echo.
goto :eof
)

if "%1"=="srcdist" (
:srcdist
	if exist %archive% del /q %archive%
	%hg% archive -X .hgignore -X .hg_archival.txt -X .hgtags -t %archext% %target%.%archext%
	if exist %target%.%archext% move %target%.%archext% %archive%
goto :eof
)

if "%1"=="tds" (
:tds
	if not exist %tdsdir%\source\latex\disser md %tdsdir%\source\latex\disser
	for %%f in (src\*.dtx src\*.tex src\*.ins) do xcopy /y /f %%f "%tdsdir%\source\latex\disser"
	set texmf=..\%tdsdir%
	cd src & call nomake install & cd ..
	cd templates & call nomake install & cd ..
	7z a -tzip -mx=9 disser.tds.zip %tdsdir%\*
goto :eof
)

if "%1"=="templates" (
:templates
	set target=thesis
	cd templates & call nomake
goto :eof
)

if "%1"=="help" (
:help
	echo Targets:
	echo   all        build classes, documentation and templates
	echo   class      ^(default^) build classes and documentation
	echo   clean      remove ouptut files
	echo   doc        build DVI and PDF versions of documentation
	echo   help       show help
	echo   install    install package and documentation
	echo   srcdist    create source distribution
	echo   templates  build all templates
goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
