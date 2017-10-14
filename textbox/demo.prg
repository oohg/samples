/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
*/

#include "oohg.ch"

Function Main

         set navigation extended

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'ooHG textbox Demo' ;
		MAIN 
		
		
		@ 10,10 TEXTBOX Txt WIDTH 200 OBJ oTxt ;
                action msginfo("uno!") ;
                action2 msginfo("dos!") ;

                @ 0,0 LABEL Label VALUE " Label " WIDTH 40 OF ( oTxt ) ;
                BACKCOLOR 0x0000FF

                @ 0,0 BUTTON Btn OF ( oTxt ) ;
                CAPTION "4" WIDTH 15 ;
                ACTION MsgInfo( "cuatro!" )

                @ 40,10 BUTTON Mover CAPTION "Mover" ACTION ;
               ( IF( oTxt:Row == 10, oTxt:Row := 80, oTxt:Row := 10 ) )



		@ 120,10 TEXTBOX Text_1 ;
			VALUE 123 ;
			FONT 'Verdana' SIZE 12 ;
			TOOLTIP 'Numeric TextBox' ;
			NUMERIC ;
			inputmask "999,999,999.99"  ;
			RIGHTALIGN ;
			ON LOSTFOCUS if ( This.Value < 100 , This.SetFocus , Nil)


	END WINDOW

	Form_1.Center

	Form_1.Activate

Return Nil

