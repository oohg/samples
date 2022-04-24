set HG_OLDLIBS=%HG_ADDLIBS%
set HG_ADDLIBS=%HG_ADDLIBS% -lhbcurl -llibcurl-4
compile s001
set HG_ADDLIBS=%HG_OLDLIBS%
set HG_OLDLIBS=

