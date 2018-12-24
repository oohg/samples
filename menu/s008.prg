/*
 * Menu Sample n° 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define nested menus and a
 * context menu.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/menu
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE "ooHG Demo - Menu Test" ;
      MAIN

      DEFINE MAIN MENU
         POPUP "File"
            ITEM "Open" ACTION MsgInfo( "File:Open" ) IMAGE "Check.Bmp"
            ITEM "Save" ACTION MsgInfo( "File:Save" ) IMAGE "Free.Bmp"
            ITEM "Print" ACTION MsgInfo( "File:Print" ) IMAGE "Info.Bmp"
            ITEM "Save As..." ACTION MsgInfo( "File:Save As" )
            ITEM "ooHG Version" ACTION MsgInfo( MiniGuiVersion() )
            SEPARATOR
            ITEM "Exit" ACTION MsgInfo( "File:Exit" ) IMAGE "Exit.Bmp"
         END POPUP
         POPUP "Test"
            ITEM "Item 1" ACTION MsgInfo( "Item 1" )
            ITEM "Item 2" ACTION MsgInfo( "Item 2" )
            POPUP "Item 3"
               ITEM "Item 3.1" ACTION MsgInfo( "Item 3.1" )
               ITEM "Item 3.2" ACTION MsgInfo( "Item 3.2" )
               POPUP "Item 3.3"
                  ITEM "Item 3.3.1" ACTION MsgInfo( "Item 3.3.1" )
                  ITEM "Item 3.3.2" ACTION MsgInfo( "Item 3.3.2" )
                  POPUP "Item 3.3.3"
                     ITEM "Item 3.3.3.1" ACTION MsgInfo( "Item 3.3.3.1" )
                     ITEM "Item 3.3.3.2" ACTION MsgInfo( "Item 3.3.3.2" )
                     ITEM "Item 3.3.3.3" ACTION MsgInfo( "Item 3.3.3.3" )
                     ITEM "Item 3.3.3.4" ACTION MsgInfo( "Item 3.3.3.4" )
                     ITEM "Item 3.3.3.5" ACTION MsgInfo( "Item 3.3.3.5" )
                     ITEM "Item 3.3.3.6" ACTION MsgInfo( "Item 3.3.3.6" )
                  END POPUP
                  ITEM "Item 3.3.4" ACTION MsgInfo( "Item 3.3.4" )
               END POPUP
            END POPUP
            ITEM "Item 4" ACTION MsgInfo( "Item 4" )
         END POPUP
         POPUP "Help" RIGHT
            ITEM "About" ACTION MsgInfo( "Help:ABout" )
         END POPUP
      END MENU

      DEFINE CONTEXT MENU
         ITEM "Item 1" ACTION MsgInfo( "Item 1" )
         ITEM "Item 2" ACTION MsgInfo( "Item 2" )
         SEPARATOR
         ITEM "Item 3" ACTION MsgInfo( "Item 3" )
      END MENU

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */