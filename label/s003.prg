/*
 * Label Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create multiline labels.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 330 HEIGHT 200 ;
      TITLE "Multiline Label Demo" ;
      MAIN

      @ 20,20 LABEL lbl OBJ oLbl ;
         VALUE "This is a multiline " + HB_OSNewLine() + ;
               "label." + HB_OSNewLine() + ;
               "I am the third line !!!" ;
         WIDTH 200 ;
         HEIGHT 50 ;
         BORDER ;
         ONDBLCLICK AutoMsgBox("DblClick")

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

/*
 * EOF
 */
