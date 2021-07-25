/*
 * Label Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set and clear the clientedge
 * extended style on a label.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 330 HEIGHT 200 ;
      TITLE "Label Demo - Change cursor and Set an Action" ;
      MAIN

      @ 20,20 LABEL lbl OBJ oLabel ;
         VALUE "Label without clientedge." ;
         WIDTH 200

      @ 60, 20 BUTTON btn_Set ;
         CAPTION "Set" ;
         ACTION SetClienteEdgeOn()

      @ 100, 20 BUTTON btn_Clear ;
         CAPTION "Clear" ;
         ACTION SetClienteEdgeOff()

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL


FUNCTION SetClienteEdgeOn

   IF IsWindowExStyle( oLabel:hWnd, WS_EX_CLIENTEDGE )
      AutoMsgBox( "Nothing done!")
   ELSE
      oLabel:ExStyle( oLabel:ExStyle() + WS_EX_CLIENTEDGE )
      oLabel:Value := "Label with clientedge."
   ENDIF

RETURN NIL


FUNCTION SetClienteEdgeOff

   IF IsWindowExStyle( oLabel:hWnd, WS_EX_CLIENTEDGE )
      oLabel:ExStyle( oLabel:ExStyle() - WS_EX_CLIENTEDGE )
      oLabel:Value := "Label without clientedge."
   ELSE
      AutoMsgBox( "Nothing done!")
   ENDIF

RETURN NIL

/*
 * EOF
 */
