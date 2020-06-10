@echo off

if "%HG_ROOT%"  == "" set HG_ROOT=C:\OOHG
if "%HG_HRB%"   == "" set HG_HRB=%HG_ROOT%\HB32
if "%HG_CCOMP%" == "" set HG_CCOMP=%HG_HRB%\COMP

set "TPATH=%PATH%"
set "PATH=%HG_HRB%\bin;%HG_CCOMP%\bin"

if "%1" == "" goto ERROR

if exist %1.exe del %1.exe
if exist %1.dll del %1.dll

if /I "%2" == "/D" goto DEBUG

hbmk2 %1.hbp
goto END

:ERROR
echo To try this sample execute TEST.BAT
goto END

:DEBUG
hbmk2 %1.hbp -l%HG_HRB%\%LIB_HRB% -prgflag=-b

:END
set "PATH=%TPATH%"
set TPATH=
