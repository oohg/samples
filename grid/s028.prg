/*
 * Grid Sample # 28
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to hide/show the scrollbars
 * of a GRID control.
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
      TITLE "Hide and Show the Scrollbars of a GRID control" ;
      MAIN ;
      ON INIT oGrid:SetFocus()

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

      @ 20,20 GRID grd_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 255 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS {60, 80, 100, 120, 300} ;
         ITEMS aRows ;
         VALUE 1 ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         NOVSCROLLBAR NOHSCROLLBAR

      @ 370,20 BUTTON btn_ShowH ;
         CAPTION 'Toggle Horz. SB' ;
         WIDTH 100 ;
         ACTION ( ( oGrid:HScrollVisible := ! oGrid:HScrollVisible ), oGrid:SetFocus() )

      @ 370,130 BUTTON btn_ShowV ;
         CAPTION 'Toggle Vert. SB' ;
         WIDTH 100 ;
         ACTION ( ( oGrid:VScrollVisible := ! oGrid:VScrollVisible ), oGrid:SetFocus() )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
