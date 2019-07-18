/*
 * Bos Taurus Sample # 9
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use DC to DC drawing
 * to copy the content of one window to another.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR flag

PROCEDURE MAIN

   PRIVATE flag := .F.

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 200, 600 ;
      WIDTH 500 ;
      HEIGHT 400 ;
      TITLE  "Bos Taurus: Draw DC to DC" ;
      NOMINIMIZE ;
      ON SIZE {|| flag := .F., BT_ClientAreaInvalidateAll( "Win2", .T. ) } ;
      ON MAXIMIZE {|| flag := .F., BT_ClientAreaInvalidateAll( "Win2", .T. ) } ;
      MAIN ;
      ON PAINT Proc_ON_PAINT() ;
      NODWP

      DEFINE TAB Tab_1 ;
         AT 50, 50 ;
         WIDTH 400 ;
         HEIGHT 200
           
         DEFINE PAGE "EditBox"
            @ 50, 50 EDITBOX EditBox_1 ;
               WIDTH 300 ;
               HEIGHT 120 ;
               VALUE "Write your memories here." + CRLF + CRLF ;
               BOLD ;
               BACKCOLOR ORANGE
         END PAGE
           
         DEFINE PAGE "Image"
            @ 40, 120 IMAGE Image_1 ;
               PICTURE "cowbook.bmp" ;
               WIDTH 128 ;
               HEIGHT 128
         END PAGE
      END TAB
       
      @ 300, 180 BUTTON Button_1 CAPTION "Click" ACTION MsgInfo( "Hello" )

      DEFINE TIMER Timer1 INTERVAL 200 ACTION Proc_Mirror()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   DEFINE WINDOW Win2 ;
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 400 ;
      TITLE "Mirror of Win1's Client Area" ;
      NOSYSMENU ;
      CHILD ;
      ON INIT Win1.EditBox_1.SetFocus()
   END WINDOW

   ACTIVATE WINDOW Win1, Win2

   RETURN


PROCEDURE Proc_ON_PAINT    
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )
   LOCAL hDC, BTstruct

   hDC = BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height, WHITE, BLACK )
   BT_DeleteDC( BTstruct )

   RETURN


PROCEDURE Proc_Mirror
   LOCAL Width1, Height1
   LOCAL Width2, Height2
   LOCAL hDC1, BTstruct1
   LOCAL hDC2, BTstruct2
   LOCAL nTypeText, nAlignText, nOrientation

   IF flag
      RETURN
   ENDIF
   
   flag := .T.

   Width1  := BT_ClientAreaWidth( "Win1" )
   Height1 := BT_ClientAreaHeight( "Win1" )
   Width2  := BT_ClientAreaWidth( "Win2" )
   Height2 := BT_ClientAreaHeight( "Win2" )

   hDC1 := BT_CreateDC( "Win1", BT_HDC_ALLCLIENTAREA, @BTstruct1 )
   hDC2 := BT_CreateDC( "Win2", BT_HDC_ALLCLIENTAREA, @BTstruct2 )

   BT_DrawDCtoDC( hDC2, 0, 0, Width2, Height2, BT_SCALE, hDC1, 0, 0, Width1, Height1 )
// BT_DrawDCtoDCAlphaBlend( hDC2, 0, 0, Width2, Height2, 50, BT_SCALE, hDC1, 0, 0, Width1, Height1 )
                    
   nTypeText    := BT_TEXT_TRANSPARENT
   nAlignText   := BT_TEXT_LEFT + BT_TEXT_TOP
   nOrientation := BT_TEXT_DIAGONAL_ASCENDANT
   BT_DrawText( hDC2, 300, 50, "Mirror of Win1", "Times", 42, YELLOW, BLACK, nTypeText, nAlignText, nOrientation )

   BT_DeleteDC( BTstruct1 )
   BT_DeleteDC( BTstruct2 )
   BT_ClientAreaInvalidateAll( "Win2" )

   flag := .F.

   RETURN

/*
 * EOF
 */
