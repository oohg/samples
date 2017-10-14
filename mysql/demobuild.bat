@echo off
if not exist c:\oohg\hb32\lib\LibDllMySql_O3GH.a copy LibDllMySql_O3GH.a c:\oohg\hb32\lib
set TPATH=%PATH%
set PATH=C:\OOHG
set THR_LIB=-lhbmysql -lDllMySql_O3GH
call COMPILE.BAT demo
set PATH=%TPATH%
set THR_LIB=
