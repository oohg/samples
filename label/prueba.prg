
#include "oohg.ch"

FUNCTION Main

	DEFINE WINDOW Form_1 OBJ oWin ;
		AT 0,0 ;
		WIDTH 330 HEIGHT 200 ;
		TITLE "OOHG Label Demo" ;
		MAIN
		
      @ 20,20 LABEL lbl OBJ oLbl ;
         VALUE "When mouse hovers me you must see a hand cursor" ;
         WIDTH 200 ;
         HEIGHT 50 ;
         TOOLTIP "Click me to trigger an action !!!"

      nHandleCursor:= MYCURSORHAND()
      oWin:lbl:hCursor:= nHandleCursor

/*
 * The next sentences work OK
 *
      oLbl:Cursor( IDC_HAND )
      oLbl:OnClick := {|| AutoMsgBox("Action triggered !!!")}
*/

      // Sets the onclick property to this codeblock
      Form_1.lbl.OnClick := {|| AutoMsgBox("Action triggered !!!")}

      // Evaluates de codeblock
      Form_1.lbl.OnClick()

      ON KEY ESCAPE ACTION Form_1.Release
	END WINDOW

	CENTER WINDOW Form_1
	ACTIVATE WINDOW Form_1

RETURN NIL

#pragma BEGINDUMP
#define WINVER 0x0500
#include <windows.h>
#include <winuser.h>
#include <hbapi.h>

#if(WINVER >= 0x0500)
#define IDC_HAND MAKEINTRESOURCE(32649)
#endif

HB_FUNC( MYCURSORHAND )
{
//hb_retnl( (long) SetCursor( LoadCursor( 0, MAKEINTRESOURCE(32649) ) ) );
hb_retnl( (long) LoadCursor( 0, MAKEINTRESOURCE(32649) ) );
}
#pragma ENDDUMP

/*
 * EOF
 */
