/*
 * Tree Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample is an adaptation of a contribution provided by
 * Alejandro Carvalho <alejandrocarvalho@gmail.com>
 *
 * This sample shows how to save the structure and items of a
 * Tree control into an INI file and how to populate a
 * Tree control by reading its items from an INI file.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()
   LOCAL oTree1

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 368 ;
      HEIGHT 368 ;
      TITLE 'Tree Control - Save to / Create from INI file' ;
      MAIN

      DEFINE TREE Tree_1 OBJ oTree1 ;
         AT 10,10 ;
         WIDTH 340 ;
         HEIGHT 260 ;
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

      @ 290,10 BUTTON Button_1 ;
         CAPTION 'Save' ;
         ACTION SaveTreeToINI(oTree1);
         WIDTH 140

      @ 290,210 BUTTON Button_2 ;
         CAPTION 'Load' ;
         ACTION LoadTreeFromINI(oTree1);
         WIDTH 140

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION SaveTreeToINI(oTree)
   LOCAL nItems, nLen, i, Parent, cItem, cValue

   nItems := oTree:ItemCount
   IF nItems < 1
      RETURN NIL
   ENDIF

   nLen := LEN(LTRIM(STR(nItems)))

   DELETE FILE "tree.ini"

   BEGIN INI FILE "tree.ini"
      SET SECTION "TREE" ENTRY "ItemCount" TO LTRIM(STR(nItems))

      FOR i := 1 TO nItems
         IF oTree:GetParent(i) == NIL                 // Root item
            cItem := "ITEM_" + STRZERO(i, nLen, 0)
            cValue := STRZERO(0, nLen, 0) + "-" + oTree:Item(i)

            SET SECTION "TREE" ENTRY cItem TO cValue

            SaveChildren(oTree, i, nLen)
         ENDIF
      NEXT i
   END INI

   MsgInfo(LTRIM(STR(nItems)) + " items saved to TREE.INI")

RETURN NIL

FUNCTION SaveChildren(oTree, Parent, nLen)
   LOCAL aChildren, i, cItem, cValue

   aChildren := oTree:GetChildren(Parent)

   FOR i := 1 TO LEN(aChildren)
      cItem := "ITEM_" + STRZERO(aChildren[i], nLen, 0)
      cValue := STRZERO(Parent, nLen, 0) + "-" + oTree:Item(aChildren[i])

      SET SECTION "TREE" ENTRY cItem TO cValue

      SaveChildren(oTree, aChildren[i], nLen)
   NEXT i

RETURN NIL

FUNCTION LoadTreeFromINI(oTree)
   LOCAL nItems, nLen, i, cItem, cValue

   BEGIN INI FILE "tree.ini"
      nItems := 0
      GET nItems SECTION "TREE" ENTRY "ItemCount"
      nLen := LEN(LTRIM(STR(nItems)))

      oTree:DeleteAllItems()
      cValue := ""

      FOR i := 1 to nItems
         cItem := "ITEM_" + STRZERO(i, nLen, 0)

         GET cValue SECTION "TREE" ENTRY cItem
         oTree:AddItem(SUBSTR(cValue, nLen + 2), VAL(SUBSTR(cValue, 1, nLen)))
      NEXT i
   END INI

   MsgInfo(LTRIM(STR(nItems)) + " items loaded from TREE.INI")

RETURN NIL

/*
 * EOF
 */
