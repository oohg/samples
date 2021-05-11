/*
 * Grid Sample # 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to display only full rows in a
 * Grid (it also applies to Browse and xBrowse).
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   LOCAL aRows[ 20 ]

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'GRID - Show Whole Rows Only' ;
      MAIN ;
      ON INIT oGrid:Height := SetHeightForWholeRows( 10 )

      aRows[ 01 ] := {'Simpson, Homer'}
      aRows[ 02 ] := {'Mulder, Fox'}
      aRows[ 03 ] := {'Smart, Max'}
      aRows[ 04 ] := {'Grillo, Pepe'}
      aRows[ 05 ] := {'Kirk, James T.'}
      aRows[ 06 ] := {'Barriga, Carlos'}
      aRows[ 07 ] := {'Flanders, Ned'}
      aRows[ 08 ] := {'Smith, John'}
      aRows[ 09 ] := {'Pedemonti, Flavio'}
      aRows[ 10 ] := {'Gomez, Juan'}
      aRows[ 11 ] := {'Fernandez, Raul'}
      aRows[ 12 ] := {'Borges, Javier'}
      aRows[ 13 ] := {'Alvarez, Alberto'}
      aRows[ 14 ] := {'Gonzalez, Ambo'}
      aRows[ 15 ] := {'Batistuta, Gol'}
      aRows[ 16 ] := {'Vinazzi, Amigo'}
      aRows[ 17 ] := {'Pedemonti, Flavio'}
      aRows[ 18 ] := {'Samarbide, Armando'}
      aRows[ 19 ] := {'Pradon, Alejandra'}
      aRows[ 20 ] := {'Reyes, Monica'}

      @ 10,10 GRID Grid_1 OBJ oGrid;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT 100 ;
         HEADERS {'Data'} ;
         WIDTHS {300} ;
         JUSTIFY {BROWSE_JTFY_LEFT} ;
         ITEMS aRows ;
         VALUE 1

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION SetHeightForWholeRows( NumberOfWholeRows )

   LOCAL NeededHeight

   NeededHeight := NumberOfWholeRows * oGrid:ItemHeight() + ;
                   oGrid:HeaderHeight + ;
                   IF( IsWindowStyle( oGrid:hWnd, WS_HSCROLL ), ;
                       GetHScrollBarHeight(), 0 ) + ;
                   IF( IsWindowExStyle( oGrid:hWnd, WS_EX_CLIENTEDGE ), ;
                       GetEdgeHeight() * 2, 0 )

RETURN NeededHeight

/*
 * EOF
 */
