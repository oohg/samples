/*
 * Button Sample # 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a button's image using
 * the handle of an already loaded bitmap.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/button
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   hBmp1 := _OOHG_BitmapFromFile( NIL, "OOHG.ICO", LR_CREATEDIBSECTION, .F., .F. )
   hBmp2 := _OOHG_ScaleImage( NIL, hBmp1, 16, 16, TRUE, -1, TRUE, 0, 0 )
   DeleteObject( hBmp1 )

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 300 ;
      HEIGHT 240 ;
      MAIN ;
      TITLE "ooHG - Button Demo" ;
      ON RELEASE DeleteObject( hBmp2 )

      @ 20,20 BUTTON btn_1 ;
         OBJ oBut1 ;
         WIDTH 120 ;
         HEIGHT 32 ;
         CAPTION "Resource" ;
         PICTURE "hbprint_print" ;
         ACTION MsgInfo( "The image was loaded from a resource." ) ;
         TOOLTIP "The image was loaded from a resource." ;
         HANDCURSOR

      @ 70,20 BUTTON btn_2 ;
         OBJ oBut2 ;
         WIDTH 120 ;
         HEIGHT 32 ;
         CAPTION "Handle" ;
         ACTION MsgInfo( "The image was loaded from a bitmap using its handle." ) ;
         HBITMAP hBmp2 NODESTROY ;
         TOOLTIP "The image was loaded from a bitmap using its handle."

      /* NODESTROY clause instructs the control to make and use a copy of the image.
       * This copy is deleted at button's release without affecting the original image.
       * This enables the reuse of the image without the need of reloading it from a file or resource.
       *
       * Despite the fact that an HBITMAP is deleted by the OS at process's end, it's a good practice
       * to explicitly release it when it's no longer needed.
       */

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */
