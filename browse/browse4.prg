/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
*/

* Value property selects a record by its number (RecNo())
* Value property returns selected record number (recNo())
* Browse control does not change the active work area
* Browse control does not change the record pointer in any area
* (nor change selection when it changes)
* You can programatically refresh it using refresh method.
* Variables called <MemVar>.<WorkAreaName>.<FieldName> are created for 
* validation in browse editing window. You can use it in VALID array.
* Using APPEND clause you can add records to table associated with WORKAREA
* clause. The hotkey to add records is Alt+A.
* Append Clause Can't Be Used With Fields Not Belonging To Browse WorkArea
* Using DELETE clause allows to mark selected record for deletion pressing <Del> key
* The leftmost column in a browse control must be left aligned.

* Enjoy !

#include "oohg.ch"
#include "dbstruct.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main

	SET CENTURY ON
	SET DELETED ON

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'ooHG Browse Demo' ;
		MAIN NOMAXIMIZE ;
		ON INIT OpenTables() ;
		ON RELEASE CloseTables()

		DEFINE MAIN MENU 
			POPUP 'File'
                                ITEM 'Set Browse Value' ACTION Form_1.Browse_1.Value := 50
                                ITEM 'Get Browse Value' ACTION MsgInfo ( Str (  ( Form_1.Browse_1.Value ) ) )
                                ITEM 'Refresh Browse'   ACTION Form_1.Browse_1.Refresh()
				SEPARATOR
                                ITEM 'Exit'             ACTION Form_1.Release()
			END POPUP
			POPUP 'Help'
				ITEM 'About'		ACTION MsgInfo ("MiniGUI Browse Demo") 
			END POPUP
		END MENU

		DEFINE STATUSBAR
			STATUSITEM 'ooHG Power Ready'
			STATUSITEM '<Enter> / Double Click To Edit' WIDTH 190
			STATUSITEM 'Alt+A: Append Record' WIDTH 140
			STATUSITEM '<Del>: Delete Record' WIDTH 140
		END STATUSBAR

                @ 10,10  BROWSE Browse_1  ;
                        WIDTH 610   ;                                                                            
                        HEIGHT 390   ;                                                                            
                        HEADERS { 'Code' , 'First Name' , 'Last Name', 'Birth Date', 'Married' , 'Biography' } ;
                        WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
                        WORKAREA Test ;
                        FIELDS { 'Test->Code' , 'Test->First' , 'Test->Last' , 'Test->Birth' , 'Test->Married' , 'Test->Bio' } ;
                        VALUE 1 ;
                        EDIT inplace append  delete ;
                        VALID { { || MemVar.Test.Code <= 1000 } , { || !Empty(MemVar.Test.First) } , { || !Empty(MemVar.Test.Last) } , { || Year(MemVar.Test.Birth) >= 1900 } , , } ;
                        VALIDMESSAGES { 'Code Range: 0-1000', 'First Name Cannot Be Empty', , , ,  }  ;
                        LOCK  
                

	END WINDOW

	CENTER WINDOW Form_1

        Form_1.Browse_1.SetFocus()

	ACTIVATE WINDOW Form_1

Return Nil

Procedure OpenTables()

	CreateTable()

	Use Test Via "DBFCDX"
	Go Top

	Form_1.Browse_1.Value := RecNo()

Return Nil

Procedure CloseTables()
	Use
   ERASE TEST.DBF
   ERASE TEST.FPT
   ERASE CODE.CDX
Return Nil

Procedure CreateTable
LOCAL aDbf[6][4]

        aDbf[1][ DBS_NAME ] := "Code"
        aDbf[1][ DBS_TYPE ] := "Numeric"
        aDbf[1][ DBS_LEN ]  := 10
        aDbf[1][ DBS_DEC ]  := 0
        //
        aDbf[2][ DBS_NAME ] := "First"
        aDbf[2][ DBS_TYPE ] := "Character"
        aDbf[2][ DBS_LEN ]  := 25
        aDbf[2][ DBS_DEC ]  := 0
        //
        aDbf[3][ DBS_NAME ] := "Last"
        aDbf[3][ DBS_TYPE ] := "Character"
        aDbf[3][ DBS_LEN ]  := 25
        aDbf[3][ DBS_DEC ]  := 0
        //
        aDbf[4][ DBS_NAME ] := "Married"
        aDbf[4][ DBS_TYPE ] := "Logical"
        aDbf[4][ DBS_LEN ]  := 1
        aDbf[4][ DBS_DEC ]  := 0
        //
        aDbf[5][ DBS_NAME ] := "Birth"
        aDbf[5][ DBS_TYPE ] := "Date"
        aDbf[5][ DBS_LEN ]  := 8
        aDbf[5][ DBS_DEC ]  := 0
        //
        aDbf[6][ DBS_NAME ] := "Bio"
        aDbf[6][ DBS_TYPE ] := "Memo"
        aDbf[6][ DBS_LEN ]  := 10
        aDbf[6][ DBS_DEC ]  := 0
        //

        DBCREATE("Test", aDbf, "DBFCDX")

	Use test Via "DBFCDX"
	zap

	For i:= 1 To 100
		append blank
		Replace code with i
		Replace First With 'First Name '+ Str(i)
		Replace Last With 'Last Name '+ Str(i)
		Replace Married With .t.
		replace birth with date()+i-10000
	Next i

	Index on code to code

	Use

Return
