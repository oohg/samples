/*
 * Combobox Sample n° 6
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to populate a combobox from a dbf
 * using ITEMSOURCE and VALUESOURCE clauses.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main

   LOCAL oWnd

   REQUEST DBFCDX, DBFFPT

   OpenTables()

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "Combobox from a DBF" ;
      WIDTH 350 ;
      HEIGHT 200

      @ 10,10 COMBOBOX Combo ;
         WIDTH 200 ;
         ITEMSOURCE 'test->last' ;
         VALUESOURCE 'test->code' ;
         VALUE 3 ;
         ON CHANGE oWnd:Label:Value := ;
                      "The combo's value is: " + autotype(oWnd:Combo:Value)

      @ 60,10 LABEL Label ;
         VALUE "Select an item in the combo to see it's value !!!" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

   CloseTables()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   LOCAL aDbf[ 2, 4 ]

   aDbf[1][ DBS_NAME ] := "Code"
   aDbf[1][ DBS_TYPE ] := "Numeric"
   aDbf[1][ DBS_LEN ]  := 3
   aDbf[1][ DBS_DEC ]  := 0

   aDbf[2][ DBS_NAME ] := "Last"
   aDbf[2][ DBS_TYPE ] := "Character"
   aDbf[2][ DBS_LEN ]  := 25
   aDbf[2][ DBS_DEC ]  := 0

   DBCREATE("Test", aDbf, "DBFCDX")

   USE test VIA "DBFCDX"
   ZAP

   FOR i := 1 TO 50
      APPEND BLANK
      REPLACE Code WITH i * 3
      REPLACE Last WITH 'Last Name '+ STR(i)
   NEXT i

   INDEX ON Code TAG Code TO Test

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CloseTables()
   LOCAL cIndexExt := INDEXEXT()

   CLOSE DATABASES
   ERASE ("Test" + cIndexExt)
   ERASE Test.dbf

RETURN NIL

/*
 * EOF
 */
