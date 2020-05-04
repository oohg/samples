/*
 * Data Input Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to make a data input form with
 * data validations (via VALID clause) and how to implement
 * the form's fields reset (ignoring the validations).
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 80,80 ;
      WIDTH 508 ;
      HEIGHT 138 ;
      MAIN ;
      TITLE "ooHG - Reset data input when using VALID clause"

      @ 30, 190 BUTTON btn_1 ;
         CAPTION 'Start Data Input' ;
         WIDTH  120 ;
         ACTION DataInput() ;
         CANCEL

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   Form_1.Activate

RETURN NIL

FUNCTION DataInput()

   LOCAL oForm2, oTxt2, oTxt3

   DEFINE WINDOW Form_2 ;
      OBJ oForm2 ;
      AT 0,0 ;
      WIDTH 300 ;
      HEIGHT 200 ;
      TITLE "Data Input Form"

      @ 13, 10 LABEL lbl_1 ;
         VALUE "Name" ;
         WIDTH 60 ;
         HEIGHT 24

      @ 10, 70 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         WIDTH 140 ;
         HEIGHT 24 ;
         MAXLENGTH 10 ;
         VALUE "<name>"

      @ 43, 10 LABEL lbl_2 ;
         VALUE "Value" ;
         WIDTH 60 ;
         HEIGHT 24

      @ 40, 70 TEXTBOX txt_2 ;
         OBJ oTxt2 ;
         NUMERIC ;
         INPUTMASK "999.9" ;
         VALID {|| iif( oTxt2:value > 0, .T., ( Tone( 1500, 2 ), .F. ) ) } ;
         WIDTH 60 ;
         HEIGHT 24 ;
         VALUE 3

      @ 73, 10 LABEL lbl_3 ;
         VALUE "Notes" ;
         WIDTH 60 ;
         HEIGHT 24

      @ 70, 70 TEXTBOX txt_3 ;
         OBJ oTxt3 ;
         WIDTH 140 ;
         HEIGHT 24 ;
         MAXLENGTH 100 ;
         VALUE "<name>"

      @ 120, 100 BUTTON btn_1 ;
         CAPTION 'Cancel' ;
         WIDTH  100 ;
         ACTION {|| oTxt1:value := "<name>", ;
                    oTxt2:value := 3, ;
                    oTxt3:value := "<notes>", ;
                    oTxt1:setfocus()} ;
         CANCEL

      ON KEY ESCAPE ACTION oForm2:Release()
   END WINDOW

   oForm2:Center()
   oForm2:Activate()

RETURN NIL

/*
 * EOF
 */
