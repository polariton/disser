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
set bst=disser-bst
set manual=manual

set clsfiles=*.cls *.rtx
set bstfiles=%target%.bst %target%-s.bst
set docfiles=%target%.pdf %subclass%.pdf %bst%.pdf %manual%.pdf
set textfiles=..\README ..\README.ru ..\ChangeLog
set srcfiles=*.dtx *.ins %manual%.tex Makefile nomake.cmd

if "!texmf!"==""   set texmf=%programfiles%\miktex
if "!destdir!"=="" set destdir=!texmf!
if "!clsdir!"==""  set clsdir=!destdir!\tex\latex\%target%
if "!bstdir!"==""  set bstdir=!destdir!\bibtex\bst\%target%
if "!docdir!"==""  set docdir=!destdir!\doc\latex\%target%
if "!srcdir!"==""  set srcdir=!destdir!\source\latex\%target%

if "!clext!"=="" set clext=*.log *.out *.aux *.dvi *.idx *.ilg *.ind *.glo ^
*.toc *.bak *.bbl *.blg *.sav
if "!clfiles!"=="" set clfiles=%clsfiles% %bstfiles% %docfiles% !clext!

if "!latex!"==""    set latex=latex
if "!pdflatex!"=="" set pdflatex=pdflatex
if "!mi!"==""       set mi=makeindex

if "!latexflags!"==""    set latexflags=--src-specials
if "!pdflatexflags!"=="" set pdflatexflags=--shell-escape
if "!miflags!"==""       set miflags=-r


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
	del %clfiles%
goto :eof

:doc
	call :pdf
goto :eof

:dvi
	%latex% %latexflags% %target%.dtx
	%mi% %miflags% %target%
	%latex% %latexflags% %target%.dtx
	%latex% %latexflags% %target%.dtx
	%latex% %latexflags% %subclass%.dtx
	%latex% %latexflags% %subclass%.dtx
	%latex% %latexflags% %bst%.dtx
	%latex% %latexflags% %bst%.dtx
	%latex% %latexflags% %manual%.tex
	%latex% %latexflags% %manual%.tex
goto :eof

:help
	echo   all        ^(default^) build package and documentation
	echo   clean      remove output files
	echo   doc        build documentation in DVI and PDF formats
	echo   dvi        build documentation in DVI format
	echo   help       show description of targets
	echo   install    install package and documentation
	echo   package    build package
	echo   pdf        build PDF version of documentation
	echo   reinstall  reinstall package and documentation
	echo   uninstall  remove package and documentation from TeX tree
goto :eof

:install
	if not exist %target%.cls call :all
	if not exist "%clsdir%" md "%clsdir%"
	if not exist "%docdir%" md "%docdir%"
	if not exist "%bstdir%" md "%bstdir%"
	if not exist "%srcdir%" md "%srcdir%"
	for %%f in (%clsfiles%)  do xcopy /y /f %%f "%clsdir%"
	for %%f in (%docfiles%)  do xcopy /y /f %%f "%docdir%"
	for %%f in (%textfiles%) do xcopy /y /f %%f "%docdir%"
	for %%f in (%bstfiles%)  do xcopy /y /f %%f "%bstdir%"
	for %%f in (%srcfiles%)  do xcopy /y /f %%f "%srcdir%"
goto :eof

:package
    %latex% %target%.ins
goto :eof

:pdf
	%pdflatex% %pdflatexflags% %target%.dtx
	%mi% %miflags% %target%
	%pdflatex% %pdflatexflags% %target%.dtx
	%pdflatex% %pdflatexflags% %target%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
	%pdflatex% %pdflatexflags% %bst%.dtx
	%pdflatex% %pdflatexflags% %bst%.dtx
	%pdflatex% %pdflatexflags% %manual%.tex
	%pdflatex% %pdflatexflags% %manual%.tex
goto :eof

:reinstall
	call :uninstall
	call :install
goto :eof

:uninstall
	for %%f in (%clsfiles%)  do del "%clsdir%\%%~nxf"
	for %%f in (%docfiles%)  do del "%docdir%\%%~nxf"
	for %%f in (%textfiles%) do del "%docdir%\%%~nxf"
	for %%f in (%bstfiles%)  do del "%bstdir%\%%~nxf"
	for %%f in (%srcfiles%)  do del "%srcdir%\%%~nxf"
	rmdir "%clsdir%"
	rmdir "%docdir%"
	rmdir "%bstdir%"
	rmdir "%srcdir%"
goto :eof
