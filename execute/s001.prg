/*
 * Execute File Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to open a registered type file
 * with it's default application.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'How to Open a Registered Type File' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Open' ;
         ACTION OpenFile()

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION OpenFile

   HB_MemoWrit( 'test.txt', ;
                'This is test file' + hb_OsNewLine() + ;
                'It should open with notepad or' + hb_OsNewLine() + ;
                'the default registered application.'+ hb_OsNewLine() )
   EXECUTE FILE 'CMD.EXE' PARAMETERS '/C test.txt' HIDE

RETURN NIL

/*
 * EOF
 */
