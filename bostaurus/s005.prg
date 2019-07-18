/*
 * Bos Taurus Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to capture the desktop, how to
 * use AlphaBlend, Grayness and Brightness functions.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR hBitmap, Alpha, Flag_AlphaBlend_Effect

PROCEDURE MAIN

   PRIVATE hBitmap := 0
   PRIVATE Alpha := 150
   PRIVATE Flag_AlphaBlend_Effect := .T.

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      VIRTUAL WIDTH  BT_DesktopWidth() + 100 ;
      VIRTUAL HEIGHT BT_DesktopHeight() + 150 ;
      TITLE "Bos Taurus: CaptureDesktop, AlphaBlend, Grayness and Brightness" ;
      MAIN ;
      ON RELEASE BT_BitmapRelease( hBitmap ) ;
      ON PAINT Proc_ON_PAINT() ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      NODWP

      DEFINE MAIN MENU
         DEFINE POPUP "Alpha Blend"
            MENUITEM "Alpha   0 (min)" ACTION AlphaChange( 0 )
            MENUITEM "Alpha  50      " ACTION AlphaChange( 50 )
            MENUITEM "Alpha 150      " ACTION AlphaChange( 150 )
            MENUITEM "Alpha 200      " ACTION AlphaChange( 200 )
            MENUITEM "Alpha 255 (max)" ACTION AlphaChange( 255 )
         END POPUP
      END MENU

      @ 350, 180 BUTTON Button_1 ;
         CAPTION "Capture Desktop" ;
         WIDTH 120 ;
         ACTION CaptureDesktop()

      @ 350, 320 BUTTON Button_2 ;
         CAPTION "Save Capture" ;
         WIDTH 120 ;
         ACTION SaveDeskTop()

      @ 350, 460 BUTTON Button_3 ;
         CAPTION "Erase Capture" ;
         WIDTH 120 ;
         ACTION EraseCapture()

      @ 435, 320 BUTTON Button_4 ;
         CAPTION "Credits" ;
         WIDTH 120 ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Proc_ON_PAINT
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )
   LOCAL Col := - Win1.HscrollBar.value
   LOCAL Row := - Win1.VscrollBar.value
   LOCAL hDC, BTstruct, nTypeText, nAlignText

   hDC := BT_CreateDC ("Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct)

   IF Flag_AlphaBlend_Effect
      BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height, RED, BLACK )
       
      BT_DrawBitmapAlphaBlend( hDC, Row + 10, Col + 10, Nil, Nil, Alpha, BT_COPY, hBitmap )

      nTypeText  := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD + BT_TEXT_ITALIC + BT_TEXT_UNDERLINE
      nAlignText := BT_TEXT_CENTER + BT_TEXT_BASELINE
      BT_DrawText( hDC, Height / 2, Width / 2, "The Power of OOHG", "Comic Sans MS", 42, YELLOW, BLACK, nTypeText, nAlignText )
   ELSE
      BT_DrawBitmap( hDC, 0, 0, Width, Height, BT_COPY, hBitmap )
   ENDIF

   BT_DeleteDC( BTstruct )
RETURN


PROCEDURE AlphaChange( new_value )
   IF hBitmap == 0
      BT_DELAY_EXECUTION( 100 )    // Allow the system time to repaint the window after hiding the popup menu
      Grayness_effect_start()      // Capture and Grayness Client Area
      MsgInfo( "Error: No desktop capture" )
      Grayness_effect_end()        // Restore Client Area
   ELSE         
      Alpha := new_value
      BT_ClientAreaInvalidateAll( "Win1" )
   ENDIF
RETURN


PROCEDURE CaptureDesktop
   Win1.Hide
   BT_DELAY_EXECUTION( 300 )       // Allow the system time to repaint the desktop after hiding the window

   /*
    * All created bitmaps must be released to avoid memory leaks.
    */

   BT_BitmapRelease( hBitmap )
   hBitmap := BT_BitmapCaptureDesktop()
   Win1.Show     
   BT_ClientAreaInvalidateAll( "Win1" )
RETURN 


PROCEDURE SaveDesktop
   IF hBitmap == 0
      Grayness_effect_start()
      MsgInfo( "Error: No desktop capture" )
      Grayness_effect_end()
   ELSE         
      BT_BitmapSaveFile( hBitmap, "DESKTOP.BMP" )
      MsgInfo( "Capture save as file DESKTOP.BMP" )
      Alpha := 255
      BT_ClientAreaInvalidateAll( "Win1" )
   ENDIF
RETURN


PROCEDURE EraseCapture
   IF hBitmap == 0
      Grayness_effect_start()      // Capture, Grayness and Brightness Client Area
      MsgInfo( "Error: No desktop capture" )
      Grayness_effect_end()        // Restore Client Area
   ELSE
      BT_BitmapRelease( hBitmap )
      hBitmap := 0
      Alpha := 150
      BT_ClientAreaInvalidateAll( "Win1" )
   ENDIF
RETURN


PROCEDURE Grayness_effect_start
   BT_BitmapRelease( hBitmap )
   hBitmap := BT_BitmapCaptureClientArea( "Win1" )
   BT_BitmapGrayness( hBitmap, 100 )
   BT_BitmapBrightness( hBitmap, 50 )
   Flag_AlphaBlend_Effect := .F.
   BT_ClientAreaInvalidateAll( "Win1" )
RETURN


PROCEDURE Grayness_effect_end
   BT_BitmapRelease( hBitmap )
   hBitmap := 0   
   Flag_AlphaBlend_Effect := .T.
   BT_ClientAreaInvalidateAll( "Win1" )
RETURN

/*
 * EOF
 */
