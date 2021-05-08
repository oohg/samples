/*
 * Grid Sample # 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use COMBOBOX ColumnControl
 * for Grid/Browse with Inplace clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

 #include "oohg.ch"
 #include "dbstruct.ch"

 FUNCTION Main

    LOCAL lOpen, oWnd, aRows[10,4], i

    REQUEST DBFCDX, DBFFPT

/*
 * Database must be opened before the grid is created so the initial rows
 * values can be displayed correctly. If it's not, the initial values are
 * ignored and cells will be blank.
 */
    IF ( lOpen := MsgYesNo( "Open database before INIT ?" ) )
       OpenTables()
    ENDIF

    DEFINE WINDOW Form_1 ;
       MAIN ;
       TITLE "Cell edition in Grid using a ComboBox ColumnControl" ;
       WIDTH 640 ;
       HEIGHT 400 ;
       ON INIT IF( ! lOpen, OpenTables(), NIL ) ;
       ON RELEASE CleanUp()

/*
 * Row definition
 * Cell value must correspond to the type of the ColumnControl returned value.
 * A RTE will rise if you place a value of diferent type.
 */
       FOR i := 1 TO LEN( aRows )
          IF i % 2 == 0
             aRows[i] := {i * 3, ;
                          STRZERO(i * 2, 2), ;
                          i % 3 + 1, ;
                          i % 3 + 4, ;
                          STR(i % 3 + 4, 1, 0), ;
                          i}
          ELSE
             aRows[i] := {0, "", 0, 0, "", 0}
          ENDIF
       NEXT

/*
 * Value of Col 1 is Test->CodeLast and it's type is Numeric as the field.
 * Value of Col 2 is Test->CodeFirst and it's type is String because the
 * field is Character.
 * Value of Col 3 is Numeric (the index of the selected item) because third
 * item in ColumnControl is NIL.
 * Value of Col 4 is Numeric (one of the values) because third item in
 * ColumnControl is an array of numbers.
 * Value of Col 5 is String (one of the values) because third item in
 * ColumnControl is an array of strings.
 * Value of Col 6 is Numeric (the record number) because third item in
 * ColumnControl is NIL.
 */
       DEFINE MAIN MENU
          ITEM "Item Values" ;
             ACTION AUTOMSGBOX( ShowItem(1) + HB_OsNewLine() + ;
                                ShowItem(2) + HB_OsNewLine() + ;
                                ShowItem(3) + HB_OsNewLine() + ;
                                ShowItem(4) + HB_OsNewLine() + ;
                                ShowItem(5) + HB_OsNewLine() + ;
                                ShowItem(6) )
       END MENU

       @ 10,10 GRID Grid_1 ;
          WIDTH 620 ;
          HEIGHT 330 ;
          HEADERS { 'Column 1', ;
                    'Column 2', ;
                    'Column 3', ;
                    'Column 4', ;
                    'Column 5', ;
                    'Column 6'} ;
          WIDTHS {100, 100, 100, 100, 100, 100} ;
          ITEMS aRows ;
          EDIT INPLACE ;
          COLUMNCONTROLS { ;
             {'COMBOBOX','Test->Last','Test->CodeLast','NUMERIC'}, ;
             {'COMBOBOX','Test->First','Test->CodeFirst','CHARACTER'}, ;
             {'COMBOBOX',{'One','Two','Three'}}, ;
             {'COMBOBOX',{'Four','Five','Six'},{4,5,6}}, ;
             {'COMBOBOX',{'Four','Five','Six'},{'4','5','6'}}, ;
             {'COMBOBOX','Test->Last'} }
/*
 * COMBOBOX ColumnControl parameters
 * OPTION 1: {'COMBOBOX', par2, par3}
 *   par2 = Array of strings to display in the combo's list.
 *          Similar to ITEMS clause in COMBOBOX control.
 *   par3 = Array of values (numbers or strings) to return when an item is
 *          selected in the combo (the value returned is the cell's value).
 *          Similar to VALUESOURCE clause in COMBOBOX control.
 *          or
 *          NIL: the combo will return a numeric value between 1 and LEN(par2).
 * OPTION 2: {'COMBOBOX', par2, par3, par4}
 *   par2 = A string containing a qualified character field (dbf->field).
 *          Similar to ITEMSOURCE clause in COMBOBOX control.
 *   par3 = A string containing a qualified (numeric or character) field.
 *          Similar to VALUESOURCE clause in COMBOBOX control.
 *          or
 *          NIL: the combo will return dbf's record number.
 *   par4 = 'NUMERIC' or 'CHARACTER' constant indicating par3's type.
 *          Defaults to 'NUMERIC'.
 *          This constant must matchs par3's type or a RTE will rise.
 */

       ON KEY ESCAPE ACTION Form_1.Release()
    END WINDOW

    CENTER WINDOW Form_1

    ACTIVATE WINDOW Form_1

 Return

 //--------------------------------------------------------------------------//
 FUNCTION OpenTables()

    LOCAL aDbf[ 4, 4 ]

    aDbf[1][ DBS_NAME ] := "CodeLast"
    aDbf[1][ DBS_TYPE ] := "Numeric"
    aDbf[1][ DBS_LEN ]  := 2
    aDbf[1][ DBS_DEC ]  := 0

    aDbf[2][ DBS_NAME ] := "Last"
    aDbf[2][ DBS_TYPE ] := "Character"
    aDbf[2][ DBS_LEN ]  := 25
    aDbf[2][ DBS_DEC ]  := 0

    aDbf[3][ DBS_NAME ] := "CodeFirst"
    aDbf[3][ DBS_TYPE ] := "Character"
    aDbf[3][ DBS_LEN ]  := 2
    aDbf[3][ DBS_DEC ]  := 0

    aDbf[4][ DBS_NAME ] := "First"
    aDbf[4][ DBS_TYPE ] := "Character"
    aDbf[4][ DBS_LEN ]  := 25
    aDbf[4][ DBS_DEC ]  := 0

    DBCREATE("Test", aDbf, "DBFCDX")

    USE Test VIA "DBFCDX"
    ZAP

    FOR i := 1 TO 30
       APPEND BLANK
       REPLACE CodeLast  WITH i * 3
       REPLACE Last      WITH 'LastName '+ LTRIM(STR(i))
       REPLACE CodeFirst WITH STRZERO(i * 2, 2)
       REPLACE First     WITH 'FirstName '+ LTRIM(STR(i))
    NEXT i

 RETURN NIL

 //--------------------------------------------------------------------------//
 STATIC FUNCTION ShowItem( nItem )

 RETURN ( "Col " + ;
          LTRIM(STR(nItem)) + ;
          " - ValType: " + ;
          VALTYPE(Form_1.Grid_1.Item( Form_1.Grid_1.Value )[nItem]) + ;
          " Value: " + ;
          LTRIM(AUTOTYPE(Form_1.Grid_1.Item( Form_1.Grid_1.Value )[nItem])) )

 //--------------------------------------------------------------------------//
 STATIC FUNCTION CleanUp()

   CLOSE DATABASES
   ERASE Test.dbf

RETURN NIL

/*
 * EOF
 */
