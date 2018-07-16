/*
 * Image Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place one Image Control upon
 * another, each one with its own ON CLICK and TOOLTIP.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main

   LOCAL oImage1
   // This declaration is needed for OBJECT clause

   DEFINE WINDOW frm_Main OBJ oWin ;
      AT 100,100 ;
      CLIENTAREA ;
      WIDTH 341 ;
      HEIGHT 155 ;
      TITLE 'Image on Image' ;
      MAIN

      @ 20,20 IMAGE img_Image2 ;
         OBJ oImage2 ;
         WIDTH 200 ;
         HEIGHT 200 ;
         NORESIZE ;
         PICTURE "oohg.jpg" ;   // 95 x 95
         ON CLICK AutoMsgBox("Image2") ;
         TOOLTIP "I'm oImage2, click me." ;
         TRANSPARENT  // This clause is needed
/*
   If you omit TRANSPARENT clause from img_Image2, the image is not
   visible or is not painted properly. Without TRANSPARENT clause,
   you must define img_Image1 before img_Image2. The reason is that
   controls are painted in the same order as they were defined except
   when you use TRANSPARENT clause. Controls with this clause are
   always painted last. See this page for more info:
   http://blogs.msdn.com/b/oldnewthing/archive/2012/12/17/10378525.aspx
*/
      DEFINE IMAGE img_Image1
         OBJECT oImage1
         ROW 0
         COL 0
         IMAGESIZE .T.
         PICTURE  "logo.jpg"
         TOOLTIP "I'm oImage1, click me."
         ONCLICK AutoMsgBox( "Image1" )
         // Do not use TRANSPARENT here
      END IMAGE

      ON KEY ESCAPE ACTION oWin:Release()
	END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL

/*
 * EOF
 */
