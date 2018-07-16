/*
 * Browse Sample n° 12
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to edit a column of a Browse using
 * another Browse, with EDITKEYS clause.
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
      WIDTH 420 HEIGHT 420 ;
      TITLE 'Use a Browse to edit another Browse' ;
      MAIN ;
      ON RELEASE CloseTables()

      @ 10, 10 BROWSE Browse_1 OBJ oBrw1 ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Code', 'Name', 'Number' } ;
         WIDTHS { 150, 150 } ;
         WORKAREA Code ;
         FIELDS { 'Code->Code', 'Code->Name', 'Code->Number' } ;
         EDIT INPLACE ;
         APPEND ;
         DELETE ;
         EDITKEYS { { "F3", {|| SelectValue( oBrw1 ) } } }

      @ 390, 10 LABEL lbl_Note ;
         WIDTH 400 ;
         HEIGHT 40 ;
         VALUE "See what happens when you press F3 while editing column 1." ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION SelectValue( oBrw )

   LOCAL nRec, oEdit

   IF _OOHG_ThisItemColIndex # 1
     RETURN NIL
   ENDIF

   nRec := 0

   oEdit := GetControlObjectByHandle( GetFocus() )

   DEFINE WINDOW Form_2 ;
      OBJ oForm2 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 HEIGHT 420 ;
      TITLE 'Select Value' ;
      MODAL ;
      ON RELEASE ( oEdit:Value := Data->Code, Code->Number := Data->Number )

      @ 10, 10 BROWSE Browse_2 OBJ oBrw2 ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Code', 'Number', 'Issued' } ;
         WIDTHS { 150, 150, 150 } ;
         WORKAREA Data ;
         FIELDS { 'Data->Code', 'Data->Number', 'Data->Issued' } ;
         ON ENTER ( nRec := Data->(Recno()), oForm2:Release() ) ;
         ON DBLCLICK ( nRec := Data->(Recno()), oForm2:Release() )

      ON KEY ESCAPE ACTION oForm2:Release()
   END WINDOW

   oForm2:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL aDbf1[ 3 ][ 4 ], aDbf2[ 3 ][ 4 ]

   // Create "Code" database

   aDbf1[ 1 ][ DBS_NAME ] := "Code"
   aDbf1[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 1 ][ DBS_LEN ]  := 10
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "Name"
   aDbf1[ 2 ][ DBS_TYPE ] := "Character"
   aDbf1[ 2 ][ DBS_LEN ]  := 25
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   aDbf1[ 3 ][ DBS_NAME ] := "Number"
   aDbf1[ 3 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 3 ][ DBS_LEN ]  := 6
   aDbf1[ 3 ][ DBS_DEC ]  := 0

   DBCREATE( "Code", aDbf1, "DBFCDX" )

   SELECT 0
   USE Code VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE Code   WITH 123
   REPLACE Name   WITH 'Homer'
   REPLACE Number WITH 12
   APPEND BLANK
   REPLACE Code   WITH 355
   REPLACE Name   WITH 'Tom'
   REPLACE Number WITH 23
   APPEND BLANK
   REPLACE Code   WITH 76
   REPLACE Name   WITH 'Mike'
   REPLACE Number WITH 32
   APPEND BLANK
   REPLACE Code   WITH 7
   REPLACE Name   WITH 'Martha'
   REPLACE Number WITH 47

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

   DBCREATE( "Data", aDbf2, "DBFCDX" )

   SELECT 0
   USE Data VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE Code   WITH 355
   REPLACE Number WITH 9334
   REPLACE Issued WITH CTOD( "09/12/1967" )
   APPEND BLANK
   REPLACE Code   WITH 123
   REPLACE Number WITH 8765
   REPLACE Issued WITH CTOD( "14/03/1961" )
   APPEND BLANK
   REPLACE Code   WITH 7
   REPLACE Number WITH 565
   REPLACE Issued WITH CTOD( "27/08/1968" )
   APPEND BLANK
   REPLACE Code   WITH 123
   REPLACE Number WITH 5433
   REPLACE Issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE Code   WITH 7
   REPLACE Number WITH 54322
   REPLACE Issued WITH CTOD( "31/10/1969" )
   APPEND BLANK
   REPLACE Code   WITH 355
   REPLACE Number WITH 76865
   REPLACE Issued WITH CTOD( "19/09/1966" )
   APPEND BLANK
   REPLACE Code   WITH 76
   REPLACE Number WITH 53377
   REPLACE Issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE Code   WITH 7
   REPLACE Number WITH 5654
   REPLACE Issued WITH CTOD( "07/04/1965" )
   APPEND BLANK
   REPLACE Code   WITH 123
   REPLACE Number WITH 7687
   REPLACE Issued WITH CTOD( "22/06/1962" )
   APPEND BLANK
   REPLACE Code   WITH 76
   REPLACE Number WITH 53377
   REPLACE Issued WITH CTOD( "05/02/1963" )

   GO TOP

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CloseTables()

  DBCLOSEALL()

  ERASE Code.dbf
  ERASE Data.dbf

RETURN NIL

/*
 * EOF
 */
