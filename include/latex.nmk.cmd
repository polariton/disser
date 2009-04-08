@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%target%"=="" set target=thesis
set bibfile=thesis.bib

if "%arch%"=="" set arch=7z
if "%bibtex%"=="" set bibtex=bibtex8
if "%epstool%"=="" set epstool=epstool
if "%epstopdf%"=="" set epstopdf=epstopdf
if "%ps2pdf%"=="" set ps2pdf=gswin32c
if "%dvips%"=="" set dvips=dvips
if "%l2h%"=="" set l2h=latex2html
if "%mktexlsr%"=="" set mktexlsr=mktexlsr
if "%pdflatex%"=="" set pdflatex=pdflatex
if "%psbook%"=="" set psbook=psbook
if "%psnup%"=="" set psnup=psnup
if "%latex%"=="" set latex=latex
if "%l2rtf%"=="" set l2rtf=latex2rtf

if "%archext%"=="" set archext=zip
if "%archflags%"=="" set archflags=a -t%archext%
if "%archive%"=="" set archive=%target%.%archext%

if "%bibtexflags%"=="" set bibtexflags=-H -c cp1251

if "%l2hflags%"=="" (
	set l2hflags=-dir html -iso_language RU.RU -split 3 -short_index ^
    -numbered_footnotes -no_footnode -white -antialias ^
    -html_version 4.0
)
if "%ps2pdfflags%"=="" (
	set ps2pdfflags=-dBATCH -dNOPAUSE -sDEVICE=pdfwrite -g4960x7016 -r600 ^
	  -dCompatibilityLevel#1.2
)
if "%psnupflags%"=="" set psnupflags=-2 -pA4
if "%pdflatexflags%"=="" set pdflatexflags=--shell-escape
if "%latexflags%"=="" set latexflags=-src-specials

set clext=*.bbl *.bak *.aux *.blg *.out *.toc *.log *.dvi *.tmp *.pdf *.ps
if "%clfiles%"=="" set clfiles= %clext% %target%.%arc%
if "%srcfiles%"=="" set srcfiles=*
if "%suffix%"=="" set suffix=~

rem end of configuration

if "%1"=="" (
:default
	call :dvi
goto :eof
)

:start
if "%1"=="" goto :eof

if "%1"=="dvi" (
:dvi
	%latex% %latexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%f
		%latex% %texflags% %target%.tex
	) else (
		echo Warning: Bibliography file does not exist
	)
	%latex% %latexflags% %target%.tex
goto :eof
)

if "%1"=="pdf" (
:pdf
	%pdflatex% %pdflatexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%f
		%pdflatex% %pdflatexflags% %target%.tex
	) else (
		echo Warning: Bibliography file does not exist
	)
	%pdflatex% %pdflatexflags% %target%.tex
goto :eof
)

if "%1"=="pdf_2on1" (
:pdf2on1
	if not exist %target%_2on1.ps call :ps2on1
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_2on1.pdf ^
	-c save pop -f %target%_2on1.ps
goto :eof
)

if "%1"=="pdf_booklet" (
:pdfbooklet
	if not exist %target%_booklet.ps call :psbooklet
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_booklet.pdf ^
	-c save pop -f %target%_booklet.ps
goto :eof
)

if "%1"=="ps" (
:ps
	if not exist %target%.dvi call :dvi
	%dvips% -o %target%.ps %target%.dvi
goto :eof
)

if "%1"=="ps_2on1" (
:ps2on1
	if not exist %target%.ps call :ps
	%psnup% %psnupflags% %target%.ps > %target%_2on1.ps
goto :eof
)

if "%1"=="ps_booklet" (
:psbooklet
	if not exist %target%.ps call :ps
	%psbook% %target%.ps | %psnup% -2 > %target%_booklet.ps
goto :eof
)

if "%1"=="html" (
:html
	if not exist %target%.dvi call :dvi
	%l2h% %l2hflags% %target%.tex
goto :eof
)

if "%1"=="rtf" (
	call :dvi
	%l2rtf% -F -M12 -i russian -a %target%.aux -b %target%.bbl %target%.tex
)

if "%1"=="clean" (
:clean
	del /s %clfiles% 2> nul
	if exist %target%.%arctype% del %target%.%arctype%
goto :eof
)

if "%1"=="srcdist" (
:srcdist
	call :clean
	%arch% %archflags% %archive% %srcfiles%
goto :eof
)

if "%1"=="epstoeps" (
:epstoeps
	cd fig & call nomake.cmd epstoeps & cd ..
goto :eof	
)

if "%1"=="epstopdf" (
:epstopdf
	cd fig & call nomake.cmd epstopdf & cd ..
goto :eof	
)

if "%1"=="fixbb" (
:fixbb
	cd fig & call nomake.cmd fixbb & cd ..
goto :eof
)

if "%1"=="help" (
:help
	echo List of targets:
	echo   dvi        ^(default^) build DVI
	echo   clean      remove output files
	echo   epstoeps   optimize EPS files
	echo   epstopdf   convert figures to PDF
	echo   fixbb      fix BoundingBox of EPS files
	echo   help       show list of targets
	echo   html       convert to HTML
	echo   pdf        build PDF
	echo   pdf_2on1   build PDF with two A5 pages on one A4 ordered by number
	echo   pdf_book   build PDF booklet ^(two A5 on A4^)
	echo   ps         build PS
	echo   ps_2on1    build PS with two A5 pages on A4 ordered by number
	echo   ps_book    build PS booklet ^(two A5 on A4^)
	echo   rtf        convert to RTF
	echo   srcdist    build source distribution %archive%
goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
