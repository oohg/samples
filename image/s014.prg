/*
 * Image Sample # 14
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to load an Enhanced Metafile to
 * an image control.
 *
 * You can download a sample file from *
 * https://github.com/oohg/samples/blob/master/image/s014.emf
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 AT 0,0 ;
      WIDTH 480 HEIGHT 700 ;
      TITLE 'OOHG- Load an EnhMetaFile to an Image control' ;
      MAIN

      DEFINE MAIN MENU
         ITEM 'Select Image' ACTION oImage:HBitmap := GetImage()
         ITEM 'Exit'         ACTION Form_1.Release()
      END MENU

      @ 00,00 IMAGE Image_1 OBJ oImage IMAGESIZE
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION GetImage

   RETURN BT_BitmapLoadEMF( GetFile( {{'EMF Files','*.emf'}}, 'Select' ), WHITE, 420, 600 )

/*
 * EOF
 */
