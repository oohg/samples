/*
 * Menu Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use BREAKMENU [SEPARATOR].
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - Menu with breakmenu clause' ;
      MAIN

      DEFINE STATUSBAR
        KEYBOARD
        DATE
      END STATUSBAR

      DEFINE MAIN MENU

         POPUP 'PopUp1'
            ITEM 'Item 1 of PopUp1' ;
               ACTION MsgInfo( 'Item 1 of PopUp1' )
            ITEM 'Item 2 of PopUp1' ;
               ACTION MsgInfo( 'Item 2 of PopUp1' )
            ITEM 'Item 3 of PopUp1' ;
               ACTION MsgInfo( 'Item 3 of PopUp1' ) ;
               BREAKMENU
            ITEM 'Item 4 of PopUp1' ;
               ACTION MsgInfo( 'Item 4 of PopUp1' )
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

RETURN Nil

/*
 * EOF
 */
