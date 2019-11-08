/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002-2005 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
 *
 * Adapted for ooHG by MigSoft 2007 <fugaz_cl@yahoo.es>
*/

#include "oohg.ch"

FUNCTION Main()

	DEFINE WINDOW WinTr OBJ oWinTR ;
		AT 0,0 ;
		WIDTH 300 ;
		HEIGHT 300 ;
		TITLE 'Transparent window' ;
		MAIN ;
		NOSIZE NOMAXIMIZE ;
		ON INIT oWinTR:SetTransparency( 210 )

		@ 200,100 BUTTON But1 ;
			CAPTION "Click Me" ;
			HEIGHT 35 WIDTH 100 ;
			ACTION oWinTR:SetTransparency( iif( nTra == 100, 255, 100 ) )

	END WINDOW

	CENTER WINDOW WinTR
	ACTIVATE WINDOW WinTR

RETURN NIL
