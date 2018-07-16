/*
 * Picture Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place one Picture Control upon
 * another, each one with its own ON CLICK and TOOLTIP.
 * It also shows how to dynamicaly set the excluded area of
 * the "background" picture control, using DATA aExcludeArea.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main
   LOCAL oPict1
   // This declaration is needed for OBJECT clause

   DEFINE WINDOW frm_Main OBJ oWin ;
      AT 100,100 ;
      CLIENTAREA ;
      WIDTH 341 ;
      HEIGHT 155 ;
      TITLE 'Picture on Picture' ;
      MAIN ;
      ON INIT SetExcludeArea( oPict1 )

      @ 20,20 PICTURE img_Pict2 ;
         OBJ oPict2 ;
         WIDTH 60 ;
         HEIGHT 60 ;
         STRETCH ;
         PICTURE "oohg.jpg" ;   // 95 x 95
         ON CLICK AutoMsgBox("Pict2") ;
         TOOLTIP "I'm oPict2, click me." ;
         TRANSPARENT  // This clause is needed, see note at the end.

      DEFINE PICTURE img_Pict1
         OBJECT oPict1
         ROW 0
         COL 0
         IMAGESIZE .T.
         PICTURE  "logo.jpg"
         TOOLTIP "I'm oPict1, click me."
         ONCLICK AutoMsgBox( "Pict1" )
         // Do not use TRANSPARENT here, see note at the end.
      END PICTURE

      @ 20, 200 LABEL lbl_1 ;
         OBJ oLbl1 ;
         VALUE "LABEL" ;
         BOLD ;
         AUTOSIZE ;
         TOOLTIP "I'm a label !!!" ;
         ON CLICK AutoMsgBox("lbl_1") ;
         TRANSPARENT

      ON KEY ESCAPE ACTION oWin:Release()
	END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL

FUNCTION SetExcludeArea( oPict1 )
/*
   The coordinates of the area to exclude must be relative to oPict1.
   You can add aditional sectors by adding elements to oPict1:aExcludeArea
   array.
*/
   oPict1:aExcludeArea := ;
      { { oLbl1:col - oPict1:col, ;                   // left
          oLbl1:row - oPict1:row, ;                   // top
          oLbl1:col - oPict1:col + oLbl1:Width, ;     // right
          oLbl1:row - oPict1:row + oLbl1:Height } }   // bottom
RETURN NIL

/*
   Note that if you delete TRANSPARENT clause from img_Pict2, the excluded
   area will function as expected but the image is not visible or not painted
   properly. Without TRANSPARENT clause, you must define img_Pict1 before
   img_Pict2. The reason is that controls are painted in the same order as
   they were defined except when you use TRANSPARENT. Controls with this
   clause are always painted last. See this page for more info:
   http://blogs.msdn.com/b/oldnewthing/archive/2012/12/17/10378525.aspx
*/

/*
 * EOF
 */
