/*
 * Grid Sample # 29
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display the totals for a column
 * in a grid using another grid.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'
#include 'i_windefs.ch'

FUNCTION Main()

   LOCAL i, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "oohg - Show totals of a Grid's column using another Grid." ;
      MAIN ;
      ON INIT ( Sum(), oGrid2:Height := SetHeightForWholeRows( 1 ) )

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR i := 1 TO 15
          aRows[ i ] := { Str(HB_RandomInt( 99 ), 2), ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ), ;
                          HB_RandomInt( 10000 ) }
      NEXT i

      @ 20,20 GRID Grid_1 OBJ oGrid1 ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS {60, 80, 100, 120, 140} ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT ;
         READONLY { .T., .T., .T., .T., .F. } ;
         ON EDITCELLEND Sum()
      oGrid1:bOnScroll := { |a| Sync( a ) }
      oGrid1:bAfterColSize := { |nCol, nSize| Size( nCol, nSize ) }

      @ 360,20 GRID Grid_2 OBJ oGrid2 ;
         WIDTH 520 ;
         HEIGHT 40 ;
         NOHEADERS ;
         WIDTHS {60, 80, 100, 120, 140, GetVScrollBarWidth() } ;
         ITEMS { { "", "", "", "", 0, "" } } ;
         READONLY { .T., .T., .T., .T., .T., .T. } ;
         COLUMNCONTROLS { NIL, NIL, NIL, NIL, { 'TEXTBOX', 'NUMERIC', '999,999,999.99' }, NIL } ;
         FONT 'COURIER NEW' SIZE 10 NOHSCROLLBAR

      @ 390, 20 BUTTON But_2 OBJ oBut2 ;
         HEIGHT 20 CAPTION "pos" ACTION AutoMsgBox( GetScrollPos( oGrid1:hWnd, SB_HORZ ) )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

PROCEDURE Sum

   LOCAL aItems, nSum := 0

   aItems := oGrid1:aItems()
   AEval( aItems, {|i| nSum += i[ 5 ] } )
   oGrid2:aItems := { { "", "", "", "", nSum, "" } }

RETURN

PROCEDURE Sync( aData )

   /*
    * aData[ 1 ] -> horizontal scroll, positive indicates scroll to right, negative to left.
    * aData[ 2 ] -> horizontal scroll, positive indicates scroll to bottom, negative to top.
    * aData[ 3 ] -> Actual horizontal scrollbar position.
    * aData[ 4 ] -> Actual vertical scrollbar position.
    */

   IF aData[ 1 ] # 0
      LISTVIEW_SCROLL( oGrid2:hWnd, GetScrollPos( oGrid1:hWnd, SB_HORZ ) - GetScrollPos( oGrid2:hWnd, SB_HORZ ), 0 )
   ENDIF

RETURN

FUNCTION Size( nCol, nSize )

   oGrid2:ColumnWidth( nCol, nSize )
   FOR i := nCol + 1 TO oGrid1:ColumnCount
      oGrid2:ColumnWidth( i, oGrid1:ColumnWidth( i ) )
   NEXT
   oGrid2:ColumnWidth( i, GetVScrollBarWidth() )

RETURN .T.

FUNCTION SetHeightForWholeRows( NumberOfWholeRows )

   LOCAL NeededHeight

   NeededHeight := NumberOfWholeRows * oGrid2:ItemHeight() + ;
                   oGrid2:HeaderHeight + ;
                   IF( IsWindowStyle( oGrid2:hWnd, WS_HSCROLL ), ;
                       GetHScrollBarHeight(), 0 ) + ;
                   IF( IsWindowExStyle( oGrid2:hWnd, WS_EX_CLIENTEDGE ), ;
                       GetEdgeHeight() * 2, 0 )

RETURN NeededHeight

/*
 * EOF
 */
