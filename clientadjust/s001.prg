/*
 * Client Adjust Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on an original contribution by
 * Cayetano Gómez <cayetano.gomez@gmail.com>
 *
 * This sample show how to use ClientAdjust property to create
 * a window with controls that automatically adjust their
 * places and sizes each time the window's size is changed or
 * when the other control's layout is changed.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL oLbl1, oTree1, oFrame1, oBut1, ;
         oInt2, oFrame2, oFrame3, oBrowse1

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 658;
      HEIGHT 480 ;
      TITLE 'ooHG - ClientAdjust Sample' ;
      MAIN

/*
 * ClientAdjust values:
 * 0 = none
 * 1 = top
 * 2 = bottom
 * 3 = left
 * 4 = right
 * 5 = client
 */

      @ 0,0 LABEL lbl_1 ;
         OBJ oLbl1 ;
         WIDTH 30 ;
         BACKCOLOR BLUE ;
         VALUE "Move/Hide this caption using the buttons." ;
         BORDER ;
         FONTCOLOR WHITE
      oLbl1:ClientAdjust := 1       // top

      DEFINE TREE tree_1 ;
         OBJ oTree1 ;
         AT 10,10 ;
         WIDTH 160 ;
         HEIGHT 400 ;
         VALUE 15

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
      oTree1:ClientAdjust := 3       // left

      DEFINE WINDOW int_1 ;
         OBJ oFrame1 ;
         HEIGHT 80 ;
         BACKCOLOR ORANGE ;
         INTERNAL

         @ 33,10 LABEL lbl_2 ;
            WIDTH 100 ;
            HEIGHT 24 ;
            VALUE 'Select an item:'

         @ 30,100 COMBOBOX cmb_1 ;
            ITEMS {'Item A', 'Item B', 'Item C'} ;
            VALUE 1

         @ 0,0 BUTTON btn_1 ;
            OBJ oBut1 ;
            CAPTION "Close" ;
            HEIGHT 24 ;
            ACTION IF( oFrame1:Height == 24, ;
                       oFrame1:Height := 80, ;
                       oFrame1:Height := 24 )
         oBut1:ClientAdjust := 1       // top
      END WINDOW
      oFrame1:ClientAdjust := 1       // top

      DEFINE WINDOW int_2 ;
         OBJ oInt2 ;
         WIDTH 10 ;
         INTERNAL ;
         BACKCOLOR YELLOW
      END WINDOW
      oInt2:ClientAdjust := 4       // right

      DEFINE WINDOW int_3 ;
         OBJ oFrame2 ;
         HEIGHT 80 ;
         INTERNAL

         @ 10,10 BUTTON btn_1 ;
           WIDTH 120 ;
           HEIGHT 24 ;
           CAPTION 'Hide/Show Frame 1' ;
           ACTION oFrame1:Visible := ! oFrame1:Visible

         @ 10,140 BUTTON btn_2 ;
            WIDTH 120 ;
            HEIGHT 24 ;
            CAPTION 'Hide/Show Caption' ;
            ACTION oLbl1:Visible := ! oLbl1:Visible

         @ 10,270 BUTTON btn_3 ;
            WIDTH 120 ;
            HEIGHT 24 ;
            CAPTION 'Hide/Show Tree' ;
            ACTION oTree1:Visible := ! oTree1:Visible

         @ 35,10 BUTTON btn_4 ;
            WIDTH 100 ;
            HEIGHT 24 ;
            CAPTION 'Caption Top' ;
            ACTION ( oLbl1:nHeight := 30, oLbl1:Adjust := 1 )

         @ 35,120 BUTTON btn_5 ;
            WIDTH 100 ;
            HEIGHT 24 ;
            CAPTION 'Caption Bottom' ;
            ACTION ( olbl1:nHeight := 30, oLbl1:Adjust := 2 )

         @ 35,230 BUTTON btn_6 ;
            WIDTH 100 ;
            HEIGHT 24 ;
            CAPTION 'Caption Left' ;
            ACTION ( oLbl1:nWidth := 30, oLbl1:Adjust := 3 )

         @ 35,340 BUTTON btn_7 ;
            WIDTH 100 ;
            HEIGHT 24 ;
            CAPTION 'Caption Right' ;
            ACTION ( oLbl1:nWidth := 30, oLbl1:Adjust := 4 )
      END WINDOW
      oFrame2:ClientAdjust := 2       // bottom

      @ 10,10 FRAME frm_3 ;
         OBJ oFrame3 ;
         CAPTION "Frame Right" ;
         WIDTH 120
      oFrame3:ClientAdjust := 4       // right

      @ 0,0 BROWSE brw_1 ;
         OBJ oBrowse1 ;
         WIDTH 100
      oBrowse1:ClientAdjust := 5       // client

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
