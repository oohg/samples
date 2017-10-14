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

Function Main

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
	Use Test Shared
Return Nil

Procedure CloseTables()
	Use
Return Nil







