@echo off

set latexnmk=call ..\..\include\latex.nmk.cmd

if "%1"=="all" (
:all
	%latexnmk% dvi
goto :eof
) else if "%1"=="allpdf" (
:allpdf
	%latexnmk% pdf
goto :eof
) else (
	%latexnmk% %*
)
