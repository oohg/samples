/*
 * Tree Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to save the items of a Tree control
 * into an array and how to populate a Tree control by reading
 * its items from an array.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()
   LOCAL oTree1

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 530 ;
      TITLE 'TreeView - Save to / Create from an array' ;
      MAIN

      DEFINE TREE Tree_1 OBJ oTree1 ;
         AT 10,10 ;
         WIDTH 300 ;
         HEIGHT 202 ;
         VALUE 1 ;
         SELBOLD

         FOR i := 1 TO 4
            NODE 'T1 Item ' + LTRIM(STR(i))
               FOR j := 1 TO 3
                  NODE 'T1 Item ' + LTRIM(STR(i)) + '.' + LTRIM(STR(j))
                     FOR k := 1 TO 5
                        TREEITEM 'T1 Item ' + ;
                                 LTRIM(STR(i)) + '.' + ;
                                 LTRIM(STR(j)) + '.' + ;
                                 LTRIM(STR(k))
                     NEXT
                  END NODE
               NEXT
            END NODE
         NEXT
      END TREE

      @ 250,10 BUTTON Button_1 ;
         CAPTION 'Process' ;
         ACTION ToArray(oTree1);
         WIDTH 140

      ON KEY ESCAPE OF Form_1 ACTION Form_1.Release()

   END WINDOW

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
Return value: an array of the root items.
Each item in the Tree is represented by a three item array:
{ item's reference number, children, item's text }
where children is an array of items.
*/
FUNCTION ToArray( oTree )
   LOCAL i, nItems, aTree, Parent

   // save in aTree
   aTree := {}
   nItems := oTree:ItemCount

   FOR i := 1 TO nItems
      If ( Parent := oTree:GetParent(i) ) == NIL
         // it's a root item
         AADD(aTree, { i, Children(oTree, i), oTree:Item(i) })
      EndIf
   NEXT i

   // show aTree
   nItems := LEN(aTree)
   FOR i := 1 to nItems
      MsgBox("Root: " + LTRIM(STR(aTree[i,1])) + HB_OsNewLine() + ;
             ListChildren(aTree[i,2], 0))
   NEXT i

   IF IsControlDefined("Tree_2", "Form_1")
      Form_1.Tree_2.Release()
   ENDIF

   // create a Tree from aTree
   DEFINE TREE Tree_2 ;
      PARENT Form_1 ;
      AT 10,320 ;
      WIDTH 300 ;
      HEIGHT 202 ;
      VALUE 1 ;
      SELBOLD

      CreateChildren(aTree)
   END TREE

RETURN NIL

FUNCTION Children( oTree, nItem )
   LOCAL aChildren, i, t

   aChildren := oTree:GetChildren(nItem)
   t := LEN(aChildren)

   FOR i := 1 TO t
      aChildren[i] := { aChildren[i], ;
                        Children(oTree, aChildren[i]), ;
                        oTree:Item(aChildren[i]) }
   NEXT i

RETURN aChildren

FUNCTION ListChildren( aChildren, nCol )
   LOCAL cMsg, i

   IF LEN(aChildren) > 0
      cMsg := space(nCol) + "Children: " + HB_OsNewLine()
      FOR i := 1 to LEN(aChildren)
         cMsg += space(nCol) + LTRIM(STR(aChildren[i,1])) + " - " + ;
                 aChildren[i,3] + HB_OsNewLine() + ;
                 ListChildren(ACLONE(aChildren[i,2]), nCol + 3)
      NEXT i
   ELSE
      cMsg := ""
   ENDIF

RETURN cMsg

FUNCTION CreateChildren( aChildren )
   LOCAL nItems, i

   nItems := LEN( aChildren )
   FOR i := 1 to nItems
      IF LEN(aChildren[i,2]) > 0
         // has children
         NODE aChildren[i,3]
            CreateChildren(aChildren[i,2])
         END NODE
      ELSE
         TREEITEM aChildren[i,3]
      ENDIF
   NEXT

RETURN NIL

/*
 * EOF
 */
