/*
 * Bos Taurus Sample # 11
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a logo and how to save
 * it to disk.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR hBitmap

PROCEDURE MAIN

   PRIVATE hBitmap := Proc_Create_Logo()

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 400 ;
      TITLE "Bos Taurus: Create Logo" ;
      MAIN ;
      ON RELEASE BT_BitmapRelease( hBitmap ) ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      ON PAINT Proc_ON_PAINT() ;
      NODWP

      @ 200, 190 LABEL Label1 ;
         VALUE "Save Image as ..." ;
         FONT "Times New Roman" ;
         SIZE 14 ;
         BOLD ;
         AUTOSIZE

      @ 250, 100 BUTTON Button1 ;
         CAPTION "BMP" ;
         ACTION Proc_Save_Image( 1 )

      @ 250, 210 BUTTON Button2 ;
         CAPTION "JPG" ;
         ACTION Proc_Save_Image( 2 )

      @ 250, 320 BUTTON Button3 ;
         CAPTION "GIF" ;
         ACTION Proc_Save_Image( 3 )

      @ 300, 150 BUTTON Button4 ;
         CAPTION "TIF" ;
         ACTION Proc_Save_Image( 4 )

      @ 300, 260 BUTTON Button5 ;
         CAPTION "PNG" ;
         ACTION Proc_Save_Image( 5 )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Proc_ON_PAINT
   LOCAL hDC, BTstruct

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   BT_DrawBitmap( hDC, 30, 180, 300, 200, BT_COPY, hBitmap )
   BT_DeleteDC( BTstruct )
RETURN


PROCEDURE Proc_Save_Image( nAction )
   LOCAL Ret, Button

   DO CASE       
   CASE nAction == 1
      Ret := BT_BitmapSaveFile( hBitmap, "LOGO_BMP.BMP", BT_FILEFORMAT_BMP )
   CASE nAction == 2
      Ret := BT_BitmapSaveFile( hBitmap, "LOGO_JPG.JPG", BT_FILEFORMAT_JPG )
   CASE nAction == 3
      Ret := BT_BitmapSaveFile( hBitmap, "LOGO_GIF.GIF", BT_FILEFORMAT_GIF )
   CASE nAction == 4
      Ret := BT_BitmapSaveFile( hBitmap, "LOGO_TIF.TIF", BT_FILEFORMAT_TIF )
   CASE nAction == 5
      Ret := BT_BitmapSaveFile( hBitmap, "LOGO_PNG.PNG", BT_FILEFORMAT_PNG )
   ENDCASE
   
   IF Ret
      Button := "Button" + ALLTRIM( STR( nAction ) )
      SetProperty( "Win1", Button, "Enabled", .F. )
   ENDIF

   MsgInfo( "Save Image: " + IF( Ret, "OK", "FAIL" ) )
RETURN


FUNCTION Proc_Create_Logo
   LOCAL hDC, BTstruct, hBitmap, hBitmap_aux
   LOCAL nTypeText, nAlignText, nOrientation
   LOCAL aRGBcolor := { 153, 217, 234 }

   // Create bitmap in memory
   hBitmap := BT_BitmapCreateNew( 150, 100, aRGBcolor )

   // Create hDC to a bitmap
   hDC := BT_CreateDC( hBitmap, BT_HDC_BITMAP, @BTstruct )
     
   // Paint Gradient
   BT_DrawGradientFillVertical( hDC, 0, 0, 150, 100, aRGBcolor, BLACK )

   // Draw Text
   nTypeText    := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD
   nAlignText   := BT_TEXT_LEFT + BT_TEXT_TOP
   nOrientation := BT_TEXT_NORMAL_ORIENTATION
   BT_DrawText( hDC, 10, 20, "OOHG Casino", "Times New Roman", 14, BLACK, WHITE, nTypeText, nAlignText, nOrientation )

   // Draw Rectangle
   BT_DrawRectangle( hDC, 5, 5, 140, 90, BLUE, 2 )

   // Paste image
   hBitmap_aux := BT_BitmapLoadFile( "img.png" )
   BT_DrawBitmapTransparent( hDC, 30, 30, 100, 100, BT_SCALE, hBitmap_aux, Nil )
   BT_BitmapRelease( hBitmap_aux )
  
  // Release hDC bitmap  
  BT_DeleteDC( BTstruct )
RETURN hBitmap

/*
 * EOF
 */
