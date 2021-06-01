/*
 * ShellExecute Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use Windows on screen keyboard.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   DEFINE WINDOW Win1 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE "Open Explorer From OOHG"

      @ 10, 10 BUTTON But1 ;
         CAPTION "Open" ;
         ACTION ( ShellExecute( NIL, NIL, "osk.exe", NIL, NIL, SW_SHOWNORMAL ), ;
                  MsgBox( "Execution continued without pause !!!" ) )

      @ 100, 10 LABEL Lbl1 ;
         VALUE "Click button to open On Screen Keyboard" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION Win1.Release()
   END WINDOW

   Win1.Center
   Win1.Activate

RETURN NIL

/*
 * EOF
 */
