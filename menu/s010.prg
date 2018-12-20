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

      DEFINE MAIN MENU
         POPUP "&File" MESSAGE "Click me!"
            MRU "&New" OBJ oMRU ACTION OpenDoc MESSAGE "Select a file!", "Click to execute!"
            /*
             * The function name can also be "OpenDoc" or ( "OpenDoc" ).
             * Also you can use a variable:
             *    var := "OpenDoc"
             *    ... ACTION ( var ) ...
             * Also you can use a codeblock using the following form:
             *    ... ACTION ( { |item| OpenDoc( item ) } ) ...
             *
             * MESSAGE: when the mouse hovers the menu item "New" the first string
             *          will be showed at the first item of the form's statusbar.
             *          The seconde string will be shown when the mouse hovers
             *          the items of the MRU list.
             * If you don't want to display a message when hovering and item
             * then add MESSAGE "". If you ommit MESSAGE clause then the previously
             * displayed message is not erased.
             */
            SEPARATOR
            ITEM "Clear" ACTION oMRU:Clear() MESSAGE "Clear the list of recently used file."
         END POPUP

         ITEM "Info" RIGHT MESSAGE "This should be at the right side of the menu bar." ACTION MsgInfo( "This is a sample of the MRU menu." )
      END MENU

      @ 150, 10 LABEL lbl_1 HEIGHT 200 WIDTH 600 VALUE ;
         "Open 'File' menu, click 'New' and select a file." + CRLF + ;
         "The file is added to the MRU menu and the associated app is opened." + CRLF + ;
         "Repeat several times. Note that the list only holds the last 7 filenames (configurable)." + CRLF + ;
         "Note also that the most recently opened file is at the top of the list." + CRLF + ;
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
         ShellExecute( , "open", cFile, , , 1 )
      ENDIF
   ELSE
      ShellExecute( , "open", cFile, , , 1 )
   ENDIF
   oForm:StatusBar:Item( 1, "" )

   RETURN NIL

/*
 * EOF
 */
