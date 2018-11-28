/*
 * Statusbar Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the font.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

PROCEDURE MAIN

   DEFINE WINDOW Frm_1 OBJ oMain ;
      TITLE "Change the Statusbar's font" ;
      WIDTH 640 ;
      HEIGHT 480 ;
      MAIN

      @ 20, 20 BUTTON btn_1 ;
         CAPTION "Change font" ;
         ACTION oMain:Statusbar:SetFont( "Verdana", 12, .F., .T. )

      DEFINE STATUSBAR OBJ oStat
         STATUSITEM "ooHG power !!!" WIDTH 200
         STATUSITEM "ooHG power !!!" WIDTH 200
         CLOCK
      END STATUSBAR

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   ACTIVATE WINDOW Frm_1

RETURN

/*
 * EOF
 */
