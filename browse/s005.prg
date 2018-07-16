/*
 * Browse Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to link some controls to a Browse,
 * so when the Browse's value is changed the values of the
 * controls are changed accordingly.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main
   LOCAL oForm1, oBrw1

   REQUEST DBFCDX, DBFFPT

   SET CENTURY ON
   SET DATE BRITISH
   SET DELETED ON
   SET BROWSESYNC ON

   OpenTables()

   DEFINE WINDOW Form_1 OBJ oForm1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 618 HEIGHT 380 ;
      TITLE 'Controls linked to a Browse' ;
      MAIN ;
      ON INIT oBrw1:value := Test->(recno()) ;
      ON INTERACTIVECLOSE ExitCheck() ;
      ON RELEASE CleanUp()

      @ 10,10 BROWSE Browse_1 OBJ oBrw1 ;
         WIDTH 410 ;
         HEIGHT 340 ;
         HEADERS { 'Code', 'First Name', 'Last Name', ;
                   'Birth Date', 'Married' , 'Biography' } ;
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
         WORKAREA test ;
         FIELDS { 'Test->Code', 'Test->First', 'Test->Last', ;
                  'Test->Birth', 'Test->Married', 'Test->Bio' } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER} ;
         COLUMNCONTROLS {NIL, NIL, NIL, NIL, {'LCOMBOBOX','Yes','No'}, NIL} ;
         ON CHANGE (oTxtName:value := Test->First, ;
                    oCmbType:value := Test->Code, ;
                    oDtpDate:value := Test->Birth)

      @ 10,430 COMBOBOX cmb_Type OBJ oCmbType ;
         WIDTH 180 ;
         ITEMSOURCE Codes->Name ;
         VALUESOURCE Codes->Code

      @ 50,430 TEXTBOX txt_Name OBJ oTxtName ;
        WIDTH 180 ;
        HEIGHT 24 ;
        MAXLENGTH 25

      @ 90,430 DATEPICKER dtp_Date OBJ oDtpDate ;
        WIDTH 180

      @ 210,430 LABEL lbl_Note ;
        WIDTH 180 ;
        HEIGHT 40 ;
        VALUE "See what happens when you change browse's selected item." ;
        FONTCOLOR RED

      ON KEY ESCAPE ACTION IF(ExitCheck(), oForm1:Release(), NIL)
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL i, aDbf1[2][4], aDbf2[6][4]

   // Create codes database

   aDbf1[1][ DBS_NAME ] := "Code"
   aDbf1[1][ DBS_TYPE ] := "Numeric"
   aDbf1[1][ DBS_LEN ]  := 10
   aDbf1[1][ DBS_DEC ]  := 0

   aDbf1[2][ DBS_NAME ] := "Name"
   aDbf1[2][ DBS_TYPE ] := "Character"
   aDbf1[2][ DBS_LEN ]  := 25
   aDbf1[2][ DBS_DEC ]  := 0

   DBCREATE("Codes", aDbf1, "DBFCDX")

   SELECT 0
   USE codes VIA "DBFCDX"
   ZAP

   FOR i := 0 TO 4
      APPEND BLANK
      REPLACE code    WITH i
      REPLACE Name    WITH 'Name of code '+ LTRIM(STR(i))
   NEXT i

   INDEX ON code TAG code TO Codes

   // Create test database

   aDbf2[1][ DBS_NAME ] := "Code"
   aDbf2[1][ DBS_TYPE ] := "Numeric"
   aDbf2[1][ DBS_LEN ]  := 10
   aDbf2[1][ DBS_DEC ]  := 0

   aDbf2[2][ DBS_NAME ] := "First"
   aDbf2[2][ DBS_TYPE ] := "Character"
   aDbf2[2][ DBS_LEN ]  := 25
   aDbf2[2][ DBS_DEC ]  := 0

   aDbf2[3][ DBS_NAME ] := "Last"
   aDbf2[3][ DBS_TYPE ] := "Character"
   aDbf2[3][ DBS_LEN ]  := 25
   aDbf2[3][ DBS_DEC ]  := 0

   aDbf2[4][ DBS_NAME ] := "Married"
   aDbf2[4][ DBS_TYPE ] := "Logical"
   aDbf2[4][ DBS_LEN ]  := 1
   aDbf2[4][ DBS_DEC ]  := 0

   aDbf2[5][ DBS_NAME ] := "Birth"
   aDbf2[5][ DBS_TYPE ] := "Date"
   aDbf2[5][ DBS_LEN ]  := 8
   aDbf2[5][ DBS_DEC ]  := 0

   aDbf2[6][ DBS_NAME ] := "Bio"
   aDbf2[6][ DBS_TYPE ] := "Memo"
   aDbf2[6][ DBS_LEN ]  := 10
   aDbf2[6][ DBS_DEC ]  := 0

   DBCREATE("Test", aDbf2, "DBFCDX")

   SELECT 0
   USE test VIA "DBFCDX"
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE code    WITH i % 5
      REPLACE First   WITH 'First Name '+ LTRIM(STR(i))
      REPLACE Last    WITH 'Last Name '+ LTRIM(STR(i))
      REPLACE Married WITH (i % 2 == 0)
      REPLACE birth   WITH DATE() + i - 10000
   NEXT i

   GO TOP

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION ExitCheck()

RETURN MsgYesNo("¿ Are you sure you want to quit ?") ;

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Test.dbf
  ERASE Test.fpt
  ERASE Codes.dbf
  ERASE Codes.cdx

RETURN NIL

/*
 * EOF
 */
