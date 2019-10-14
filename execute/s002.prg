/*
 * Execute File Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to execute a .bat file.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'OOHG - How to execute a BAT file' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Execute + Show' ;
         ACTION ExecBAT( .T. )

      @ 60,20 BUTTON btn_2 ;
         CAPTION 'Execute + Hide' ;
         ACTION ExecBAT( .F. )

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION ExecBAT( lShow )

   IF FILE( "test.bat" )
      ERASE test.bat
   ENDIF

   IF FILE( "done.txt" )
      ERASE done.txt
   ENDIF

   // For WIN 7 & 10 because sometimse file operations are delayed
   HB_IdleSleep( 3 )

   IF lShow
      HB_MemoWrit( 'test.bat', ;
                   "@echo off" + CRLF + ;
                   "echo Executing .bat file ...." + CRLF + ;
                   "pause" + CRLF + ;
                   "exit" + CRLF )
      EXECUTE FILE 'CMD.EXE /K test.bat' WAIT

   ELSE
      IF File( "done.txt" )
         ERASE done.txt
      ENDIF

      HB_MemoWrit( 'test.bat', ;
                   "@echo off" + CRLF + ;
                   "echo Executing .bat file ...." + CRLF + ;
                   "copy test.bat done.txt" + CRLF )

      EXECUTE FILE 'CMD.EXE' PARAMETERS '/C test.bat' HIDE

   // For WIN 7 & 10 because sometimse file operations are delayed
      HB_IdleSleep( 3 )

      IF FILE( "done.txt" )
         MsgInfo( 'File "done.txt" was created!' )
      ELSE
         MsgInfo( "Can't create file " + '"done.txt"!' )
      ENDIF
   ENDIF

   IF FILE( "test.bat" )
      ERASE test.bat
   ENDIF

RETURN NIL

/*
 * EOF
 */
