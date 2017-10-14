
#include "oohg.ch"
Function main()

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 ;
		HEIGHT 400 ;
                TITLE 'ANIMATEBOX Test' ;
		MAIN TOPMOST

                @ 20,200 animatebox ani_a obj oani width 300 height 80 file "sample.avi"


		DEFINE BUTTON Button_D1
			ROW	60
			COL	0
			CAPTION	"Play ANI"
                        ACTION  oani:Play() 
		END BUTTON
		
		DEFINE BUTTON Button_D2
			ROW	90
			COL	0
			CAPTION	"Seek ANI"
                        ACTION  oani:Seek(3) 
		END BUTTON

		DEFINE BUTTON Button_D3
			ROW	120
			COL	0
			CAPTION	"Stop ANI"
                        ACTION  oani:Stop() 
		END BUTTON

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

RETURN

