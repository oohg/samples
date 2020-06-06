@echo off

setlocal

if "%HG_ROOT%"=="" set HG_ROOT=C:\OOHG
if "%HG_HRB%"=="" set HG_HRB=%HG_ROOT%\HB32

REM If you want to use hbmk2 to build the exe, uncomment the following line and comment all others:
REM BuildApp s014 -i%HG_ROOT%\hb32\contrib\hbzebra

REM If you want to use harbour and gcc to build the exe, uncomment the following line and comment all others:
REM COMPILE s014

COMPILE s014
