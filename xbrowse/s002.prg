/*
 * XBrowse Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use SET AUTOADJUST ON.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include 'oohg.ch'

FUNCTION Main

   SET AUTOADJUST ON
   
   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "AutoAdjust Sample" ;

      @ 20, 20 XBROWSE XBrowse_1 ;
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
