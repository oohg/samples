/*
 * Grid Sample # 35
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to add, modify and remove the rows
 * of a virtual grid.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL k, oGrid, aRows[ 30, 2 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE "Add, modify and remove the rows of a Virtual Grid" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 30
          aRows[ k ] := { Str( hb_RandomInt( 99 ), 2, 0 ), ;
                          'Refer ' + Str( hb_RandomInt( 10 ), 2 ) }
      NEXT k

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'REFERENCE' } ;
         WIDTHS { 60, 140 } ;
         ITEMS aRows ;
         ITEMCOUNT 20 ;
         FONT 'COURIER NEW' SIZE 10 ;
         VIRTUAL ;
         ON QUERYDATA SetData( oGrid, aRows ) ;
         VALUE 1

      @ 360, 10 BUTTON Button_1 ;
         CAPTION "Add" ACTION AddData( oGrid, aRows )

      @ 360, 120 BUTTON Button_2 ;
         CAPTION "Modify" ACTION ModifyData( oGrid, aRows )

      @ 360, 230 BUTTON Button_3 ;
         CAPTION "Remove" ACTION RemoveData( oGrid, aRows )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION SetData( oGrid, aRows )

   IF Len( aRows ) >= _OOHG_ThisQueryRowIndex
      _OOHG_ThisQueryData := aRows[ _OOHG_ThisQueryRowIndex, _OOHG_ThisQueryColIndex ]
   ENDIF

   RETURN NIL

FUNCTION AddData( oGrid, aRows )

  AAdd( aRows, { Str( hb_RandomInt( 99 ), 2, 0 ), 'Refer ' + Str( hb_RandomInt( 10 ), 2 ) } )
  oGrid:ItemCount := Len( aRows )
  oGrid:Value := Len( aRows )

   RETURN NIL

FUNCTION ModifyData( oGrid, aRows )

  IF oGrid:Value <= Len( aRows )
     aRows[ oGrid:Value ] := { Str( hb_RandomInt( 99 ), 2, 0 ), 'Refer ' + Str( hb_RandomInt( 10 ), 2 ) }
     oGrid:Refresh()
  ENDIF

   RETURN NIL

FUNCTION RemoveData( oGrid, aRows )

   LOCAL nCurrent := oGrid:Value

   ADel( aRows, nCurrent )
   ASize( aRows, Len( aRows ) - 1 )
   oGrid:ItemCount := Len( aRows )
   IF nCurrent > Len( aRows )
      IF Len( aRows ) > 0
         oGrid:Value := Len( aRows )
      ELSE
         oGrid:Refresh()
      ENDIF
   ENDIF

   RETURN NIL

/*
 * EOF
 */
