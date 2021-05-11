/*
 * Grid Sample # 36
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a virtual grid with
 * non-text columns and how to manage the addition,
 * removal and modification of its rows.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL k, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 608 ;
      HEIGHT 460 ;
      TITLE "Virtual Grid with non-text columns" ;
      MAIN ;
      ON INIT oGrid:ColumnBetterAutoFit( 1 )

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 15
          aRows[k] := { k % 3, ;
                        Str( hb_RandomInt( 99 ), 2), ;
                        hb_RandomInt( 100 ), ;
                        Date() + Random( hb_RandomInt() ), ;
                        'Refer ' + Str( hb_RandomInt( 10 ), 2 ), ;
                        hb_RandomInt( 10000 ) }
      NEXT k

      @ 10,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 570 ;
         HEIGHT 330 ;
         HEADERS { "", 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 1, 60, 80, 100, 120, 100 } ;
         ITEMS aRows ;
         ITEMCOUNT 15 ;
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
         APPEND DELETE EDIT INPLACE ;
         VIRTUAL ;
         ON QUERYDATA SetData( oGrid, aRows ) ;
         ON EDITCELL SaveData( oGrid, aRows ) ;
         ON DELETE DeleteData( oGrid, aRows ) ;
         ON BEFOREINSERT AddData( oGrid, aRows )

      @ 350, 10 BUTTON But1 ;
         CAPTION "ItemCount" ;
         ACTION AutoMsgBox( oGrid:ItemCount )

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION SetData( oGrid, aRows )

   LOCAL aItem

   oForm:StatusBar:Item( 1, "Row = " + LTrim( Str( _OOHG_ThisQueryRowIndex ) ) + "  Col = " + LTrim( Str( _OOHG_ThisQueryColIndex ) ) )

   aItem := TGrid_SetArray( oGrid, aRows[ _OOHG_ThisQueryRowIndex ] )
   _OOHG_ThisQueryData := aItem[ _OOHG_ThisQueryColIndex ]

   RETURN NIL

FUNCTION SaveData( oGrid, aRows )

   aRows[ _OOHG_ThisItemRowIndex, _OOHG_ThisItemColIndex ] := _OOHG_ThisItemCellValue

   RETURN NIL

FUNCTION DeleteData( oGrid, aRows )

   IF oGrid:Type == "MULTIGRID"
      FOR k := Len( _OOHG_ThisItemRowIndex ) TO 1 STEP -1
         ADel( aRows, k )
         ASize( aRows, Len( aRows ) - 1 )
         oGrid:ItemCount --
      NEXT k
   ELSE
      ADel( aRows, _OOHG_ThisItemRowIndex )
      ASize( aRows, Len( aRows ) - 1 )
   ENDIF

   RETURN NIL

FUNCTION AddData( oGrid, aRows )

   AAdd( aRows, { 0, "", 0, CToD(""), "", 0 } )

   RETURN NIL

/*
 * EOF
 */
