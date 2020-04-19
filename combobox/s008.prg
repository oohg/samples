/*
 * ComboBox Sample # 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to populate a combobox from a dbf
 * using an array to set the combo's ITEMSOURCE clause and
 * to set the dbf's index order. It also shows how to get
 * the selected value and the corresponding item.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

/*
 * SET COMBOINDEXISVALUEDBF OFF is the default behaviour.
 * Set to ON to change the behaviour of all the combos in the app.
 * To set the behaviour of one particular combo use clauses INDEXISVALUE or SOURCEISVALUE.
 * To get the current setting use var _OOHG_ComboDbfIndexIsValue, default value is .F.
 */

   OpenTables()

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "Combobox's Test Case for ITEMSOURCE, VALUESOURCE, INDEXISVALUE and SOURCEISVALUE" ;
      WIDTH 800 ;
      HEIGHT 440 ;
      ON RELEASE CloseTables()

      @ 020,010 LABEL 0 ;
         VALUE "with SOURCEISVALUE and VALUESOURCE" ;
         AUTOSIZE

      @ 050,010 COMBOBOX Combo11 OBJ oCombo11 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 's008', 'Data', 'tData' } ) ;   // If the index name is ommited then the current one is used
         VALUESOURCE s008->Code ;
         SOURCEISVALUE ;                                // You can ommit this clause if the default set wasn't changed
         ON CHANGE ( oValue11:Value := "Value (code) is: " + ;
                                       AutoType( oCombo11:Value ), ;
                     oItem11:Value := "Item (Data) is: " + ;
                                      oCombo11:ItemBySource( oCombo11:Value ) )
/*
 * You can replace ItemBySource( oCombo11:Value ) with
 * Item( AScan( oCombo11:aValues, oCombo11:Value ) )
 *
 * Note that the combo's value is the value of the field Code of the corresponding record.
 */

      @ 100,010 LABEL 0 OBJ oValue11 ;
         VALUE "Select an item to see it's value (code)" ;
         AUTOSIZE

      @ 130,010 LABEL 0 OBJ oItem11 ;
         VALUE "Select an item to see it's caption (Data)" ;
         AUTOSIZE

      @ 210,010 LABEL 0 ;
         VALUE "with SOURCEISVALUE and without VALUESOURCE" ;
         AUTOSIZE

      @ 240,010 COMBOBOX Combo21 OBJ oCombo21 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 's008', 'Data', 'tData' } ) ;
         SOURCEISVALUE ;
         ON CHANGE ( oValue21:value := "Value (recno) is: " + ;
                                       AutoType( oCombo21:Value ), ;
                     oItem21:value := "Item (Data) is: " + ;
                                      oCombo21:ItemBySource( oCombo21:Value ) )
/*
 * You can replace ItemBySource( oCombo21:Value ) with
 * Item( oCombo21:Value )
 *
 * Note that the combo's value is the physical record number.
 */

      @ 290,010 LABEL 0 OBJ oValue21 ;
         VALUE "Select an item to see it's value (recno)" ;
         AUTOSIZE

      @ 320,010 LABEL 0 OBJ oItem21 ;
         VALUE "Select an item to see it's caption (Data)" ;
         AUTOSIZE

// Column 2

      @ 020,410 LABEL 0 ;
         VALUE "with INDEXISVALUE and VALUESOURCE" ;
         AUTOSIZE

      @ 050,410 COMBOBOX Combo12 OBJ oCombo12 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 's008', 'Data', 'tData' } ) ;
         VALUESOURCE 's008->Code' ;
         INDEXISVALUE ;
         ON CHANGE ( oValue12:value := "Value (index) is: " + ;
                                       AutoType( oCombo12:Value ), ;
                     oItem12:value := "Item (Data) is: " + ;
                                      oCombo12:ItemBySource( oCombo12:Value ) )
/*
 * You can replace ItemBySource( oCombo12:Value ) with
 * Item( AScan( oCombo12:aValues, oCombo12:Value ) )
 *
 * Note that the combo's value is the logical record number according to the dbf's index.
 * See harbour's function OrdKeyNo.
 */

      @ 100,410 LABEL 0 OBJ oValue12 ;
         VALUE "Select an item to see it's value (code)" ;
         AUTOSIZE

      @ 130,410 LABEL 0 OBJ oItem12 ;
         VALUE "Select an item to see it's caption (Data)" ;
         AUTOSIZE

      @ 210,410 LABEL 0 ;
         VALUE "with INDEXISVALUE and without VALUESOURCE" ;
         AUTOSIZE

      @ 240,410 COMBOBOX Combo22 OBJ oCombo22 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 's008', 'Data', 'tData' } ) ;
         INDEXISVALUE ;
         ON CHANGE ( oValue22:value := "Value (index) is: " + ;
                                       AutoType( oCombo22:Value ), ;
                     oItem22:value := "Item (Data) is: " + ;
                                      oCombo22:ItemBySource( oCombo22:Value ) )
/*
 * You can replace ItemBySource( oCombo22:Value ) with
 * Item( oCombo22:Value )
 *
 * Note that the combo's value is the logical record number according to the dbf's index.
 * See harbour's function OrdKeyNo.
 */

      @ 290,410 LABEL 0 OBJ oValue22 ;
         VALUE "Select an item to see it's value (recno)" ;
         AUTOSIZE

      @ 320,410 LABEL 0 OBJ oItem22 ;
         VALUE "Select an item to see it's caption (Data)" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN NIL

FUNCTION OpenTables()

   LOCAL aDbf[ 2, 4 ], i

   IF File( "s008.dbf" ) .AND. File( "s008.cdx ")
      USE s008 SHARED VIA "DBFCDX"
   ELSE
      aDbf[1] := { "code", "N", 3, 0 }
      aDbf[2] := { "data", "C", 25, 0 }

      REQUEST DBFCDX

      dbCreate( "s008", aDbf, "DBFCDX" )

      USE s008 SHARED VIA "DBFCDX"

      FOR i := 1 TO 50
         APPEND BLANK
         REPLACE code WITH i * 3
         REPLACE data WITH {"1", "2", "3", "4", "5"} [ i % 5 + 1 ] + " Recno " + StrZero( i, 2, 0 ) + " Code " + LTrim( Str( Code ) )
      NEXT i

      INDEX ON code TAG tCode TO s008
      INDEX ON data TAG tData TO s008
   ENDIF

RETURN NIL

FUNCTION CloseTables()

   CLOSE DATABASES

   IF MsgYesNo( "Delete auxiliary files?" )
      ERASE s008.dbf
      ERASE s008.cdx
   ENDIF

RETURN NIL

/*
 * EOF
 */
