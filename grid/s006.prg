/*
 * Grid Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to set a Grid with 'editable'
 * images in the first column. The images can be replaced
 * by anyone of the imagelist asociated with the grid.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()
   LOCAL k, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 558 ;
      HEIGHT 460 ;
      TITLE 'Grid with Editable Images' ;
      MAIN ;
      ON INIT oGrid:ColumnBetterAutoFit(1)

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 15
          aRows[k] := { k % 3, ;
                        Str(HB_RANDOMINT( 99 ), 2), ;
                        HB_RANDOMINT( 100 ), ;
                        Date() + Random( HB_RANDOMINT() ), ;
                        'Refer ' + Str( HB_RANDOMINT( 10 ), 2 ), ;
                        HB_RANDOMINT( 10000 ) }
      NEXT k

      @ 10,10 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { "", 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS {1, 60, 80, 100, 120, 100} ;
         ITEMS aRows ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' } ;
         COLUMNCONTROLS { NIL, ;
                          { 'TEXTBOX', 'CHARACTER', '99'} , ;
                          { 'TEXTBOX', 'NUMERIC', '999999'} , ;
                          { 'TEXTBOX', 'DATE'}, ;
                          { 'TEXTBOX', 'CHARACTER'}, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT INPLACE

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
