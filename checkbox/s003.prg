/*
 * Checkbox Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" checkbox
 * over an image control.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download fondo.jpg from:
 * https://github.com/oohg/samples/tree/master/CheckBox
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oImg

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 400 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "OOHG - Transparent CheckBox over an image control"

      @ 00, 00 IMAGE img_1 ;
         OBJ oImg ;
         PICTURE "fondo.jpg" ;
         WIDTH 450 ;
         HEIGHT 400

      DEFINE CHECKBOX ChkBox
         ROW 100
         COL 10
         WIDTH 360
         VALUE .F.
         CAPTION 'CheckBox with Transparent Background'
         FONTCOLOR BLUE
         FONTSIZE 12
         FONTBOLD .T.
         THREESTATE .T.
         LEFTALIGN .T.
         BACKGROUND oImg
         NOFOCUSRECT .T.
      END CHECKBOX

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
