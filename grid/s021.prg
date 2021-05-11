/*
 * Grid Sample # 21
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use SET AUTOADJUST ON to automatically
 * resize the controls of a form whenever the form is resized.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main
   LOCAL oGrid

   SET AUTOADJUST ON
   
   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "AutoAdjust Sample" ;

      @ 20, 20 GRID Grid_1 ;
         OBJ oGrid ;
         WIDTH 600 ;
         HEIGHT 400 ;
         HEADERS {'Col.1', 'Col.2'} ;
         WIDTHS { 200, 200 }

      @ 430, 20 LABEL Label_1 ;
         WIDTH 600 ;
         VALUE "The columns will maintain its proportions " + ;
               "whenever the form is resized." ;
         FONTCOLOR RED
   END WINDOW

   ACTIVATE WINDOW Form_1
RETURN NIL

/*
 * EOF
 */
