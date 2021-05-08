/*
 * Grid Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to set a Grid with checkboxes.
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
      TITLE 'Grid with Checkboxes' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k :=1 TO 15
          aRows[k] := { STR( HB_RANDOMINT( 99 ), 2 ), ;
                        HB_RANDOMINT( 100 ), ;
                        DATE() + RANDOM( HB_RANDOMINT() ), ;
                        'Refer ' + STR( HB_RANDOMINT( 10 ), 2 ), ;
                        HB_RANDOMINT( 10000 ) }
      NEXT k

      @ 10,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 60, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99'} , ;
                          { 'TEXTBOX', 'NUMERIC', '999999'} , ;
                          { 'TEXTBOX', 'DATE'}, ;
                          { 'TEXTBOX', 'CHARACTER'}, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT INPLACE ;
         CHECKBOXES ;
         ON CHECKCHANGE { |nItem| MsgBox( "Item " + ;
                                          LTRIM( STR( nItem ) ) + ;
                                          " checkbox changed !!!" ) }

      @ 360,10 LABEL lbl_1 ;
         VALUE 'Try the context menu. Use the mouse or the ' + ;
               'spacebar to check/uncheck items.' ;
         AUTOSIZE

      DEFINE CONTEXT MENU CONTROL Grid_1
         MENUITEM 'Check Item' ;
            ACTION { || oGrid:CheckItem( oGrid:Value, .T. ) }
         MENUITEM 'Uncheck Item' ;
            ACTION { || oGrid:CheckItem( oGrid:Value, .F. ) }
         MENUITEM 'Item Status' ;
            ACTION { || AutoMsgBox( IF( oGrid:CheckItem( oGrid:Value ), ;
                                        'Checked', 'Unchecked' ) ) }
         MENUITEM 'Check All Items' ;
            ACTION { || CheckAllItems( oGrid ) }
         MENUITEM 'Uncheck All Items' ;
            ACTION { || UncheckAllItems( oGrid ) }
         MENUITEM 'Items Checked' ;
            ACTION { || ItemsChecked( oGrid ) }
      END MENU

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION CheckAllItems( oGrid )
   LOCAL i

   FOR i := 1 TO oGrid:ItemCount
      oGrid:CheckItem( i, .T. )
   NEXT i

RETURN NIL

FUNCTION UncheckAllItems( oGrid )
   LOCAL i

   FOR i := 1 TO oGrid:ItemCount
      oGrid:CheckItem( i, .F. )
   NEXT i

RETURN NIL

FUNCTION ItemsChecked( oGrid )
   LOCAL i, aItems := {}

   FOR i := 1 TO oGrid:ItemCount
      IF oGrid:CheckItem( i )
         AADD( aItems, i )
      ENDIF
   NEXT i

   IF LEN( aItems ) > 0
      AutoMsgBox( aItems )
   ELSE
      AutoMsgBox( 'No item is checked !!!' )
   ENDIF

RETURN NIL

/*
 * EOF
 */
