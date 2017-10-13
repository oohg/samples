/*
 * Label Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the cursor when the mouse
 * hovers a label, and how to set an action that triggers
 * when the label is clicked.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 330 HEIGHT 200 ;
      TITLE "Label Demo - Change cursor and Set an Action" ;
      MAIN

      @ 20,20 LABEL lbl OBJ oLbl ;
         VALUE "When mouse hovers me you must see a hand cursor." ;
         WIDTH 200 ;
         HEIGHT 50 ;
         TOOLTIP "Click me to trigger an action !!!" ;
         ACTION {|| AutoMsgBox( "Action triggered !!!" ) }

      /*
       * Acceptable values are:
       * a) standard cursors, use constants defined in i_controlmisc.ch
       * b) cursors from resource file, use "name" defined in RC file
       * c) cursors from disk, use "filename"
       */
      oLbl:Cursor := IDC_HAND

      /*
       * The ACTION can also be specified using:
       * oLbl:OnClick := {|| AutoMsgBox( "Action triggered !!!" ) }
       * Form.lbl.OnClick := {|| AutoMsgBox("Action triggered !!!")}
       *
       * To trigger the ACTION in code, use
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
