/*
 * Label Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows some features of LABEL controls.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 300 HEIGHT 400 ;
		TITLE "Label Demo" ;
		MAIN ;
		FONT "Arial" SIZE 10 ;
      BACKCOLOR YELLOW

      ON KEY ESCAPE ACTION ThisWindow.Release()

      @ 010,10 LABEL Label_1 ;
         VALUE "Label_1" ;
         WIDTH 200 ;
         TOOLTIP "Label 1"

      @ 040,10 LABEL Label_2 ;
         VALUE "Label_2" ;
         CENTERALIGN ;
         WIDTH 200 ;
         TOOLTIP "Label 2 CenterAlign"

      @ 070,10 LABEL Label_3 ;
         VALUE "Label_3" ;
         RIGHTALIGN ;
         WIDTH 200 ;
         TOOLTIP "Label 3 RightAlign"

   	@ 110,10 LABEL Label_4 ;
   		VALUE "Label_4" ;
   		WIDTH 200 ;
   		TRANSPARENT ;
   		TOOLTIP "Label 4 Transparent" ;
         ON CLICK AutoMsgBox( "Label_4 clicked !!!" )

      @ 140,10 LABEL Label_5 ;
         VALUE "Label_5" ;
         CENTERALIGN ;
         WIDTH 200 ;
         TRANSPARENT ;
         TOOLTIP "Label 5 CenterAlign Transparent"

      @ 170,10 LABEL Label_6 ;
         VALUE "Label_6" ;
         RIGHTALIGN ;
         WIDTH 200 ;
         TRANSPARENT ;
         TOOLTIP "Label 6 RightAlign Transparent"

      @ 200,20 LABEL Label_7 ;
         VALUE "OOHG" ;
         TRANSPARENT ;
         FONT "ARIAL" SIZE 36 ;
         FONTCOLOR BLACK ;
         BACKCOLOR YELLOW ;
         AUTOSIZE

      @ 202,23 LABEL Label_8 ;
         VALUE "OOHG" ;
         TRANSPARENT ;
         FONT "ARIAL" SIZE 36 ;
         FONTCOLOR PINK ;
         BACKCOLOR YELLOW ;
         AUTOSIZE

      @ 300,20 LABEL Label_9 ;
         VALUE "OOHG" ;
         TRANSPARENT ;
         WIDTH 90 ;
         HEIGHT 40 ;
         CLIENTEDGE

      @ 300,120 LABEL Label_10 ;
         VALUE "OOHG" ;
         TRANSPARENT ;
         WIDTH 90 ;
         HEIGHT 40 ;
         CLIENTEDGE ;
         VCENTERALIGN

	END WINDOW

	CENTER WINDOW Form_1
	ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */

