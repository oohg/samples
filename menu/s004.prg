/*
 * Menu Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to programatically open a window's
 * menu using its shortcut key.
 *
 * Visit us at https://github.com/oohg/samples
 */

 #include "oohg.ch"

 FUNCTION Main()

    DEFINE WINDOW Win_1 ;
       AT 0,0 ;
       WIDTH 640 ;
       HEIGHT 480 ;
       TITLE "ooHG Demo - Open Menu" ;
       MAIN ;
       ON INIT INSERT_ALT_F()

       DEFINE MAIN MENU OF Win_1
          POPUP "&File"
             ITEM "One" ACTION MsgInfo( "Menu Option One" )
             ITEM "Two" ACTION MsgInfo( "Menu Option Two" )
             SEPARATOR
             ITEM "Exit" ACTION Win_1.Release
          END POPUP
       END MENU

      /*
      The trick is done by defining an accelerator key for the menu,
      using an & before the corresponding letter (in this case F),
      and simulating that the user has pressed Alt+F with the
      function INSERTAR_ALT_F().
      */

      @ 100, 10 LABEL Lbl_1 ;
          VALUE "At start time the menu should be open." ;
          AUTOSIZE

       ON KEY ESCAPE ACTION Win_1.Release
    END WINDOW

    CENTER WINDOW Win_1
    ACTIVATE WINDOW Win_1

 RETURN NIL

 #pragma BEGINDUMP

 #include "hbapi.h"
 #include <windows.h>

 #ifndef VK_F
    #define VK_F 70
 #endif

 HB_FUNC( INSERT_ALT_F )
 {
    keybd_event(VK_MENU, 0, 0, 0 ) ;
    keybd_event(VK_F, 0, 0, 0 ) ;
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0 );
 }

 #pragma ENDDUMP

 /*
  * EOF
  */
