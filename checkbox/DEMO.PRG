#include "oohg.ch"

Function main()

        DEFINE WINDOW Form_1 AT 97,62 WIDTH 348 HEIGHT 400 MAIN TITLE "Checkbox oohg Demo" 

        define tab tab_1 at 0,0 width 300 height 100

        define page "p1"

                @ 23,34 CHECKBOX CheckBox_1 CAPTION  "CheckBox_1" WIDTH 100 HEIGHT 28 TRANSPARENT
                @ 23,203 CHECKBOX CheckBox_2 CAPTION "CheckBox_2" WIDTH 100 HEIGHT 28 
///////// altsyntax test
                               DEFINE CHECKBOX Check_1a
					ROW	50
					COL	34
					CAPTION 'Check 1a' 
					VALUE .T. 
					TOOLTIP 'CheckBox' 
					ONCHANGE PLAYOK()
				END CHECKBOX


     end page
     define page "p2"
                                DEFINE CHECKBOX Check_1b
					ROW	50
					COL	203
					CAPTION 'Check 1b' 
					VALUE .T. 
					TOOLTIP 'CheckBox' 
 				END CHECKBOX



     end page
     end tab

	DEFINE MAIN MENU 
			POPUP 'M&isc'
			
                                ITEM 'mira'        ACTION mira()
                                ITEM 'Get CheckBox_1 Value Property'        ACTION MsgInfo ( IIF(Form_1.CheckBox_1.Value,"True","False") ,'CheckBox_1')
				ITEM 'Set CheckBox_1 Row Property'	    ACTION Form_1.CheckBox_1.Row := max(Val(InputBox('Enter Row','')),1)
				ITEM 'Set CheckBox_1 Col Property'	    ACTION Form_1.CheckBox_1.Col := max(Val(InputBox('Enter Col','')),1)
                                SEPARATOR
                          	ITEM 'Set CheckBox_2 Value Property'	    ACTION Form_1.CheckBox_2.Value := .t.
				ITEM 'Get CheckBox_2 Value Property'	    ACTION MsgInfo ( IIF(Form_1.CheckBox_2.Value,"True","False") ,'CheckBox_2')
				ITEM 'Set CheckBox_2 Row Property'	    ACTION Form_1.CheckBox_2.Row := max(Val(InputBox('Enter Row','')),1)
				ITEM 'Set CheckBox_2 Col Property'	    ACTION Form_1.CheckBox_2.Col := max(Val(InputBox('Enter Col','')),1)

			END POPUP
		END MENU

               @ 260,203 CHECKBOX CheckBox_98 CAPTION "CheckBox_98" WIDTH 100 HEIGHT 28  TRANSPARENT

               @ 290,203 CHECKBOX CheckBox_99 CAPTION "CheckBox_99" WIDTH 100 HEIGHT 28 



	END WINDOW

        center window form_1
        activate window form_1


Return Nil

function mira()
acolor:=form_1.tab_1.backcolor
msgbox(str(acolor[1]))
msgbox(str(acolor[2]))
msgbox(str(acolor[3]))

return nil
