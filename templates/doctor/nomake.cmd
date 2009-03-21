@echo off

if "%1"=="help" (
:help
	call ..\..\include\latex.nmk.cmd %1
	echo   all        build DVI of autoref and thesis
	echo   allpdf     build PDF of autoref and thesis
goto :eof
) else if "%1"=="all" (
:all
	set target=thesis & call ..\..\include\latex.nmk.cmd dvi
	set target=autoref & call ..\..\include\latex.nmk.cmd dvi
	set target=
goto :eof
) else if "%1"=="allpdf" (
:allpdf
	set target=thesis & call ..\..\include\latex.nmk.cmd pdf
	set target=autoref & call ..\..\include\latex.nmk.cmd pdf
	set target=
goto :eof
) else (
	..\..\include\latex.nmk.cmd %*
	goto :eof
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
