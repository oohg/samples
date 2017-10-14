
#include "oohg.ch"

FUNCTION Main
   LOCAL aRows [20] [3]

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 450 ;
      HEIGHT 500 ;
      TITLE 'Hello World!' ;
      MAIN

      aRows[ 01 ] := { 'Simpson',   'Homer',     '555-5555' }
      aRows[ 02 ] := { 'Mulder',    'Fox',       '324-6432' }
      aRows[ 03 ] := { 'Smart',     'Max',       '432-5892' }
      aRows[ 04 ] := { 'Grillo',    'Pepe',      '894-2332' }
      aRows[ 05 ] := { 'Kirk',      'James',     '346-9873' }
      aRows[ 06 ] := { 'Barriga',   'Carlos',    '394-9654' }
      aRows[ 07 ] := { 'Flanders',  'Ned',       '435-3211' }
      aRows[ 08 ] := { 'Smith',     'John',      '123-1234' }
      aRows[ 09 ] := { 'Pedemonti', 'Flavio',    '000-0000' }
      aRows[ 10 ] := { 'Gomez',     'Juan',      '583-4832' }
      aRows[ 11 ] := { 'Fernandez', 'Raul',      '321-4332' }
      aRows[ 12 ] := { 'Borges',    'Javier',    '326-9430' }
      aRows[ 13 ] := { 'Alvarez',   'Alberto',   '543-7898' }
      aRows[ 14 ] := { 'Gonzalez',  'Ambo',      '437-8473' }
      aRows[ 15 ] := { 'Batistuta', 'Gol',       '485-2843' }
      aRows[ 16 ] := { 'Vinazzi',   'Amigo',     '394-5983' }
      aRows[ 17 ] := { 'Pedemonti', 'Flavio',    '534-7984' }
      aRows[ 18 ] := { 'Samarbide', 'Armando',   '854-7873' }
      aRows[ 19 ] := { 'Pradon',    'Alejandra', '???-????' }
      aRows[ 20 ] := { 'Reyes',     'Monica',    '432-5836' }

      @ 10,10 GRID Grid_2 OBJ oGrid;
         WIDTH 350 ;
         HEIGHT 330 ;
         HEADERS { 'Last Name','First Name','Phone' } ;
         WIDTHS { 140,140,140 } ;
         ITEMS aRows ;
         VALUE 1 ;
         TOOLTIP 'Editable Grid Control - USE ALT+A TO APPEND' ;
         APPEND ;
         EDIT INPLACE ;
         DELETE ;
         ENABLEALTA ;
         ON HEADCLICK { { || MsgInfo( 'Click 1' ) }, ;
                        { || MsgInfo( 'Click 2' ) }, ;
                        { || MsgInfo( 'Click 3' ) } } ;
         JUSTIFY { BROWSE_JTFY_LEFT, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER }

      @ 350, 010 BUTTON But_1 CAPTION "Hide Column" ACTION { || oGrid:ColumnHide( 2 ) }
      @ 390, 010 BUTTON But_2 CAPTION "Show Column" ACTION { || oGrid:ColumnShow( 2 ) }

      @ 350, 140 BUTTON But_3 CAPTION "Better Auto Fit" ACTION { || oGrid:ColumnsBetterAutoFit() }

      ON KEY F1 ACTION Cambia( oGrid )
      ON KEY ESCAPE ACTION Form_1:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN

FUNCTION Cambia
   oGrid:Header( 1, "Apellido" )
   SetProperty('Form_1', 'Grid_1', 'HEADER', 3, 'Teléfono' )
RETURN NIL

/*
 * EOF
 */
