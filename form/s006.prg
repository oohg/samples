/*
 * Form Sample n° 6
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display a message while a process
 * is running.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION MAIN

   PUBLIC oWait

   DEFINE WINDOW MainWin ;
      AT 10, 10 ;
      TITLE "Wait Message" ;
      MAIN

      @ 30, 30 BUTTON btn_Process ;
         CAPTION "Click me" ;
         ACTION Process()

      ON KEY ESCAPE ACTION MainWin.Release
   END WINDOW

   MainWin.Center

   DEFINE WINDOW Form_Wait OBJ oWait  ;
      AT 10, 10 ;
      WIDTH 150 ;
      HEIGHT 100 ;
      CLIENTAREA ;
      CHILD ;
      NOSYSMENU ;
      NOCAPTION ;
      NOSHOW ;
      ON INIT oWait:Center()

      @ 40, 15 LABEL lbl_Msg ;
         WIDTH 120 ;
         CENTERALIGN
   END WINDOW

   ACTIVATE WINDOW MainWin, Form_Wait

RETURN NIL

FUNCTION Process()

   oWait:lbl_Msg:Value := "Please wait ..."
   oWait:Show()

   /*
    * Substitute this line with you process
    */
   hb_IdleSleep( 3 )

   oWait:Hide()

RETURN NIL

/*
 * EOF
 */
