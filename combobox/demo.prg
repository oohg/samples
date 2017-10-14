/*
* MiniGUI ComboBox Demo
* (c) 2002 Roberto Lopez
* Modified Ciro Vargas Clemow
*/

#include "oohg.ch"

Function Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 200 ;
		TITLE 'ComboBox Demo' ;
		MAIN 

		DEFINE MAIN MENU
			DEFINE POPUP 'Test'
                                MENUITEM 'Get Value' ACTION autoMsgInfo(oCombo:Value)
                                MENUITEM 'Set Value' ACTION Ocombo:Value := 1
                                MENUITEM 'Get DisplayValue' ACTION MsgInfo( Ocombo:DisplayValue )
                                MENUITEM 'Set DisplayValue' ACTION Ocombo:DisplayValue := 'New Text' 
			END POPUP
		END MENU


                @ 10,10 COMBOBOX Combo_1 obj Ocombo ;
			ITEMS { 'A' , 'B' , 'C' } ;
			VALUE 1 ;
			DISPLAYEDIT ;
			ON DISPLAYCHANGE PlayBeep() 

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

Return


