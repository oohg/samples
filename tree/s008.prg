/*
 * Tree Sample n° 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use checkboxes in a Tree control.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "ooHG.ch"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      ON RELEASE Bye();
      MAIN ;
      TITLE "How to use checkboxes in a Tree control"

      ON KEY ESCAPE ACTION Form_1.Release

      DEFINE TREE Tree_1 obj oTree;
         AT 10, 10 ;
         WIDTH 200 ;
         HEIGHT 400 ;
         CHECKBOXES

         NODE 'Item 1'
            TREEITEM 'Item 1.1' CHECKED
            TREEITEM 'Item 1.2'
            TREEITEM 'Item 1.3'
         END NODE
      END TREE
   END WINDOW

   oTree:CheckItem( 3, .T.)

   Form_1.Center
   Form_1.Activate

RETURN

PROCEDURE Bye
   LOCAL cMsg, nNum

   cMsg := "ItemCount = " + Ltrim(Str(oTree:ItemCount)) + HB_OsNewLine()

   FOR nNum := 1 TO oTree:ItemCount
      cMsg += "Item " + Ltrim(Str(nNum)) + " = "
      cMsg += IF(oTree:CheckItem(nNum), ".T.", ".F.")
      cMsg += HB_OsNewLine()
   NEXT nNum

   MSGBOX(cMsg)

RETURN

/*
 * EOF
 */
