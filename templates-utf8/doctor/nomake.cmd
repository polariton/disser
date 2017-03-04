@echo off

rem Makefile for documents and templates
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

chcp 1251 > nul
set bibtex=biber
set bibtexflags= 
set latexnmk=call ..\..\include\latex.nmk.cmd

if "%1"=="" (
	%latexnmk%
) else (
	for %%f in (%*) do if "%%f"=="help" (
		call :%%f
	) else if "%%f"=="all" (
		call :allpdf
	) else if "%%f"=="allpdf" (
		call :%%f
	) else if "%%f"=="alldvi" (
		call :%%f
	) else (
		%latexnmk% %%f
	)
)

exit /b

:help
	echo   all           build PDF of autoref and thesis
	echo   allpdf        build PDF of autoref and thesis
	echo   alldvi        build DVI of autoref and thesis
	%latexnmk% help
goto :eof

:allpdf
	set target=thesis & %latexnmk% pdf
	set target=autoref & %latexnmk% pdf
	set target=
goto :eof

:alldvi
	set target=thesis & %latexnmk% dvi
	set target=autoref & %latexnmk% dvi
	set target=
goto :eof
