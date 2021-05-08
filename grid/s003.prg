/*
 * Grid Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to abort edition in a Grid with
 * Inplace clause using a Timer. It relies on the fact that
 * the editing is done in a modal window called _OOHG_GRIDWN.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL k, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE 'GRID - Abort Edition Using a Timer' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 15
          aRows[ k ] := { Str(HB_RandomInt( 99 ), 2), ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ), ;
                          HB_RandomInt( 10000 ) }
      NEXT k

      @ 20, 20 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 60, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99', NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999', NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL } , ;
                          { 'TEXTBOX', 'DATE', NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL }, ;
                          { 'TEXTBOX', 'CHARACTER', NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99', NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL, NIL } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT INPLACE ;
         VALUE 4 ;
         TIMEOUT 5000

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
