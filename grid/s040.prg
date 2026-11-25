/*
 * Grid Sample # 40
 * Author: Miguel Ingles <miguelsuizowin@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on an example by David Field.
 *
 * This sample shows how to use headers with two or more
 * lines in GRID, BROWSE and XBROWSE controls (MULTILINEHEADERS
 * clause and MultiLineHeaders property).
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

#define CRLF   CHR( 13 ) + CHR( 10 )   // Windows line break
#define LF     CHR( 10 )               // Linux line break

FUNCTION Main()

   LOCAL oGrid, oBrowse, oXBrowse

   CreateTable()

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 640 ;
      TITLE "Grid, Browse and XBrowse with multiline headers" ;
      MAIN ;
      ON RELEASE dbCloseAll()

      // GRID: columns with one, two and three lines can be mixed
      @ 10, 10 GRID Grid_1 OBJ oGrid ;
         WIDTH 610 ;
         HEIGHT 160 ;
         HEADERS { "Code", "Customer" + CRLF + "name", "Pending" + LF + "balance" + LF + "(EUR)" } ;
         WIDTHS { 100, 300, 150 } ;
         ITEMS { { "1001", "John Smith", "1250.00" }, { "1002", "Mary Jones", "2350.00" } } ;
         JUSTIFY { GRID_JTFY_LEFT, GRID_JTFY_CENTER, GRID_JTFY_RIGHT } ;
         HEADERCOLORS { NIL, BLUE, NIL } ;
         VALUE 1 ;
         MULTILINEHEADERS

      // BROWSE: automatic header height
      @ 180, 10 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH 610 ;
         HEIGHT 170 ;
         HEADERS { "Customer" + CRLF + "code", "Name" } ;
         WIDTHS { 120, 300 } ;
         WORKAREA CUSTOMER ;
         FIELDS { "CUSTOMER->CODE", "CUSTOMER->NAME" } ;
         MULTILINEHEADERS

      // XBROWSE: the height can also be changed at runtime
      @ 360, 10 XBROWSE XBrowse_1 OBJ oXBrowse ;
         WIDTH 610 ;
         HEIGHT 170 ;
         HEADERS { "Code", "Customer" + LF + "full name" } ;
         WIDTHS { 120, 300 } ;
         WORKAREA CUSTOMER ;
         FIELDS { "CUSTOMER->CODE", "CUSTOMER->NAME" } ;
         MULTILINEHEADERS

      @ 545, 10 BUTTON Button_1 ;
         CAPTION "Change caption" ;
         WIDTH 145 ;
         ACTION oGrid:Header( 1, "New" + CRLF + "code" + CRLF + "column" )

      @ 545, 165 BUTTON Button_2 ;
         CAPTION "Bigger font" ;
         WIDTH 145 ;
         ACTION oGrid:HeaderSetFont( NIL, 12, .T. )

      @ 545, 320 BUTTON Button_3 ;
         CAPTION "Fixed height 60" ;
         WIDTH 145 ;
         ACTION oXBrowse:MultiLineHeaders := 60

      @ 545, 475 BUTTON Button_4 ;
         CAPTION "Disable (Grid)" ;
         WIDTH 145 ;
         ACTION oGrid:MultiLineHeaders := .F.
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

STATIC FUNCTION CreateTable()

   dbCreate( "CUSTOMER", { { "CODE", "C", 5, 0 }, { "NAME", "C", 30, 0 } } )
   USE CUSTOMER NEW
   APPEND BLANK
   REPLACE CODE WITH "1001", NAME WITH "John Smith"
   APPEND BLANK
   REPLACE CODE WITH "1002", NAME WITH "Mary Jones"
   APPEND BLANK
   REPLACE CODE WITH "1003", NAME WITH "Peter Brown"
   dbGoTop()

   RETURN NIL

/*
 * EOF
 */
