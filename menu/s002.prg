/*
 * Menu Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create and delete
 * menu items on the fly and how to right align
 * text in menu captions.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   ERASE DumpLog.txt

   SET TOOLTIP ACTIVATE ON
   SET TOOLTIPBALLOON ON

   DEFINE WINDOW Form OBJ oForm ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - Create and Delete Menu Items' ;
      MAIN

      ON KEY F1 ACTION MsgInfo( 'Action 1' )
      ON KEY F2 ACTION MsgInfo( 'Action 2' )
      ON KEY F3 ACTION MsgInfo( 'Action 3' )

      ADD TOOLTIP ICON INFO_LARGE WITH TITLE "This is the way!" TO Form

      DEFINE MAIN MENU OBJ mnu_Main
         POPUP 'Actions'  OBJ mnu_Actions
            ITEM 'Action 1' + Chr( 9 ) + "F1" ACTION MsgInfo( 'Action 1' ) NAME mnu_Action1 TOOLTIP "F1"
            SEPARATOR
            ITEM 'Action 2' + Chr( 9 ) + "F2" ACTION MsgInfo( 'Action 2' ) NAME mnu_Action2 TOOLTIP "F2"
            ITEM 'Action 3' + Chr( 9 ) + "F3" ACTION MsgInfo( 'Action 3' ) NAME mnu_Action3 TOOLTIP "F3"
         END POPUP

         POPUP 'Test'
            ITEM 'Delete Action 2' ;
               ACTION ( oForm:mnu_Action2:Release(), ;
                        MsgInfo( 'Menu "Action 2" has been deleted !!!' ), ;
                        oForm:mnu_Create:Enabled( .T. ), ;
                        oForm:mnu_Delete:Enabled( .F. ) ) ;
               NAME mnu_Delete TOOLTIP "DEL F2"
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
               DISABLED TOOLTIP "ADD F2"
         END POPUP
      END MENU

//      INSERT ITEM 'Action 4' ;
      INSERT ITEM nil ;
         AT -1 ACTION MsgInfo( 'Action 4' ) FROM mnu_Actions TOOLTIP "Action 4"

      INSERT SEPARATOR AT 3 FROM mnu_Actions

      INSERT POPUP 'About' OBJ mnu_About FROM mnu_Main
      END POPUP

      INSERT ITEM 'OOHG Power !!!' ;
         AT -1 ACTION MsgInfo( 'Enjoy !!!' ) FROM mnu_Main TOOLTIP "ENJOY OOHG!!!"


      @ 100, 20 TEXTBOX txt WIDTH 200 TOOLTIP "This is a textbox!"

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL

/*
 * EOF
 */
