/*
 * Bos Taurus Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to put an image into the clipboard,
 * how to get an image from the clipboard and how to monitor
 * the content of the clipboard.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR hBitmap, Image_Width, Image_Height

PROCEDURE MAIN

   /*
    * Because OOHG executes ON PAINT before executing ON INIT
    * the image must be loaded before the window's activation.
    *
    * All loaded bitmaps must be released to avoid memory leaks.
    */

   PRIVATE hBitmap      := BT_BitmapLoadFile( "sami.jpg" )
   PRIVATE Image_Width  := BT_BitmapWidth( hBitmap )
   PRIVATE Image_Height := BT_BitmapWidth( hBitmap )

   IF BT_BitmapClipboardPut( "Win1", hBitmap )
      MsgInfo( "Put Bitmap in the Clipboard: OK" )
   ELSE
      MsgInfo( "Put Bitmap in the Clipboard: FAILED" )
   ENDIF

   /*
    * When you see this message, you can paste the content
    * of the clipboard (sami.jpg image) into any program
    * that handles image pasting.
    */

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 700 ;
      HEIGHT 600 ;
      TITLE "Bos Taurus: Clipboard Monitor" ;
      MAIN ;
      ON RELEASE BT_BitmapRelease( hBitmap ) ;
      ON PAINT Proc_ON_PAINT() ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      NODWP

      @ 200, 200 EDITBOX EditBox_1 ;
         WIDTH 250 ;
         HEIGHT 100 ;
         VALUE "Copy an image to the clipboard with Microsoft Paint or another graphic tool." ;
         BOLD ;
         BACKCOLOR ORANGE ;
         NOHSCROLL

      @ 400, 280 BUTTON Button_1 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      DEFINE TIMER Timer1 ;
         INTERVAL 300 ;
         ACTION Proc_Get_Clipboard_Timer()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Proc_ON_PAINT
   LOCAL Width := BT_ClientAreaWidth( "Win1" ) - 40
   LOCAL Height := BT_ClientAreaHeight( "Win1" ) - 40
   LOCAL hDC, BTstruct

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   BT_DrawGradientFillVertical( hDC, 0, 0, BT_ClientAreaWidth( "Win1" ), BT_ClientAreaHeight( "Win1" ), WHITE, BLACK )
   IF Image_Width > Width .OR. Image_Height > Height
      BT_DrawBitmap( hDC, 20, 20, Width, Height, BT_SCALE, hBitmap )
   ELSE
      BT_DrawBitmap( hDC, 20, 20, Width, Height, BT_COPY, hBitmap )
   ENDIF  
   BT_DeleteDC( BTstruct )
RETURN


PROCEDURE Proc_Get_Clipboard_Timer
   LOCAL hBitmap_aux

   IF ! BT_BitmapClipboardIsEmpty()
      hBitmap_aux := BT_BitmapClipboardGet( "Win1" )
      IF hBitmap_aux <> 0
         BT_BitmapClipboardClean( "Win1" )
         BT_BitmapRelease( hBitmap )
         hBitmap := hBitmap_aux
         Image_Width  := BT_BitmapWidth( hBitmap )
         Image_Height := BT_BitmapHeight( hBitmap )
         BT_ClientAreaInvalidateAll( "Win1", .T. )
      ENDIF
   ENDIF
RETURN

/*
 * EOF
 */
