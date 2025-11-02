@echo off

cls
echo Building DLL sample...
echo.

call build somedll
echo.
call build testdll
echo.
pause

testdll.exe
