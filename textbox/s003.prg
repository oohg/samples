/*
 * Textbox Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to link a textbox to, and periodically
 * update it from, a database.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

PROCEDURE Main

   OpenTables()

   DEFINE WINDOW Frm1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'ooHG - Linked TEXTBOX Demo' ;
      MAIN ;
      ON RELEASE CloseTables()

      @ 20,20 TEXTBOX Txt1 ;
         WIDTH 200 ;
         FIELD db->code               // ( { || db->code } )

      @ 70,20 TEXTBOX Txt2 ;
         WIDTH 200 ;
         NUMERIC ;
         FIELD db->number

      @ 120,10 BUTTON Btn1 ;
         CAPTION "Refresh" ;
         ACTION oForm:RefreshData()

      DEFINE TIMER Tmr1 INTERVAL 1000 ACTION db->( dbGoto( RecNo() % RecCount() + 1 ) )

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN


PROCEDURE OpenTables

   LOCAL aDbf1[ 2 ][ 4 ]

   aDbf1[ 1 ][ DBS_NAME ] := "code"
   aDbf1[ 1 ][ DBS_TYPE ] := "CHARACTER"
   aDbf1[ 1 ][ DBS_LEN ]  := 3
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "number"
   aDbf1[ 2 ][ DBS_TYPE ] := "NUMERIC"
   aDbf1[ 2 ][ DBS_LEN ]  := 6
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   dbCreate( "db", aDbf1 )

   USE db
   ZAP

   APPEND BLANK
   REPLACE code   WITH "ccc"
   REPLACE number WITH 933421
   APPEND BLANK
   REPLACE code   WITH "aaa"
   REPLACE number WITH 876554
   APPEND BLANK
   REPLACE code   WITH "bbb"
   REPLACE number WITH 565451
   APPEND BLANK
   REPLACE code   WITH "uuu"
   REPLACE number WITH 543300
   APPEND BLANK
   REPLACE code   WITH "ddd"
   REPLACE number WITH 933321
   APPEND BLANK
   REPLACE code   WITH "yyy"
   REPLACE number WITH 878854
   APPEND BLANK
   REPLACE code   WITH "eee"
   REPLACE number WITH 567751
   APPEND BLANK
   REPLACE code   WITH "zzz"
   REPLACE number WITH 541100
   APPEND BLANK
   REPLACE code   WITH "fff"
   REPLACE number WITH 932221
   APPEND BLANK
   REPLACE code   WITH "kkk"
   REPLACE number WITH 875554
   APPEND BLANK
   REPLACE code   WITH "ggg"
   REPLACE number WITH 569851
   APPEND BLANK
   REPLACE code   WITH "jjj"
   REPLACE number WITH 549300
   APPEND BLANK
   REPLACE code   WITH "www"
   REPLACE number WITH 934521
   APPEND BLANK
   REPLACE code   WITH "yyy"
   REPLACE number WITH 878654
   APPEND BLANK
   REPLACE code   WITH "iii"
   REPLACE number WITH 567351
   APPEND BLANK
   REPLACE code   WITH "zzz"
   REPLACE number WITH 54133

   GO TOP

RETURN


PROCEDURE CloseTables

  dbCloseAll()

  ERASE db.dbf

RETURN

/*
 *
 */
