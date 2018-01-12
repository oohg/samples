@echo off
call BUILDAPP servergu -rebuild
start servergu
call BUILDAPP netiotst -rebuild
netiotst
