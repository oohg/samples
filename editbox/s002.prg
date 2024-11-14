/*
 * EditBox Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to make the last row added to
 * an EDITBOX control visible.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

MEMVAR oEdt, oTmr

FUNCTION Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'Editbox - Auto scroll when adding a line' ;
		MAIN

		DEFINE STATUSBAR
			STATUSITEM ""
		END STATUSBAR

		@ 30, 10 EDITBOX Edit_1 OBJ oEdt ;
			WIDTH 410 ;
			HEIGHT 140 ;
         VALUE ( "Started at  " + Time() ) ;
         ON CHANGE ShowRowCol()

      DEFINE TIMER Timer_1 OBJ oTmr ;
         INTERVAL 1000 ;
		   ACTION oEdt:Value += ( CRLF + "New line at " + Time() )

	END WINDOW

	Form_1.Center()
	Form_1.Activate()

	RETURN NIL

PROCEDURE ShowRowCol

   LOCAL s, c, i, e, q

   oTmr:Enabled := .F.

   // Show last row
   oEdt:CaretPos( Len( oEdt:Value ) )

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

   oTmr:Enabled := .T.

   RETURN

/*
 * EOF
 */

