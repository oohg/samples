@echo off
if "%HG_ROOT%"=="" set HG_ROOT=c:\oohg
if not exist %HG_ROOT%\hb32\lib\LibDllMySql_O3GH.a copy LibDllMySql_O3GH.a %HG_ROOT%\hb32\lib
set "TPATH=%PATH%"
set "PATH=%HG_ROOT%"
set HG_ADDLIBS_TEMP=%HG_ADDLIBS%
set HG_ADDLIBS=%HG_ADDLIBS% -lhbmysql -lDllMySql_O3GH
call COMPILE.BAT demo
set "PATH=%TPATH%"
set HG_ADDLIBS=%HG_ADDLIBS_TEMP%
