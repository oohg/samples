/*
 * Toolbar Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to add and remove buttons from a
 * toolbar at runtime.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION MAIN

   PUBLIC oTool, oTBut

   DEFINE WINDOW Win ;
      OBJ oWin ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Add and remove toolbar buttons at runtime" ;
      MAIN

      DEFINE TOOLBAR Tool OBJ oTool BUTTONSIZE 70,20 FLAT BORDER
         BUTTON But1 CAPTION "&Exit"   ACTION oWin:Release()
         BUTTON But2 CAPTION "&Add"    ACTION AddButton()
         BUTTON But3 CAPTION "&Remove" ACTION DeleteButton()
      END TOOLBAR

   END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL


PROCEDURE AddButton

   oTBut := oTool:AddButton( "But4", 0, 0, "But4", {|| MsgBox("But4")}, Nil, Nil, Nil, ;
                             "Added button", Nil, Nil, .F., .F., .F.,  .F., ;
                             .F., .F., .F. )
/*
   oTBut := TToolButton():Define( "But4", 0, 0, "But4", {|| MsgBox("But4")}, Nil, Nil, Nil, ;
                                  "Added button", Nil, Nil, .F., .F., .F.,  .F., ;
                                  .F., .F., .F., oTool )
*/

RETURN


PROCEDURE DeleteButton

   oTool:DeleteButton( 4 )
/*
   oTBut:Release()
*/

RETURN

/*
 * EOF
 */
