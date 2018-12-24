/*
 * Menu Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to use SetMenuBarColor and
 * SetItemsColor methods to change the colors of a
 * window's menu.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/menu
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - Menu Colors' ;
      MAIN

      DEFINE MAIN MENU OBJ oMain
         ITEM 'Exit' ACTION MsgInfo( 'Exit' )
         POPUP 'File' OBJ oFile
            POPUP 'One'
              ITEM 'Open' IMAGE 'Check.Bmp'
              ITEM 'Save' IMAGE 'Free.Bmp'
              ITEM 'Print' IMAGE 'Info.Bmp'
              ITEM 'Save As...'
            END POPUP
            POPUP 'More'
              ITEM 'Open' IMAGE 'Check.Bmp'
              ITEM 'Save' IMAGE 'Free.Bmp'
              ITEM 'Print' IMAGE 'Info.Bmp'
              ITEM 'Save As...'
            END POPUP
         END POPUP
         POPUP 'Test'
            ITEM 'Item 1'
            ITEM 'Item 2'
            POPUP 'Item 3' OBJ oItem3
               ITEM 'Item 3.1'
               SEPARATOR
               ITEM 'Item 3.2'
               POPUP 'Item 3.3'
                  ITEM 'Item 3.3.1'
                  SEPARATOR
                  ITEM 'Item 3.3.2'
                  POPUP 'Item 3.3.3'
                     ITEM 'Item 3.3.3.1'
                     ITEM 'Item 3.3.3.2'
                     ITEM 'Item 3.3.3.3'
                     ITEM 'Item 3.3.3.4'
                     ITEM 'Item 3.3.3.5'
                     ITEM 'Item 3.3.3.6'
                  END POPUP
                  ITEM 'Item 3.3.4'
               END POPUP
            END POPUP
            ITEM 'Item 4'
         END POPUP
         POPUP 'Help'
            ITEM 'About'
         END POPUP
      END MENU

      /* This doesn't works in Win Vista or 7 when themes are enabled.
         It doesn't works in Win 10 because themes are _always_ enabled.
         To change the color of the main menu you must disable the themes
         for the whole form. See Context Menu
         Note that after disabling the themes you can't reenable them.
      */
      oMain:SetMenuBarColor( RED, .F. )

      oFile:SetItemsColor( {170,213,255}, .T. )
      oItem3:SetItemsColor( {170,213,255}, .F. )
      /* Only the menu containing
         Item 3.1
         Item 3.2
         Item 3.3
         will be colored with pale blue
      */

      DEFINE CONTEXT MENU OBJ oContext
         ITEM 'Item 1'
         ITEM 'Item 2'
         SEPARATOR
         ITEM 'Toggle' ;
            ACTION ToggleItem3Colors()
         SEPARATOR
         ITEM 'Disable themes and change color to RED' ;
            ACTION ( oMain:DisableVisualStyle(), oMain:SetMenuBarColor( RED, .F. ) )
      END MENU

      oContext:SetMenuBarColor( {170,213,255}, .T. )

      @ 20,10 LABEL lbl_1 VALUE "Use Toggle in Context Menu" AUTOSIZE

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

STATIC FUNCTION ToggleItem3Colors

   STATIC lColoredSubMenus := .F.

   lColoredSubMenus := ! lColoredSubMenus

   IF lColoredSubMenus
      oItem3:SetItemsColor( YELLOW, .T. )
      /* The menu containing
         Item 3.1
         Item 3.2
         Item 3.3
         and all its submenues will be colored yellow
      */
   ELSE
      oItem3:SetItemsColor( WHITE, .T. )
      /* The menu containing
         Item 3.1
         Item 3.2
         Item 3.3
         and all its submenues will be colored white
      */
      oItem3:SetItemsColor( {170,213,255}, .F. )
      /* Only the menu containing
         Item 3.1
         Item 3.2
         Item 3.3
         will be colored pale blue
      */
   ENDIF

RETURN NIL

/*
 * EOF
 */
