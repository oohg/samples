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
      TITLE "Create and Delete Menu Items" ;
      MAIN

      _OOHG_DefaultStatusBarMsg := "App-wide default message"

      DEFINE STATUSBAR MESSAGE "Statusbar default message"
         STATUSITEM ""
      END STATUSBAR

      DEFINE MAIN MENU OBJ mnu_Main
         POPUP "Actions"  OBJ mnu_Actions MESSAGE "First menu"
            ITEM "MsgInfo" ACTION MsgInfo( "Action 1" ) NAME mnu_Action1 MESSAGE "Shows an informative message!"
            SEPARATOR
            ITEM "Dump" ACTION _oohg_calldump() NAME mnu_Action2 MESSAGE "Dumps the stack of function calls!"
            ITEM "New Form" ACTION NewForm() NAME mnu_Action3 MESSAGE "Opens a new form!"
         END POPUP

         POPUP "Test" MESSAGE "Second menu"
            ITEM "Delete item Inserted of menu Actions" ;
               ACTION ( oForm:mnu_Action4:Release(), ;
                        MsgInfo( 'Item Inserted of menu Actions has been deleted !!!' ), ;
                        oForm:mnu_Create:Enabled( .T. ), ;
                        oForm:mnu_Delete:Enabled( .F. ) ) ;
               NAME mnu_Delete
            ITEM "Create item Inserted of menu Actions" ;
               ACTION ( TMenuItem():InsertItem( "Inserted" , ;
                                                { || MsgInfo( "Item Inserted of Actions menu!" ) }, ;
                                                "mnu_Action4", ;
                                                NIL, ;
                                                .F., ;
                                                .F., ;
                                                mnu_Actions, ;
                                                .F., ;
                                                .F., ;
                                                .F., ;
                                                NIL, ;
                                                4 ), ;
                        MsgInfo( 'Item Inserted of menu Actions has been created !!!'), ;
                        oForm:mnu_Create:Enabled( .F. ) , ;
                        oForm:mnu_Delete:Enabled( .T. ) ) ;
               NAME mnu_Create ;
               DISABLED
         END POPUP
      END MENU

      INSERT ITEM "Inserted" NAME mnu_Action4 FROM mnu_Actions ;
         AT -1 ACTION MsgInfo( 'Item Inserted of menu Actions has been deleted !!!' )

      INSERT SEPARATOR AT 3 FROM mnu_Actions

      INSERT POPUP "About" OBJ mnu_About FROM mnu_Main MESSAGE "New Popup"
      END POPUP

      INSERT ITEM "OOHG Power !!!" ;
         AT -1 ACTION MsgInfo( "Enjoy !!!" ) FROM mnu_About MESSAGE "New Item"

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

   RETURN NIL

FUNCTION NewForm

   DEFINE WINDOW Form2 ;
      AT Form.Row + 50, Form.Col + 50 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE "New Form"

      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR

      DEFINE MAIN MENU
         ITEM "Close" ACTION ThisWindow.Release()
      END MENU

      @ 20, 20 LABEL lbl_1 ;
         AUTOSIZE ;
         VALUE "The statusbar should show the app-wide default message!" + CRLF + ;
               "when the mouse hovers the menu's item."

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   ACTIVATE WINDOW Form2

   RETURN NIL

/*
 * EOF
 */
