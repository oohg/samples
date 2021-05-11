/*
 * Grid Sample # 31
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a navigated by cell and
 * fullmove grid and how to switch on and off append and
 * edit options at runtime.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aRows [40] [4]

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 450 ;
      HEIGHT 500 ;
      TITLE 'Hello World!' ;
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
         WIDTH 350 ;
         HEIGHT 330 ;
         HEADERS { 'Last Name','First Name','Phone','Job' } ;
         WIDTHS { 140,140,140,140 } ;
         ITEMS aRows ;
         VALUE {3,2} ;
         TOOLTIP 'Editable Grid Control - USE ALT+A TO APPEND' ;
         APPEND ;
         EDIT INPLACE ;
         FULLMOVE ;
         DELETE ;
         ENABLEALTA ;
         NAVIGATEBYCELL ;
         EXTDBLCLICK ;
         ON DBLCLICK Form_1.StatusBar.Item( 1, "DblClick on " + AutoType( oGrid:Value ) ) ;
         ON HEADCLICK { { || MsgInfo( 'Click 1' ) }, ;
                        { || MsgInfo( 'Click 2' ) }, ;
                        { || MsgInfo( 'Click 3' ) }, ;
                        { || MsgInfo( 'Click 4' ) } } ;
         JUSTIFY { BROWSE_JTFY_LEFT, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_LEFT } ;

      @ 350, 010 BUTTON But_1 OBJ oB1 ;
         CAPTION "Append OFF" ;
         ACTION ( oB1:Caption := iif( oGrid:Append := ! oGrid:Append, "Append OFF", "Append ON" ) )
      @ 390, 010 BUTTON But_2 OBJ oB2 ;
         CAPTION "Edit OFF" ;
         ACTION ( oB2:Caption := iif( oGrid:AllowEdit := ! oGrid:AllowEdit, "Edit OFF", "Edit ON" ) )

      @ 350, 140 BUTTON But_3 CAPTION "Value := {3,4}" ACTION ( oGrid:Value := {3,4}, oGrid:SetFocus() )

      ON KEY F1 ACTION Cambia( oGrid )
      ON KEY ESCAPE ACTION Form_1.Release()
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
