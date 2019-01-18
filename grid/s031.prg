/*
 * Grid Sample n° 31
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to simulate a button on
 * a grid's column.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL i, aRows[ 30, 5 ]

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "oohg - Simulate a button on each row of a Browse (image)" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR i := 1 TO 30
          aRows[ i ] := { 0, ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ) }
      NEXT i

      @ 20,20 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { '', 'NUMBER', 'DATE', 'REFERENCE' } ;
         WIDTHS {40, 80, 100, 120} ;
         ITEMS aRows ;
         IMAGE { 'MINIGUI_EDIT_FIND' } ;
         COLUMNCONTROLS { { 'IMAGEDATA' }, ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         ON CLICK {| nMouseRow, nMouseCol, nItem, nCol | iif( nCol == 1, DoSomeAction( nItem ), NIL ) }

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION DoSomeAction( nItem )

   AutoMsgBox( nItem )

RETURN NIL

/*
 * EOF
 */
