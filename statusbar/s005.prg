/*
 * Statusbar Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a LABEL control "inside"
 * a statusbar and how to resize it when the statusbar's
 * width is changed.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

PROCEDURE MAIN

  PUBLIC oStat

   DEFINE WINDOW Main ;
      TITLE "oohg - Label inside a Statusbar" ;
      WIDTH 640 ;
      HEIGHT 480 ;
      ON INIT ResizeStatusbar() ;
      ON SIZE ResizeStatusbar()

      @ 10, 120 BUTTON btn_1 ;
         CAPTION "Resize" ;
         ACTION ResizeStatusbar()

      DEFINE STATUSBAR OBJ oStat
         STATUSITEM "ooHG power !!!"
         STATUSITEM "" WIDTH 200
         STATUSITEM "ooHG power !!!" WIDTH 100

         @ 4, 102 LABEL lbl_status ;
           WIDTH 192 ;
           HEIGHT oStat:ClientHeight - 6 ;
           BACKCOLOR RED
      END STATUSBAR

      ON KEY ESCAPE ACTION Main.Release
   END WINDOW

   Main.Activate

RETURN

PROCEDURE ResizeStatusbar

   IF oStat:ItemWidth( 2 ) > 150
      oStat:ItemWidth( 2, 100 )
   ELSE
      oStat:ItemWidth( 2, oStat:ClientWidth - 200 )
   ENDIF
   Main.lbl_status.Col := oStat:ItemWidth( 1 ) + 4
   Main.lbl_status.Width := oStat:ItemWidth( 2 ) - 8

RETURN

/*
 * EOF
 */
