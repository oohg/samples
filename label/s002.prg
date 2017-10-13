/*
 * Label Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display a vertical or rotated label
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

#define CRLF Chr(13) + Chr(10)

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ oWin ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      CLIENTAREA ;
      TITLE "OOHG Label Demo" ;
      MAIN

      @ 20, 20 LABEL lbl_1 ;
         VALUE "T" + CRLF + ;
               "h" + CRLF + ;
               "i" + CRLF + ;
               "s" + CRLF + ;
               " " + CRLF + ;
               "i" + CRLF + ;
               "s" + CRLF + ;
               " " + CRLF + ;
               "a" + CRLF + ;
               " " + CRLF + ;
               "v" + CRLF + ;
               "e" + CRLF + ;
               "r" + CRLF + ;
               "t" + CRLF + ;
               "i" + CRLF + ;
               "c" + CRLF + ;
               "a" + CRLF + ;
               "l" + CRLF + ;
               " " + CRLF + ;
               "l" + CRLF + ;
               "a" + CRLF + ;
               "b" + CRLF + ;
               "e" + CRLF + ;
               "l"          ;
         WIDTH 24 ;
         HEIGHT 440

      @ 20, 100 LABEL lbl_2 OBJ oLbl2 ;
         VALUE " This is a rotated label" ;
         WIDTH 150 ;
         HEIGHT 150 ;
         CENTERALIGN ;
         BORDER
      oLbl2:SetFont( NIL, NIL, NIL, NIL, NIL, NIL, -900, NIL )

      @ 20, 260 LABEL lbl_3 OBJ oLbl3 ;
         VALUE " This is another" ;
         WIDTH 150 ;
         HEIGHT 150 ;
         CENTERALIGN ;
         BORDER
      oLbl3:SetFont( NIL, NIL, NIL, NIL, NIL, NIL, -450, NIL )

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
