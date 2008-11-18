@echo off

rem nomake script for LaTeX packages
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%target%"=="" set target=disser
set subclass=gost732
if "%texmf%"=="" set texmf=%programfiles%\miktex

if "%clsdir%"=="" set clsdir=%texmf%\tex\latex\%target%
if "%bstdir%"=="" set bstdir=%texmf%\bibtex\bst\%target%
if "%docdir%"=="" set docdir=%texmf%\doc\latex\%target%

if "%clsfiles%"=="" set clsfiles=*.cls *.rtx
if "%docfiles%"=="" set docfiles=*.dvi *.pdf
if "%bstfiles%"=="" set bstfiles=*.bst

if "%clfiles%"=="" set clfiles=*.rtx *.cls *.log *.out *.aux *.dvi *.ind ^
*.idx *.ilg *.glo *.toc *.ind *.bak *.bbl *.blg *.pdf *.sav *.ps *.bst

if "%latex%"=="" set latex=latex
if "%pdflatex%"=="" set pdflatex=pdflatex
if "%mi%"=="" set mi=makeindex

if "%latexflags%"=="" set latexflags=-src-specials
if "%pdflatexflags%"=="" set pdflatexflags=""

rem Default target
if "%1"=="" (
:default
	call :all
goto :eof
)

:start
if "%1"=="" goto :eof

if "%1"=="all" (
:all
	call :class
	call :doc
goto :eof
)

if "%1"=="class" (
:class
    %latex% %target%.ins
goto :eof
)

if "%1"=="clean" (
:clean
	del %clfiles%
goto :eof
)

if "%1"=="doc" (
:doc
	call :dvi
	call :pdf
goto :eof
)

if "%1"=="dvi" (
:dvi
	%latex% %latexflags% %target%.dtx
	%mi% -r %target%
	%latex% %latexflags% %target%.dtx
	%latex% %latexflags% %subclass%.dtx
	%latex% %latexflags% %subclass%.dtx
goto :eof
)

if "%1"=="pdf" (
:pdf
	%pdflatex% %pdflatexflags% %target%.dtx
	%mi% -r %target%
	%pdflatex% %pdflatexflags% %target%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
goto :eof
)

if "%1"=="install" (
:install
	if not exist %target%.cls call :all
	if not exist "%clsdir%" md "%clsdir%"
	if not exist "%docdir%" md "%docdir%"
	if not exist "%bstdir%" md "%bstdir%"
	xcopy /y /f *.cls "%clsdir%"
	xcopy /y /f *.rtx "%clsdir%"
	xcopy /y /f %target%.bst "%bstdir%"
	xcopy /y /f *.dvi "%docdir%"
	xcopy /y /f *.pdf "%docdir%"
goto :eof
)

if "%1"=="help" (
:help
	echo List of targets:
	echo   all       ^(default^) build classes and documentation
	echo   class     build classes
	echo   clean     remove ouptut files
	echo   doc       build documentation
	echo   dvi       build DVI version of documentation
	echo   help      show help
	echo   install   install package and documentation
	echo   pdf       build PDF version of documentation
goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
