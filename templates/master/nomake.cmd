@echo off

if "%1"=="all" (
:all
	call ..\..\include\latex.nmk.cmd dvi
goto :eof
) else if "%1"=="allpdf" (
:allpdf
	call ..\..\include\latex.nmk.cmd pdf
goto :eof
) else (
	call ..\..\include\latex.nmk.cmd %*
)
