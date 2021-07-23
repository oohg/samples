/*
 * Checkbox Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define, set and check the state
 * of a leftaligned and a threestate checkboxes. It also
 * shows how the control behaves under different settings.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'OOHG - CheckBox clauses OOHGDRAW and WINDRAW' ;
      MAIN ;
      NOSIZE 

      DEFINE MAIN MENU
         POPUP 'CheckBox'
            ITEM 'Set Chk2 to UNCHECKED'     ACTION SetChkState( 0 )
            ITEM 'Set Chk2 to CHECKED'       ACTION SetChkState( 1 )
            ITEM 'Set Chk2 to INDETERMINATE' ACTION SetChkState( 2 )
            SEPARATOR
            ITEM 'Exit' ACTION Form1.Release()
         END POPUP
      END MENU

      @ 30, 30 LABEL Lbl_1 ;
         VALUE "OOHGDRAW" ;
         TRANSPARENT

      @ 52,29 FRAME frm_1 ;                  // If row is set to 23, the top line of
         WIDTH 122 ;                         // the frame disappears. If height is set
         HEIGHT 38                           // to 37 the bottom line disappears.

      @ 60,30 CHECKBOX Chk1 ;                // The background of the control
         CAPTION 'Chk1 LeftAlign' ;          // is 38 pixels high: 8 extra pixels
         WIDTH 120 ;                         // at the top and 2 at the bottom.
         HEIGHT 28 ;
         LEFTALIGN ;
         OOHGDRAW
      // Control has no BACKGROUND so it inherits from Form1.
      // At start time control appears "transparent" because it's background matches the form's.
      // When the form's backcolor changes the transparency dissapears.
      // When TRANSPARENT is set to .T. the control appears "transparent" regardless its backcolor.

      @ 52,199 FRAME frm_2 ;
         WIDTH 122 ;
         HEIGHT 38

      @ 60,200 CHECKBOX Chk2 ;
         OBJ Chk2 ;
         CAPTION 'Chk2 Three State' ;
         WIDTH 120 ;
         HEIGHT 28 ;
         THREESTATE ;
         FONTCOLOR RED ;
         OOHGDRAW
      // Same as Chk1, except FONTCOLOR is honored.

      @ 60, 350 BUTTON But_1 ;
         CAPTION "Chg Ctrl BkClr" ;
         ACTION ChangeCtrlBkClr()

      @ 60, 500 BUTTON But_2 ;
         CAPTION "Chg Ctrl FntClr" ;
         ACTION ChangeCtrlFntClr()

      @ 84,29 FRAME frm_3 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk3
         ROW 92
         COL 30
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk3 AltSyntax'
         VALUE .T.
         LEFTALIGN .T.
         OOHGDRAW .T.
       END CHECKBOX
      // Same as Chk1

      @ 84,199 FRAME frm_4 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk4
         ROW 92
         COL 200
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk4 AltSyntax'
         VALUE .T.
         TOOLTIP 'Chk4 AltSyntax'
         ONCHANGE ShowState()
         THREESTATE .T.
         FONTCOLOR RED
         OOHGDRAW .T.
      END CHECKBOX
      // Same as Chk2

      @ 130, 30 LABEL Lbl_2 ;
         VALUE "WINDRAW" ;
         BACKCOLOR GREEN

      @ 152,29 FRAME frm_5 ;                 // If row is set to 23, the top line of
         WIDTH 122 ;                         // the frame disappears. If height is set
         HEIGHT 38                           // to 37 the bottom line disappears.

      @ 160,30 CHECKBOX Chk5 ;               // The background of the control
         CAPTION 'Chk1 LeftAlign' ;          // is 38 pixels high: 8 extra pixels
         WIDTH 120 ;                         // at the top and 2 at the bottom.
         HEIGHT 28 ;
         LEFTALIGN ;
         WINDRAW
      // Same as Chk1

      @ 152,199 FRAME frm_6 ;
         WIDTH 122 ;
         HEIGHT 38

      @ 160,200 CHECKBOX Chk6 ;
         OBJ Chk2 ;
         CAPTION 'Chk2 Three State' ;
         WIDTH 120 ;
         HEIGHT 28 ;
         THREESTATE ;
         FONTCOLOR RED ;
         WINDRAW
      // Same as Chk1, except FONTCOLOR is not honored.

      @ 160, 350 BUTTON But_3 ;
         CAPTION "Chg Form BkClr" ;
         ACTION ChangeFormBkClr()

      @ 184,29 FRAME frm_7 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk7
         ROW 192
         COL 30
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk3 AltSyntax'
         VALUE .T.
         LEFTALIGN .T.
         WINDRAW .T.
       END CHECKBOX
      // Same as Chk3

      @ 184,199 FRAME frm_8 ;
         WIDTH 122 ;
         HEIGHT 38

      DEFINE CHECKBOX Chk8
         ROW 192
         COL 200
         WIDTH 120
         HEIGHT 28
         CAPTION 'Chk4 AltSyntax'
         VALUE .T.
         TOOLTIP 'Chk4 AltSyntax'
         ONCHANGE ShowState()
         THREESTATE .T.
         FONTCOLOR RED
         WINDRAW .T.
      END CHECKBOX
      // Same as Chk4, except FONTCOLOR is not honored.

      @ 240, 30 BUTTON But_4 ;
         CAPTION "Toggle Frames" ;
         ACTION TglFrames()

      @ 280, 30 BUTTON But_5 ;
         CAPTION "Tgl Transparent" ;
         ACTION TglTransparent()

      @ 282, 150 LABEL Lbl_3 ;
         VALUE "Transparent .F." ;
         TRANSPARENT

      @ 240, 280 FRAME frm_9 ;
         CAPTION "Font + Color " ;
         WIDTH 100 ;
         HEIGHT 100 ;
         FONTCOLOR RED ;
         UNDERLINE
      // Windows ignores FONTCOLOR

      @ 240, 400 FRAME frm_10 ;
         CAPTION "Font + BkColor " ;
         WIDTH 100 ;
         HEIGHT 100 ;
         BACKCOLOR RED ;
         ITALIC
      // Windows ignores BACKCOLOR

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

FUNCTION ChangeCtrlBkClr

   STATIC lSwitch := .T.

   IF lSwitch
      Form1.Chk1.BackColor := BLUE
      Form1.Chk5.BackColor := BLUE
   ELSE
      Form1.Chk1.BackColor := Form1.BackColor
      Form1.Chk5.BackColor := Form1.BackColor
      // Both OOHGDRAW and WINDRAW honor the backcolor when TRANSPARENT is .F.
   ENDIF
   lSwitch := ! lSwitch

   RETURN NIL

FUNCTION ChangeCtrlFntClr

   STATIC lSwitch := .T.

   IF lSwitch
      Form1.Chk1.FontColor := BLUE
      Form1.Chk5.FontColor := BLUE
   ELSE
      Form1.Chk1.FontColor := Form1.FontColor
      Form1.Chk5.FontColor := Form1.FontColor
   ENDIF
   lSwitch := ! lSwitch

   RETURN NIL

FUNCTION ChangeFormBkClr

   STATIC lSwitch := .T.

   IF lSwitch
      Form1.BackColor := YELLOW
      Form1.BackColor := YELLOW
   ELSE
      Form1.BackColor := NIL
      Form1.BackColor := NIL
   ENDIF
   lSwitch := ! lSwitch

   RETURN NIL

FUNCTION TglFrames

   Form1.frm_1.Visible := ! Form1.frm_1.Visible
   Form1.frm_2.Visible := ! Form1.frm_2.Visible
   Form1.frm_3.Visible := ! Form1.frm_3.Visible
   Form1.frm_4.Visible := ! Form1.frm_4.Visible
   Form1.frm_5.Visible := ! Form1.frm_5.Visible
   Form1.frm_6.Visible := ! Form1.frm_6.Visible
   Form1.frm_7.Visible := ! Form1.frm_7.Visible
   Form1.frm_8.Visible := ! Form1.frm_8.Visible

   RETURN NIL

FUNCTION TglTransparent

   Form1.Chk1.Transparent := ! Form1.Chk1.Transparent
   Form1.Chk2.Transparent := ! Form1.Chk2.Transparent
   Form1.Chk3.Transparent := ! Form1.Chk3.Transparent
   Form1.Chk4.Transparent := ! Form1.Chk4.Transparent
   Form1.Chk5.Transparent := ! Form1.Chk5.Transparent
   Form1.Chk6.Transparent := ! Form1.Chk6.Transparent
   Form1.Chk7.Transparent := ! Form1.Chk7.Transparent
   Form1.Chk8.Transparent := ! Form1.Chk8.Transparent
   Form1.Redraw

   Form1.Lbl_3.Value := "Transparent " + iif( Form1.Chk1.Transparent, ".T.", ".F. ")

   RETURN NIL

/*
 * EOF
 */
