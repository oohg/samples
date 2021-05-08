/*
 * Grid Sample # 37
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to update one column with a
 * value computed from the others.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aRows[5, 4], k

   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 600 ;
      HEIGHT 550 ;
      TITLE 'OOHG - How to calculate a total in a Grid' ;
      MAIN

      FOR k := 1 TO 5
          aRows[k] := { Str( HB_RandomInt(99), 2 ), 0, hb_RandomInt( 100 ), 0 }
      NEXT k

      @ 40,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'QUANTITY', 'PRICE', 'AMOUNT' } ;
         WIDTHS {120, 120, 120, 140} ;
         ITEMS aRows ;
         COLUMNCONTROLS { {'TEXTBOX', 'CHARACTER', "99"}, ;
                          {'TEXTBOX', "NUMERIC", '999'}, ;
                          {'TEXTBOX', "NUMERIC", '999999'}, ;
                          {'TEXTBOX', 'NUMERIC', '999,999,999.99'} } ;
         FONT "COURIER NEW" SIZE 10 ;
         VALUE 1 ;
         APPEND ;
         EDIT INPLACE ;
         FULLMOVE ;
         READONLY { .F., .F., .F., .T. } ;
         ON EDITCELL { |nRow, nCol| CalculateAmount( nRow, nCol ) }

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION CalculateAmount( nRow, nCol )

   LOCAL aItem := oGrid:Item( nRow )

   IF nCol == 2 .OR. nCol == 3
      aItem[ 4 ] := aItem[ 2 ] * aItem[ 3 ]
      oGrid:Item( nRow, aItem )
   ENDIF

   RETURN NIL

/*
 * EOF
 */
