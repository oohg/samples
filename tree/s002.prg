/*
 * Tree Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to link different windows with the
 * items of a TREE controls .
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Tree Control - Windows linked to a Tree' ;
      MAIN

      DEFINE TREE Tree_1 ;
         OBJ oTree ;
         AT 10,10 ;
         WIDTH 200 ;
         HEIGHT 400 ;
         ON CHANGE ShowMyWindow( oForm, oTree ) ;
         ON EXPAND { |a, b| AutoMsgBox( {"Expand", a, b} ) } ;
         ON COLLAPSE { |a, b| AutoMsgBox( {"Collapse", a, b} ) }

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

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

FUNCTION ShowMyWindow( oForm, oTree )

   STATIC oAuxWin := Nil

   IF HB_IsObject( oAuxWin )
     oAuxWin:Release()
     oAuxWin := Nil
   ENDIF

   DEFINE INTERNAL AuxWin ;
      OBJ oAuxWin ;
      OF (oForm) ;
      AT oTree:row, oTree:col + oTree:width + 20 ;
      WIDTH oForm:width - oTree:col * 2 - oTree:width - 30 ;
      HEIGHT oTree:height ;
      BACKCOLOR WHITE ;
      BORDER

      @ 20, 20 LABEL lbl_data ;
         VALUE "Linked to item " + LTRIM(STR(oTree:value)) ;
         AUTOSIZE ;
         TRANSPARENT
   END INTERNAL

RETURN Nil

/*
 * EOF
 */
