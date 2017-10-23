/*
* Bos Taurus Sample n� 1
* Author: Fernando Yurisich <fernando.yurisich@gmail.com>
* Licensed under The Code Project Open License (CPOL) 1.02
* See <http://www.codeproject.com/info/cpol10.aspx>
*
* This sample shows how to use the ON PAINT event to fill the
* form's background with a color gradient and show an image.
*
* Based on a sample from Bos Taurus library for HMG
* created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
* <http://srvet.blogspot.com>
*
* Visit us at https://github.com/fyurisich/OOHG_Samples or at
* http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
*
* You can download bostaurus_logo.jpg from:
* https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/BosTaurus
*/

#include "oohg.ch"
#include "bostaurus.ch"

PROCEDURE MAIN
   LOCAL hBitmap := BT_BitmapLoadFile( "bostaurus_logo.jpg" )

   /*
   * Because OOHG executes ON PAINT before executing ON INIT
   * the image must be loaded before the window's activation.
   *
   * All loaded bitmaps must be released to avoid memory leaks.
   */

   DEFINE WINDOW Win1 ;
         AT 0, 0 ;
         WIDTH 700 ;
         HEIGHT 600 ;
         TITLE "Bos Taurus: Prototype Demo";
         MAIN;
         ON RELEASE BT_BitmapRelease( hBitmap ) ;
         ON PAINT Proc_ON_PAINT( hBitmap ) ;
         ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. )

      @ 500, 280 BUTTON Button_1 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
   RETURN

PROCEDURE Proc_ON_PAINT( hBitmap )
   LOCAL hDC, BTstruct

   /*
   * Since OOHG executes the default window procedure at the start of
   * the function that process WM_PAINT message, thus validating the
   * update region before calling the ON PAINT codeblock, we need to
   * invalidate the whole client area to force the correct painting
   * of all the controls.
   */

   BT_ClientAreaInvalidateAll( "Win1", .F. )

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   BT_DrawGradientFillVertical( hDC, 0, 0, BT_ClientAreaWidth( "Win1" ), BT_ClientAreaHeight( "Win1" ), WHITE, BLACK )
   BT_DrawBitmap( hDC, 30, 150, 400, 400, BT_COPY, hBitmap )
   BT_DeleteDC( BTstruct )
   RETURN

/*
* EOF
*/

