/*
 * This file is part of HTTP Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licenced under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This file is needed to test the sample.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main( cAct )

   IF ! hb_IsString( cAct )
      cAct := "N"
   ENDIF

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Hello World !!!' ;
      MAIN

      @ 10, 10 LABEL lbl_Act ;
         AUTOSIZE ;
         VALUE IF( cAct == "T", "App was updated !!!", "App was not updated !!!" )

      ON KEY ESCAPE ACTION Win_1.Release
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN Nil

/*
 * EOF
 */
