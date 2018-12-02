## How to build this sample

### With COMPILE.BAT

Open "sample.prg" with your favorite editor and uncomment the line (near the top of the line):

    #include "h_pbrowse.prg"
Save the file and build with

    compile sample
Note that your PATH must include C:\OOHG folder.

### With BUILDAPP.BAT

Open "sample.prg" with your favorite editor and comment the line (near the top of the line):

    #include "h_pbrowse.prg"
Save the file and build with

    buildapp sample
Note that your PATH must include C:\OOHG folder.

### With HBMK2.EXE

Open "sample.prg" with your favorite editor and comment the line (near the top of the line):

    #include "h_pbrowse.prg"
Save the file and build with

    hbmk2 sample
Note that

    PATH must include C:\OOHG\HB32\BIN folder
Also the following env vars must exist

    HG_ROOT=C:\OOHG
    LIB_GUI=LIB\HB\MINGW
