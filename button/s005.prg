/*
 * Button Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use CHECKBUTTON controls.
 * It also serves as a test case for the TButton class.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION MAIN

   DEFINE WINDOW Form1 ;
      MAIN ;
      TITLE "oohg - CheckButton sample" ;
      WIDTH 400

      @ 20, 20 CHECKBUTTON cbt_1 ;
         OBJ oCbt1 ;
         CAPTION "ONE" ;
         WINDRAW ;
         VALUE .T. ;
         TOOLTIP "I'm a WINDRAW checkbox, click me!"

      @ 50, 20 CHECKBUTTON cbt_2 ;
         OBJ oCbt2 ;
         CAPTION "TWO" ;
         FONTCOLOR BLUE ;
         BACKCOLOR WHITE ;
         ON CHANGE ChangeColors() ;
         SOLID ;
         VALUE .T. ;
         TOOLTIP "I'm a OOHGDRAW checkbox, click me!"

      @ 90, 20 BUTTON btn_1 ;
         WIDTH 200 ;
         CAPTION "Change checkbutton 1" ;
         ACTION ( oCbt1:Value := ! oCbt1:Value )

      @ 120, 20 BUTTON btn_2 ;
         WIDTH 200 ;
         CAPTION "Change checkbutton 2" ;
         ACTION ( oCbt2:Value := ! oCbt2:Value )

      @ 160, 20 BUTTON btn_3 ;
         OBJ oBt3 ;
         WIDTH 200 ;
         CAPTION "Show checkboxes values" ;
         ACTION AutoMsgBox( {"Ckb_1 ->", oCbt1:Value, "   ", "Ckb_2 ->", oCbt2:Value} )

      @ 200, 20 LABEL lbl_1 ;
         WIDTH 400 ;
         HEIGHT 60 ;
         VALUE "The value of the checkbox can be changed programmatically or" + CRLF + ;
               "by clicking on the control. When the checkbox is highlighted" + CRLF + ;
               "its value is .T., otherwise is .F."

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   oBt3:SetFocus()

   CENTER WINDOW Form1
   ACTIVATE WINDOW Form1

RETURN NIL

FUNCTION ChangeColors

   IF oCbt2:Value
      oCbt2:FontColor := BLUE
      oCbt2:BackColor := WHITE
   ELSE
      oCbt2:FontColor := WHITE
      oCbt2:BackColor := SILVER
   ENDIF

RETURN NIL

/*
 * EOF
 */
