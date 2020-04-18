/*
 * ComboBox Sample # 9
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set/edit/get the displayed
 * value and how to set its maximum length.
 *
 * Based on the original MINIGUI sample by Roberto López,
 * modified by Ciro Vargas Clemow.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ComboBox Demo' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP 'Test'
            MENUITEM 'Get Value'        ACTION autoMsgInfo(oCombo:Value)
            MENUITEM 'Set Value to 1'   ACTION oCombo:Value := 1
            MENUITEM 'Get DisplayValue' ACTION MsgInfo( oCombo:DisplayValue )
            MENUITEM 'Set DisplayValue' ACTION oCombo:DisplayValue := 'New Text'
         END POPUP
      END MENU

      @ 10,10 COMBOBOX Combo_1 OBJ oCombo ;
         ITEMS { 'A', 'B', 'C' } ;
         VALUE 1 ;
         DISPLAYEDIT MAXLENGTH 20 ;
         ON DISPLAYCHANGE PlayBeep()

      @ 10,210 COMBOBOX Combo_2 ;
         ITEMS { 'A', 'B', 'C' } ;
         VALUE 1 ;
         DISPLAYEDIT MAXLENGTH 20 NOHSCROLL

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
