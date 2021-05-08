/*
 * Grid Sample # 20
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an IMAGELIST ColumnControl.
 * The control uses the item's value (a zero based number)
 * to display one of the images in IMAGE clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()
   LOCAL k, aRows[ 40, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 658 ;
      HEIGHT 460 ;
      TITLE 'Grid with IMAGELIST ColumnControl' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k :=1 TO LEN( aRows )
          aRows[k] := { HB_RANDOMINT( 100 ), ;
                        DATE() + RANDOM( HB_RANDOMINT() ), ;
                        'Refer ' + STR( HB_RANDOMINT( 10 ), 2 ), ;
                        HB_RANDOMINT( 10000 ), ;
                        k % 3 }
      NEXT k

      @ 10,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 620 ;
         HEIGHT 330 ;
         HEADERS { 'NUMBER', ;
                   'DATE', ;
                   'REFERENCE', ;
                   'AMOUNT', ;
                   'STATUS' } ;
         WIDTHS { 100, ;
                  100, ;
                  120, ;
                  140, ;
                  100 } ;
         ITEMS aRows ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '999999'} , ;
                          { 'TEXTBOX', 'DATE'}, ;
                          { 'TEXTBOX', 'CHARACTER'}, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' }, ;
                          { 'IMAGELIST' } } ;
         JUSTIFY { GRID_JTFY_RIGHT, ;
                   GRID_JTFY_CENTER, ;
                   GRID_JTFY_LEFT, ;
                   GRID_JTFY_RIGHT, ;
                   GRID_JTFY_LEFT } ;
         READONLY { .F., .F., .F., .F., .T. } ;
         EDIT INPLACE

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
