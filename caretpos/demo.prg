
#include "oohg.ch"

Function Main

   LOCAL oText

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 200 ;
		TITLE 'CaretPos Property Demo' ;
		MAIN

		DEFINE MAIN MENU

			POPUP 'CaretPos'

				ITEM 'Set CaretPos Property'	ACTION Form_1.Text_1.CaretPos := 4 
				ITEM 'Get CaretPos Property'	ACTION MsgInfo ( Str ( Form_1.Text_1.CaretPos ) )

			END POPUP

		END MENU

      DEFINE TEXTBOX text_1
         ROW 10
         COL 10
         VALUE 12345
         SUBCLASS TTextNum
      END TEXTBOX

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

Return

#include "oohg.ch"
