/*
 * Tab Sample # 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to enable and disable tabpages.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

MEMVAR FrmMain

FUNCTION Main

   LOCAL oPage1, oPage2

   DEFINE WINDOW FrmMain ;
      AT 0,0 WIDTH 480 HEIGHT 300 ;
      TITLE "OOHG - Tabpages demo" ;
      MAIN

      ON KEY F1 ACTION oPage1:Enabled := ! oPage1:Enabled
      ON KEY F2 ACTION oPage2:Enabled := ! oPage2:Enabled

      DEFINE STATUSBAR
         STATUSITEM "F1 to enable/disable Page 1 - F2 for Page 2"
      END STATUSBAR

      DEFINE TAB Tab_1 ;
         AT         10, 10 ;
         WIDTH      450 ;
         HEIGHT     200 ;
         VALUE      1

         PAGE "One" OBJ oPage1
            @  60, 10 TEXTBOX txt_1 VALUE "1-uno"
            @  90, 10 TEXTBOX txt_2 VALUE "2-Dos"
            @ 120, 10 TEXTBOX txt_3 VALUE "3-Tres"
         END PAGE

         PAGE "Two" OBJ oPage2
            @ 40, 10  TEXTBOX txt_a VALUE "A-Uno" WIDTH 90
            @ 40, 110 TEXTBOX txt_b VALUE "B-Dos" WIDTH 90

            DEFINE TAB Tab_2 ;
               AT 70,10 ;
               WIDTH 200 ;
               HEIGHT 100 ;

               PAGE "IN1"
                  @  60,10 TEXTBOX txt_4 VALUE "4-cuatro"
               END PAGE

               PAGE "IN2"
                  @  60,10 TEXTBOX txt_5 VALUE "5-cinco"
               END PAGE
            END TAB
         END PAGE
         oPage2:Enabled := .F.

      END TAB

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   FrmMain.Center()
   FrmMain.Activate()

   RETURN NIL

/*
 * EOF
 */
