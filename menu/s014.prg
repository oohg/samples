/*
 * Menu Sample # 14
 * Author: Miguel Ingles <miguelsuizowin@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use SET MENU FONT TO to set the font of
 * the menus of the application, and how a main menu, a context menu
 * of the window and a context menu of a control work together.
 * It's useful to test the menus under Wine (Linux):
 * - The context menus must not replace the main menu.
 * - No item of the menu bar must be shown as selected at startup.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   // Only affects this application; it must be used before defining the menus
   SET MENU FONT TO "Arial", 11

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 300 ;
      TITLE "SET MENU FONT and context menus" ;
      MAIN

      DEFINE MAIN MENU
         POPUP "&File"
            ITEM "&New"  ACTION AutoMsgBox( "New" )
            ITEM "&Open" ACTION AutoMsgBox( "Open" )
            SEPARATOR
            ITEM "E&xit" ACTION Form_1.Release()
         END POPUP
         POPUP "&Help"
            ITEM "&About" ACTION AutoMsgBox( "Menu sample # 14" )
         END POPUP
      END MENU

      DEFINE CONTEXT MENU
         ITEM "Window option 1" ACTION AutoMsgBox( "Window option 1" )
         ITEM "Window option 2" ACTION AutoMsgBox( "Window option 2" )
      END MENU

      @ 20, 20 LABEL Label_1 ;
         VALUE "Right click the window or the textbox." ;
         WIDTH 400

      @ 60, 20 TEXTBOX Text_1 ;
         VALUE "Right click here" ;
         WIDTH 250

      DEFINE CONTEXT MENU CONTROL Text_1
         ITEM "Textbox option 1" ACTION AutoMsgBox( "Textbox option 1" )
         ITEM "Textbox option 2" ACTION AutoMsgBox( "Textbox option 2" )
      END MENU
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */
