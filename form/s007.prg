/*
 * Form Sample n° 7
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a form with transparent
 * background.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 420 ;
      HEIGHT 200 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "Form with transparent background" ;
      BACKCOLOR GRAY ;
      ON INIT SetLayeredWindowAttributes( oForm1:hWnd, RGB_VALUE( oForm1:BackColor ), 0, LWA_COLORKEY )

      @ 30,10 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         VALUE "The form's background is transparent !!!" ;
         WIDTH 400

      @ 60,10 RADIOGROUP rdg_1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil


FUNCTION RGB_VALUE( aColor )

RETURN RGB( aColor[ 1 ], aColor[ 2 ], aColor[ 3 ] )

/*
 * EOF
 */
