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
		WIDTH 600 HEIGHT 400 ;
		TITLE "ooHG DatePicker Demo" ;
		MAIN ;
		FONT "Arial" SIZE 10

		@ 10,10 DATEPICKER Date_1 ;
		VALUE CTOD("01/01/2001") ;
		TOOLTIP "DatePicker Control"

		@ 10,310 DATEPICKER Date_2 ;
		VALUE CTOD("01/01/2001") ;
		TOOLTIP "DatePicker Control ShowNone RightAlign" ;
		SHOWNONE ;
		RIGHTALIGN

		@ 230,10 DATEPICKER Date_3 ;
		VALUE CTOD("01/01/2001") ;
		TOOLTIP "DatePicker Control UpDown" ;
		UPDOWN

		@ 230,310 DATEPICKER Date_4 ;
		VALUE CTOD("01/01/2001") ;
		TOOLTIP "DatePicker Control ShowNone UpDown" ;
		SHOWNONE ;
		UPDOWN

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

Return Nil

