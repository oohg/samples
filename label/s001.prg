/*
 * Label Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the cursor when the mouse
 * hovers a label, and how to trigger an action when the
 * label is clicked.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 440 HEIGHT 200 ;
      TITLE "OOHG - Label Demo: Cursor, Action, Mouse" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR

      @ 20,20 LABEL lbl OBJ oLbl ;
         VALUE "When mouse hovers me you must see a hand cursor." ;
         WIDTH 200 ;
         HEIGHT 100 ;
         CLIENTEDGE ;
         TOOLTIP "Click me to trigger an action !!!" ;
         ACTION {|| AutoMsgBox( "Action triggered !!!" ) } ;
         CURSOR IDC_HAND ;
         ON MOUSEHOVER oWin:StatusBar:Item( 1, "Hover " + Time() ) ;
         ON MOUSELEAVE oWin:StatusBar:Item( 1, "MouseLeave" )

      /*
       * Acceptable values are:
       * a) standard cursors, use constants defined in i_controlmisc.ch
       * b) cursors from resource file, use "name" defined in RC file
       * c) cursors from disk, use "filename"
       *
       * The 'CURSOR IDC_HAND' clause can be replaced by
       * oLbl:Cursor := IDC_HAND
       *
       * The ACTION clause can be replaced by
       * oLbl:OnClick := {|| AutoMsgBox( "Action triggered !!!" ) }
       * or
       * Form.lbl.OnClick := {|| AutoMsgBox("Action triggered !!!")}
       *
       * To trigger the ACTION by code, use
       * Form.lbl.OnClick()
       * Eval( Form.lbl.OnClick )
       * Eval( oLbl:OnClick )
       * Form.lbl.Action()
       * Eval( Form.lbl.Action )
       * Eval( oLbl:Action )
       */

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

/*
 * EOF
 */
