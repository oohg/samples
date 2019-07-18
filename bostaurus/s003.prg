/*
 * Bos Taurus Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to manipulate a bitmap.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

PROCEDURE MAIN

   LOCAL hBitmap1, hBitmap2, oWin

   hBitmap1 := BT_BitmapLoadFile( "oohg_3d.bmp" )
   hBitmap2 := BT_BitmapTransform( hBitmap1, BT_BITMAP_ROTATE + BT_BITMAP_REFLECT_HORIZONTAL + BT_BITMAP_REFLECT_VERTICAL, 135, Nil )

   BT_BitmapRelease( hBitmap1 )
   hBitmap1 := Proc_Paint_on_the_Bitmap()

   /*
    * Because OOHG executes ON PAINT before executing ON INIT
    * the image must be loaded before the window's activation.
    *
    * All loaded bitmaps must be released to avoid memory leaks.
    */

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE "Bos Taurus: BITMAP Manipulation" ;
      MAIN ;
      ON PAINT Proc_ON_PAINT( hBitmap1, hBitmap2 ) ;
      ON SIZE Proc_ON_SIZE() ;
      ON RELEASE Proc_ON_RELEASE( hBitmap1, hBitmap2 ) ;
      NODWP

      @ 30, 333 LABEL Label_1 ;
         VALUE "Client Area WIDTH " + STR( oWin:ClientWidth ) ;
         AUTOSIZE

      @ 80, 333 LABEL Label_2 ;
         VALUE "Client Area HEIGHT" + STR( oWin:ClientHeight ) ;
         AUTOSIZE ;
         TRANSPARENT ;
         FONTCOLOR BLUE

      @ 435, 410 BUTTON Button_1 ;
         CAPTION "Maximize" ;
         ACTION Win1.Maximize

      @ 435, 280 BUTTON Button_2 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


FUNCTION Proc_Paint_on_the_Bitmap
   LOCAL hDC, BTstruct
   LOCAL hBitmap, aRGBcolor := { 153, 217, 234 }
   LOCAL nTypeText, nAlignText, nOrientation

   hBitmap := BT_BitmapCreateNew( 300, 200, aRGBcolor )

   hDC := BT_CreateDC( hBitmap, BT_HDC_BITMAP, @BTstruct )
     
   BT_DrawGradientFillVertical( hDC, 50, 50, 200, 100, aRGBcolor, BLACK )

   nTypeText    := BT_TEXT_OPAQUE + BT_TEXT_BOLD
   nAlignText   := BT_TEXT_LEFT + BT_TEXT_TOP
   nOrientation := BT_TEXT_NORMAL_ORIENTATION
   BT_DrawText( hDC, 90, 80, " The Power of OOHG ", "Times New Roman", 12, BLACK, WHITE, nTypeText, nAlignText, nOrientation )
     
   BT_DeleteDC( BTstruct )
RETURN hBitmap


PROCEDURE Proc_ON_RELEASE( hBitmap1, hBitmap2 )
   BT_BitmapRelease( hBitmap1 )
   BT_BitmapRelease( hBitmap2 )
RETURN


PROCEDURE Proc_ON_SIZE
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )

   Win1.Label_1.Value := "Client Area WIDTH " + STR( Width )
   Win1.Label_2.Value := "Client Area HEIGHT" + STR( Height )

   BT_ClientAreaInvalidateAll( "Win1", .F. )
RETURN


PROCEDURE Proc_ON_PAINT( hBitmap1, hBitmap2 )
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )
   LOCAL hDC, BTstruct, nTypeText, nAlignText, nOrientation

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )

   BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height, WHITE, BLACK )

   BT_DrawBitmap( hDC, 10, 10, 300, 200, BT_COPY, hBitmap1 )

   BT_DrawBitmapTransparent( hDC, 10, 500, 250, 150, BT_COPY, hBitmap1, Nil )

   BT_DrawBitmapTransparent( hDC, 350, 100, 250, 150, BT_SCALE, hBitmap2, Nil )

   BT_DrawBitmap( hDC, 350, 600, 250, 150, BT_SCALE, hBitmap2 )

   nTypeText    := BT_TEXT_OPAQUE + BT_TEXT_BOLD + BT_TEXT_ITALIC + BT_TEXT_UNDERLINE
   nAlignText   := BT_TEXT_CENTER + BT_TEXT_BASELINE
   nOrientation := 10
   BT_DrawText( hDC, 300, 400, " The Power of OOHG ", "Comic Sans MS", 42, WHITE, BLACK, nTypeText, nAlignText, nOrientation )

   BT_DeleteDC( BTstruct )
RETURN

/*
 * EOF
 */
