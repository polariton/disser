@echo off

rem nomake script for LaTeX projects
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

if "%CMDEXTVERSION%"=="" (
	echo Error: This script requires command interpreter from Windows 2000 or above.
	goto :eof
)

if "%1"=="help" (
	set subdirs=bachelor
) else (
	set subdirs=bachelor ..\master ..\candidate ..\doctor
)

for %%i in (%subdirs%) do @cd %%i & nomake %1 %2 %3 %4 %5 %6 %7 %8 %9
cd ..