
#include "oohg.ch"

Function Main

	SET DATE GERMAN

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 ;
		HEIGHT 400 ;
		TITLE 'Statusbar Keyboard Demo' ;
		MAIN 


		DEFINE STATUSBAR FONT 'Arial' SIZE 9 OBJ oStat

			STATUSITEM "Statusbar Demo" 
         STATUSITEM "DOS" width 200

		END STATUSBAR

  oStat:ItemClick( 1, {|| oStat:Item(1, "C " + Time()), AutoMsgBox(2)} )
  oStat:ItemDblClick( 1, {|| oStat:Item(2, "D " + Time()), hb_idlesleep(2)} )

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

Return


