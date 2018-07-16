/*
 * Statusbar Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a StatusBar control in
 * a window that has virtual height.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION MAIN

   DEFINE WINDOW Win_1 OBJ oWin ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 438 ;
      TITLE 'StatusBar in a Virtual Window' ;
      MAIN

      DEFINE STATUSBAR FONT 'Arial' SIZE 9
          STATUSITEM ""
          KEYBOARD
      END STATUSBAR

      // Note that oWin:StatusBar:ClientHeightUsed()
      // returns a negative value.

      DEFINE WINDOW Int_1 OBJ oInt ;
         AT 0,0 ;
         WIDTH oWin:ClientWidth ;
         HEIGHT (oWin:ClientHeight + oWin:StatusBar:ClientHeightUsed()) ;
         INTERNAL ;
         VIRTUAL HEIGHT 900

         @ 200,20 GRID Grid_1 ;
            HEIGHT 300 ;
            WIDTH (oInt:ClientWidth - 40) ;
            HEADERS {NIL,'CODE','NAME'} ;
            WIDTHS {25,80,370}
      END WINDOW

      ON KEY ESCAPE ACTION oWin:Release()
   END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL

/*
 * EOF
 */
