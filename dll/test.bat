@echo off

cls
echo Building DLL sample...
echo.

call build somedll
echo.
call build testdll
echo.
pause

set "TPATH=%PATH%"
set "PATH=%HG_HRB%\bin;%HG_CCOMP%\bin"

testdll.exe

set "PATH=%TPATH%"
set TPATH=
