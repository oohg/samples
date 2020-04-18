/*
 * Combobox Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to associate images with items
 * using IMAGE clause.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download all the images from
 * https://github.com/oohg/samples/tree/master/combobox
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 200 ;
      TITLE 'ooHG - ComboBox with Images from List' ;
      MAIN

      @ 10,10 COMBOBOX Combo_1 obj oCombo ;
         ITEMS { {'A', 0}, {'B', 1}, {'C', 2} } ;
         VALUE 1 ;
         IMAGE {"albaran.bmp", "info.bmp", "globe.bmp"} ;
         FIT ;
         TEXTHEIGHT 48 ;
         HEIGHT 300 ;
         BACKCOLOR YELLOW

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
