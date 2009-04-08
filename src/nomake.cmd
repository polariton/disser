@echo off

rem nomake script for LaTeX packages
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%target%"=="" set target=disser
set subclass=gost732
set bst=disser-bst

if "%texmf%"=="" set texmf=%programfiles%\miktex

if "%clsdir%"=="" set clsdir=%texmf%\tex\latex\%target%
if "%bstdir%"=="" set bstdir=%texmf%\bibtex\bst\%target%
if "%docdir%"=="" set docdir=%texmf%\doc\latex\%target%
if "%bstdocdir%"=="" set bstdocdir=%texmf%\doc\bibtex\%target%

if "%clsfiles%"=="" set clsfiles=*.cls *.rtx
if "%docfiles%"=="" set docfiles=%target%.dvi %subclass%.pdf %target%.pdf %subclass%.pdf
if "%bstdocfiles%"=="" set bstdocfiles=%bst%.dvi %bst%.pdf
if "%bstfiles%"=="" set bstfiles=%target%.bst

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
	%latex% %latexflags% %bst%.dtx
	%latex% %latexflags% %bst%.dtx
goto :eof
)

if "%1"=="pdf" (
:pdf
	%pdflatex% %pdflatexflags% %target%.dtx
	%mi% -r %target%
	%pdflatex% %pdflatexflags% %target%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
	%pdflatex% %pdflatexflags% %subclass%.dtx
	%pdflatex% %pdflatexflags% %bst%.dtx
	%pdflatex% %pdflatexflags% %bst%.dtx
goto :eof
)

if "%1"=="install" (
:install
	if not exist %target%.cls call :all
	if not exist "%clsdir%" md "%clsdir%"
	if not exist "%docdir%" md "%docdir%"
	if not exist "%bstdir%" md "%bstdir%"
	if not exist "%bstdocdir%" md "%bstdocdir%"
	for %%f in (%clsfiles%) do xcopy /y /f %%f "%clsdir%"
	for %%f in (%docfiles%) do xcopy /y /f %%f "%docdir%"
	for %%f in (%bstfiles%) do xcopy /y /f %%f "%bstdir%"
	for %%f in (%bstdocfiles%) do xcopy /y /f %%f "%bstdocdir%"
	echo.
	echo Don't forget to run 'mktexlsr' if you install this class first time
	echo.
goto :eof
)

if "%1"=="help" (
:help
	echo List of targets:
	echo   all       ^(default^) build classes and documentation
	echo   class     build class
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
