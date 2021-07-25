/*
 * Label Sample # 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the alignment of
 * a LABEL control at runtime.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

	DEFINE WINDOW Form_1 OBJ oForm ;
		AT 0,0 ;
		WIDTH 400 HEIGHT 400 ;
		TITLE "oohg - Label Alignment Demo" ;
		MAIN

      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR

      ON KEY ESCAPE ACTION ThisWindow.Release()

      @ 10,10 LABEL Label_1 OBJ oLbl1 ;
         VALUE "Label_1" ;
         WIDTH oForm:ClientWidth - 20  ;
         BORDER ;
         TOOLTIP "Label 1" ;                      // SS_LEFT, default
         ON MOUSEMOVE oForm:Statusbar:Item( 1, Time() ) ;
         ON MOUSELEAVE oForm:Statusbar:Item( 1, "Leave" )

      @ 40,10 LABEL Label_2 OBJ oLbl2 ;
         VALUE "Label_2" ;
         CENTERALIGN ;
         WIDTH oForm:ClientWidth - 20  ;
         BORDER ;
         TOOLTIP "Label 2 CenterAlign"           // SS_CENTER

      @ 70,10 LABEL Label_3 OBJ oLbl3 ;
         VALUE "Label_3" ;
         RIGHTALIGN ;
         WIDTH oForm:ClientWidth - 20  ;
         BORDER ;
         TOOLTIP "Label 3 RightAlign"            // SS_RIGHT

      @ 150,10 LABEL Label_4 ;
         VALUE "Change Align" ;
         WIDTH 200
         
      @ 200,10 BUTTON Button_1 ;
         CAPTION "Lbl_1 Center" ;
         ACTION oLbl1:Align := SS_CENTER 

      @ 250,10 BUTTON Button_2 ;
         CAPTION "Lbl_2 Right" ;
         ACTION oLbl2:Align := SS_RIGHT 

      @ 300,10 BUTTON Button_3 ;
         CAPTION "Lbl_3 Left" ;
         ACTION oLbl3:Align := SS_LEFT

      @ 150,120 LABEL Label_5 ;
         VALUE "Show Align" ;
         WIDTH 200

      @ 200,120 BUTTON Button_4 ;
         CAPTION "Lbl_1" ;
         ACTION ShowAlign( oLbl1:Align )

      @ 250,120 BUTTON Button_5 ;
         CAPTION "Lbl_2" ;
         ACTION ShowAlign( oLbl2:Align )

      @ 300,120 BUTTON Button_6 ;
         CAPTION "Lbl_3" ;
         ACTION ShowAlign( oLbl3:Align )

      @ 150,230 LABEL Label_6 ;
         VALUE "Reset Align" ;
         WIDTH 200

      @ 200,230 BUTTON Button_7 ;
         CAPTION "Lbl_1" ;
         ACTION oLbl1:LeftAlign()

      @ 250,230 BUTTON Button_8 ;
         CAPTION "Lbl_2" ;
         ACTION oLbl2:CenterAlign()

      @ 300,230 BUTTON Button_9 ;
         CAPTION "Lbl_3" ;
         ACTION oLbl3:RightAlign()

	END WINDOW

	CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ShowAlign( nAlign )

   DO CASE
   CASE nAlign == SS_LEFT
      cAlign := "LEFT = " + LTrim( Str( nAlign ) )
   CASE nAlign == SS_CENTER
      cAlign := "CENTER = " + LTrim( Str( nAlign ) )
   CASE nAlign == SS_RIGHT
      cAlign := "RIGHT = " + LTrim( Str( nAlign ) )
   OTHERWISE
      cAlign := LTrim( Str( nAlign ) )
   ENDCASE

   MsgBox( cAlign )

RETURN NIL

/*
 * EOF
 */
