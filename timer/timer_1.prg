
#include "oohg.ch"

Function Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 400 ;
		TITLE 'Timer Test' ;
		MAIN 

		@ 10,10 LABEL Label_1 

		DEFINE TIMER Timer_1 ;
		INTERVAL 1000 ;
		ACTION Form_1.Label_1.Value := Time() 

		DEFINE TIMER Timer_2 ;
		INTERVAL 2500 ;
		ACTION PlayBeep() 

    @ 50, 10 BUTTON Button_1 CAPTION "Detener" WIDTH 100 HEIGHT 28 ACTION (Form_1.Timer_1.Enabled := .f., Form_1.Timer_2.Enabled := .f., Form_1.Button_1.Enabled := .f., Form_1.Button_2.Enabled := .t.)
    Form_1.Button_1.Enabled := .t.

    @ 50, 210 BUTTON Button_2 CAPTION "Arrancar"  WIDTH 100 HEIGHT 28 ACTION (Form_1.Timer_1.Enabled := .t., Form_1.Timer_2.Enabled := .t., Form_1.Button_1.Enabled := .t., Form_1.Button_2.Enabled := .f.)
    Form_1.Button_2.Enabled := .f.
    
	END WINDOW

	Form_1.Center 

	Form_1.Activate 

Return

