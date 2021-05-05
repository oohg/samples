/*
 * Textbox Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place controls inside a
 * TextBox controls.
 *
 * Adapted from an original sample by Roberto Lopez.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

PROCEDURE Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'ooHG textbox Demo' ;
		MAIN ON INIT ( oTxt1:oButton1:lNoFocusRect := .T., oTxt1:oButton1:lLibDraw := .T. )

		@ 10,10 TEXTBOX Txt1 OBJ oTxt1 ;
         WIDTH 200 ;
         VALUE "data" ;
         ACTION MsgInfo("One!") ;
         ACTION2 MsgInfo("Two!")

         @ 0,0 LABEL Label1 OBJ oLbl1 ;
            OF ( oTxt1 ) ;
            VALUE " Label " ;
            WIDTH 40 ;
            BACKCOLOR 0x0000FF

         @ 0,0 BUTTON Btn1 OBJ oBtn1 ;
            OF ( oTxt1 ) ;
            CAPTION "4" ;
            WIDTH 15 ;
            ACTION MsgInfo( "Four!" )

       @ 40,10 BUTTON Move ;
          CAPTION "Move" ;
          ACTION iif( oTxt1:Row == 10, oTxt1:Row := 80, oTxt1:Row := 10 )

		@ 120,10 TEXTBOX Text_1 OBJ oTxt ;
			VALUE 123 ;
			FONT 'Verdana' SIZE 12 ;
			TOOLTIP { 'This is a NUMERIC TextBox.', "Control Type:", LoadIcon( NIL, IDI_INFORMATION ) } ;
			NUMERIC ;
			INPUTMASK "999,999,999.99"  ;
			RIGHTALIGN ;
			ON LOSTFOCUS iif( This.Value < 100, This.SetFocus, NIL )

      @ 120, 200 LABEL 0 VALUE "<- try the textbox's tooltip" AUTOSIZE

		@ 180,10 TEXTBOX Txt2 OBJ oTxt2 ;
         WIDTH 200 ;
         CTRLSATLEFT ;
         ACTION MsgInfo("One!") ;
         ACTION2 MsgInfo("Two!")

         @ 0,0 LABEL Label2 OBJ oLbl2 ;
            OF ( oTxt2 ) ;
            VALUE " Label " ;
            WIDTH 40 ;
            BACKCOLOR 0x0000FF

         @ 0,0 BUTTON Btn2 ;
            OF ( oTxt2 ) ;
            CAPTION "4" ;
            WIDTH 15 ;
            ACTION MsgInfo( "Four!" )

       @ 210,10 BUTTON Delete ;
          CAPTION "Delete" ;
          ACTION ( oLbl1:Release(), oLbl2:Release() )

       @ 250,10 BUTTON ReadOnly ;
          CAPTION "ReadOnly" ;
          ACTION oTxt1:Readonly := ! oTxt1:ReadOnly

      ON KEY ESCAPE ACTION ThisWindow.Release
	END WINDOW

	Form_1.Center
	Form_1.Activate

RETURN 

/*
 *
 */
