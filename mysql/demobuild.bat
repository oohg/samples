@echo off
if "%HG_ROOT%"="" set HG_ROOT=c:\oohg
if not exist %HG_ROOT%\hb32\lib\LibDllMySql_O3GH.a copy LibDllMySql_O3GH.a %HG_ROOT%\hb32\lib
set "TPATH=%PATH%"
set "PATH=%HG_ROOT%"
set THR_LIB=-lhbmysql -lDllMySql_O3GH
call COMPILE.BAT demo
set "PATH=%TPATH%"
set THR_LIB=
