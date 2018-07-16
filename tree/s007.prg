/*
 * Tree Sample n° 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to drag an item of a Tree control
 * to an internal window.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download the resource file and the images from:
 * https://github.com/oohg/samples/tree/master/Tree
 */

#include "oohg.ch"

FUNCTION Main()

   PUBLIC nRow := 0, ;
          nImage := 1, ;
          aImages := { "WINDOW", "WATCH", "LED_OFF", "LED_ON" }

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Tree Control - Drag to a window' ;
      MAIN

      DEFINE TREE Tree_1 ;
         OBJ oTree ;
         AT 10,10 ;
         WIDTH 200 ;
         HEIGHT 400 ;
         ENABLEDRAG ;
         TARGET { {|| oAuxWin } } ;
         NODEIMAGES {"WINDOW", "WATCH"} ;
         ITEMIMAGES {"LED_OFF", "LED_ON"}

         NODE 'Item 1'
            TREEITEM 'Item 1.1'
            TREEITEM 'Item 1.2'
            TREEITEM 'Item 1.3'
         END NODE

         NODE 'Item 2'
            TREEITEM 'Item 2.1'

            NODE 'Item 2.2'
               TREEITEM 'Item 2.2.1'
               TREEITEM 'Item 2.2.2'
               TREEITEM 'Item 2.2.3'
               TREEITEM 'Item 2.2.4'
               TREEITEM 'Item 2.2.5'
               TREEITEM 'Item 2.2.6'
               TREEITEM 'Item 2.2.7'
               TREEITEM 'Item 2.2.8'
            END NODE

            TREEITEM 'Item 2.3'
         END NODE

         NODE 'Item 3'
            TREEITEM 'Item 3.1'
            TREEITEM 'Item 3.2'

            NODE 'Item 3.3'
               TREEITEM 'Item 3.3.1'
               TREEITEM 'Item 3.3.2'
            END NODE
         END NODE
      END TREE

      DEFINE INTERNAL AuxWin ;
         OBJ oAuxWin ;
         AT oTree:Row, oTree:Col + oTree:Width + 20 ;
         WIDTH oForm:ClientWidth - oTree:Col * 2 - oTree:Width - 30 ;
         HEIGHT oTree:Height ;
         BACKCOLOR WHITE ;
         BORDER
      END INTERNAL

      WITH OBJECT oAuxWin
         :DropEnabled := .T.
         :OnMouseDrag := ;
            { |oOrigin, oTarget, wParam| Generic_OnMouseDrag( wParam ) }
         :OnMouseDrop := ;
            { |oOrigin, oTarget, wParam| AuxWin_OnDrop( oOrigin, oTarget ) }
      END WITH

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

FUNCTION AuxWin_OnDrop( oOrigin, oTarget )

   LOCAL nItem, aItemImages, nImage

   WITH OBJECT oOrigin
      nItem := :HandleToItem( :ItemOnDrag )
      aItemImages := :ItemImages( :HandleToItem( :ItemOnDrag ) )
      If nItem == :Value
         nImage := aItemImages[ 2 ] + 1     // selected image
      Else
         nImage := aItemImages[ 1 ] + 1     // unselected image
      EndIf

      DEFINE IMAGE ( "Image_" + LTRIM( STR( nImage ) ) )
         PARENT  (oTarget)
         ROW     nRow
         COL     20
         PICTURE ( aImages[ nImage ] )
         WIDTH   50
         HEIGHT  50
         STRETCH .T.
      END IMAGE

      nRow += 60
      nImage ++
   END WITH

RETURN Nil

/*
 * EOF
 */
