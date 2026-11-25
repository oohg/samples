/*
 * Grid Sample # 41
 * Author: Miguel Ingles <miguelsuizowin@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows the painting of the selected row in GRID and
 * BROWSE controls, with and without focus. It's useful to test the
 * selection under Windows and under Wine (Linux):
 * - The whole selected row must be painted, not only its first cell.
 * - The selection must stay visible when the control loses the focus.
 * - The BROWSE uses the MiniGUI syntax (minigui.ch) and has a date
 *   column, so the virtual listview must show the dates as text.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "minigui.ch"

FUNCTION Main()

   LOCAL i, aRows := {}

   SET DATE BRITISH
   SET CENTURY ON

   FOR i := 1 TO 20
      AAdd( aRows, { StrZero( i, 4 ), "Customer " + LTrim( Str( i ) ), "City " + LTrim( Str( i ) ), ;
                     Transform( i * 125.5, "999,999.99" ), DToC( Date() - i ) } )
   NEXT i

   CreateTable()

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 560 ;
      TITLE "Selected row in Grid and Browse" ;
      MAIN ;
      ON RELEASE dbCloseAll()

      @ 10, 10 LABEL Label_1 ;
         VALUE "Click a row, then click the textbox: the selection must stay visible in both controls." ;
         WIDTH 610

      @ 35, 10 GRID Grid_1 ;
         WIDTH 610 ;
         HEIGHT 200 ;
         HEADERS { "Code", "Name", "City", "Amount", "Date" } ;
         WIDTHS { 70, 160, 140, 100, 100 } ;
         ITEMS aRows ;
         VALUE 3

      @ 245, 10 BROWSE Browse_1 ;
         WIDTH 610 ;
         HEIGHT 220 ;
         HEADERS { "Code", "Name", "Amount", "Date" } ;
         WIDTHS { 70, 200, 100, 100 } ;
         WORKAREA CUSTOMER ;
         FIELDS { "CUSTOMER->CODE", "CUSTOMER->NAME", "CUSTOMER->AMOUNT", "CUSTOMER->DATE" } ;
         VALUE 1

      @ 480, 10 TEXTBOX Text_1 ;
         VALUE "Click here to move the focus" ;
         WIDTH 300
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

STATIC FUNCTION CreateTable()

   LOCAL i

   dbCreate( "CUSTOMER", { { "CODE", "C", 4, 0 }, { "NAME", "C", 30, 0 }, ;
                           { "AMOUNT", "N", 10, 2 }, { "DATE", "D", 8, 0 } } )
   USE CUSTOMER NEW
   FOR i := 1 TO 20
      APPEND BLANK
      REPLACE CODE WITH StrZero( i, 4 ), NAME WITH "Customer " + LTrim( Str( i ) ), ;
              AMOUNT WITH i * 125.5, DATE WITH Date() - i
   NEXT i
   dbGoTop()

   RETURN NIL

/*
 * EOF
 */
