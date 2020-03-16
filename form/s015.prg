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

   // This can be ommited because it's the default value
   _OOHG_ExitOnMainRelease := .F.

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

   // This is executed. To exit here add RETURN or QUIT.
   MsgBox( "After MAIN 1 release !!!" )

   // Here you can add App.Release to destroy the TApplication object.
   // After that you can use any (x)Harbour function but any attempt
   // to use an OOHG object will throw an RTE.
   // Uncomment the next line and see what happens.
   // App.Release

   _OOHG_ExitOnMainRelease := .T.

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

   // This is not executed.
   MsgBox( "After MAIN 2 release !!!" )

   RETURN

/*
 * EOF
 */
