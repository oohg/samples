/*
 * Form Sample # 14
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to reverse the default order in
 * which forms are released (first the parent later the
 * its children).
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE Main(...)
   LOCAL oMain

   _OOHG_WinReleaseSameOrder := .F.

   DEFINE WINDOW Win_1 OBJ oMain ;
      AT 0, 0 ;
      WIDTH 400 HEIGHT 200 ;
      MAIN ;
      TITLE "Ventana MAIN" ;
      ON RELEASE AutoMsgBox( "Closing MAIN" )

      DEFINE MAIN MENU
         ITEM "Form1"   ACTION Open( "1" )
         ITEM "Form2"   ACTION Open( "2" )
         ITEM "Release" ACTION oMain:Release()
      END MENU

      ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oMain:Activate()

   RETURN

PROCEDURE oPen( x )
   LOCAL oDlg

   DEFINE WINDOW TEMPLATE OBJ oDlg ;
      AT hb_RandomInt( GetDesktopHeight() - 200 ), hb_RandomInt( GetDesktopWidth() - 400 )  ;
      WIDTH 400 HEIGHT 200 TITLE "Form " + x ;
      ON RELEASE AutoMsgBox( "Closing Form" + x )

      DEFINE MAIN MENU
         ITEM "Form1"   ACTION Open( x + "-1" )
         ITEM "Form2"   ACTION OPen( x + "-2" )
         ITEM "Release" ACTION oDlg:Release()
      END MENU

      ON KEY ESCAPE ACTION oDlg:Release()
   END WINDOW

   oDlg:Activate()

   RETURN

/*
 * EOF
 */
