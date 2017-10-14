/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002-06 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
 *
 * Copyright 2006 Grigory Filatov <gfilatov@inbox.ru>
*/

#include "oohg.ch"

Function Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'ooHG Demo' ;
		MAIN ;

//////////                ON SIZE SizeTest()

		DEFINE MAIN MENU

			DEFINE POPUP 'Style'
				MENUITEM 'Top pages' ACTION Tab_1( .t. )
				MENUITEM 'Bottom pages' ACTION Tab_1( .f. )
				SEPARATOR 
				MENUITEM 'Exit' ACTION ThisWindow.Release
			END POPUP

			DEFINE POPUP 'Tests'
				MENUITEM 'Add Page' ACTION Form_1.Tab_1.AddPage ( 2 , 'New Page' , 'Info.Bmp' )
				MENUITEM 'Delete Page' ACTION Form_1.tab_1.DeletePage ( 2 )
				SEPARATOR
				MENUITEM 'Change Image' ACTION Form_1.Tab_1.Image( 1 ) := 'Info.Bmp'
				MENUITEM 'Replace Image' ACTION Form_1.Tab_1.Image( 1 ) := 'Exit.Bmp'
				SEPARATOR
				MENUITEM 'Change Caption' ACTION Form_1.Tab_1.Caption( 1 ) := 'Caption'
				MENUITEM 'Replace Caption' ACTION Form_1.Tab_1.Caption( 1 ) := 'Page 1'
				SEPARATOR
				MENUITEM 'Get Row' ACTION MsgInfo(Str(Form_1.tab_1.Row))
				MENUITEM 'Get Col' ACTION MsgInfo(Str(Form_1.tab_1.Col))
				MENUITEM 'Get Width' ACTION MsgInfo(Str(Form_1.tab_1.Width))
				MENUITEM 'Get Height' ACTION MsgInfo(Str(Form_1.tab_1.Height))
				SEPARATOR
				MENUITEM 'Set Row' ACTION Form_1.tab_1.Row := Val( InputBox('',''))
				MENUITEM 'Set Col' ACTION Form_1.tab_1.Col:= Val( InputBox('',''))
				MENUITEM 'Set Width' ACTION Form_1.tab_1.Width:= Val( InputBox('',''))
				MENUITEM 'Set Height' ACTION Form_1.tab_1.Height:= Val( InputBox('',''))
			END POPUP

		END MENU

		Tab_1( .t. )

	END WINDOW

	Form_1.Center

	Form_1.Activate

Return Nil

Procedure SizeTest()

	Form_1.Tab_1.Width := Form_1.Width - 30
	Form_1.Tab_1.Height := Form_1.Height - 100

Return

Procedure Tab_1( lStyle )

	IF IsControlDefined(Tab_1, Form_1)
		Form_1.Tab_1.Release
	ENDIF

	IF lStyle

		DEFINE TAB Tab_1 ;
			OF Form_1 ;
			AT 10,10 ;
			WIDTH 600 ;
			HEIGHT 400 ;
			VALUE 1 ;
			TOOLTIP 'Tab Control'

	ELSE

		DEFINE TAB Tab_1 ;
			OF Form_1 ;
			AT 10,10 ;
			WIDTH 600 ;
			HEIGHT 400 ;
			VALUE 1 ;
			TOOLTIP 'Tab Control' ;


////                        BOTTOM

	ENDIF
			PAGE 'Page 1' IMAGE 'Exit.Bmp'

			END PAGE

			PAGE 'Page 2' //IMAGE 'Info.Bmp'

			END PAGE

			PAGE 'Page 3' IMAGE 'Check.Bmp'

			END PAGE

		END TAB

Return
