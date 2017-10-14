/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
*/

#include "oohg.ch"

Function Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'Editbox Demo' ;
		ICON 'DEMO.ICO' ;
		MAIN ;
		FONT 'Arial' SIZE 10

		DEFINE STATUSBAR
			STATUSITEM 'oohg Power Ready!' 
		END STATUSBAR

		@ 30,10 EDITBOX Edit_1 ;
			WIDTH 410 ;
			HEIGHT 140 ;
			VALUE 'EditBox!!' ;
			TOOLTIP 'EditBox' ;
			MAXLENGTH 255 ;
			ON CHANGE ShowRowCol() // NOVSCROLL NOHSCROLL

		DEFINE BUTTON B
			ROW 250
			COL 10
			CAPTION 'Set CaretPos'
			ACTION ( Form_1.Edit_1.CaretPos := Val(InputBox('Set Caret Position','')) , Form_1.Edit_1.SetFocus )
		END BUTTON

	END WINDOW

	Form_1.Center()

	Form_1.Activate()

Return Nil

Procedure ShowRowCol
Local s , c , i , e , q 
	
	s := Form_1.Edit_1.Value
	c := Form_1.Edit_1.CaretPos
	e := 0
	q := 0

	for i := 1 to c
		if substr ( s , i , 1 ) == chr(13)
			e++
			q := 0
		Else
			q++
		EndIf
	Next i

	Form_1.StatusBar.Item(1) := 'Row: ' + alltrim(Str(e+1)) + ' Col: ' + alltrim(Str(q))

Return
