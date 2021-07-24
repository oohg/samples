/*
 * Form Sample n° 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a form with transparent
 * background.
 *
 * Visit us at https://github.com/oohg/samples
 *
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
      ON INIT oForm1:SetBackgroundInvisible()

      @ 30,10 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         VALUE "The form's background is transparent !!!" ;
         WIDTH 400

      @ 60,10 RADIOGROUP rdg_1 ;
         OPTIONS { 'O n e', 'T w o', 'T h r e e', 'F o u r' } ;
         WIDTH 80 ;
         SPACING 25 ;
         SIZE 11 BOLD

      @ 120, 160 LABEL lbl_1 ;
         VALUE "Press ESC to exit!" ;
         AUTOSIZE ;
         SIZE 20 BOLD ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
