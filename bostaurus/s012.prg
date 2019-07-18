/*
 * Bos Taurus Sample # 12
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to resize an image and how
 * to draw over a control's current image.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR hBitmap1, hBitmap2

PROCEDURE MAIN

   PRIVATE hBitmap1, hBitmap2

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 650 ;
      TITLE "Bos Taurus: Image Resize / Drawing over Control's Image" ;
      MAIN ;
      NOMAXIMIZE ;
      NOSIZE ;
      ON INIT Proc_ON_INIT() ;
      ON RELEASE Proc_ON_RELEASE() ;
      NODWP

      @ 005, 50 IMAGE Image1 ;
         PICTURE "" ;
         IMAGESIZE ;
         ON CLICK Proc_Image( "Image1", "OOHG Control Image 1", RED )

      @ 315, 50 IMAGE Image2 ;
         PICTURE "" ;
         IMAGESIZE ;
         ON CLICK Proc_Image( "Image2", "OOHG Control Image 2", GREEN )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1

   RETURN


PROCEDURE Proc_ON_RELEASE

   BT_BitmapRelease( hBitmap1 )
   BT_BitmapRelease( hBitmap2 )

   RETURN

PROCEDURE Proc_ON_INIT
   LOCAL hBitmap3, hBitmap4

   hBitmap3 := BT_BitmapLoadFile( "giovanni.png" )
   hBitmap1 := BT_BitmapCopyAndResize( hBitmap3, 500, 300, Nil, BT_RESIZE_HALFTONE )
   BT_BitmapRelease( hBitmap3 )
   Win1.Image1.HBitMap := hBitmap1

   hBitmap4 := BT_BitmapLoadFile( "giovanni.gif" )
   hBitmap2 := BT_BitmapCopyAndResize( hBitmap4, 500, 300, Nil, BT_RESIZE_HALFTONE )
   BT_BitmapRelease( hBitmap4 )
   Win1.Image2.HBitMap := hBitmap2

   MsgInfo( "Click on the images" )

   RETURN


PROCEDURE Proc_Image( cControlName, cText, aColor )
   LOCAL hDC, BTstruct, hBitmap, hUY
   LOCAL nTypeText, nAlignText, nOrientation

   hBitmap := GetControlObject( cControlName, "Win1" ):HBitMap

   hUY := BT_BitmapLoadFile( "uruguay.bmp" )

   hDC := BT_CreateDC( hBitmap, BT_HDC_BITMAP, @BTstruct )

   nTypeText    := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD
   nAlignText   := BT_TEXT_LEFT + BT_TEXT_BASELINE
   nOrientation := 30
   BT_DrawText( hDC, 285, 45, cText, "Times New Roman", 38, aColor, WHITE, nTypeText, nAlignText, nOrientation )

   BT_DrawBitmap( hDC, 80, 100, BT_BitmapWidth( hUY ), BT_BitmapHeight( hUY ), BT_COPY, hUY )

   BT_DeleteDC( BTstruct )

   BT_BitmapRelease( hUY )

   GetControlObject( cControlName, "Win1" ):RePaint()

   RETURN

/*
 * EOF
 */
