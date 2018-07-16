/*
 * Browse Sample n° 9
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to paint with alternating colors
 * the rows on an "indexed" browse.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main

   LOCAL Form_1, Browse_1

   REQUEST DBFCDX, DBFFPT

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 500 HEIGHT 380 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE 'ooHG Demo - Alternate Painting of an "Indexed" Browse' ;
      MAIN ;
      NOMAXIMIZE ;
      ON INIT OpenTables() ;
      ON RELEASE CleanUp()

      @ 10,10 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         HEADERS { 'Code', 'RecNo' } ;
         WIDTHS { 150, 150 } ;
         WORKAREA test ;
         FIELDS { 'Test->Code', 'Test->Recno' } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT, BROWSE_JTFY_RIGHT } ;
         DELETE ;
         LOCK ;
         EDIT INPLACE FULLMOVE ;
         APPEND ;
         FORCEREFRESH ;
         DYNAMICBACKCOLOR {|| IF( ORDKEYNO() % 2 == 0, WHITE, ORANGE ) }

      oBrowse:ColumnWidth(2, oBrowse:ClientWidth() - oBrowse:ColumnWidth(1) )

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL aDbf[2][4]

   aDbf[1][ DBS_NAME ] := "Code"
   aDbf[1][ DBS_TYPE ] := "Numeric"
   aDbf[1][ DBS_LEN ]  := 10
   aDbf[1][ DBS_DEC ]  := 0

   aDbf[2][ DBS_NAME ] := "Recno"
   aDbf[2][ DBS_TYPE ] := "Numeric"
   aDbf[2][ DBS_LEN ]  := 10
   aDbf[2][ DBS_DEC ]  := 0

   DBCREATE("Test", aDbf, "DBFCDX")

   USE test VIA "DBFCDX"
   ZAP

   FOR i:= 1 TO 100
      APPEND BLANK
      REPLACE Code  WITH HB_RandomInt( 1000 )
      REPLACE Recno WITH RECNO()
   NEXT i

   INDEX ON code TO code

   GO TOP

   Form_1.Browse_1.Value := RECNO()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Test.dbf
  ERASE Code.cdx

RETURN NIL

/*
 * EOF
 */
