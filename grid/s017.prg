/*
 * Grid Sample # 17
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a virtual grid with
 * dynamic back color using VIRTUAL and ON QUERYDATA
 * clauses of a Grid, and how to change the backcolor
 * of the items after control's definition.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

#define bColor { |nCol,nRow,aItem| If( Val( aItem[ 1 ] ) % 2 == 0, WHITE, RED ) }

FUNCTION Main()

   LOCAL k, oGrid, aRows[ 30, 2 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE "Virtual Grid with DynamicBackColor" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 30
          aRows[ k ] := { Str(HB_RandomInt( 99 ), 2, 0), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ) }
      NEXT k

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'REFERENCE' } ;
         WIDTHS { 60, 140 } ;
         ITEMS aRows ;
         ITEMCOUNT 20 ;
         FONT 'COURIER NEW' SIZE 10 ;
         DYNAMICBACKCOLOR { bColor, bColor } ;
         VIRTUAL ;
         ON QUERYDATA SetData( oGrid, aRows )

      @ 360, 10 BUTTON Button_1 ;
         CAPTION "Change" ACTION ChangeData( oGrid, aRows )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION SetData( oGrid, aRows )

   _OOHG_ThisQueryData := aRows[ _OOHG_ThisQueryRowIndex, _OOHG_ThisQueryColIndex ]
   oGrid:SetItemColor( _OOHG_ThisQueryRowIndex, NIL, bColor, aRows[ _OOHG_ThisQueryRowIndex ], .F. )

RETURN NIL

FUNCTION ChangeData( oGrid, aRows )

  aRows[ oGrid:Value, 1 ] := Str( ( Val( aRows[ oGrid:Value, 1 ] ) + 1 ) % 100, 2, 0 )
  oGrid:Refresh()

RETURN NIL

/*
 * EOF
 */
