/*
 * Browse Sample # 25
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set the default row where
 * newly added records are shown.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "dbstruct.ch"

REQUEST DBFCDX

FUNCTION Main

   SET BROWSESYNC ON
   SET DATE BRITISH
   SET LANGUAGE TO SPANISH
   SET NAVIGATION EXTENDED

   OpenTables()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 480 HEIGHT 320 ;
      TITLE 'OOHG - Set the default row for new records' ;
      MAIN ;
      ON RELEASE CloseTables()

      @ 20, 10 BROWSE Browse_1 OBJ oBrw1 ;
         WIDTH 440 ;
         HEIGHT 220 ;
         HEADERS { 'Code', 'Name', 'Number' } ;
         WIDTHS { 150, 150, 110 } ;
         WORKAREA Code ;
         FIELDS { 'Code->Code', 'Code->Name', 'Code->Number' } ;
         EDIT ;
         APPEND ;
         DELETE

      @ 270, 10 LABEL lbl_Note ;
         AUTOSIZE ;
         HEIGHT 40 ;
         VALUE "Add records with Alt-A and change the default row with F1, F2 and F3 keys." ;
         FONTCOLOR RED

      DEFINE STATUSBAR
         STATUSITEM "Default row for new records is " + LTrim( Str( oBrw1:nNewAtRow ) )
      END STATUSBAR

      // Show new record at the top row
      ON KEY F1 ACTION ChangeDefault( 1 )
                          
      // Show new record at default row = Int( oBrw1:CountPerPage / 2 )
      ON KEY F2 ACTION ChangeDefault( 0 )

      // Show new record at bottom row
      ON KEY F3 ACTION ChangeDefault( oBrw1:CountPerPage )

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

   RETURN NIL


FUNCTION ChangeDefault( nValue )

    
    oForm1:Statusbar:Item( 1, "Default row for new records is " + hb_ntos( oBrw1:nNewAtRow := nValue ) )

   RETURN NIL


FUNCTION OpenTables()

   LOCAL aDbf1[ 3 ][ 4 ], aDbf2[ 3 ][ 4 ]

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

   dbCreate( "Code", aDbf1, "DBFCDX" )

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
   APPEND BLANK
   REPLACE Code   WITH 354
   REPLACE Name   WITH 'Bob'
   REPLACE Number WITH 11
   APPEND BLANK
   REPLACE Code   WITH 147
   REPLACE Name   WITH 'Alice'
   REPLACE Number WITH 2
   APPEND BLANK
   REPLACE Code   WITH 79
   REPLACE Name   WITH 'Charlie'
   REPLACE Number WITH 55
   APPEND BLANK
   REPLACE Code   WITH 71
   REPLACE Name   WITH 'Thelma'
   REPLACE Number WITH 44

   GO TOP

   RETURN NIL


FUNCTION CloseTables()

  dbCloseAll()

  ERASE Code.dbf
  ERASE Data.dbf

  RETURN NIL

/*
 * EOF
 */
