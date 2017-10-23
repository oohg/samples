/*
 * ComboBox Sample n� 7
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution
 * (c) 2002 Roberto Lopez
 * Modified by Ciro Vargas Clemow <cvc@oohg.org>
 *
 * This sample show how to set the caret's position in a
 * ComboBox with DISPLAYEDIT clause and how to force
 * uppercase on DisplayEdit value.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'CaretPos in ComboBox with DisplaEdit Clause' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP 'Test'
            MENUITEM 'Get Value' ;
               ACTION autoMsgInfo( oCombo:Value )
            MENUITEM 'Set Value' ;
               ACTION oCombo:Value := 1
            MENUITEM 'Get DisplayValue' ;
               ACTION MsgInfo( oCombo:DisplayValue )
            MENUITEM 'Set DisplayValue' ;
               ACTION ( oCombo:DisplayValue := 'New Text', ;
                        oCombo:SetFocus(), ;
                        oCombo:CaretPos := 3 )
         END POPUP
      END MENU

      @ 10,10 COMBOBOX Combo_1 OBJ oCombo ;
         ITEMS { 'Orange' , 'Black' , 'Yellow' } ;
         VALUE 1 ;
         DISPLAYEDIT ;
         IMAGE {} ;
         ON DISPLAYCHANGE ForceUpperCase( oCombo, oText )
      oCombo:FontColorSelected := GREEN
      oCombo:BackColorSelected := YELLOW

      @ 50, 10 TEXTBOX Text_1 OBJ oText

   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

RETURN NIL

STATIC FUNCTION ForceUpperCase( oCombo, oText )

  LOCAL nPos := oCombo:CaretPos

  oText:value := oCombo:DisplayValue

  oCombo:DisplayValue := Upper( oCombo:DisplayValue )

  oCombo:CaretPos := nPos

RETURN NIL

/*
 * EOF
 */

