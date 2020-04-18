/*
 * ComboBox Sample # 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use clause DELAYEDLOAD.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oWnd, oCombo1, oCombo2, oValue1, oItem1, oValue2, oItem2

   OpenTables()

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "OOHG - ComboBox with DELAYLOAD clause" ;
      WIDTH 400 ;
      HEIGHT 400 ;
      ON INIT oWnd:lRefreshDataOnActivate := .F. ;
      ON RELEASE CloseTables()

      @ 10,10 COMBOBOX Combo1 OBJ oCombo1 ;
         WIDTH 200 ;
         DELAYEDLOAD ;
         ITEMSOURCE ( { 's013', 'Data', 'tData' } ) ;
         VALUESOURCE 's013->Code' ;
         ON CHANGE ( oValue1:Value := "Value (code) is: " + ;
                                      AutoType( oCombo1:Value ), ;
                     oItem1:Value := "Item (data) is: " + ;
                                     oCombo1:ItemBySource( oCombo1:Value ) )
/*
 * You can replace ItemBySource(oCombo1:Value) with
 * Item(ASCAN(oCombo1:aValues, oCombo1:Value)).
 */

      @ 13,220 LABEL Dummy1 VALUE "WITH VALUESOURCE" AUTOSIZE

      @ 60,10 LABEL Label11 OBJ oValue1 ;
         VALUE "Select an item to see it's value (code)" ;
         AUTOSIZE

      @ 80,10 LABEL Label12 OBJ oItem1 ;
         VALUE "Select an item to see it's caption (data)" ;
         AUTOSIZE

      @ 160,10 COMBOBOX Combo2 OBJ oCombo2 ;
         WIDTH 200 ;
         DELAYEDLOAD ;
         ITEMSOURCE ( { 's013', 'Data', 'tCode' } ) ;
         ON CHANGE ( oValue2:Value := "Value (recno) is: " + ;
                                      AutoType( oCombo2:Value ), ;
                     oItem2:Value := "Item (data) is: " + ;
                                     oCombo2:ItemBySource( oCombo2:Value ) )
/*
 * You can replace ItemBySource(oCombo2:Value) with
 * Item(oCombo2:Value).
 */

      @ 213,220 LABEL Dummy2 VALUE "WITHOUT" AUTOSIZE

      @ 260,10 LABEL Label21 OBJ oValue2 ;
         VALUE "Select an item to see it's value (recno)" ;
         AUTOSIZE

      @ 280,10 LABEL Label22 OBJ oItem2 ;
         VALUE "Select an item to see it's caption (data)" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN NIL

FUNCTION OpenTables()

   LOCAL aDbf[ 2, 4 ], i

   IF File( "s013.dbf" ) .AND. File( "s013.cdx ")
      USE s013 SHARED VIA "DBFCDX"
   ELSE
      aDbf[1] := { "code", "N", 5, 0 }
      aDbf[2] := { "data", "C", 25, 0 }

      REQUEST DBFCDX

      dbCreate( "s013", aDbf, "DBFCDX" )

      USE s013 SHARED VIA "DBFCDX"

      FOR i := 1 TO 500
         APPEND BLANK
         REPLACE code WITH i * 3
         REPLACE data WITH {"1", "2", "3", "4", "5"} [ i % 5 + 1 ] + " Recno " + StrZero( i, 4, 0 ) + " Code " + LTrim( Str( Code ) )
      NEXT i

      INDEX ON code TAG tCode TO s013
      INDEX ON data TAG tData TO s013
   ENDIF

RETURN NIL

FUNCTION CloseTables()

   CLOSE DATABASES

   IF MsgYesNo( "Delete auxiliary files?" )
      ERASE s013.dbf
      ERASE s013.cdx
   ENDIF

RETURN NIL

/*
 * EOF
 */
