/*
 * Browse Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to enable F1 and F2 keys while the
 * control is in edit mode, using the EDITKEYS clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main

   LOCAL oForm1, oBrowse1

   REQUEST DBFCDX, DBFFPT

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 508 HEIGHT 380 ;
      TITLE 'ooHG Demo - Hot Keys in Edit Mode' ;
      MAIN ;
      ON INIT OpenTables() ;
      ON RELEASE CleanUp()

      @ 10,10 BROWSE Browse_1 OBJ oBrowse1 ;
         WIDTH 480 ;
         HEIGHT 300 ;
         HEADERS { 'Code', ;
                   'First Name', ;
                   'Last Name', ;
                   'Birth Date', ;
                   'Married', ;
                   'Biography' } ;
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
         WORKAREA test ;
         FIELDS { 'Test->Code', ;
                  'Test->First', ;
                  'Test->Last', ;
                  'Test->Birth', ;
                  'Test->Married', ;
                  'Test->Bio' } ;
         FONT "Courier New" SIZE 10 ;
         DELETE ;
         LOCK ;
         EDIT INPLACE ;
         FULLMOVE ;
         APPEND ;
         EDITKEYS { { "F1", {|| AutoMsgBox( "Control: " + oBrowse1:name + " - Column: " + ltrim(str(This.CellColIndex))) } }, { "F2", {|| SetCellValue() } } }

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   ACTIVATE WINDOW Form_1

RETURN Nil

//----------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL aDbf[6][4]

   aDbf[1][ DBS_NAME ] := "Code"
   aDbf[1][ DBS_TYPE ] := "Numeric"
   aDbf[1][ DBS_LEN ]  := 10
   aDbf[1][ DBS_DEC ]  := 0

   aDbf[2][ DBS_NAME ] := "First"
   aDbf[2][ DBS_TYPE ] := "Character"
   aDbf[2][ DBS_LEN ]  := 25
   aDbf[2][ DBS_DEC ]  := 0

   aDbf[3][ DBS_NAME ] := "Last"
   aDbf[3][ DBS_TYPE ] := "Character"
   aDbf[3][ DBS_LEN ]  := 25
   aDbf[3][ DBS_DEC ]  := 0

   aDbf[4][ DBS_NAME ] := "Married"
   aDbf[4][ DBS_TYPE ] := "Logical"
   aDbf[4][ DBS_LEN ]  := 1
   aDbf[4][ DBS_DEC ]  := 0

   aDbf[5][ DBS_NAME ] := "Birth"
   aDbf[5][ DBS_TYPE ] := "Date"
   aDbf[5][ DBS_LEN ]  := 8
   aDbf[5][ DBS_DEC ]  := 0

   aDbf[6][ DBS_NAME ] := "Bio"
   aDbf[6][ DBS_TYPE ] := "Memo"
   aDbf[6][ DBS_LEN ]  := 10
   aDbf[6][ DBS_DEC ]  := 0

   DBCREATE("Test", aDbf, "DBFCDX")

   USE test VIA "DBFCDX"
   ZAP

   FOR i:= 1 TO 100
      APPEND BLANK
      REPLACE code    WITH i * 10000
      REPLACE First   WITH 'First Name '+ STR(i)
      REPLACE Last    WITH 'Last Name '+ STR(i)
      REPLACE Married WITH .t.
      REPLACE birth   WITH DATE() + i - 10000
   NEXT i

   INDEX ON code TO code

   GO BOTTOM

   Form_1.Browse_1.Value := RECNO()

RETURN Nil

//----------------------------------------------------------------------------//
FUNCTION SetCellValue

  LOCAL oCtrl

  oCtrl := GetControlObjectByHandle( GetFocus() )

  DO CASE
  CASE This.CellColIndex == 1
    oCtrl:Value := 12345
  CASE This.CellColIndex == 2
    oCtrl:Value := "FIRST NAME"
  CASE This.CellColIndex == 3
    oCtrl:Value := "LAST NAME"
  CASE This.CellColIndex == 4
    oCtrl:Value := date()
  CASE This.CellColIndex == 5
    oCtrl:Value := 2
  CASE This.CellColIndex == 6
    oCtrl:Value := ""
  ENDCASE

  oCtrl:Setfocus()

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Test.dbf
  ERASE Test.fpt
  ERASE Code.cdx

RETURN NIL

/*
 * EOF
 */
