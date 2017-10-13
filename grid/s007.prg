/*
 * Grid Sample n° 07
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a Grid with images in a
 * columun using IMAGEDATA ColumnControl.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include 'oohg.ch'

FUNCTION Main()
   LOCAL k, aRows[ 40, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 558 ;
      HEIGHT 460 ;
      TITLE 'Grid with IMAGEDATA ColumnControl' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k :=1 TO LEN( aRows )
          aRows[k] := { { STR( HB_RANDOMINT( 99 ), 2 ), k % 3 }, ;
                        HB_RANDOMINT( 100 ), ;
                        DATE() + RANDOM( HB_RANDOMINT() ), ;
                        'Refer ' + STR( HB_RANDOMINT( 10 ), 2 ), ;
                        HB_RANDOMINT( 10000 ) }
      NEXT k

      @ 10,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 100, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' } ;
         COLUMNCONTROLS { { 'IMAGEDATA', { 'TEXTBOX', 'CHARACTER', '99'} }, ;
                          { 'TEXTBOX', 'NUMERIC', '999999'} , ;
                          { 'TEXTBOX', 'DATE'}, ;
                          { 'TEXTBOX', 'CHARACTER'}, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT INPLACE

      @ 360,10 LABEL lbl_1 ;
         VALUE 'Try the context menu.' ;
         AUTOSIZE

      DEFINE CONTEXT MENU CONTROL Grid_1
         MENUITEM 'Insert Item 2' ;
            ACTION { || oGrid:InsertItem( 2, ;
                        { {'19',2}, 123456, date(), 'Inserted', 100 } ) }
         MENUITEM 'Change Item 3 ' ;
            ACTION { || oGrid:Item( 3, ;
                        { {'00',1}, 654321, date()+100, 'Changed', 200 } ) }
         MENUITEM 'Data in Item 4' ;
            ACTION { || AutoMsgBox( oGrid:Item( 4 ) ) }
      END MENU

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
