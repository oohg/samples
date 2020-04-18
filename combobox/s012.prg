/*
 * Combobox Sample # 12
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to open the dropdown list when
 * the combobox gets the focus.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW frm_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ComboBox Demo' ;
      MAIN ;
      ON INIT frm_1.btn_1.SetFocus

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Exit" ;
         ACTION ThisWindow:Release()

      @ 50,10 COMBOBOX cmb_1 ;
         OBJ oCombo ;
         ITEMS { "B", "A", "C"  } ;
         ON GOTFOCUS oCombo:ShowDropDown( .T. )

      @ 100, 10 LABEL lbl_1 ;
         VALUE "Use TAB key to move the focus to the combobox control." ;
         AUTOSIZE

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW frm_1
   ACTIVATE WINDOW frm_1

RETURN NIL

/*
 * EOF
 */
