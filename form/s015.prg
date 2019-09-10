/*
 * Form Sample # 15
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to prevent app exit
 * on main form release.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE Main(...)
   LOCAL oMain

   _OOHG_ExitOnMainRelease := .F.
   _OOHG_KeepAppOnMainRelease := .T.

   DEFINE WINDOW Win_1 OBJ oMain ;
      AT 0, 0 ;
      WIDTH 400 HEIGHT 200 ;
      MAIN ;
      TITLE "Ventana MAIN 1"

      DEFINE MAIN MENU
         ITEM "Click here" ACTION oMain:Release()
      END MENU

      ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oMain:Activate()

   MsgBox( "After MAIN 1 release !!!" )

   DEFINE WINDOW Win_1 OBJ oMain ;
      AT 0, 0 ;
      WIDTH 400 HEIGHT 200 ;
      MAIN ;
      TITLE "Ventana MAIN 2"

      DEFINE MAIN MENU
         ITEM "Click here" ACTION oMain:Release()
      END MENU

      ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oMain:Activate()

   _OOHG_ExitOnMainRelease := .T.

   MsgBox( "After MAIN 2 release !!!" )

   RETURN

/*
 * EOF
 */
