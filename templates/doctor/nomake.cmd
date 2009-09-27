@echo off

rem Makefile for documents and templates
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

set latexnmk=call ..\..\include\latex.nmk.cmd

if "%1"=="help" (
:help
	%latexnmk% help
	echo   all        build DVI of autoref and thesis
	echo   allpdf     build PDF of autoref and thesis
goto :eof
) else if "%1"=="all" (
:all
	set target=thesis & %latexnmk% dvi
	set target=autoref & %latexnmk% dvi
	set target=
goto :eof
) else if "%1"=="allpdf" (
:allpdf
	set target=thesis & %latexnmk% pdf
	set target=autoref & %latexnmk% pdf
	set target=
goto :eof
) else (
	%latexnmk% %*
)
