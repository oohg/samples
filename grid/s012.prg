/*
 * Grid Sample # 12
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change Grid's background color
 * when the control is enabled or disabled.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL k, aRows[ 15, 5 ], oGrid, oButt

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE 'Change Grid BackColor' ;
      MAIN ;
      ON INIT ChangeStatus( oGrid, oButt )

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
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } }

      @ 370, 20 BUTTON btn_Change ;
         OBJ oButt ;
         CAPTION "Disable" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         ACTION ChangeStatus( oGrid, oButt )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ChangeStatus( oGrid, oButt )

  IF oGrid:Enabled
     oGrid:SetRangeColor( NIL, { YELLOW, YELLOW, YELLOW, YELLOW, YELLOW }, 1, 1, oGrid:ItemCount, Len( oGrid:aHeaders ) )
     oGrid:Refresh()
     oGrid:Enabled := .F.
     oButt:Caption := "Enable"
  ELSE
     oGrid:SetRangeColor( NIL, { GREEN, GREEN, GREEN, GREEN, GREEN }, 1, 1, oGrid:ItemCount, Len( oGrid:aHeaders ) )
     oGrid:Refresh()
     oGrid:Enabled := .T.
     oButt:Caption := "Disable"
  ENDIF

RETURN NIL

/*
 * EOF
 */
