/*
 * Picture Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to paint an image using PICTURE
 * and IMAGE controls. Since these controls use different
 * methods for painting there's a chance that an image is
 * not painted in the same way. In such a case, please
 * send me a small sample and I'll try to fix the problem.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download oohg.gif from
 * https://github.com/oohg/samples/tree/master/Picture
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Image vs Picture Test Case' ;
      MAIN ;
      BACKCOLOR CYAN

      @ 0,300 IMAGE Img_1 ;
         WIDTH 200;
         HEIGHT 150;
         PICTURE 'oohg.gif' ;
         ON CLICK MsgBox( "I'm an IMAGE control !!!")

      @ 0,0 PICTURE Img_2 ;
         WIDTH 200;
         HEIGHT 150;
         PICTURE 'oohg.gif' ;
         ON CLICK MsgBox( "I'm a PICTURE control !!!")

      /*
       * Note that IMAGE uses IMAGESIZE by default and
       * PICTURE uses STRETCH by default.
       */

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
