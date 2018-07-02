/*
 * Checkbox Sample n° 6
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define, set and check the state
 * of a leftaligned and a threestate checkboxes. It also
 * show some weird behaviour when the control's background
 * is painted.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

    DEFINE WINDOW Form1 ;
      AT 0, 0 ;
      WIDTH 448 ;
      HEIGHT 176 ;
      TITLE 'oohg - CheckBox demo - WINDRAW' ;
      MAIN ;
      NOSIZE ;
      BACKCOLOR {255,255,204}

      DEFINE MAIN MENU
         POPUP 'CheckBox'
            ITEM 'Set Chk2 to UNCHECKED'     ACTION SetChkState( 0 )
            ITEM 'Set Chk2 to CHECKED'       ACTION SetChkState( 1 )
            ITEM 'Set Chk2 to INDETERMINATE' ACTION SetChkState( 2 )
            SEPARATOR
            ITEM 'Exit' ACTION Form1.Release()
         END POPUP
      END MENU

      @ 22,29 FRAME frm_1 ;                  // If row is set to 23, the top line of
         WIDTH 122 ;                         // the frame disappears. If height is set
         HEIGHT 38                           // to 37 the bottom line disappears.

      @ 30,30 CHECKBOX Chk1 ;                // The background of the control
         CAPTION 'Chk1 LeftAlign' ;          // is 38 pixels high: 8 extra pixels
         WIDTH 120 ;                         // at the top and 2 at the bottom.
         HEIGHT 28 ;
         LEFTALIGN ;
         WINDRAW

      @ 22,199 FRAME frm_2 ;
         WIDTH 122 ;
         HEIGHT 38

      @ 30,200 CHECKBOX Chk2 ;
         OBJ Chk2 ;
         CAPTION 'Chk2 Three State' ;
         WIDTH 120 ;
         HEIGHT 28 ;
         THREESTATE ;
         WINDRAW

      @ 54,29 FRAME frm_3 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk3
         ROW 62
         COL 30                              
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk3 AltSyntax'
         VALUE .T.
         LEFTALIGN .T.
         WINDRAW .T.
       END CHECKBOX

      @ 54,199 FRAME frm_4 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk4
         ROW 62
         COL 200
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk4 AltSyntax'
         VALUE .T.
         TOOLTIP 'Chk4 AltSyntax'
         ONCHANGE ShowState()
         THREESTATE .T.
         WINDRAW .T.
      END CHECKBOX

      ON KEY ESCAPE ACTION Form1.Release()
   END WINDOW

   CENTER WINDOW Form1
   ACTIVATE WINDOW Form1

RETURN NIL


FUNCTION SetChkState( nState )

   DO CASE
   CASE nState == 0                 // UNCHECKED
      Form1.Chk2.Value := .F.
   CASE nState == 1                 // CHECKED
      Form1.Chk2.Value := .T.
   OTHERWISE                        // INDETERMINATE
      Form1.Chk2.Value := NIL
   ENDCASE

RETURN NIL


FUNCTION ShowState()
   LOCAL uValue := Form1.Chk4.Value

   DO CASE
   CASE uValue == NIL
      MsgInfo('Chk4 status is INDETERMINATE')
   CASE uValue == .T.
      MsgInfo('Chk4 status is CHECKED')
   OTHERWISE
      MsgInfo('Chk4 status is UNCHECKED')
   ENDCASE

RETURN NIL

/*
 * EOF
 */
