/*
 * Radiogroup Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" 
 * radiogroup over an image control.
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
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 300 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "oohg - Transparent radiogroup over an image control"

      @ 00, 00 IMAGE img_1 ;
         OBJ oImg ;
         PICTURE "logo.jpg" ;
         IMAGESIZE

      @ 20, 20 RADIOGROUP rdg_1 ;
         OPTIONS { 'OOHGDRAW', 'Two', 'Three', 'Four' } ;
         SPACING 25 ;
         FONTCOLOR RED BOLD ;
         OOHGDRAW ;
         TRANSPARENT ;
         BACKGROUND oImg

      @ 20, 220 RADIOGROUP rdg_2 ;
         OPTIONS { 'WINDRAW', 'Two', 'Three', 'Four' } ;
         SPACING 25 ;
         FONTCOLOR RED BOLD ;
         WINDRAW ;
         TRANSPARENT ;
         BACKGROUND oImg

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
