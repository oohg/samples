/*
 * Mixed mode Sample #1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to open forms from a
 * console interfase.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

REQUEST HB_GT_WIN_DEFAULT

FUNCTION Main()

   LOCAL cOption := 1

   SetMode( 25, 80 )
   CLEAR SCREEN

   @ 01, 00 SAY "OOHG - MIXEDMODE Sample"
   @ 03, 00 SAY "Built with: " + OOHGVersion()
   @ 04, 00 SAY "            " + hb_Compiler()
   @ 05, 00 SAY "            " + Version()

   DO WHILE .T.
      @ 10, 10 SAY "Option 1"
      @ 12, 10 SAY "Option 2"
      @ 16, 10 SAY "Enter option number or 0 to exit: " GET cOption PICTURE '9'
      READ

      DO CASE
      CASE cOption == 0
         EXIT
      CASE cOption == 1
         Option1()
      CASE cOption == 2
         Option2()
      ENDCASE
   ENDDO

   RETURN NIL

FUNCTION Option1

   DEFINE WINDOW Win1 ;
      TITLE 'Option 1' ;
      AT 100, 100
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1

   RETURN NIL

FUNCTION Option2

   DEFINE WINDOW Win2 ;
      TITLE 'Option 2' ;
      AT 200, 200
   END WINDOW

   CENTER WINDOW Win2
   ACTIVATE WINDOW Win2

   RETURN NIL

/*
 * EOF
 */
