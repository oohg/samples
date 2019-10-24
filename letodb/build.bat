@echo off
if "%HG_ROOT%"="" set HG_ROOT=c:\oohg
set "TPATH=%PATH%"
set "PATH=%HG_ROOT%"
set HG_ADDLIBS_TEMP=%HG_ADDLIBS%
set HG_ADDLIBS=%HG_ADDLIBS% -lrddleto
call COMPILE.BAT demo
set "PATH=%TPATH%"
set HG_ADDLIBS=%HG_ADDLIBS_TEMP%
