/*
 * Browse Sample n° 22
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to simulate a button on
 * a browse's column.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "oohg - Simulate a button on each row of a Browse (image & text)" ;
      MAIN ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables() ON SIZE {|| oBrowse:Height := oForm:ClientHeight - 20 }

      @ 10,10 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         HEADERS { "", "Col1", "Col2", "Action" } ;
         WIDTHS { 40, 100, 150, 100 } ;
         WORKAREA Test ;
         FIELDS { "Image", "Code", "Name", "Action" } ;
         EDIT INPLACE ;
         READONLY { .F., .F., .F., .T. } ;
         IMAGE { 'MINIGUI_EDIT_FIND' } ;
         COLUMNCONTROLS { { 'IMAGELIST' }, ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'CHARACTER' } } ;
         ON CLICK {| nMouseRow, nMouseCol, nItem, nCol | iif( nCol == 1, DoSomeAction1( nItem ), iif( nCol == 4, DoSomeAction4( nItem ), NIL ) ) }

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

   RETURN NIL

FUNCTION OpenTables()

   LOCAL i

   DBCREATE( "Test", ;
             { { "Image",  "N",  1, 0 }, ;
               { "Code",   "N", 10, 0 }, ;
               { "Name",   "C", 25, 0 }, ;
               { "Action", "C", 10, 0 } } )

   USE Test NEW
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Image  WITH 0
      REPLACE Code   WITH i
      REPLACE Name   WITH 'Name - ' + StrZero( i )
      REPLACE Action WITH 'Click me!'
   NEXT i

   GO TOP

   RETURN NIL

FUNCTION CloseTables()

  CLOSE DATABASES

  ERASE Test.dbf

  RETURN NIL

FUNCTION DoSomeAction1( nItem )

   AutoMsgBox( { "Action1 on ", nItem } )

   RETURN NIL

FUNCTION DoSomeAction4( nItem )

   AutoMsgBox( { "Action4 on ", nItem } )

   RETURN NIL

/*
 * EOF
 */
