/*
 * Tab Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on an original MINIGUI demo by Roberto Lopez
 * modified by Grigory Filatov.
 *
 * This sample shows how to dynamically add and delete
 * tabpages and change its captions and images. It also
 * shows how to change the tab's position and size.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ Form_1 ;
      AT 0, 0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'ooHG Demo' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP 'Style'
            MENUITEM 'Top pages'                ACTION Tab_1( .T. )
            MENUITEM 'Bottom pages'             ACTION Tab_1( .F. )
            SEPARATOR
            MENUITEM 'Exit'                     ACTION ThisWindow:Release()
         END POPUP

         DEFINE POPUP 'Tests'
            MENUITEM 'Add Page 2'               ACTION Form_1.Tab_1.AddPage( 2, 'New Page', 'Info.Bmp' )
            MENUITEM 'Delete Page 2'            ACTION iif( Form_1.Tab_1.ItemCount > 1, Form_1.Tab_1.DeletePage( 2 ), NIL )
            SEPARATOR
            MENUITEM 'Set Image to "Info"'      ACTION Form_1.Tab_1.Image( Form_1.Tab_1.Value ) := 'Info.Bmp'
            MENUITEM 'Set Image to "Exit"'      ACTION Form_1.Tab_1.Image( Form_1.Tab_1.Value ) := 'Exit.Bmp'
            MENUITEM 'Set Image to "Check"'     ACTION Form_1.Tab_1.Image( Form_1.Tab_1.Value ) := 'Check.Bmp'
            SEPARATOR
            MENUITEM 'Set Caption to "Caption"' ACTION Form_1.Tab_1.Caption( Form_1.Tab_1.Value ) := 'Caption'
            MENUITEM 'Set Caption to "Page #"'  ACTION Form_1.Tab_1.Caption( Form_1.Tab_1.Value ) := 'Page ' + LTrim( Str( Form_1.Tab_1.Value ) )
            SEPARATOR
            MENUITEM "Get Tab's Row"            ACTION MsgInfo( Str( Form_1.Tab_1.Row ) )
            MENUITEM "Get Tab's Col"            ACTION MsgInfo( Str( Form_1.Tab_1.Col ) )
            MENUITEM "Get Tab's Width"          ACTION MsgInfo( Str( Form_1.Tab_1.Width ) )
            MENUITEM "Get Tab's Height"         ACTION MsgInfo( Str( Form_1.Tab_1.Height ) )
            SEPARATOR
            MENUITEM "Set Tab's Row"            ACTION Form_1.Tab_1.Row    := Val( InputBox( '', '' ) )
            MENUITEM "Set Tab's Col"            ACTION Form_1.Tab_1.Col    := Val( InputBox( '', '' ) )
            MENUITEM "Set Tab's Width"          ACTION Form_1.Tab_1.Width  := Val( InputBox( '', '' ) )
            MENUITEM "Set Tab's Height"         ACTION Form_1.Tab_1.Height := Val( InputBox( '', '' ) )
            MENUITEM "Fit to client area"       ACTION SizeTest()
            SEPARATOR
            MENUITEM "Hide Page 2"              ACTION iif( Form_1.Tab_1.ItemCount > 1, Form_1:Tab_1:HidePage( 2 ), NIL )
            MENUITEM "Show Page 2"              ACTION iif( Form_1.Tab_1.ItemCount > 1, Form_1:Tab_1:ShowPage( 2 ), NIL )
         END POPUP
      END MENU

      Tab_1( .T. )

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   Form_1.Center
   Form_1.Activate

   RETURN NIL

PROCEDURE SizeTest()

   Form_1.Tab_1.Width  := Form_1.ClientWidth - Form_1.Tab_1.Col - 30
   Form_1.Tab_1.Height := Form_1.ClientHeight - Form_1.Tab_1.Row - 30

   RETURN

PROCEDURE Tab_1( lStyle )

   IF IsControlDefined( Tab_1, Form_1 )
      Form_1.Tab_1.Release
   ENDIF

IF lStyle
   DEFINE TAB Tab_1 ;
      OF Form_1 ;
      AT 10, 10 ;
      WIDTH 600 ;
      HEIGHT 400 ;
      VALUE 1 ;
      TOOLTIP 'Tab Control'
ELSE
   DEFINE TAB Tab_1 ;
      OF Form_1 ;
      AT 10, 10 ;
      WIDTH 600 ;
      HEIGHT 400 ;
      VALUE 1 ;
      TOOLTIP 'Tab Control' ;
      BOTTOM
ENDIF
      PAGE 'Page 1' IMAGE 'Exit.Bmp'
      END PAGE

      PAGE 'Page 2' IMAGE 'Info.Bmp'
      END PAGE

      PAGE 'Page 3' IMAGE 'Check.Bmp'
      END PAGE
   END TAB

   SizeTest()

   RETURN

/*
 * EOF
 */
