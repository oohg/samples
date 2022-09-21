/*
 * EditBox Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how display row and column position
 * of an editbox control.
 *
 * Based on a sample from MINIGUI distribution
 * (c) 2002 Roberto Lopez
 * Modified by Ciro Vargas Clemow <cvc@oohg.org>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

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
			ACTION ( Form_1.Edit_1.CaretPos := Val( InputBox( 'Set Caret Position', '' ) ), Form_1.Edit_1.SetFocus )
		END BUTTON

	END WINDOW

	Form_1.Center()
	Form_1.Activate()

   RETURN NIL

PROCEDURE ShowRowCol

   LOCAL s, c, i, e, q

	s := Form_1.Edit_1.Value
	c := Form_1.Edit_1.CaretPos
	e := 0
	q := 0

	FOR i := 1 TO c
		IF SubStr( s, i, 1 ) == Chr( 13 )
			e++
			q := 0
		ELSE
			q++
		ENDIF
	NEXT i

	Form_1.StatusBar.Item( 1 ) := 'Row: ' + AllTrim( Str( e + 1 ) ) + ' Col: ' + AllTrim( Str( q ) )

   RETURN

/*
 * EOF
 */
