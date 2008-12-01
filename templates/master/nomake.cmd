@echo off

if "%1"=="all" (
:all
	..\..\include\latex.nmk.cmd dvi
goto :eof
) else if "%1"=="allpdf" (
:allpdf
	..\..\include\latex.nmk.cmd pdf
goto :eof
) else (
	..\..\include\latex.nmk.cmd %*
)

if "%1" neq "" echo Don't know how to make %1
:end
shift & goto :start
