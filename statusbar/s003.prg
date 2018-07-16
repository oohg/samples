/*
 * Statusbar Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a progressbar control
 * "inside" a statusbar control.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

PROCEDURE MAIN

   DEFINE WINDOW Main ;
      TITLE "Progressbar inside a Statusbar"

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Animate" ;
         ACTION AnimateProgressBar()

      DEFINE STATUSBAR OBJ oStat
         @ 4, 2 PROGRESSBAR pgb_status ;
           RANGE 0, 100 ;
           WIDTH oStat:ClientWidth - 4 ;
           HEIGHT oStat:ClientHeight - 6 ;
           SMOOTH
      END STATUSBAR

      ON KEY ESCAPE ACTION Main.Release
   END WINDOW

   Main.Activate

RETURN

PROCEDURE AnimateProgressBar

   Main.pgb_status.Value := 0
   DO WHILE Main.pgb_status.Value < 100
      Main.pgb_status.Value += 5
      HB_IdleSleep(.5)
   ENDDO

RETURN

/*
 * EOF
 */
