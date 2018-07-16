/*
 * Browse Sample n° 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to add a column of images to a
 * preexistent Browse (applies also to Grid and XBrowse).
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main
   LOCAL oForm1, oBrw1

   REQUEST DBFCDX

   SET BROWSESYNC ON
   SET DATE BRITISH
   SET LANGUAGE TO SPANISH

   OpenTables()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'Add IMAGLIST column to a Browse' ;
      MAIN ;
      ON RELEASE CloseTables()

      @ 10, 10 BROWSE Browse_1 OBJ oBrw1 ;
         WIDTH 620 ;
         HEIGHT 180 ;
         HEADERS { 'Col.1', 'Col.2', 'Col.3', "Image" } ;
         WIDTHS { 50, 150, 150, 50 } ;
         WORKAREA Data ;
         FIELDS { 'code', 'number', 'issued', 'image' } ;
         COLUMNCONTROLS { NIL, NIL, NIL, {'IMAGELIST'} } ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_COPY', ;
                 'MINIGUI_EDIT_OK' } ;
         EDIT INPLACE

      @ 220, 10 BUTTON btn_Add ;
         CAPTION "Add column" ;
         ACTION AddColumn( oBrw1 )

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables

   LOCAL aDbf1[ 4 ][ 4 ]

   aDbf1[ 1 ][ DBS_NAME ] := "code"
   aDbf1[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 1 ][ DBS_LEN ]  := 10
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "number"
   aDbf1[ 2 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 2 ][ DBS_LEN ]  := 6
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   aDbf1[ 3 ][ DBS_NAME ] := "issued"
   aDbf1[ 3 ][ DBS_TYPE ] := "Date"
   aDbf1[ 3 ][ DBS_LEN ]  := 8
   aDbf1[ 3 ][ DBS_DEC ]  := 0

   aDbf1[ 4 ][ DBS_NAME ] := "image"
   aDbf1[ 4 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 4 ][ DBS_LEN ]  := 1
   aDbf1[ 4 ][ DBS_DEC ]  := 0

   DBCREATE( "Data", aDbf1, "DBFCDX" )

   SELECT 0
   USE Data VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 9334
   REPLACE issued WITH CTOD( "09/12/1967" )
   REPLACE image  WITH 0
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 8765
   REPLACE issued WITH CTOD( "14/03/1961" )
   REPLACE image  WITH 1
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 565
   REPLACE issued WITH CTOD( "27/08/1968" )
   REPLACE image  WITH 2
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 5433
   REPLACE issued WITH CTOD( "05/02/1963" )
   REPLACE image  WITH 2
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 54322
   REPLACE issued WITH CTOD( "31/10/1969" )
   REPLACE image  WITH 1
   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 76865
   REPLACE issued WITH CTOD( "19/09/1966" )
   REPLACE image  WITH 0
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )
   REPLACE image  WITH 1
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 5654
   REPLACE issued WITH CTOD( "07/04/1965" )
   REPLACE image  WITH 2
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 7687
   REPLACE issued WITH CTOD( "22/06/1962" )
   REPLACE image  WITH 1
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )
   REPLACE image  WITH 0

   GO TOP

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CloseTables

  DBCLOSEALL()

  ERASE Data.dbf

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION AddColumn(oBrw1)

   oBrw1:ClearBitMaps()
   oBrw1:AddBitMap( { 'MINIGUI_EDIT_CANCEL', ;
                      'MINIGUI_EDIT_COPY', ;
                      'MINIGUI_EDIT_OK' } )

   // See parameters in h_xbrowse.prg
   oBrw1:AddColumn( NIL, ;                  // add in last position
                    "image", ;
                    "Image", ;
                    50, ;
                    NIL, ;
                    NIL, ;
                    NIL, ;
                    NIL, ;
                    NIL, ;
                    { 'IMAGELIST' } )

RETURN NIL

/*
 * EOF
 */
