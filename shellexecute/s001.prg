/*
 * ShellExecute Sample n� 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use ShellExecute function to
 * open a Explorer window at a given folder.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Win1 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE "Open Explorer From OOHG"

      @ 10, 10 BUTTON But1 ;
         CAPTION "Open" ;
         ACTION ( ShellExecute( 0, "open", GetStartUpFolder(), 0, 0, 1 ), ;
                  MsgBox( "Execution continued without pause !!!" ) )

      @ 100, 10 LABEL Lbl1 ;
         VALUE "Click button to open Explorer" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION Win1.Release()
   END WINDOW

   Win1.Center
   Win1.Activate

RETURN NIL

/*
 * EOF
 */

