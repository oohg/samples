/*
 * Statusbar Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a progressbar control "inside"
 * a statusitem and how to replace it when the statusitem's width
 * is changed.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

PROCEDURE MAIN

  PUBLIC oStat

   DEFINE WINDOW Main ;
      TITLE "Progressbar inside a Statusbar" ;
      WIDTH 640 ;
      HEIGHT 480 ;
      ON INIT ResizeStatusbar()

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Animate" ;
         ACTION AnimateProgressBar()

      @ 10, 120 BUTTON btn_2 ;
         CAPTION "Resize" ;
         ACTION ResizeStatusbar()

      DEFINE STATUSBAR OBJ oStat
         STATUSITEM "ooHG power !!!"
         STATUSITEM "" WIDTH 200
         STATUSITEM "ooHG power !!!" WIDTH 100

         @ 4, 102 PROGRESSBAR pgb_status ;
           RANGE 0, 100 ;
           WIDTH 192 ;
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

PROCEDURE ResizeStatusbar

   If oStat:ItemWidth( 2 ) > 150
      oStat:ItemWidth( 2, 100 )
   Else
      oStat:ItemWidth( 2, oStat:ClientWidth - 200 )
   EndIf
   Main.pgb_status.Col := oStat:ItemWidth( 1 ) + 4
   Main.pgb_status.Width := oStat:ItemWidth( 2 ) - 8

RETURN

/*
 * EOF
 */
