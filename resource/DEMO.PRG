/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
 * modified ciro Vargas Clemow
*/

#include "oohg.ch"

Function Main

	DEFINE WINDOW Form_Main ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'Demo PlayWave from resource' ;
		ICON 'WORLD' ;
		MAIN 

		@ 200,140 BUTTON ImageButton_1 ;
                        PICTURE 'buttonx' ;
			ACTION MsgInfo('Button Pressed!','!') ;
			WIDTH 29 ;
			HEIGHT 29 TOOLTIP 'Print Preview' ;

		@ 50 ,100 BUTTON Button_1 ;
			CAPTION "Play Wave From Resource" ;
			ACTION Play_CLick() ;
	                WIDTH 200 ;
			HEIGHT 30


	END WINDOW

	ACTIVATE WINDOW Form_Main 

Return Nil

Procedure Play_Click

	PLAY WAVE 'RESWAVE' FROM RESOURCE

Return

