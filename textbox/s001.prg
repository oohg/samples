/*
 * Textbox Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to autocomplete a TextBox with
 * DATE clause, using DEFAULTYEAR clause.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oWnd

   SET CENTURY ON
   SET DATE BRITISH
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Win_1 OBJ oWnd ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 400 ;
      TITLE 'Autocomplete Date Textbox'

      ON KEY ESCAPE ACTION oWnd:Release()

      @ 20,20 LABEL lbl_Date ;
         VALUE "With DefaultYear clause:" ;
         AUTOSIZE

      @ 20,200 TEXTBOX txt_Date ;
         WIDTH 100 ;
         HEIGHT 24 ;
         DATE ;
         DEFAULTYEAR Year(Date())

      @ 120,20 LABEL lbl_Value ;
         VALUE "Without DefaultYear clause:" ;
         AUTOSIZE

      @ 120,200 TEXTBOX txt_Value ;
         WIDTH 100 ;
         HEIGHT 24 ;
         DATE

      @ 200, 20 LABEL lbl_Note ;
         VALUE "Enter a partial date and tab outside the field to see what happens." ;
         AUTOSIZE

   END WINDOW

   oWnd:Center()
   oWnd:Activate()

RETURN Nil

/*
 * EOF
 */
