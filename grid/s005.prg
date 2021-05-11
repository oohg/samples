/*
 * Grid Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to use images in column headers.
 * The methods exampled are DeleteColumn, AddColumn,
 * LoadHeaderImages, HeaderImage, HeaderImageAlign,
 * ColumnHide, ColumnShow, ColumnsBetterAutoFit, Header
 * and Item. This also applies to Browse and XBrowse controls.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL oForm, oGrid, aRows[ 20 ]

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 400 ;
      TITLE 'Grid - Images in Column Headers' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP 'Look at me'
            MENUITEM 'Remove col 1' ACTION oGrid:DeleteColumn( 1, .T. )
            MENUITEM 'Add at col 5' ;
               ACTION oGrid:AddColumn( 5, ;
                                       "New col", ;
                                       70, ;
                                       HEADER_IMG_AT_LEFT, ;
                                       WHITE, ;
                                       RED, ;
                                       .T., ;
                                       NIL, ;
                                       { 'TEXTBOX', 'CHARACTER', '!!!' }, ;
                                       { || AutoMsgBox( "Clicked !!!" ) }, ;
                                       { |x| ! Empty( x ) }, ;
                                       "Must not be empty !!!", ;
                                       { |col, item| Empty( item[ col ] ) }, ;
                                       2, ;
                                       HEADER_IMG_AT_LEFT, ;
                                       .F. )
            MENUITEM 'Change columns order' ACTION oGrid:ColumnOrder := { 3, 1, 2, 4, 5 }
            SEPARATOR
            MENUITEM 'Change images' ;
               ACTION oGrid:LoadHeaderImages( { 'MINIGUI_EDIT_ADD', ;
                                                'MINIGUI_EDIT_CANCEL', ;
                                                'MINIGUI_EDIT_ADD', ;
                                                'MINIGUI_EDIT_CANCEL', ;
                                                'MINIGUI_EDIT_ADD' } )
            MENUITEM 'Remove image from col 3' ;
               ACTION oGrid:HeaderImage( 3, 0 )
            MENUITEM 'Add image 2 to col 3' ;
               ACTION oGrid:HeaderImage( 3, 2 )
            SEPARATOR
            MENUITEM 'Place left in col 3' ;
               ACTION oGrid:HeaderImageAlign( 3, HEADER_IMG_AT_LEFT )
            MENUITEM 'Place right in col 3' ;
               ACTION oGrid:HeaderImageAlign( 3, HEADER_IMG_AT_RIGHT )
            SEPARATOR
            MENUITEM "Image index of col 3" ;
               ACTION AutoMsgBox( oGrid:HeaderImage( 3 ) )
            MENUITEM "Image alignment of col 3" ;
               ACTION MsgBox( ;
                  IF( oGrid:HeaderImageAlign( 3 ) == HEADER_IMG_AT_LEFT, 'LEFT', 'RIGHT') )
            SEPARATOR
            MENUITEM 'Set Item 2' ACTION SetItem()
            MENUITEM 'Get Item 2' ACTION GetItem()
            SEPARATOR
            MENUITEM 'Hide Column 2' ACTION oGrid:ColumnHide( 2 )
            MENUITEM 'Show Column 2' ACTION oGrid:ColumnShow( 2 )
            MENUITEM 'Better Auto Fit' ACTION oGrid:ColumnsBetterAutoFit()
            MENUITEM 'Change Header 1' ACTION ChangeHeader(oGrid)
            SEPARATOR
            MENUITEM 'Get Justify' ACTION AutoMsgBox( oGrid:Justify() )
            MENUITEM 'Set Justify 1' ACTION AutoMsgBox( oGrid:Justify( 1, GRID_JTFY_LEFT ) )
            MENUITEM 'Set Justify All' ACTION AutoMsgBox( oGrid:Justify( { GRID_JTFY_CENTER, GRID_JTFY_CENTER, GRID_JTFY_CENTER, GRID_JTFY_CENTER, GRID_JTFY_CENTER }, .T. ) )
         END POPUP
      END MENU

      aRows [01] := { 113.12, Date(), 1, 01, .T. }
      aRows [02] := { 123.12, Date(), 2, 02, .F. }
      aRows [03] := { 133.12, Date(), 3, 03, .T. }
      aRows [04] := { 143.12, Date(), 1, 04, .F. }
      aRows [05] := { 153.12, Date(), 2, 05, .T. }
      aRows [06] := { 163.12, Date(), 3, 06, .F. }
      aRows [07] := { 173.12, Date(), 1, 07, .T. }
      aRows [08] := { 183.12, Date(), 2, 08, .F. }
      aRows [09] := { 193.12, Date(), 3, 09, .T. }
      aRows [10] := { 113.12, Date(), 1, 10, .F. }
      aRows [11] := { 123.12, Date(), 2, 11, .T. }
      aRows [12] := { 133.12, Date(), 3, 12, .F. }
      aRows [13] := { 143.12, Date(), 1, 13, .T. }
      aRows [14] := { 153.12, Date(), 2, 14, .F. }
      aRows [15] := { 163.12, Date(), 3, 15, .T. }
      aRows [16] := { 173.12, Date(), 1, 16, .F. }
      aRows [17] := { 183.12, Date(), 2, 17, .T. }
      aRows [18] := { 193.12, Date(), 3, 18, .F. }
      aRows [19] := { 113.12, Date(), 1, 19, .T. }
      aRows [20] := { 123.12, Date(), 2, 20, .F. }

      DEFINE GRID Grid_1
         ROW 10
         COL 10
         WIDTH 620
         HEIGHT 330
         HEADERS { 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5' }
         HEADERIMAGES { 'MINIGUI_EDIT_EDIT', ;
                        'MINIGUI_EDIT_DELETE', ;
                        'MINIGUI_EDIT_EDIT', ;
                        'MINIGUI_EDIT_CLOSE', ;
                        'MINIGUI_EDIT_EDIT' }
         IMAGESALIGN { HEADER_IMG_AT_RIGHT, ;
                       HEADER_IMG_AT_LEFT, ;
                       HEADER_IMG_AT_RIGHT, ;
                       HEADER_IMG_AT_LEFT, ;
                       HEADER_IMG_AT_RIGHT }
         JUSTIFY { GRID_JTFY_RIGHT, ;
                   GRID_JTFY_RIGHT, ;
                   GRID_JTFY_RIGHT, ;
                   GRID_JTFY_RIGHT, ;
                   GRID_JTFY_RIGHT }
         WIDTHS { 140, 140, 140, 140, 140 }
         ITEMS aRows
         ALLOWEDIT .T.
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '$ 999,999.99' }, ;
                          { 'DatePICKER', 'DROPDOWN' }, ;
                          { 'COMBOBOX', { 'One', 'Two', 'Three' } }, ;
                          { 'SPINNER', 1, 20 }, ;
                          { 'CHECKBOX', 'Yes', 'No' } }
         VALID { { |uValue| uValue > 100 }, { || .T. }, { || .T. }, { || .T. }, { || .T. } }
      END GRID

      oGrid := GetControlObject( "Grid_1", "Form_1" )

      ON KEY ESCAPE OF Form_1 ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 *  HEADERIMAGES {'MINIGUI_EDIT_EDIT', ;
 *                'MINIGUI_EDIT_DELETE', ;
 *                'MINIGUI_EDIT_EDIT', ;
 *                'MINIGUI_EDIT_CLOSE', ;
 *                'MINIGUI_EDIT_EDIT'}
 *
 *  Defines the images for each column header.
 *
 *  The images are loaded (without repetition) into an imagelist in
 *  - position 1: MINIGUI_EDIT_EDIT
 *  - position 2: MINIGUI_EDIT_DELETE
 *  - position 3: MINIGUI_EDIT_CLOSE
 *
 *  The images are asociated to each column by the index number of
 *  the image in the imagelist, so
 *  ::HeaderImage(1) returns 1
 *  ::HeaderImage(2) returns 2
 *  ::HeaderImage(3) returns 1
 *  ::HeaderImage(4) returns 3
 *  ::HeaderImage(5) returns 1
 *
 */

PROCEDURE SetItem

   Form_1.Grid_1.Item( 2 ) := { 123.45, Date(), 2, 10, .T. }

   RETURN

PROCEDURE GetItem
   LOCAL a := Form_1.Grid_1.Item( 2 )

   MsgInfo( Str( a[ 1 ] ), 'Item 2  Col. 1' )
   MsgInfo( DToC( a[ 2 ] ), 'Item 2  Col. 2' )
   MsgInfo( Str( a[ 3 ] ), 'Item 2  Col. 3' )
   MsgInfo( Str( a[ 4 ] ), 'Item 2  Col. 4' )
   MsgInfo( iif( a[ 5 ], '.T.', '.F.' ), 'Item2  Col. 5' )

   RETURN

PROCEDURE ChangeHeader

   IF GetProperty( 'Form_1', 'Grid_1', 'HEADER', 1 ) == 'New'
      Form_1.Grid_1.Header( 1 ) := "Column 1"
   ELSE
      SetProperty( 'Form_1', 'Grid_1', 'HEADER', 1, 'New' )
   ENDIF

   RETURN

/*
 * EOF
 */
