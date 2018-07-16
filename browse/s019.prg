/*
 * Browse Sample n° 19
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to link one browse to another
 * and how to avoid the execution of the on change event
 * for a certain time period.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"
#include "ord.ch"

FUNCTION Main

   PUBLIC oForm1, oBrw1, oBrw2, aRecs := {}

   PUBLIC uLastTime := hb_MilliSeconds()

   REQUEST DBFCDX

   SET BROWSESYNC ON
   SET DATE BRITISH

   OpenTables()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 HEIGHT 420 ;
      TITLE 'Browse linked to a Browse' ;
      MAIN ;
      ON INIT oBrw1:value := Code->(RecNo()) ;
      ON RELEASE CleanUp()

      @ 10, 10 BROWSE Browse_1 OBJ oBrw1 ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Code', 'Name' } ;
         WIDTHS { 150, 150 } ;
         WORKAREA Code ;
         FIELDS { 'Code->code', 'Code->name' } ;
         ON CHANGE ProcessOnChange()

      @ 200, 10 BROWSE Browse_2 OBJ oBrw2 ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Code', 'Number', 'Issued' } ;
         WIDTHS { 150, 150, 150 } ;
         WORKAREA Data ;
         FIELDS { 'Data->code', 'Data->number', 'Data->issued' } ;

      @ 390, 10 LABEL lbl_Note ;
         WIDTH 400 ;
         HEIGHT 40 ;
         VALUE "See what happens when you change top browse's selected item." ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION ProcessOnChange()

   IF hb_MilliSeconds() > uLastTime + 150
      uLastTime := hb_MilliSeconds()
      Data->( OrdScope( TOPSCOPE, Code->Code ) )
      Data->( OrdScope( BOTTOMSCOPE, Code->Code ) )
      aAdd( aRecs, Code->Code )
      oBrw2:GoTop()
   ENDIF

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL aDbf1[ 2 ][ 4 ], aDbf2[ 3 ][ 4 ], i, j

   // Create "Code" database

   aDbf1[ 1 ][ DBS_NAME ] := "Code"
   aDbf1[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 1 ][ DBS_LEN ]  := 10
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "Name"
   aDbf1[ 2 ][ DBS_TYPE ] := "Character"
   aDbf1[ 2 ][ DBS_LEN ]  := 25
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   dbCreate( "Code", aDbf1, "DBFCDX" )

   SELECT 0
   USE Code VIA "DBFCDX"
   ZAP

   FOR i := 0 TO 999
      APPEND BLANK
      REPLACE Code WITH i
      REPLACE Name WITH 'Record ' + StrZero( i, 4, 0)
   NEXT
   GO TOP

   // Create "Data" database

   aDbf2[ 1 ][ DBS_NAME ] := "Code"
   aDbf2[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf2[ 1 ][ DBS_LEN ]  := 10
   aDbf2[ 1 ][ DBS_DEC ]  := 0

   aDbf2[ 2 ][ DBS_NAME ] := "Number"
   aDbf2[ 2 ][ DBS_TYPE ] := "Numeric"
   aDbf2[ 2 ][ DBS_LEN ]  := 6
   aDbf2[ 2 ][ DBS_DEC ]  := 0

   aDbf2[ 3 ][ DBS_NAME ] := "Issued"
   aDbf2[ 3 ][ DBS_TYPE ] := "Date"
   aDbf2[ 3 ][ DBS_LEN ]  := 8
   aDbf2[ 3 ][ DBS_DEC ]  := 0

   dbCreate( "Data", aDbf2, "DBFCDX" )

   SELECT 0
   USE Data VIA "DBFCDX"
   INDEX ON Code TO Data
   ZAP

   FOR i := 0 TO 999
      FOR j := 0 TO 999
         APPEND BLANK
         REPLACE Code   WITH i
         REPLACE Number WITH i * 1000 + j
         REPLACE Issued WITH CToD( "09/12/1967" ) + j
      NEXT
   NEXT

   SET SCOPE TO Code->Code

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Code.dbf
  ERASE Data.dbf
  ERASE Data.cdx

  AutoMsgBox( aRecs )

RETURN NIL

/*
 * EOF
 */
