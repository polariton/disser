@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

set target=disser

if "%ver%"=="" set ver=1.1.2
set hg=hg
set archext=zip
set archive=%target%-%ver%.%archext%
set tdsdir=..\disser-tds
set tdsarchive=%target%.tds.%archext%

setlocal enabledelayedexpansion

if "%1"=="" (
:default
	call :package
	call :doc
goto :eof
) else if "%1"=="templates" (
:templates
	cd templates & call nomake & cd ..
goto :eof
) else if "%1"=="all" (
:all
	call :default
	call :templates
goto :eof
) else if "%1"=="package" (
:package
	cd src & call nomake & cd ..
goto :eof
) else if "%1"=="doc" (
:doc
	cd src & call nomake %1 & cd ..
goto :eof
) else if "%1"=="clean" (
:clean
	cd src & call nomake clean & cd ..
	cd templates & call nomake clean & cd ..
goto :eof
) else if "%1"=="install" (
:install
	cd src & call nomake install & cd ..
	cd templates & call nomake install & cd ..
goto :eof
) else if "%1"=="reinstall" (
:uninstall
	cd src & call nomake reinstall & cd ..
	cd templates & call nomake reinstall & cd ..
goto :eof
) else if "%1"=="uninstall" (
:uninstall
	cd src & call nomake uninstall & cd ..
	cd templates & call nomake uninstall & cd ..
goto :eof
) else if "%1"=="srcdist" (
:srcdist
	if exist %archive% del /q %archive%
	%hg% archive -X .hgignore -X .hg_archival.txt -X .hgtags -t %archext% %target%.%archext%
	if exist %target%.%archext% move %target%.%archext% %archive%
goto :eof
) else if "%1"=="tds" (
:tds
	if not exist %tdsdir% md "%tdsdir%"
	set texmf=..\%tdsdir%
	call :install
	7z a -t%archext% -mx=9 %tdsarchive% %tdsdir%\*
goto :eof
) else if "%1"=="help" (
:help
	echo   all        build classes, documentation and templates
	echo   clean      remove output files
	echo   doc        build DVI and PDF versions of documentation
	echo   help       show description of targets
	echo   install    install package and documentation
	echo   package    ^(default^) build package and documentation
	echo   reinstall  reinstall package and documentation
	echo   srcdist    create source distribution
	echo   tds        create TDS archive
	echo   templates  build all templates
	echo   uninstall  uninstall package and documentation
goto :eof
) else (
	echo Don't know how to make %1
)

