/*
 * Bos Taurus Sample # 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use draw functions when
 * a statusbar is present.
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
   LOCAL oWin

   SET LANGUAGE TO SPANISH

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE "Bos Taurus: Draw Functions" ;
      MAIN ;
      ON PAINT Proc_ON_PAINT() ;
      ON SIZE  Proc_ON_SIZE() ;
      NODWP

      DEFINE MAIN MENU
         DEFINE POPUP "File"
            MENUITEM "Exit" ACTION Win1.Release
         END POPUP
      END MENU

      DEFINE STATUSBAR
         STATUSITEM "OOHG Power !!!"
         DATE
         CLOCK
      END STATUSBAR

      @ 30, 300 LABEL Label_1 ;
         VALUE "Client Area WIDTH " + STR( oWin:ClientWidth ) ;
         AUTOSIZE

      @ 80, 300 LABEL Label_2 ;
         VALUE "Client Area HEIGHT" + STR( oWin:ClientHeight + oWin:Statusbar:ClientHeightUsed ) ;
         AUTOSIZE ;
         TRANSPARENT ;
         FONTCOLOR BLACK

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


PROCEDURE Proc_ON_SIZE
   LOCAL Width  := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" ) - BT_StatusBarHeight( "Win1" )

   Win1.Label_1.Value := "Label_1: Client Area WIDTH " + STR( Width )
   Win1.Label_2.Value := "Label_2: Client Area HEIGHT" + STR( Height )

   BT_ClientAreaInvalidateAll( "Win1", .F. )
RETURN


PROCEDURE Proc_ON_PAINT    
   LOCAL Width  := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" ) - BT_StatusBarHeight( "Win1" )
   LOCAL hDC, BTstruct, cText, nTypeText, nAlignText

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )

   BT_DrawGradientFillVertical( hDC, 0, 0, Width, Height, { 100, 0, 33 }, BLACK )

   BT_DrawLine( hDC, 0, 0, Height, Width, ORANGE, 5 )
   BT_DrawLine( hDC, Height, 0, 0, Width, ORANGE, 5 )

   BT_DrawLine( hDC, 0, Width / 2, Height, Width / 2, ORANGE, 5 )
   BT_DrawLine( hDC, Height / 2, 0, Height / 2, Width, ORANGE, 5 )

   BT_DrawEllipse( hDC, 140, 200, 400, 230, WHITE, 5 )

   BT_DrawFillRectangle( hDC,  20, 250, 300, 100, ORANGE, RED, 3 )
   BT_DrawFillRoundRect( hDC, 400, 250, 300, 100, 10, 10, ORANGE, RED, 3 )
   BT_DrawFillEllipse( hDC, 180, 250, 300, 160, BLACK, BROWN, 2 )

   cText := "ABC ¡…Õ”⁄‹ ·ÈÌÛ˙¸ abcgjq"
   nTypeText  := BT_TEXT_OPAQUE + BT_TEXT_BOLD + BT_TEXT_UNDERLINE + BT_TEXT_ITALIC
   nAlignText := BT_TEXT_LEFT + BT_TEXT_TOP
   BT_DrawText( hDC, 230, 110, cText, "Comic Sans MS", 32, RED, { 228, 228, 228 }, nTypeText, nAlignText )

   BT_DrawRectangle( hDC, 220, 90, 610, 80, YELLOW, 1 )

   BT_DeleteDC( BTstruct )
RETURN

/*
 * EOF
 */
