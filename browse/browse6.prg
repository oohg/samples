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

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'ooHG Browse Demo' ;
		MAIN NOMAXIMIZE ;
		ON INIT OpenTables() ;
		ON RELEASE CloseTables()

		DEFINE MAIN MENU
			POPUP 'File'
                                ITEM 'Set Browse Value' ACTION Form_1.Browse_1.Value := 10
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
			STATUSITEM '<Enter> / Double Click To Edit' WIDTH 200
			STATUSITEM 'Alt+A: Append' WIDTH 120
		END STATUSBAR

                DEFINE BROWSE Browse_1
                        ROW 10
                        COL 10
                        WIDTH 610                                                                               
                        HEIGHT 390                                                                               
                        HEADERS { 'Field 1' , 'Field 2' , 'Field 3', 'Field 4', 'Field 5' , 'Field 6' , 'Field 7', 'Field 8' , 'Field 9' , 'Field 10'  , 'Field 11' , 'Field 12' , 'Field 13' , 'Field 14' , 'Field 15' , 'Field 16' , 'Field 17' , 'Field 18' , 'Field 19' , 'Field 20' , 'Field 21' , 'Field 22' , 'Field 23' , 'Field 24' , 'Field 25' , 'Field 26' , 'Field 27' , 'Field 28' , 'Field 29' , 'Field 30' , 'Field 31' , 'Field 32' } 
                        WIDTHS  { 100       ,100        ,100       ,100       ,100        ,100        ,100        ,100       ,100        ,100          ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         ,100         } 
                        WORKAREA MuchFields 
                        FIELDS { 'c1','c2','c3','c4','c5','c6','c7','c8','c9','c10','c11','c12','c13','c14','c15','c16','c17','c18','c19','c20','c21','c22','c23','c24','c25','c26','c27','c28','c29','c30','c31','c32' } 
                        VALUE 1 
                        ALLOWEDIT .T.
                        ALLOWAPPEND .T.
                END BROWSE

	END WINDOW

	CENTER WINDOW Form_1

        Form_1.Browse_1.SetFocus()

	ACTIVATE WINDOW Form_1

Return Nil

Procedure OpenTables()
	Use MuchFields
Return Nil

Procedure CloseTables()
	Use
Return Nil







