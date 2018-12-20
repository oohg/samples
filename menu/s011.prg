/*
 * Menu Sample n° 11
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the menu's MESSAGE clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form OBJ oForm ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'Create and Delete Menu Items' ;
      MAIN

      _OOHG_DefaultStatusBarMsg := "App-wide default message"

      DEFINE STATUSBAR MESSAGE "Statusbar default message"
         STATUSITEM ""
      END STATUSBAR

      DEFINE MAIN MENU OBJ mnu_Main
         POPUP 'Actions'  OBJ mnu_Actions MESSAGE "First menu"
            ITEM 'Action 1' ACTION MsgInfo( 'Action 1' ) NAME mnu_Action1 MESSAGE "Action 1"
            SEPARATOR
            ITEM 'Action 2' ACTION _oohg_calldump() NAME mnu_Action2 MESSAGE "Action 2"
            ITEM 'Action 3' ACTION MsgInfo( 'Action 3' ) NAME mnu_Action3 MESSAGE "Action 3"
         END POPUP

         POPUP 'Test' MESSAGE "Second menu"
            ITEM 'Delete Action 2' ;
               ACTION ( oForm:mnu_Action2:Release(), ;
                        MsgInfo( 'Menu "Action 2" has been deleted !!!' ), ;
                        oForm:mnu_Create:Enabled( .T. ), ;
                        oForm:mnu_Delete:Enabled( .F. ) ) ;
               NAME mnu_Delete MESSAGE 4
            ITEM 'Create Action 2' ;
               ACTION ( TMenuItem():InsertItem( "Action 2" , ;
                                                { || MsgInfo("Action 2") }, ;
                                                "mnu_Action2", ;
                                                NIL, ;
                                                .F., ;
                                                .F., ;
                                                mnu_Actions, ;
                                                .F., ;
                                                .F., ;
                                                .F., ;
                                                NIL, ;
                                                2 ), ;
                        MsgInfo( 'Menu "Action 2" has been created !!!'), ;
                        oForm:mnu_Create:Enabled( .F. ) , ;
                        oForm:mnu_Delete:Enabled( .T. ) ) ;
               NAME mnu_Create ;
               DISABLED
         END POPUP
      END MENU

      INSERT ITEM 'Action 4' ;
         AT -1 ACTION MsgInfo( 'Action 4' ) FROM mnu_Actions

      INSERT SEPARATOR AT 3 FROM mnu_Actions

      INSERT POPUP 'About' OBJ mnu_About FROM mnu_Main MESSAGE "New Popup"
      END POPUP

      INSERT ITEM 'OOHG Power !!!' ;
         AT -1 ACTION MsgInfo( 'Enjoy !!!' ) FROM mnu_About MESSAGE "New Item"

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

/*
 * EOF
 */
