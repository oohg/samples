@echo off
rem
rem $Id: build.bat $
rem

SET DISCO=%~d1
SET OOHGPATH=%DISCO%\oohg

%OOHGPATH%\2buildapp.bat %*
