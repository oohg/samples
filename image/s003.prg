/*
 * Image Sample n° 3
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" checkbox
 * over an image control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
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
      TITLE "Checkbox with transparent background"

      @ 00, 00 IMAGE img_1 ;
         PICTURE "fondo.jpg" ;
         WIDTH 450 HEIGHT 400 ;
         OBJ oImg

      @ 20,20 RADIOGROUP rdg_1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKGROUND oImg

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
