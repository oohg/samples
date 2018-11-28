/*
 * Browse Sample n° 21
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to configure a Browse
 * without scrollbars.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main()

   PUBLIC oForm, oBrw

   REQUEST DBFCDX

   SET DATE BRITISH
   SET LANGUAGE TO SPANISH

   OpenTable()

   DEFINE WINDOW frm_1 OBJ oForm ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 ;
      HEIGHT 420 ;
      TITLE 'oohg - Browse without scrollbars' ;
      MAIN ;
      ON RELEASE CleanUp()

      @ 10, 10 BROWSE brw_1 OBJ oBrw ;
         WIDTH 400 ;
         HEIGHT 182 ;
         HEADERS { 'Col.1', 'Col.2', 'Col.3' } ;
         WIDTHS { 150, 150, 150 } ;
         WORKAREA Data ;
         FIELDS { 'code', 'number', 'issued' } ;
         NOHSCROLLBAR ;
         NOVSCROLLBAR

      @ 220, 10 BUTTON btn_1 ;
         CAPTION "Toggle Vert" ;
         ACTION oBrw:VScrollVisible := ! oBrw:VScrollVisible

      @ 220, 120 BUTTON btn_2 ;
         CAPTION "Toggle Horz" ;
         ACTION oBrw:HScrollVisible := ! oBrw:HScrollVisible

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTable()

   LOCAL aDbf1[ 3 ][ 4 ]

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

   dbCreate( "Data", aDbf1, "DBFCDX" )

   SELECT 0
   USE Data VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 9334
   REPLACE issued WITH CTOD( "09/12/1967" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 8765
   REPLACE issued WITH CTOD( "14/03/1961" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 565
   REPLACE issued WITH CTOD( "27/08/1968" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 5433
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 54322
   REPLACE issued WITH CTOD( "31/10/1969" )
   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 76865
   REPLACE issued WITH CTOD( "19/09/1966" )
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 5654
   REPLACE issued WITH CTOD( "07/04/1965" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 7687
   REPLACE issued WITH CTOD( "22/06/1962" )
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )

   APPEND BLANK
   REPLACE code   WITH 1355
   REPLACE number WITH 19334
   REPLACE issued WITH CTOD( "09/12/1967" )
   APPEND BLANK
   REPLACE code   WITH 1123
   REPLACE number WITH 18765
   REPLACE issued WITH CTOD( "14/03/1961" )
   APPEND BLANK
   REPLACE code   WITH 17
   REPLACE number WITH 1565
   REPLACE issued WITH CTOD( "27/08/1968" )
   APPEND BLANK
   REPLACE code   WITH 1123
   REPLACE number WITH 15433
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 17
   REPLACE number WITH 154322
   REPLACE issued WITH CTOD( "31/10/1969" )
   APPEND BLANK
   REPLACE code   WITH 1355
   REPLACE number WITH 176865
   REPLACE issued WITH CTOD( "19/09/1966" )
   APPEND BLANK
   REPLACE code   WITH 176
   REPLACE number WITH 153377
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 17
   REPLACE number WITH 15654
   REPLACE issued WITH CTOD( "07/04/1965" )
   APPEND BLANK
   REPLACE code   WITH 1123
   REPLACE number WITH 17687
   REPLACE issued WITH CTOD( "22/06/1962" )
   APPEND BLANK
   REPLACE code   WITH 176
   REPLACE number WITH 153377
   REPLACE issued WITH CTOD( "05/02/1963" )

   GO TOP

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Data.dbf

RETURN NIL

/*
 * EOF
 */
