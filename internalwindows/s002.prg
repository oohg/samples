/*
 * Internal Windows Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on an original contribution by
 * Cayetano Gómez <cayetano.gomez@gmail.com>
 *
 * This sample shows how to place a StatusBar and a
 * Toolbar at the bottom of the window.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW ppal OBJ oWnd WIDTH 400 HEIGHT 300 ;
      TITLE "Statusbar and Toolbar at the Bottom"

      DEFINE STATUSBAR OBJ oSb
         STATUSITEM "OOHG Power !!!"
         DATE
         CLOCK
      END STATUSBAR

      DEFINE INTERNAL inte OBJ oInt
         DEFINE TOOLBAR tool OBJ oTool BUTTONSIZE 25,25 BOTTOM BORDER
            BUTTON firs CAPTION '|<'
            BUTTON prev CAPTION '<<'
            BUTTON next CAPTION '>>'
            BUTTON last CAPTION '>|'
            BUTTON edit CAPTION '><'
         END TOOLBAR
      END INTERNAL

      oInt:Adjust := 'BOTTOM'
      oInt:Height := oTool:Height

      ON KEY ESCAPE ACTION ppal.Release
   END WINDOW

   CENTER WINDOW ppal
   ACTIVATE WINDOW ppal

RETURN NIL

/*
 * EOF
 */
