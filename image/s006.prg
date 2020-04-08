/*
 * Image Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the EXCLUDEAREA clause of
 * an IMAGE control to restrict ON CLICK and TOOLTIP to
 * a specific area of the control. It also shows how to
 * dynamicaly set the exclude area using DATA aExcludeArea.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download img1.bmp from:
 * https://github.com/oohg/samples/tree/master/image
 */

#include 'oohg.ch'

FUNCTION Main

   LOCAL oImage1

   DEFINE WINDOW frm_Main OBJ oWin ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 300 ;
      HEIGHT 160 ;
      TITLE 'Exclude Areas in Image' ;
      MAIN

      DEFINE IMAGE img_Image1
         OBJECT oImage1             // This variable must be declared
         ROW 20
         COL 20
         WIDTH 120
         HEIGHT 120
         PICTURE "s006.bmp"
         TOOLTIP "Visible only over green area."
         ONCLICK AutoMsgBox( "Click on green area !!!" )
         EXCLUDEAREA { { 30, 30, 90, 90 } }  // left, top, right, bottom
      END IMAGE

      @ 20, 180 LABEL lbl_1 ;
         VALUE "Move the mouse over the image and click in different places. Use F5 to toggle the exclude area." ;
         WIDTH 90 ;
         HEIGHT 120 ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION oWin:Release()
      ON KEY F5 ACTION SwapArea( oImage1 )
	END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL

FUNCTION SwapArea( oImage1 )

   STATIC lSwap := .T.
/*
   Pixel at (right, bottom) is not part of the exclude area.
   Coordinates must be relative to oImage1.
*/
   IF lSwap
      oImage1:aExcludeArea := { {  0,  0, 120,  30 }, ;
                                { 90, 30, 120, 120 }, ;
                                {  0, 30,  30, 120 }, ;
                                { 30, 90,  90, 120 } }
      oImage1:Tooltip := "Visible only over red area."
      oImage1:bOnClick := { || AutoMsgBox( "Click on red area !!!" ) }
   ELSE
      oImage1:aExcludeArea := { { 30, 30, 90, 90 } }
      oImage1:Tooltip := "Visible only over green area."
      oImage1:bOnClick := { || AutoMsgBox( "Click on green area !!!" ) }
   ENDIF

   lSwap := ! lSwap

RETURN NIL

/*
 * EOF
 */
