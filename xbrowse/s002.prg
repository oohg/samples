/*
 * XBrowse Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use SET AUTOADJUST ON.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'
#include "dbstruct.ch"

REQUEST DBFCDX

FUNCTION Main()

   OpenTable()

   SET AUTOADJUST ON
   
   DEFINE WINDOW frm_1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "oohg - AutoAdjust Sample" ;
      ON RELEASE CleanUp()

      DEFINE TAB tab1 AT 10, 10 WIDTH 600 HEIGHT 400

      DEFINE PAGE "Page1"

      @ 40, 40 XBROWSE xbr_1 ;
         WIDTH 500 ;
         HEIGHT 300 ;
         HEADERS { 'Col.1', 'Col.2' } ;
         WIDTHS { 200, 200 } NOVSCROLL

      END PAGE

      END TAB

      @ 430, 20 LABEL lbl_1 ;
         WIDTH 600 ;
         VALUE "The columns will maintain its proportions " + ;
               "whenever the form is resized." ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW frm_1
   ACTIVATE WINDOW frm_1

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
