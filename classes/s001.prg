/*
 * Classes Sample 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to build a subclass of Grid to
 * intercept and process a group of keys.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "hbclass.ch"
#include "i_windefs.ch"

FUNCTION Main

   PUBLIC aRows[ 20, 3 ]

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 420 ;
      TITLE 'Process keys in a Grid using a subclass' ;
      MAIN

      aRows[ 01 ] := {'Simpson',   'Homer',     '555-5555'}
      aRows[ 02 ] := {'Mulder',    'Fox',       '324-6432'}
      aRows[ 03 ] := {'Smart',     'Max',       '432-5892'}
      aRows[ 04 ] := {'Grillo',    'Pepe',      '894-2332'}
      aRows[ 05 ] := {'Kirk',      'James',     '346-9873'}
      aRows[ 06 ] := {'Barriga',   'Carlos',    '394-9654'}
      aRows[ 07 ] := {'Flanders',  'Ned',       '435-3211'}
      aRows[ 08 ] := {'Smith',     'John',      '123-1234'}
      aRows[ 09 ] := {'Pedemonti', 'Flavio',    '000-0000'}
      aRows[ 10 ] := {'Gomez',     'Juan',      '583-4832'}
      aRows[ 11 ] := {'Fernandez', 'Raul',      '321-4332'}
      aRows[ 12 ] := {'Borges',    'Javier',    '326-9430'}
      aRows[ 13 ] := {'Alvarez',   'Alberto',   '543-7898'}
      aRows[ 14 ] := {'Gonzalez',  'Ambo',      '437-8473'}
      aRows[ 15 ] := {'Batistuta', 'Gol',       '485-2843'}
      aRows[ 16 ] := {'Vinazzi',   'Amigo',     '394-5983'}
      aRows[ 17 ] := {'Pedemonti', 'Flavio',    '534-7984'}
      aRows[ 18 ] := {'Samarbide', 'Armando',   '854-7873'}
      aRows[ 19 ] := {'Pradon',    'Alejandra', '???-????'}
      aRows[ 20 ] := {'Reyes',     'Monica',    '432-5836'}


      @ 10, 10 GRID Grid_2 OBJ ogrid ;
         SUBCLASS MyGrid ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT 230 ;
         HEADERS {'Last Name', 'First Name', 'Phone'} ;
         WIDTHS {130, 130, 130} ;
         ITEMS aRows ;
         VALUE 1

      // Disable Search
      oGrid:SearchCol := oGrid:ColumnCount + 1

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

CLASS MyGrid FROM TGrid

   METHOD Events_Notify

ENDCLASS

METHOD Events_Notify( wParam, lParam ) CLASS MyGrid
   Local nNotify := GetNotifyCode( lParam )
   Local nvkey, c, i

   If nNotify == LVN_KEYDOWN
      // Get virtual key code, see i_keybd.ch
      nvKey := GetGridvKey( lParam )

      If nvkey >= VK_A .AND. nvkey <= VK_Z
         // Get character
         c := Upper( Chr( GetGridvKeyAsChar( lParam ) ) )

         // Search for the first row with character in it
         i := ASCAN( aRows, { |aItem| c $ Upper( aItem[1] ) } )

         If i > 0
            // Select item
            ::Value := i
         EndIf

         // Skip default action
         Return 1
      EndIf
   EndIf

   // Do TGrid's default action
Return ::Super:Events_Notify( wParam, lParam )

/*
 * EOF
 */
