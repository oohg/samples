@echo off

if "%HG_ROOT%"=="" set HG_ROOT=c:\oohg

REM If you want to use hbmk2 to build the exe, uncomment the following line and comment all others:
REM BuildApp s001 -i%HG_ROOT%\hb32\contrib\hbzebra

REM If you want to use harbour and gcc to build the exe, uncomment the following line and comment all others:
REM COMPILE s001 -i%HG_ROOT%\hb32\contrib\hbzebra

COMPILE s001 -i%HG_ROOT%\hb32\contrib\hbzebra
