/*
 * Browse Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to use DELETEWHEN, DELETEMSG and ON DELETE
 * clauses on Grid, XBrowse and Browse controls, to pre and post
 * process record deletion. It also illustrates how to create and
 * populate a database on the fly.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

Function Main

   LOCAL Form_1, Browse_1

   REQUEST DBFCDX, DBFFPT

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ Form_1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 500 HEIGHT 380 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE 'ooHG Demo - DELETEWHEN, DELETEMSG and ON DELETE clauses' ;
      MAIN NOMAXIMIZE ;
      ON INIT {|| OnPaint(Form_1), OpenTables()} ;
      ON RELEASE CleanUp() ;
      ON SIZE OnPaint(Form_1)

      @ 10,10 BROWSE Browse_1 OBJ Browse_1 ;
         WIDTH 610 ;
         HEIGHT 390 ;
         HEADERS { 'Code', 'First Name', 'Last Name', ;
                   'Birth Date', 'Married' , 'Biography' } ;
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
         WORKAREA test ;
         FIELDS { 'Test->Code', 'Test->First', 'Test->Last', ;
                  'Test->Birth', 'Test->Married', 'Test->Bio' } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER} ;
         DELETE ;
         DELETEWHEN {|| test->(recno()) % 2 == 0} ;
         DELETEMSG "Odd records can't be deleted !!!" ;
         ON DELETE {|| automsgbox("Record " + ;
                       ltrim(str(test->(recno()))) + ;
                       " deleted !!!")} ;
         LOCK ;
         EDIT INPLACE ;
         APPEND

/*
 * This is the same browse but in alternative syntax
 */
/*
      DEFINE BROWSE Browse_1
         ROW 10
         COL 10
         WIDTH 610
         HEIGHT 390
         HEADERS { 'Code', 'First Name', 'Last Name', ;
                   'Birth Date', 'Married' , 'Biography' }
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 }
         WORKAREA test
         FIELDS { 'Test->Code', 'Test->First', 'Test->Last', ;
                  'Test->Birth', 'Test->Married', 'Test->Bio' }
         FONTNAME "Courier New"
         FONTSIZE 10
         JUSTIFY { BROWSE_JTFY_LEFT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER}
         ALLOWDELETE .T.
         DELETEWHEN {|| test->(recno()) % 2 == 0}
         DELETEMSG "Odd records can't be deleted !!!"
         ON DELETE {|| automsgbox("Record " + ;
                       ltrim(str(test->(recno()))) + ;
                       " deleted !!!")}
         LOCK .T.
         ALLOWEDIT .T.
         INPLACEEDIT .T.
         ALLOWAPPEND .T.
      END BROWSE
*/

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

RETURN Nil

//--------------------------------------------------------------------------//
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

   GO TOP

   Form_1.Browse_1.Value := RECNO()

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION OnPaint (Ventana)

  WITH OBJECT Ventana
    :Browse_1:Row      := ;
    :Browse_1:Col      := 20
    :Browse_1:Width    := :ClientWidth - :Browse_1:Col * 2
    :Browse_1:Height   := :ClientHeight - :Browse_1:Row * 2
  END WITH

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
