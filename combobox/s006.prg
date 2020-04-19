/*
 * Combobox Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to populate a combobox from a dbf
 * using specific fields and the current index order.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main

/*
 * SET COMBOINDEXISVALUEDBF OFF is the default behaviour.
 * Set to ON to change the behaviour of all the combos in the app.
 * To set the behaviour of one particular combo use clauses INDEXISVALUE or SOURCEISVALUE.
 * To get the current setting use var _OOHG_ComboDbfIndexIsValue, default value is .F.
 */

   IF _OOHG_ComboIndexIsValueDbf
      IF MsgYesNo( "Set COMBOINDEXISVALUEDBF to OFF?" )
         SET COMBOINDEXISVALUEDBF OFF
      ENDIF
   ELSE
      IF MsgYesNo( "Set COMBOINDEXISVALUEDBF to ON?" )
         SET COMBOINDEXISVALUEDBF ON
      ENDIF
   ENDIF

   OpenTables()
   cIndexKey := IndexKey()

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "Combobox from a DBF" ;
      WIDTH 500 ;
      HEIGHT 300 ;
      ON RELEASE CloseTables()

      @ 10,10 COMBOBOX Combo ;
         WIDTH 200 ;
         ITEMSOURCE "s006->data" ;
         VALUESOURCE "s006->code" ;
         VALUE 9 ;
         HEIGHT 250 ;
         NOREFRESH ;
         ON CHANGE oWnd:Label:Value := "The combo's value is: " + Autotype( oWnd:Combo:Value )
/*
 * If you set combo's value to 9 when COMBOINDEXISVALUEDBF is OFF then
 *    The item selected is the one with recno() == 3 and s006->code == 9 whatever the index order is.
 * Else
 *    The item selected is the nineth record acording to the index order.
 *    For tCode index: recno() ==  9 and s006->code == 27
 *    For tData index: recno() == 45 and s006->code == 135
 *
 * Note that changing the controlling index between the combo´s creation and the end of the form's
 * INIT procedure will change the order of the items unless, inbetween, combo's NOREFRESH clause
 * is set or combo´s LREFRESH data is set to .F. or SET COMBOREFRESH is OFF. See method RefreshData.
 * So the next sentence has no effect on the combo.
 */
      ordSetFocus( iif( cIndexKey == "code", "tData", "tCode" ) )

      @ 10,230 LABEL Label ;
         VALUE "The combo's value is: " + Autotype( oWnd:Combo:Value ) ;
         AUTOSIZE

      @ 40,230 LABEL 0 ;
         VALUE "COMBOINDEXISVALUEDBF is: " + iif( _OOHG_ComboIndexIsValueDbf, "ON", "OFF" ) ;
         AUTOSIZE

      @ 70,230 LABEL 0 ;
         VALUE "Items were loaded by key: " + cIndexKey ;
         AUTOSIZE

      @ 100,230 LABEL 0 ;
         VALUE "Controlling index key is: " + IndexKey() ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN NIL

FUNCTION OpenTables()

   LOCAL aDbf[ 2, 4 ], i

   IF File( "s006.dbf" ) .AND. File( "s006.cdx ")
      USE s006 SHARED VIA "DBFCDX"
   ELSE
      aDbf[1] := { "code", "N", 3, 0 }
      aDbf[2] := { "data", "C", 25, 0 }

      REQUEST DBFCDX

      dbCreate( "s006", aDbf, "DBFCDX" )

      USE s006 SHARED VIA "DBFCDX"

      FOR i := 1 TO 50
         APPEND BLANK
         REPLACE code WITH i * 3
         REPLACE data WITH {"1", "2", "3", "4", "5"} [ i % 5 + 1 ] + " Recno " + StrZero( i, 2, 0 ) + " Code " + LTrim( Str( Code ) )
      NEXT i

      INDEX ON code TAG tCode TO s006
      INDEX ON data TAG tData TO s006
   ENDIF
   ordSetFocus( iif( MsgYesNo( "Use 'tCode' order?" ), "tCode", "tData" ) )

RETURN NIL

FUNCTION CloseTables()

   CLOSE DATABASES

   IF MsgYesNo( "Delete auxiliary files?" )
      ERASE s006.dbf
      ERASE s006.cdx
   ENDIF

RETURN NIL

/*
 * EOF
 */
