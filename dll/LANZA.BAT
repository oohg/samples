@ECHO OFF
SET _PATH2=%PATH%
SET PATH=c:\oohg\harbour\bin;c:\oohg\mingw\bin;

DEL %1.EXE

IF "%2"=="/d" GOTO condebug
hbmk2 %1.hbp
GOTO fin

:CONDEBUG
ECHO con debug
pause
hbmk2 %1.hbp -lc:\oohg\harbour\lib\win\mingw -prgflag=-b
GOTO fin

:FIN
rem SET PATH=%_PATH2%
rem \upx\upx %1.exe -9
SET _PATH2=
