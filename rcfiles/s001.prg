/*
 * RC File Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to include images in a resource file, so
 * they are embeded into the executable when your programm is compiled.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download the resource file and the images from:
 * https://github.com/oohg/samples/tree/master/RCFiles
 */

#include "oohg.ch"

PROCEDURE Main()

   DEFINE WINDOW Form_Main ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 364 ;
      HEIGHT 243 ;
      TITLE 'Test case for loading images from RC file' ;
      MAIN ;
      ICON "APPICON"

      @ 1, 1 IMAGE Image_1 ;
         PICTURE "DEMO1" ;
         IMAGESIZE ;
         TOOLTIP "BITMAP"

      @ 1, 122 IMAGE Image_2 ;
         PICTURE "DEMO2" ;
         IMAGESIZE ;
         TOOLTIP "GIF"

      @ 1, 243 IMAGE Image_3 ;
         PICTURE "DEMO3" ;
         IMAGESIZE ;
         TOOLTIP "JPG"

      @ 121, 1 IMAGE Image_4 ;
         PICTURE "DEMO4" ;
         IMAGESIZE ;
         TOOLTIP "PNG"

      @ 121, 122 IMAGE Image_5 ;
         PICTURE "DEMO5" ;
         IMAGESIZE ;
         TOOLTIP "TIFF"

      @ 121, 243 IMAGE Image_6 ;
         PICTURE "DEMO6" ;
         IMAGESIZE ;
         TOOLTIP "ICON"

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_Main
   ACTIVATE WINDOW Form_Main
RETURN

/*
 * EOF
 */
