/*
 * Picture Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how STRETCH clause works.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main
   LOCAL oWin

   SetOneArrayItemPerLine( .T. )

   DEFINE WINDOW frm_Main OBJ oWin ;
      AT 86,94 ;
      CLIENTAREA ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Picture with STRETCH clause' ;
      MAIN

      @ 20,20 PICTURE pct_Image1 OBJ oPict1 ;
         WIDTH 240 ;
         HEIGHT 180 ;
         STRETCH ;
         PICTURE "ROTA.JPG" // 155 x 341

      DRAW RECTANGLE IN WINDOW frm_Main ;
         AT 20, 20 ;
         TO 200, 260 ;
         FILLCOLOR YELLOW

      @ 250,20 PICTURE pct_Image2 OBJ oPict2 ;
         WIDTH 400 ;
         HEIGHT 200 ;
         STRETCH ;
         PICTURE "LOGO.JPG" // 341 x 155

      DRAW RECTANGLE IN WINDOW frm_Main ;
         AT 250, 20 ;
         TO 450, 420 ;
         FILLCOLOR YELLOW

/*
   STRETCH   = The image´s dimensions are increased or
               decreased (both in the same proportion)
               until the width and/or the height equals
               the controls' width and/or height.

   IMAGESIZE = The control is resized to fit the image's
               dimensions.

   NORESIZE  = The image is shown with its dimensions,
               even if they surpass the control's ones.
               Control's dimensions are not changed.

   NEITHER   = image is scaled to control's dimensions
               (image's proportion may be changed).
*/

      ON KEY ESCAPE ACTION oWin:Release()
      ON KEY F9 ACTION AutoMsgBox( { "Control 1", ;
                                     "Width and Height", ;
                                     oPict1:Width, ;
                                     oPict1:Height, ;
                                     "Original Image Width and Heigth", ;
                                     oPict1:OriginalSize(), ;
                                     "Current Image Width and Heigth", ;
                                     oPict1:CurrentSize(), ;
                                     "Control 2", ;
                                     "Width and Height", ;
                                     oPict2:Width, ;
                                     oPict2:Height, ;
                                     "Original Image Width and Heigth", ;
                                     oPict2:OriginalSize(), ;
                                     "Current Image Width and Heigth", ;
                                     oPict2:CurrentSize() } )
   END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN NIL

/*
 * EOF
 */
