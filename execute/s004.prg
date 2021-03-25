/*
 * Execute File Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to start and external app.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

	DEFINE WINDOW Win_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 400 ;
		TITLE 'Hello World!' ;
		MAIN 

		DEFINE BUTTON B1
			ROW 10
			COL 10
			CAPTION 'Execute'
			ACTION ExecTest()
		END BUTTON

	END WINDOW

	ACTIVATE WINDOW Win_1

RETURN NIL

FUNCTION ExecTest()

	EXECUTE FILE "NOTEPAD.EXE" 

RETURN NIL

/*
 * EOF
 */
