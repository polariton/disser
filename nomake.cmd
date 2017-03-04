@echo off

rem nomake script for disser package
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

set target=disser

if "!ver!"=="" set ver=1.5.0
set git=git
set archext=zip
set archive=%target%-!ver!.%archext%
set excludefiles=.gitignore
set tdsdir=..\%target%-tds
set tdsarchive=%target%-!ver!.tds.%archext%


if "%1"=="" (
	call :package
	call :doc
) else (
	for %%f in (%*) do call :%%f
)

exit /b

:templates
	cd templates & call nomake & cd ..
	cd templates-utf8 & call nomake & cd ..
goto :eof

:all
	call :default
	call :templates
goto :eof

:package
	cd src & call nomake & cd ..
goto :eof

:doc
	cd src & call nomake doc & cd ..
goto :eof

:clean
	cd src & call nomake clean & cd ..
	cd templates & call nomake clean & cd ..
	cd templates-utf8 & call nomake clean & cd ..
goto :eof

:install
	cd src & call nomake install & cd ..
	cd templates & call nomake install & cd ..
	cd templates-utf8 & call nomake install & cd ..
goto :eof

:reinstall
	cd src & call nomake reinstall & cd ..
	cd templates & call nomake reinstall & cd ..
	cd templates-utf8 & call nomake reinstall & cd ..
goto :eof

:uninstall
	cd src & call nomake uninstall & cd ..
	cd templates & call nomake uninstall & cd ..
	cd templates-utf8 & call nomake uninstall & cd ..
goto :eof

:srcdist
	if exist %archive% del /q %archive%
	%git% archive --format=%archext% --output=%archive% -9 HEAD
	7z d %archive% %excludefiles%
goto :eof

:tds
	if exist %tdsarchive% del /q %tdsarchive%
	if not exist %tdsdir% (
		mkdir "%tdsdir%"
	) else (
		rmdir /q /s "%tdsdir%"
	)
	set destdir=..\%tdsdir%
	call :install
	cd %tdsdir%\bibtex\bst\disser
	flip -ub *.bst
	cd ..\..\..\tex\latex\disser
	flip -ub *.cls *.rtx
	cd ..\..\..\..\disser
	7z a -t%archext% -mx=9 %tdsarchive% %tdsdir%\*
goto :eof

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
