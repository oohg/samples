/*
 * Grid Sample # 25
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set default values to the cells
 * of a new item using ON INSERT event.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aRows[ 10, 3 ]

   SET DATE BRITISH
   SET EPOCH TO 1960

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 540 ;
      TITLE 'Default values in Grid' ;
      MAIN ;
      ON SIZE oGrid:Width := oForm:ClientWidth - 20

      DEFINE STATUSBAR
         STATUSITEM "Use Alt-A to add a new item and see what happens"
      END STATUSBAR

      aRows[ 01 ] := { 'Simpson',   'Homer',  '555-5555', '14/03/61', '125', 1 }
      aRows[ 02 ] := { 'Mulder',    'Fox',    '324-6432', '14/12/65', '125', 1 }
      aRows[ 03 ] := { 'Smart',     'Max',    '432-5892', '14/11/60', '125', 1 }
      aRows[ 04 ] := { 'Grillo',    'Pepe',   '894-2332', '14/03/64', '125', 1 }
      aRows[ 05 ] := { 'Kirk',      'James',  '346-9873', '14/10/67', '125', 1 }
      aRows[ 06 ] := { 'Barriga',   'Carlos', '394-9654', '14/06/69', '125', 1 }
      aRows[ 07 ] := { 'Flanders',  'Ned',    '435-3211', '14/05/63', '125', 1 }
      aRows[ 08 ] := { 'Smith',     'John',   '123-1234', '14/02/68', '125', 1 }
      aRows[ 09 ] := { 'Pedemonti', 'Flavio', '000-0000', '14/07/66', '125', 1 }
      aRows[ 10 ] := { 'Gomez',     'Juan',   '583-4832', '14/09/63', '125', 0 }

      @ 10, 10 GRID Grid_1 OBJ oGrid;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT 330 ;
         HEADERS { 'Last Name', 'First Name', 'Phone', 'Date', 'Data', 'Pos' } ;
         WIDTHS { 100, 140, 140, 100, 60, 100 } ;
         COLUMNCONTROLS { NIL, NIL, NIL, NIL, NIL, { 'COMBOBOX', { 'One', 'Two', 'Three' } } } ;
         ITEMS aRows ;
         VALUE 3 ;
         TOOLTIP 'Editable Grid Control - USE ALT+A TO APPEND' ;
         APPEND ;
         EDIT INPLACE;
         FULLMOVE ;
         DELETE ;
         ENABLEALTA ;
         ON INSERT { |nItem| SetDefaultValues( nItem ) }

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION SetDefaultValues( nItem )

   oGrid:Item( nItem, ;
               { "Smith", "John", "234-4567", "14/03/61", "250", 2 }, ;
               { WHITE, WHITE, WHITE, WHITE, WHITE }, ;
               { BLUE, BLUE, BLUE, BLUE, BLUE } )

   RETURN NIL

/*
 * EOF
 */
