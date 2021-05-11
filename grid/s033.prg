/*
 * Grid Sample # 33
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to handle the grid's dblclick event.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aRows [40] [4]

   DEFINE WINDOW frm_1 ;
      AT 0, 0 ;
      WIDTH 650 ;
      HEIGHT 500 ;
      TITLE "Grid demo - How to handle DblClick's parameters" ;
      MAIN

      DEFINE STATUSBAR
      END STATUSBAR

      aRows[ 01 ] := { 'Simpson',   'Homer',     '555-5555', 'The Simpsons' }
      aRows[ 02 ] := { 'Mulder',    'Fox',       '324-6432', 'The X Files' }
      aRows[ 03 ] := { 'Smart',     'Max',       '432-5892', 'Get Smart' }
      aRows[ 04 ] := { 'Grillo',    'Pepe',      '894-2332', 'Pinocchio' }
      aRows[ 05 ] := { 'Kirk',      'James',     '346-9873', 'Star Trek' }
      aRows[ 06 ] := { 'Barriga',   'Carlos',    '394-9654', 'Politics' }
      aRows[ 07 ] := { 'Flanders',  'Ned',       '435-3211', 'The Simpsons' }
      aRows[ 08 ] := { 'Smith',     'John',      '123-1234', 'The Dead Zone' }
      aRows[ 09 ] := { 'Pedemonti', 'Flavio',    '000-0000', 'Chef' }
      aRows[ 10 ] := { 'Gomez',     'Juan',      '583-4832', 'Driver' }
      aRows[ 11 ] := { 'Fernandez', 'Raul',      '321-4332', 'Clerk' }
      aRows[ 12 ] := { 'Borges',    'Javier',    '326-9430', 'Auditor' }
      aRows[ 13 ] := { 'Alvarez',   'Alberto',   '543-7898', 'Farmer' }
      aRows[ 14 ] := { 'Gonzalez',  'Ambo',      '437-8473', 'Taylor' }
      aRows[ 15 ] := { 'Batistuta', 'Gol',       '485-2843', 'FIFA' }
      aRows[ 16 ] := { 'Vinazzi',   'Amigo',     '394-5983', 'Public Relations' }
      aRows[ 17 ] := { 'Pedemonti', 'Flavio',    '534-7984', 'Marathonist' }
      aRows[ 18 ] := { 'Samarbide', 'Armando',   '854-7873', 'Diver' }
      aRows[ 19 ] := { 'Pradon',    'Alejandra', '???-????', 'Landscaper' }
      aRows[ 20 ] := { 'Reyes',     'Monica',    '432-5836', 'Poker Player' }
      FOR i := 1 TO 20
         aRows[ i + 20 ] := aClone( aRows[ i ] )
      NEXT i

      @ 10,10 GRID Grid_2 OBJ oGrid;
         WIDTH 600 ;
         HEIGHT 400 ;
         HEADERS { 'Last Name','First Name','Phone','Job' } ;
         WIDTHS { 140,140,140,140 } ;
         ITEMS aRows ;
         ON DBLCLICK { | nRow, nCol | ShowPos( nRow, nCol ) } ;
         JUSTIFY { BROWSE_JTFY_LEFT, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_LEFT }

      ON KEY ESCAPE ACTION frm_1.Release()
   END WINDOW

   CENTER WINDOW frm_1
   ACTIVATE WINDOW frm_1

RETURN

FUNCTION ShowPos( nRow, nCol )

   AutoMsgBox( "Row " + LTrim( Str( nRow ) ) + "  Col " + LTrim( Str( nCol ) ) + " (coordinates)" + CRLF + ;
               "_OOHG_ThisItemRowIndex " + LTrim( Str( _OOHG_ThisItemRowIndex ) ) + CRLF + ;
               "_OOHG_ThisItemColIndex " + LTrim( Str( _OOHG_ThisItemColIndex ) ) + CRLF + ;
               "_OOHG_ThisItemCellRow " + LTrim( Str( _OOHG_ThisItemCellRow ) ) + CRLF + ;
               "_OOHG_ThisItemCellCol " + LTrim( Str( _OOHG_ThisItemCellCol ) ) + CRLF + ;
               "_OOHG_ThisItemCellWidth " + LTrim( Str( _OOHG_ThisItemCellWidth ) ) + CRLF + ;
               "_OOHG_ThisItemCellHeight " + LTrim( Str( _OOHG_ThisItemCellHeight ) ) + CRLF + ;
               "_OOHG_ThisItemCellValue " + _OOHG_ThisItemCellValue + CRLF + ;
               "Grid's value " + AutoType( oGrid:Value ) )

RETURN NIL

/*
 * EOF
 */
