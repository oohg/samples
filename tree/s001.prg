/*
 * Tree Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to drag and drop between two Tree
 * controls, how to get the visible items and the items
 * currently shown in the control's window, and how to get
 * the reference numbers of the visible items and the reference
 * numbers of the items currently shown in the control's window.
 * It also shows how to use methods EditLabel, Expand,
 * FirstVisible, IsItemExpanded, IsItemValid, IsItemVisible,
 * ItemCount, ItemDraggable, ItemEnabled, ItemHeight,
 * ItemVisible, LastVisible, NextVisible, Value, SelectionID
 * and VisibleCount.
 * 
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download the resource file and the images from:
 * https://github.com/oohg/samples/tree/master/Tree
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL oForm, oTree1, oTree2, oTree

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 530 ;
      TITLE 'Tree Control - Drag/Drop and other things' ;
      MAIN

      DEFINE TREE Tree_1 OBJ oTree1 ;
         AT 10,10 ;
         WIDTH 300 ;
         HEIGHT 202 ;
         ENABLEDRAG ;
         ENABLEDROP ;
         EDITLABELS ;
         TARGET { {|| oTree1 }, {|| oTree2 } } ;
         NODEIMAGES {"WINDOW", "WATCH"} ;
         ITEMIMAGES {"LED_OFF", "LED_ON"} ;
         SELBOLD ;
         INDENT 25 ;
         VALUE 1 

         ON KEY F2 OF (oTree1) ACTION {|| Form_1.Tree_1.EditLabel }

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

      FOR i := 1 TO Form_1.Tree_1.ItemCount
         Form_1.Tree_1.Expand(i)
      NEXT

      oTree1:ItemVisible(oTree1:Value)

      Form_1.Tree_1.ItemDraggable(3, .F.)
      Form_1.Tree_1.ItemDraggable(4, .F.)
      Form_1.Tree_1.ItemEnabled(5, .F.)
      Form_1.Tree_1.ItemEnabled(6, .F.)


      DEFINE TREE Tree_2 OBJ oTree2 ;
         AT 10,320 ;
         WIDTH 300 ;
         HEIGHT 200 ;
         ENABLEDRAG ;
         ENABLEDROP ;
         EDITLABELS ;
         TARGET { {|| oTree1 }, {|| oTree2 } } ;
         NODEIMAGES {"WATCH", "WINDOW"} ;
         ITEMIMAGES {"LED_OFF", "LED_ON"} ;
         VALUE 1 ;
         SELBOLD ;
         INDENT 25

         ON KEY F2 OF (oTree2) ACTION {|| Form_1.Tree_2.EditLabel }

         FOR i := 1 TO 4
            NODE 'T2 Item ' + LTRIM(STR(i))
               FOR j := 1 TO 3
                  NODE 'T2 Item ' + LTRIM(STR(i)) + '.' + LTRIM(STR(j))
                     FOR k := 1 TO 5
                        TREEITEM 'T2 Item ' + ;
                                 LTRIM(STR(i)) + '.' + ;
                                 LTRIM(STR(j)) + '.' + ;
                                 LTRIM(STR(k))
                     NEXT
                  END NODE
               NEXT
            END NODE
         NEXT
      END TREE

      FOR i := 1 TO Form_1.Tree_2.ItemCount
         Form_1.Tree_2.Expand(i)
      NEXT

      Form_1.Tree_2.ItemDraggable(3, .F.)
      Form_1.Tree_2.ItemDraggable(4, .F.)
      Form_1.Tree_2.ItemEnabled(5, .F.)
      Form_1.Tree_2.ItemEnabled(6, .F.)

      @ 250,10 BUTTON Button_1 ;
         CAPTION 'Is Expanded' ;
         ACTION IsExpanded(oTree) ;
         WIDTH 140

      @ 250,160 BUTTON Button_2 ;
         CAPTION 'First Visible' ;
         ACTION AutoMsgBox(oTree:FirstVisible()) ;
         WIDTH 140

      @ 250,310 BUTTON Button_3 ;
         CAPTION 'Visible Items' ;
         ACTION VisibleItems(oTree) ;
         WIDTH 140

      @ 250,460 BUTTON Button_4 ;
         CAPTION 'Show Item' ;
         ACTION ShowItem( oTree ) ;
         WIDTH 140

      @ 280,10 BUTTON Button_5 ;
         CAPTION 'Change ID of Sel. Item' ;
         ACTION ChangeID(oTree) ;
         WIDTH 140

      @ 280,160 BUTTON Button_6 ;
         CAPTION 'Visible Count' ;
         ACTION AutoMsgBox(oTree:VisibleCount()) ;
         WIDTH 140

      @ 280,310 BUTTON Button_7 ;
         CAPTION 'Items in Window' ;
         ACTION ItemsInWindow(oTree) ;
         WIDTH 140

      @ 280,460 BUTTON Button_8 ;
         CAPTION 'Item Height' ;
         ACTION AutoMsgBox( ;
                oTree:ItemHeight( ;
                   VAL(InputBox('New Item Height')))) ;
         WIDTH 140

      @ 310,10 BUTTON Button_9 ;
         CAPTION 'Is In Window' ;
         ACTION IsVisible(oTree) ;
         WIDTH 140

      @ 310,160 BUTTON Button_10 ;
         CAPTION 'Last Visible' ;
         ACTION AutoMsgBox(oTree:LastVisible()) ;
         WIDTH 140

      @ 345,400 LABEL Lbl_1 ;
         VALUE "Apply to:" ;
         WIDTH 60

      @ 342,460 COMBOBOX Cmb_1 ;
         ITEMS {"Tree1", "Tree2"} ;
         WIDTH 140 ;
         VALUE 1 ;
         ON CHANGE oTree := if(Form_1.Cmb_1.Value == 1, oTree1, oTree2)

      oTree := oTree1

      ON KEY ESCAPE OF (oForm) ACTION oForm:Release()

   END WINDOW

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * Items that are visible now or that will be visible
 * when the control is scrolled up or down.
 */
