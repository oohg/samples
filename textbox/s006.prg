/*
 * Textbox Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how the buttons asociated to a textbox work.
 * Note that the one defined by the ACTION clause, which corresponds to
 * the rightmost button, does nothing, while the one with the ACTION2
 * clause is executed. This behavior is caused by the CANCEL clause.
 * Without it, the VALID clause takes precedence and the ACTION is
 * ignored, with it, the VALID is ignored and the ACTION is executed.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      OBJ wnd ;
      AT 0,0 ;
      WIDTH 400 HEIGHT 280 ;
      TITLE 'ooHG textbox Demo' ;
      MAIN ;
      FONT "Verdana" ;
      SIZE 14

      @ 10,10 TEXTBOX Txt1 OBJ oTxt1 ;
         WIDTH 200 ;
         HEIGHT 28 ;
         VALUE space(20) ;
         VALID .not. empty( This.Value ) ;
         ACTION {|| MsgInfo("One!"), oTxt1:SetFocus()} TOOLTIP "One!" ;
         ACTION2 {|| MsgInfo("Two!"), oTxt1:SetFocus()} TOOLTIP "Two!" CANCEL

      @ 90,10 BUTTON Move OBJ oMove ;
         CAPTION "Ok" ACTION MsgInfo("OK")

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

	Form_1.Center
	Form_1.Activate

RETURN
