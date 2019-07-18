/*
 * Bos Taurus Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the ON PAINT and ON SIZE
 * events to fill the form's background with a color gradient
 * and show some text.
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
   LOCAL cont := 1

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 600 ;
      TITLE "Bos Taurus: DrawGradientFill and DrawText" ;
      MAIN ;
      ON PAINT Proc_ON_PAINT( cont ) ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      VIRTUAL WIDTH 700 ;
      VIRTUAL HEIGHT 700 ;
      NODWP

      DEFINE MAIN MENU
         DEFINE POPUP "File"
            MENUITEM "Exit" ACTION Win1.Release
         END POPUP
      END MENU

      @  50, 100 LABEL Label_1 ;
         VALUE " Label_1 ON PAINT Event Demo " ;
         AUTOSIZE

      @ 100, 100 LABEL Label_2 ;
         VALUE " Label_2 ON PAINT Event Demo " ;
         AUTOSIZE ;
         TRANSPARENT ;
         FONTCOLOR YELLOW

      @ 330, 300 BUTTON Button_1 ;
         CAPTION "Maximize" ;
         ACTION Win1.Maximize

      @ 330, 100 BUTTON Button_2 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      @ 400, 200 BUTTON Button_3 ;
         CAPTION "Change" ;
         ACTION {|| cont++, BT_ClientAreaInvalidateAll( "Win1" ) }

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Proc_ON_PAINT( cont )
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )
   LOCAL hDC, BTstruct
   LOCAL nTypeText, nAlignText

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
  
   IF cont > 6
      cont := 1
   ENDIF

   DO CASE
   CASE cont == 1
      BT_DrawGradientFillHorizontal( hDC, 0, 0, Width / 2, Height, BLACK, BLUE )
      BT_DrawGradientFillHorizontal( hDC, 0, Width / 2, Width / 2, Height, BLUE, BLACK )
   CASE cont == 2
      BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height / 2, BLACK, RED )
      BT_DrawGradientFillVertical( hDC, Height / 2, 0, Width, Height / 2, RED, BLACK )
   CASE cont == 3
      BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height / 2, RED, GREEN )
      BT_DrawGradientFillVertical( hDC, Height / 2, 0, Width, Height / 2, GREEN, BLUE )
   CASE cont == 4
      BT_DrawGradientFillHorizontal( hDC, 0, 0, Width / 2, Height, GREEN, BLUE )
      BT_DrawGradientFillHorizontal( hDC, 0, Width / 2, Width / 2, Height, BLUE, RED )
   CASE cont == 5
      BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height, WHITE, BLACK )
   CASE cont == 6
      BT_DrawGradientFillHorizontal( hDC, 0, 0, Width, Height, { 100, 0,123 }, BLACK )
   END CASE
    
   nTypeText  := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD + BT_TEXT_ITALIC + BT_TEXT_UNDERLINE
   nAlignText := BT_TEXT_CENTER + BT_TEXT_BASELINE
   BT_DrawText( hDC, Height / 2 - 3, Width / 2 + 3, "The Power of OOHG", "Comic Sans MS", 42, GRAY, BLACK, nTypeText, nAlignText )  // Shadow effect
   BT_DrawText( hDC, Height / 2, Width / 2, "The Power of OOHG", "Comic Sans MS", 42, YELLOW, BLACK, nTypeText, nAlignText )
   
   BT_DeleteDC( BTstruct )
RETURN

/*
 * EOF
 */
