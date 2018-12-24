/*
 * Menu Sample n° 12
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a specific font for
 * a menu instead of using an app-wide font (see "ownerdraw"
 * folder for such an example).
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm_1 ;
      AT 0, 0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - OwnerDraw Menu' ;
      MAIN

      DEFINE STATUSBAR
        STATUSITEM ""
        KEYBOARD
        DATE
      END STATUSBAR

      DEFINE MAIN MENU OWNERDRAW FONT { "Comic Sans MS", 8, .F., .T. }

         POPUP 'PopUp1'
            ITEM 'Item 1 of PopUp1' ;
               ACTION MsgInfo( 'Item 1 of PopUp1' )
            ITEM 'Item 2 of PopUp1' ;
               ACTION MsgInfo( 'Item 2 of PopUp1' )
            SEPARATOR
            ITEM 'Item 3 of PopUp1' ;
               ACTION MsgInfo( 'Item 3 of PopUp1' )
            ITEM 'Item 4 of PopUp1' ;
               ACTION MsgInfo( 'Item 4 of PopUp1' ) ;
               BREAKMENU
            ITEM 'Item 5 of PopUp1' ;
               ACTION MsgInfo( 'Item 5 of PopUp1' )
            SEPARATOR
            ITEM 'Exit' ;
               ACTION oForm_1:Release()
         END POPUP

         POPUP 'PopUp2'
            ITEM 'Item 1 of PopUp2' ;
               ACTION MsgInfo( 'Item 1 of PopUp2' )
            ITEM 'Item 2 of PopUp2' ;
               ACTION MsgInfo( 'Item 2 of PopUp2' )

            POPUP 'Item 3 of PopUp2'
               ITEM 'Item 3.1 of PopUp2' ;
                  ACTION MsgInfo( 'Item 3.1 of PopUp2' )
               ITEM 'Item 3.2 of PopUp2' ;
                  ACTION MsgInfo( 'Item 3.2 of PopUp2' )

               POPUP 'Item 3.3 of PopUp2'
                  ITEM 'Item 3.3.1 of PopUp2' ;
                     ACTION MsgInfo( 'Item 3.3.1 of PopUp2' )
                  ITEM 'Item 3.3.2 of PopUp2' ;
                     ACTION MsgInfo( 'Item 3.3.2 of PopUp2' )

                  POPUP 'Item 3.3.3 of PopUp2'
                     ITEM 'Item 3.3.3.1 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.1 of PopUp2' )
                     ITEM 'Item 3.3.3.2 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.2 of PopUp2' )
                     ITEM 'Item 3.3.3.3 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.3 of PopUp2' )
                     ITEM 'Item 3.3.3.4 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.4 of PopUp2' ) ;
                        BREAKMENU SEPARATOR
                     ITEM 'Item 3.3.3.5 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.5 of PopUp2' )
                     ITEM 'Item 3.3.3.6 of PopUp2' ;
                        ACTION MsgInfo( 'Item 3.3.3.6 of PopUp2' )
                  END POPUP

                  ITEM 'Item 3.3.4 of PopUp2' ;
                     ACTION MsgInfo( 'Item 3.3.4 of PopUp2' )
               END POPUP
            END POPUP

            ITEM 'Item 4 of PopUp2' ;
               ACTION MsgInfo( 'Item 4 of PopUp2' )
         END POPUP

         POPUP 'PopUp3' BREAKMENU
            ITEM 'Item 1 of PopUp3' ;
               ACTION MsgInfo( 'Item 1 of PopUp3' )
         END POPUP

      END MENU

      ON KEY ESCAPE ACTION oForm_1:Release()

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */
