@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

setlocal enabledelayedexpansion

if "%target%"==""  set target=thesis
if "%bibfile%"=="" set bibfile=thesis.bib

if "%arch%"==""     set arch=7z
if "%bibtex%"==""   set bibtex=bibtex8
if "%dvips%"==""    set dvips=dvips
if "%l2h%"==""      set l2h=latex2html
if "%l2rtf%"==""    set l2rtf=latex2rtf
if "%latex%"==""    set latex=latex
if "%mktexlsr%"=="" set mktexlsr=mktexlsr
if "%pdflatex%"=="" set pdflatex=pdflatex
if "%ps2pdf%"==""   set ps2pdf=gswin32c
if "%psbook%"==""   set psbook=psbook
if "%psnup%"==""    set psnup=psnup

if "%archext%"==""     set archext=zip
if "%archflags%"==""   set archflags=a -t%archext%
if "%archive%"==""     set archive=%target%.%archext%
if "%bibtexflags%"=="" set bibtexflags=-H -c cp1251
if "%dvipsflags%"==""  set dvipsflags=-P pdf -t A4 -z
if "%l2hflags%"=="" (
	set l2hflags=-dir html -iso_language RU.RU -split 3 -short_index ^
		-numbered_footnotes -white -antialias -html_version 4.0
)
if "%l2rtfflags%"==""  set l2rtfflags=-F -M12 -i russian
if "%latexflags%"==""  set latexflags=--src-specials
if "%ps2pdfflags%"=="" (
	set ps2pdfflags=-dBATCH -dNOPAUSE -sDEVICE=pdfwrite -g4960x7016 -r600 ^
		-dCompatibilityLevel#1.2
)
if "%psnupflags%"==""    set psnupflags=-2 -pA4
if "%pdflatexflags%"=="" set pdflatexflags=--shell-escape

if "%clext%"==""    set clext=*.bbl *.bak *.aux *.blg *.out *.toc *.log ^
	*.dvi *.tmp *.pdf *.ps
if "%clfiles%"==""  set clfiles=!clext! %archive%
if "%srcfiles%"=="" set srcfiles=*


if "%1"=="" (
	call :dvi
) else (
	for %%f in (%*) do call :%%f
)

exit /b

:clean
	del /s %clfiles% 2> nul
	if exist %target%.%arctype% del %target%.%arctype%
goto :eof

:dvi
	call :cmptimes %target%.dvi *.tex *.bib
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'dvi'.
		goto :eof
	)
	%latex% %latexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%f
		%latex% %texflags% %target%.tex
	) else (
		echo Warning: Bibliography file does not exist
	)
	%latex% %latexflags% %target%.tex
goto :eof

:help
	call ..\..\include\latex.fig.nmk.cmd
	echo   dvi          ^(default^) build DVI
	echo   figclean     clean output files in figures directory
	echo   help         show description of targets
	echo   html         convert DVI to HTML
	echo   pdf          build PDF
	echo   pdf_2on1     build PDF with two A5 pages on one A4 ordered by number
	echo   pdf_book     build PDF booklet ^(two A5 on A4^)
	echo   ps           build PS
	echo   ps_2on1      build PS with two A5 pages on A4 ordered by number
	echo   ps_book      build PS booklet ^(two A5 on A4^)
	echo   rtf          convert DVI to RTF
	echo   srcdist      build source distribution
goto :eof

:html
	call :dvi
	%l2h% %l2hflags% %target%.tex
goto :eof

:pdf
	call :cmptimes %target%.pdf *.tex *.bib
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'pdf'.
		goto :eof
	)
	%pdflatex% %pdflatexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%f
		%pdflatex% %pdflatexflags% %target%.tex
	) else (
		echo Warning: Bibliography file does not exist
	)
	%pdflatex% %pdflatexflags% %target%.tex
goto :eof

:pdf2on1
	call :ps2on1
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_2on1.pdf ^
		-c save pop -f %target%_2on1.ps
goto :eof

:pdfbook
	call :psbook
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_book.pdf ^
		-c save pop -f %target%_book.ps
goto :eof

:ps
	call :dvi
	%dvips% %dvipsflags% %target%.dvi
goto :eof

:ps2on1
	call :ps
	%psnup% %psnupflags% %target%.ps > %target%_2on1.ps
goto :eof

:psbook
	call :ps
	%psbook% %target%.ps | %psnup% -2 > %target%_book.ps
goto :eof

:rtf
	call :dvi
	%l2rtf% %l2rtfflags% -a %target%.aux -b %target%.bbl %target%.tex
goto :eof

:srcdist
	call :clean
	%arch% %archflags% %archive% %srcfiles%
goto :eof

:bmtoeps
	cd fig & call nomake.cmd bmtoeps & cd ..
goto :eof

:epstoeps
	cd fig & call nomake.cmd epstoeps & cd ..
goto :eof

:epstopdf
	cd fig & call nomake.cmd epstopdf & cd ..
goto :eof

:figclean
	cd fig & call nomake.cmd clean & cd ..
goto :eof

:fixbb
	cd fig & call nomake.cmd fixbb & cd ..
goto :eof

:optimize
	cd fig & call nomake.cmd optimize & cd ..
goto :eof

:pdftopng256
	cd fig & call nomake.cmd pdftopng256 & cd ..
goto :eof

:pdftotiffg4
	cd fig & call nomake.cmd pdftotiffg4 & cd ..
goto :eof

:cmptimes
	set _ctfiles=%*
	set _ctoutf=%~1
	if not exist %_ctoutf% (
		set _ctres=1
		goto :eof
	)
	for /f "usebackq" %%f in (`dir /b /t:w /o:-d %_ctfiles%`) do (
		set _ctnewest=%%f
		goto :_ctbreak
	)
	:_ctbreak

	if "%_ctoutf%"=="%_ctnewest%" (
		set _ctres=0
	) else (
		set _ctres=1
	)
goto :eof
