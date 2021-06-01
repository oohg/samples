/*
 * Menu Sample n° 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a menu of
 * "most recently used" files.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL lOwnerDraw := MsgYesNo( "Define MAIN MENU as OWNERDRAW?", 'ooHG Demo - MRU Sample' )

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'ooHG Demo - MRU Sample' ;
      MAIN

      DEFINE STATUSBAR
        STATUSITEM ""
        KEYBOARD
        DATE
      END STATUSBAR

   IF lOwnerDraw
      DEFINE MAIN MENU  MESSAGE "Try the menu options!" TIMEOUT 0 OWNERDRAW
   ELSE
      DEFINE MAIN MENU MESSAGE "Try the menu options!" TIMEOUT 0
   ENDIF
         POPUP "&File" MESSAGE "Click me!"
            MRU "&New" OBJ oMRU ACTION OpenDoc MESSAGE "Select a file!", "Click to execute!" TIMEOUT 5000
            /*
             * The function name can also be "OpenDoc" or ( "OpenDoc" ).
             * Also you can use a variable:
             *    var := "OpenDoc"
             *    ... ACTION ( var ) ...
             * Also you can use a codeblock using the following form:
             *    ... ACTION ( { |item| OpenDoc( item ) } ) ...
             *
             * MESSAGE: When you move the mouse pointer over the "New" menu item,
             * the first string will be displayed in the first element of the
             * form's status bar. The second string will be displayed when the mouse
             * pointer passes over the items in the MRU list. If you do not want to
             * display a message when you move the mouse over an item, add MESSAGE "".
             * The MESSAGE is automatically erased after 5 seconds.
             * Set TIMEOUT to 0 to prevent the message from being erased.
             * When an item's TIMEOUT is omited the parent's is assumed.
             * When the menu's TIMEOUT is omited a default value is assigned.
             */
            SEPARATOR
            ITEM "Clear" ACTION oMRU:Clear() MESSAGE "Clear the list of recently used file."
         END POPUP

         ITEM "Info" RIGHT MESSAGE "This should be at the right side of the menu bar." ACTION MsgInfo( "This is a sample of the MRU menu." )
      END MENU

      @ 150, 10 LABEL lbl_1 HEIGHT 200 WIDTH 600 VALUE ;
         "Open 'File' menu, click 'New' and select a file." + CRLF + ;
         "The file is added to the top of the MRU menu and the associated app is opened." + CRLF + ;
         "Repeat several times. Note that the list only holds the last 7 filenames (configurable)." + CRLF + ;
         "Use 'Clear' to remove all entries." + CRLF + ;
         "All entries are save to file 'MRU.INI' on control's release and read from it at control's creation."

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION OpenDoc( cFile )

   IF Empty( cFile )
      cFile := Getfile ( { {'Sources', '*.prg'} }, 'Open source' )
      IF ! Empty( cFile )
         oMRU:AddItem( cFile )
         ShellExecute( , "open", cFile, , , SW_SHOWNORMAL )
      ENDIF
   ELSE
      ShellExecute( , "open", cFile, , , SW_SHOWNORMAL )
   ENDIF
   oForm:StatusBar:Item( 1, "" )

   RETURN NIL

/*
 * EOF
 */
