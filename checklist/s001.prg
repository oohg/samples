/*
 * CheckList Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a CheckList control
 * and how to use it's methods and events.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 500 ;
      TITLE 'CheckList Demo' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR

      @ 10,10 CHECKLIST ckl_1 obj oChkL1 ;
         WIDTH 300 ;
         HEIGHT 300 ;
         ITEMS { {'Red', 0}, {'Green', 1}, {'Black', 2}, {'Pink', 1} } ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' } ;
         ON CHANGE { || Form_1.StatusBar.Item( 1 ) := "Item " + ;
                        LTRIM( STR( oChkL1:LastChangedItem ) ) + ;
                        " checkbox changed !!!" }
/*
      DEFINE CHECKLIST ckl_1
         ROW 10
         COL 10
         WIDTH 300
         HEIGHT 300
         ITEMS { {'Red', 0}, {'Green', 1}, {'Black', 2}, {'Pink', 1} }
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' }
         ON CHANGE { || Form_1.StatusBar.Item( 1 ) := "Item " + ;
                        LTRIM( STR( oChkL1:LastChangedItem ) ) + ;
                        " checkbox changed !!!" }
      END CHECKLIST

      oChkL1 := GetControlObject('ckl_1','Form_1')
*/

/*
 * LastChangedItem:
 * Item responsible for the last OnChange event.
 * Zero when the event was fired by Sort or DeleteItem methods.
 */

      DEFINE CONTEXT MENU CONTROL ckl_1
         MENUITEM 'Change Selected' ;
            ACTION oChkL1:CheckItem( oChkL1:FirstSelectedItem, ;
                            ! oChkL1:CheckItem( oChkL1:FirstSelectedItem ) )
         SEPARATOR
         MENUITEM 'Check Item 2' ;
            ACTION oChkL1:CheckItem( 2, .T. )
         MENUITEM 'Uncheck Item 2' ;
            ACTION oChkL1:CheckItem( 2, .F. )
         MENUITEM 'Status of Item 2' ;
            ACTION AutoMsgBox( IF( oChkL1:CheckItem( 2 ), ;
                                   'Checked', 'Unchecked' ) )
         MENUITEM 'Check All Items' ;
            ACTION CheckAllItems( oChkL1 )
         MENUITEM 'Uncheck All Items' ;
            ACTION UncheckAllItems( oChkL1 )
         SEPARATOR
         MENUITEM 'Change Width' ;
            ACTION oChkL1:Width := If( oChkL1:Width > 50, 50, 300 )
         MENUITEM 'Set Value := {2,3}' ;
            ACTION oChkL1:Value := { 2, 3 }
         MENUITEM 'Make Last Item Visible' ;
            ACTION oChkL1:ItemVisible( oChkL1:ItemCount )
         SEPARATOR
         MENUITEM 'Add Item' ;
            ACTION oChkL1:AddItem( {'White', 1}, .T. )
         MENUITEM 'Insert Item' ;
            ACTION oChkL1:InsertItem( 3, {'Gray', 2}, .T. )
         MENUITEM 'Change Item 2' ;
            ACTION oChkL1:Item( 2, {'Blue', 0}, .F. )
         MENUITEM 'Delete Item 1' ;
            ACTION oChkL1:DeleteItem( 1 )
         MENUITEM 'Delete All Items' ;
            ACTION oChkL1:DeleteAllItems()
         SEPARATOR
         MENUITEM 'Sort Items Ascending' ;
            ACTION oChkL1:Sort( .F. )         // if omitted .F. is assumed
         MENUITEM 'Sort Items Descending' ;
            ACTION oChkL1:Sort( .T. )
      END MENU

      @ 330,10 BUTTON btn_Value1 ;
         CAPTION "Show Value" ;
         ACTION AutoMsgBox(oChkL1:Value)

      @ 10,340 CHECKLIST chk_2 obj oChkL2 ;
         WIDTH 140 ;
         HEIGHT 300 ;
         ITEMS { 'Peaches', 'Bananas', 'Apples', 'Grapes' } ;
         JUSTIFY CHKL_JTFY_RIGHT ;
         SORT ;
         VALUE { 1,2 }

/*
      DEFINE CHECKLIST chk_2
         ROW 10
         COL 340
         WIDTH 140
         HEIGHT 300
         ITEMS { 'Peaches', 'Bananas', 'Apples', 'Grapes' }
         JUSTIFY CHKL_JTFY_RIGHT
         SORT .T.
         VALUE { 1,2 }
      END CHECKLIST

      oChkL2 := GetControlObject('chk_2','Form_1')
*/

      DEFINE CONTEXT MENU CONTROL chk_2
         MENUITEM 'Check Item 2' ;
            ACTION oChkL2:CheckItem( 2, .T. )
         MENUITEM 'Uncheck Item 2' ;
            ACTION oChkL2:CheckItem( 2, .F. )
         MENUITEM 'Status of Item 2' ;
            ACTION AutoMsgBox( IF( oChkL2:CheckItem( 2 ), ;
                                   'Checked', 'Unchecked' ) )
         MENUITEM 'Check All Items' ;
            ACTION CheckAllItems( oChkL2 )
         MENUITEM 'Uncheck All Items' ;
            ACTION UncheckAllItems( oChkL2 )
         SEPARATOR
         MENUITEM 'Set Value := {2,3}' ;
            ACTION oChkL2:Value := {2,3}
         MENUITEM 'Make Last Item Visible' ;
            ACTION oChkL2:ItemVisible( oChkL2:ItemCount )
         SEPARATOR
         MENUITEM 'Add Item' ;
            ACTION oChkL2:AddItem( "Oranges", .F. )
         MENUITEM 'Insert Item' ;
            ACTION oChkL2:InsertItem( 3, 'Plums', .F. )
         MENUITEM 'Change Item 2' ;
            ACTION oChkL2:Item( 2, 'Watermelon', .T. )
         MENUITEM 'Delete Item 1' ;
            ACTION oChkL2:DeleteItem( 1 )
         MENUITEM 'Delete All Items' ;
            ACTION oChkL2:DeleteAllItems()
         SEPARATOR
         MENUITEM 'Sort Items Ascending' ;
            ACTION oChkL2:Sort( .F. )         // if omitted .F. is assumed
         MENUITEM 'Sort Items Descending' ;
            ACTION oChkL2:Sort( .T. )
      END MENU

      @ 330,340 BUTTON btn_Value2 ;
         CAPTION "Show Value" ;
         ACTION AutoMsgBox( oChkL2:Value )

      @ 370,10 BUTTON btn_Clear ;
         CAPTION "Clear StatusBar" ;
         ACTION Form_1.StatusBar.Item( 1 ) := ""

      ON KEY ESCAPE OF Form_1 ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

Return Nil

FUNCTION CheckAllItems( oChkL )
   LOCAL i

   FOR i := 1 TO oChkL:ItemCount
      oChkL:CheckItem( i, .T. )
   NEXT i

Return Nil

FUNCTION UncheckAllItems( oChkL )
   LOCAL i

   FOR i := 1 TO oChkL:ItemCount
      oChkL:CheckItem( i, .F. )
   NEXT i

Return Nil

/*
 * EOF
 */