FUNCTION VisibleItems(oTree)
  LOCAL i, Item, lFound

  i := 1
  Item := oTree:FirstVisible()
  lFound := .F.

  DO WHILE Item # 0
     AutoMsgBox(Item)

     i ++
     lFound := .T.

     Item := oTree:NextVisible(Item)
  ENDDO

  IF ! lFound
     MsgBox("Tree has no visible items !!!")
  ENDIF

RETURN NIL

/* Items that are visible now.
 * The second parameter in IsItemVisible indicates if the method
 * is going to consider visible an item partially shown.
 */
FUNCTION ItemsInWindow(oTree)
  LOCAL i, Item, Partial, lFound

  i := 1
  Item := oTree:FirstVisible()
  lFound := .F.

  DO WHILE Item # 0 .AND. oTree:IsItemVisible(Item, .F.)
     AutoMsgBox({Item, IF(oTree:IsItemVisible(Item, .T.), ;
                          "whole", "partial")})
     i ++
     lFound := .T.

     Item := oTree:NextVisible(Item)
  ENDDO

  IF ! lFound
     MsgBox("Tree's window shows no item !!!")
  ENDIF

RETURN NIL

FUNCTION ShowItem( oTree )
   LOCAL uItem

   uItem := VAL(InputBox('Item To Show'))

   IF oTree:IsItemValid( uItem )
      AutoMsgBox( oTree:ItemVisible( uItem ) )
   ELSE
      MsgStop( "Invalid item !!!" )
   ENDIF

RETURN NIL

/* In trees without ITEMID clause you can use
 * oTree:SelectionID := Nil to clear the item ID.
 *
 * Doing this in trees with ITEMID clause will rise a runtime error.
 *
 * Note that oTree:SelectionID() retrives the ID of the selected item,
 * while oTree:SelectionID(Nil) will try to clear it's ID.
 */
FUNCTION ChangeID( oTree )
   LOCAL newID

   // we are assuming character IDs
   newID := InputBox('Change ID from ' + ;
                     AutoType( oTree:SelectionID() ) + ' to:')
   // to use numeric IDs uncomment next line an adapt validation
   // newID := VAL(newID)
   // to use mixed IDs you must develop and use you own capture function

   IF EMPTY(newID)
      MsgStop("ID can't be empty !!!")
   ELSE
      AutoMsgBox(oTree:SelectionID(newID))
   ENDIF

RETURN NIL

FUNCTION IsVisible( oTree )
   LOCAL uItem

   uItem := VAL(InputBox('Item To Check'))

   IF oTree:IsItemValid( uItem )
      AutoMsgBox( oTree:IsItemVisible( uItem ) )
   ELSE
      MsgStop( "Invalid item !!!" )
   ENDIF

RETURN NIL

FUNCTION IsExpanded( oTree )
   LOCAL uItem

   uItem := VAL(InputBox('Item To Check'))

   IF oTree:IsItemValid( uItem )
      AutoMsgBox( oTree:IsItemExpanded( uItem ) )
   ELSE
      MsgStop( "Invalid item !!!" )
   ENDIF

RETURN NIL

/*
 * EOF
 */
