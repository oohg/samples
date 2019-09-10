/*
 * Menu Sample # 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows an ownerdraw dropdown.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/menu
 */

#include "oohg.ch"

FUNCTION MAIN

   LOCAL aMenuParams := _OOHG_DefaultMenuParams
   aMenuParams[ MNUCLR_MENUITEMTEXT ] := ArrayRGB_TO_COLORREF( RED )
   _OOHG_DefaultMenuParams := aMenuParams

   DEFINE WINDOW Form OBJ oForm ;
      AT 0, 0 ;
      WIDTH 584 ;
      HEIGHT 308 ;
      TITLE "Ownerdraw menu" ;
      MAIN ON INIT oMenu:Enabled := .F.

      DEFINE MAIN MENU
         POPUP '&File'
            ITEM '&New'  ACTION AutoMsgBox( "New" )
            ITEM '&Open' ACTION AutoMsgBox( "Open" )
            SEPARATOR
            ITEM '&Exit' ACTION oForm:Release()
         END POPUP
         ITEM "Toggle DropDown Menu" ACTION ToggleMenu()
      END MENU

      DEFINE SPLITBOX
         DEFINE TOOLBAR 0 BUTTONSIZE 16,16 FLAT
            BUTTON Button_1 PICTURE 'new.bmp'  TOOLTIP 'New'  ACTION AutoMsgBox( "New" )  AUTOSIZE DROPDOWN
            BUTTON Button_2 PICTURE 'open.bmp' TOOLTIP 'Open' ACTION AutoMsgBox( "Open" ) AUTOSIZE SEPARATOR
            BUTTON Button_4 PICTURE 'left.bmp' TOOLTIP 'Exit' ACTION oForm:Release()      AUTOSIZE
         END TOOLBAR

         DEFINE DROPDOWN MENU BUTTON Button_1 OWNERDRAW FONT { "Comic Sans MS", 18, .F., .T. } OBJ oMenu
            ITEM 'FMG' ACTION AutoMsgBox( "FMG" )
            ITEM 'PRG' ACTION AutoMsgBox( "PRG" )
            ITEM 'CH'  ACTION AutoMsgBox( "CH" )
            ITEM 'RPT' ACTION AutoMsgBox( "RPT" )
            ITEM 'RC'  ACTION AutoMsgBox( "RC" )
         END MENU
      END SPLITBOX
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

FUNCTION ToggleMenu

   oMenu:Enabled := ! oMenu:Enabled
   AutoMsgBox( "DropDown Menu is " + iif( oMenu:Enabled, "enabled.", "disabled." ) )

RETURN NIL

/*
 * EOF
 */
