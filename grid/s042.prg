/*
 * Grid Sample # 42
 * Author: Miguel Ingles <miguelsuizowin@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the MARKROW clause and the MarkRow
 * property: the current cell is painted with the selection colors
 * and the rest of the selected row with a lighter color.
 * Use the left and right arrows, or click a cell, to move the marked
 * cell.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL i, oGrid, aRows := {}

   FOR i := 1 TO 30
      AAdd( aRows, { StrZero( i, 4 ), "Customer " + LTrim( Str( i ) ), "City " + LTrim( Str( i ) ), ;
                     Transform( i * 125.5, "999,999.99" ) } )
   NEXT i

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 560 ;
      HEIGHT 420 ;
      TITLE "Grid with MARKROW" ;
      MAIN

      @ 10, 10 GRID Grid_1 OBJ oGrid ;
         WIDTH 530 ;
         HEIGHT 300 ;
         HEADERS { "Code", "Name", "City", "Amount" } ;
         WIDTHS { 70, 180, 150, 100 } ;
         ITEMS aRows ;
         VALUE 1 ;
         MARKROW .T.

      @ 320, 10 BUTTON Button_1 ;
         CAPTION "Light blue (.T.)" ;
         WIDTH 125 ;
         ACTION oGrid:MarkRow := .T.

      @ 320, 145 BUTTON Button_2 ;
         CAPTION "Yellow (array)" ;
         WIDTH 125 ;
         ACTION oGrid:MarkRow := { NIL, { 255, 255, 180 }, NIL, { 240, 240, 200 } }

      @ 320, 280 BUTTON Button_3 ;
         CAPTION "Disable (.F.)" ;
         WIDTH 125 ;
         ACTION oGrid:MarkRow := .F.

      @ 320, 415 BUTTON Button_4 ;
         CAPTION "Show column" ;
         WIDTH 125 ;
         ACTION MsgInfo( "Row: " + LTrim( Str( oGrid:Value ) ) + "  Column: " + LTrim( Str( oGrid:nMarkCol ) ) )
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */
