@echo off

rem Makefile for documents and templates
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

set latexnmk=call ..\..\include\latex.nmk.cmd

if "%1"=="" (
	%latexnmk%
) else (
	for %%f in (%*) do if "%%f"=="help" (
		call :%%f
	) else if "%%f"=="all" (
		%latexnmk% dvi
	) else if "%%f"=="allpdf" (
		%latexnmk% pdf
	) else (
		%latexnmk% %%f
	)
)

exit /b

:help
	echo   all          alias for dvi target
	echo   allpdf       alias for pdf target
	%latexnmk% help
goto :eof

