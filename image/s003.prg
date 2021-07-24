/*
 * Image Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" checkbox
 * over an image control.
 *
 * Visit us at https://github.com/oohg/samples
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
      TITLE "Controls with transparent background"

      @ 00, 00 IMAGE img_1 ;
         PICTURE "logo.jpg" ;
         WIDTH 450 HEIGHT 400 ;
         OBJ oImg

      @ 220,300 RADIOGROUP rdg_1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 25 ;
         FONTCOLOR RED BOLD ;
         BACKGROUND oImg

      @ 100,160 CHECKBOX chk_1 ;
         WIDTH 130 ;
         VALUE .F. ;
         CAPTION 'CheckBox ' ;
         FONTCOLOR BLUE BOLD UNDERLINE SIZE 12 ;
         LEFTALIGN ;
         BACKGROUND oImg

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
