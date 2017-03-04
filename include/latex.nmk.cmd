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

if "%arch%"==""      set arch=7z
if "%bibtex%"==""    set bibtex=bibtex8
if "%dvips%"==""     set dvips=dvips
if "%l2h%"==""       set l2h=latex2html
if "%l2rtf%"==""     set l2rtf=latex2rtf
if "%latex%"==""     set latex=latex
if "%mktexlsr%"==""  set mktexlsr=mktexlsr
if "%pdflatex%"==""  set pdflatex=pdflatex
if "%ps2pdf%"==""    set ps2pdf=gswin32c
if "%psbook%"==""    set psbook=psbook
if "%psnup%"==""     set psnup=psnup
if "%makeindex%"=="" set makeindex=makeindex

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
if "%pdflatexflags%"=="" set pdflatexflags=--shell-escape --synctex=1

if "%clext%"=="" set clext=*.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof *.lot *.lol ^
  *.bbl *.blg *.bak *.dvi *.ps *.pdf *.synctex *.synctex.gz *.run.xml *.bcf *.nlo *.nls
if "%clfiles%"=="" set clfiles=!clext! %archive%
if "%srcfiles%"=="" set srcfiles=*
if "%prereq%"=="" set prereq=*.tex *.bib


if "%1"=="" (
	call :pdf
) else (
	for %%f in (%*) do call :%%f
)

exit /b

:clean
	del /s %clfiles% 2> nul
	if exist %target%.%arctype% del %target%.%arctype%
goto :eof

:dvi
	call :cmptimes %target%.dvi %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'dvi'.
		goto :eof
	)
	%latex% %latexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%~nf
	) else (
		echo Warning: Bibliography file does not exist
	)
	if exist %target%.nlo (
		%makeindex% %target%.nlo -s nomencl.ist -o %target%.nls
	)
	%latex% %latexflags% %target%.tex
	%latex% %latexflags% %target%.tex
goto :eof

:help
	echo   dvi          build DVI
	echo   figclean     clean output files in figures directory
	echo   html         convert DVI to HTML
	echo   pdf          ^(default^) build PDF
	echo   pdf_2on1     build PDF with two A5 pages on one A4 ordered by number
	echo   pdf_book     build PDF booklet ^(two A5 on A4^)
	echo   ps           build PS
	echo   ps_2on1      build PS with two A5 pages on A4 ordered by number
	echo   ps_book      build PS booklet ^(two A5 on A4^)
	echo   rtf          convert DVI to RTF
	echo   srcdist      build source distribution
	call ..\..\include\latex.fig.nmk.cmd
goto :eof

:html
	call :cmptimes %target%.html %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'html'.
		goto :eof
	)
	call :dvi
	%l2h% %l2hflags% %target%.tex
goto :eof

:pdf
	call :cmptimes %target%.pdf %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'pdf'.
		goto :eof
	)
	%pdflatex% %pdflatexflags% %target%.tex
	if exist %bibfile% (
		for %%f in (*.aux) do %bibtex% %bibtexflags% %%~nf
	) else (
		echo Warning: Bibliography file does not exist
	)
	if exist %target%.nlo (
		%makeindex% %target%.nlo -s nomencl.ist -o %target%.nls
	)
	%pdflatex% %pdflatexflags% %target%.tex
	%pdflatex% %pdflatexflags% %target%.tex
goto :eof

:pdf_2on1
	call :cmptimes %target%_2on1.pdf %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'pdf_2on1'.
		goto :eof
	)
	call :ps_2on1
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_2on1.pdf ^
		-c save pop -f %target%_2on1.ps
goto :eof

:pdf_book
	call :cmptimes %target%_book.pdf %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'pdf_book'.
		goto :eof
	)
	call :ps_book
	%ps2pdf% %ps2pdfflags% -sOutputFile=%target%_book.pdf ^
		-c save pop -f %target%_book.ps
goto :eof

:ps
	call :cmptimes %target%.ps %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'ps'.
		goto :eof
	)
	call :dvi
	%dvips% %dvipsflags% %target%.dvi
goto :eof

:ps_2on1
	call :cmptimes %target%_2on1.ps %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'ps_2on1'.
		goto :eof
	)
	call :ps
	%psnup% %psnupflags% %target%.ps > %target%_2on1.ps
goto :eof

:ps_book
	call :cmptimes %target%_book.ps %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'ps_book'.
		goto :eof
	)
	call :ps
	%psbook% %target%.ps | %psnup% -2 > %target%_book.ps
goto :eof

:rtf
	call :cmptimes %target%.rtf %prereq%
	if !_ctres!==0 (
		echo nomake: Nothing to be done for 'rtf'.
		goto :eof
	)
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
