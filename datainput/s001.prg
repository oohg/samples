/*
 * Data Input Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to avoid data validation when the
 * input transaction is canceled.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm1

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      MAIN ;
      NOSYSMENU ;
      TITLE "ooHG - How to avoid validation on transaction's cancel"

      @ 13, 10 LABEL lbl_1 ;
         VALUE "Value" ;
         WIDTH 60 ;
         HEIGHT 24

      @ 10, 70 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         NUMERIC ;
         INPUTMASK "999.9" ;
         VALID {|| oTxt1:value > 0} ;
         WIDTH 60 ;
         HEIGHT 24

      @ 80, 100 BUTTON btn_1 ;
         CAPTION 'Quit' ;
         WIDTH  100 ;
         ACTION oForm1:Release() ;
         CANCEL

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

/*
 * EOF
 */
