@echo off

rem nomake script for disser package
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

set target=disser
set subclass=gost732
set manual=manual

set clsfiles=*.cls *.rtx
set docfiles=%target%.pdf %subclass%.pdf %bst%.pdf %manual%.pdf
set textfiles=..\README ..\README.ru ..\ChangeLog
set srcfiles=*.dtx %target%.ins dtx.ist %manual%.tex Makefile nomake.cmd

if "!texmf!"==""   set texmf=%allusersprofile%\Application Data\MiKTeX\2.9
if "!destdir!"=="" set destdir=!texmf!
if "!clsdir!"==""  set clsdir=!destdir!\tex\latex\%target%
if "!docdir!"==""  set docdir=!destdir!\doc\latex\%target%
if "!srcdir!"==""  set srcdir=!destdir!\source\latex\%target%

if "!clext!"=="" set clext=*.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof ^
*.lot *.lol *.bbl *.blg *.bak *.dvi *.ps *.pdf *.synctex *.synctex.gz
if "!clfiles!"=="" set clfiles=!clext! %clsfiles%

if "!latex!"==""    set latex=latex
if "!pdflatex!"=="" set pdflatex=pdflatex
if "!mi!"==""       set mi=makeindex

if "!latexflags!"==""    set latexflags=--src-specials
if "!pdflatexflags!"=="" set pdflatexflags=--shell-escape --synctex=1
if "!miflags!"==""       set miflags=-r -s dtx.ist


if "%1"=="" (
	call :all
) else (
	for %%f in (%*) do call :%%f
)

exit /b

:all
	call :package
	call :doc
goto :eof

:clean
	del !clfiles!
goto :eof

:doc
	call :pdf
goto :eof

:dvi
	!latex! !latexflags! %target%.dtx
	!mi! !miflags! %target%
	!latex! !latexflags! %target%.dtx
	!latex! !latexflags! %target%.dtx

	!latex! !latexflags! %subclass%.dtx
	!latex! !latexflags! %subclass%.dtx

	!latex! !latexflags! %bst%.dtx
	!mi! !miflags! %bst%
	!latex! !latexflags! %bst%.dtx
	!latex! !latexflags! %bst%.dtx

	!latex! !latexflags! %manual%.tex
	!latex! !latexflags! %manual%.tex
goto :eof

:help
	echo   all        ^(default^) build package and documentation
	echo   clean      remove output files
	echo   doc        alias for pdf target
	echo   dvi        build documentation in DVI format
	echo   help       show description of targets
	echo   install    install package and documentation
	echo   package    build package
	echo   pdf        build documentation in PDF format
	echo   reinstall  reinstall package and documentation
	echo   uninstall  uninstall package and documentation
goto :eof

:install
	if not exist %target%.cls call :all
	if not exist "!clsdir!" mkdir "!clsdir!"
	if not exist "!docdir!" mkdir "!docdir!"
	if not exist "!srcdir!" mkdir "!srcdir!"
	for %%f in (%clsfiles%)  do xcopy /y /i /f %%f "!clsdir!"
	for %%f in (%docfiles%)  do xcopy /y /i /f %%f "!docdir!"
	for %%f in (%textfiles%) do xcopy /y /i /f %%f "!docdir!"
	for %%f in (%srcfiles%)  do xcopy /y /i /f %%f "!srcdir!"
goto :eof

:package
    %latex% %target%.ins
goto :eof

:pdf
	!pdflatex! !pdflatexflags! %target%.dtx
	!mi! !miflags! %target%
	!pdflatex! !pdflatexflags! %target%.dtx
	!pdflatex! !pdflatexflags! %target%.dtx

	!pdflatex! !pdflatexflags! %subclass%.dtx
	!pdflatex! !pdflatexflags! %subclass%.dtx

	!pdflatex! !pdflatexflags! %manual%.tex
	!pdflatex! !pdflatexflags! %manual%.tex
goto :eof

:reinstall
	call :uninstall
	call :install
goto :eof

:uninstall
	rmdir /s /q "!clsdir!"
	rmdir /s /q "!docdir!"
	rmdir /s /q "!srcdir!"
goto :eof
