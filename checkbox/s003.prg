/*
 * Checkbox Sample n° 3
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" checkbox
 * over an image control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 *
 * You can download fondo.jpg from:
 * https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/CheckBox
 */

#include "oohg.ch"

FUNCTION Main()
   LOCAL oImg

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 400 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "oohg - Checkbox with transparent background"

      @ 00, 00 IMAGE img_1 ;
         PICTURE "fondo.jpg" ;
         WIDTH 450 HEIGHT 400 ;
         OBJ oImg

      DEFINE CHECKBOX ChkBox
         ROW 70
         COL 10
         WIDTH 280
         VALUE .F.
         CAPTION 'CheckBox with Transparent Background'
         FONTCOLOR BLUE
         THREESTATE .T.
         LEFTALIGN .T.
         BACKGROUND oImg
      END CHECKBOX

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
