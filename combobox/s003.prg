/*
 * Combobox Sample n° 3
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change an item in a
 * sorted combobox.
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
      TITLE 'ComboBox Demo' ;
      MAIN

      @ 10,10 COMBOBOX cmb_1 ;
         OBJ oCombo ;
         ITEMS { "B" , "A" , "C"  } ;
         VALUE 3 ;
         SORT

      @ 50, 10 BUTTON boton ;
         CAPTION "Change" ;
         ACTION {|| AutoMsgBox(oCombo:value), ;
                    oCombo:Item(2, "Z"), ;
                    AutoMsgBox(oCombo:value) }

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
