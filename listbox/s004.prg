/*
 * Listbox Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a Drag ListBox and how
 * to use some of it's methods.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oList2

   DEFINE WINDOW Win1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 400 ;
      TITLE 'DRAGITEMS ListBox' ;
      MAIN

      DEFINE MAIN MENU
         POPUP "Action"
            ITEM "GetTopIndex of ListBox 1"    ACTION AutoMsgBox( oList1:TopIndex() )
            ITEM "SetTopIndex of ListBox 1"    ACTION oList1:TopIndex := Val( InputBox( "Set ListBox 1 TopIndex") )
            ITEM "EnsureVisible of ListBox 1"  ACTION oList1:EnsureVisible( Val( InputBox( "EnsureVisible of ListBox 1 Item") ) )
            ITEM "DeleteAllItems of ListBox 2" ACTION oList2:DeleteAllItems()
            ITEM "GetColumnWidth of ListBox 2" ACTION AutoMsgBox( oList2:ColumnWidth() )
            ITEM "SetColumnWidth of ListBox 2" ACTION oList2:ColumnWidth := Val( InputBox( "Set ListBox 2 ColumnWidth") )
            ITEM "GetTopIndex of ListBox 2"    ACTION AutoMsgBox( oList2:TopIndex() )
         END POPUP
      END MENU

      @ 10,20 LISTBOX lst_1 OBJ oList1 ;         // it's not required to declare oList1, it's created PRIVATE
         WIDTH 100 ;
         HEIGHT 200 ;
         ITEMS { '01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20' } ;
         DRAGITEMS ;
         TEXTHEIGHT 20

      DEFINE LISTBOX lst_2
         OBJECT      oList2         // it's required to declare oList2 or a RTE will rise
         ROW         10
         COL         150
         WIDTH       100
         HEIGHT      200
         ITEMS       { '01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20' }
         MULTISELECT .T.          // this is ignored because DRAGITEMS takes precedence
         MULTICOLUMN .T.
         DRAGITEMS   .T.
         COLUMNWIDTH 50
      END LISTBOX

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1

RETURN Nil

/*
 * EOF
 */
