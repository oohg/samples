@ECHO OFF
if "%HG_ROOT%"="" set HG_ROOT=c:\oohg

SET TPATH=%PATH%
SET PATH=%HG_ROOT%\hb32\bin;%HG_ROOT%\hb32\comp\mingw\bin

DEL %1.EXE

IF "%2"=="/d" GOTO condebug
hbmk2 %1.hbp
GOTO fin

:CONDEBUG
ECHO con debug
pause
hbmk2 %1.hbp -l%HG_ROOT%\hb32\lib\win\mingw -prgflag=-b
GOTO fin

:FIN
SET PATH=%TPATH%
SET TPATH=
