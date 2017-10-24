/*
 * Menu Sample n� 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a menu using InsertPopup,
 * InsertItem and InsertSeparator methods.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form OBJ oForm ;
         AT 0,0 ;
         WIDTH 400 ;
         HEIGHT 200 ;
         TITLE 'Create and Delete Menu Items' ;
         MAIN

      DEFINE MAIN MENU OBJ mnu_Main
         POPUP 'Actions'  OBJ mnu_Actions
            ITEM 'Action 1' ACTION MsgInfo( 'Action 1' ) NAME mnu_Action1
            SEPARATOR
            ITEM 'Action 2' ACTION MsgInfo( 'Action 2' ) NAME mnu_Action2
            ITEM 'Action 3' ACTION MsgInfo( 'Action 3' ) NAME mnu_Action3
         END POPUP

         POPUP 'Test'
            ITEM 'Delete Action 2' ;
               ACTION ( oForm:mnu_Action2:Release(), ;
               MsgInfo( 'Menu "Action 2" has been deleted !!!' ), ;
               oForm:mnu_Create:Enabled( .T. ), ;
               oForm:mnu_Delete:Enabled( .F. ) ) ;
               NAME mnu_Delete
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

      INSERT POPUP 'About' OBJ mnu_About FROM mnu_Main
   END POPUP

   INSERT ITEM 'OOHG Power !!!' ;
      AT -1 ACTION MsgInfo( 'Enjoy !!!' ) FROM mnu_About

   ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

/*
 * EOF
 */

