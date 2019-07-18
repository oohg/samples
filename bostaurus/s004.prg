/*
 * Bos Taurus Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the ON PAINT and ON SIZE
 * events to place a wallpaper at the form's background.
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
   LOCAL Flag_Erase, hBitmap, hBitmap1, hBitmap2, nMode

   Flag_Erase := .F.
   hBitmap    := hBitmap1 := BT_BitmapLoadFile( "cowbook.bmp" )
   hBitmap2   := BT_BitmapLoadFile( "sami.jpg" )
   nMode      := BT_STRETCH

   /*
    * Because OOHG executes ON PAINT before executing ON INIT
    * the image must be loaded before the window's activation.
    *
    * All loaded bitmaps must be released to avoid memory leaks.
    */

   DEFINE WINDOW Win1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 630 ;
      TITLE "Bos Taurus: Wallpaper" ;
      MAIN ;
      ON PAINT Proc_ON_PAINT( nMode, Flag_Erase, hBitmap ) ;
      ON SIZE BT_ClientAreaInvalidateAll( "Win1", .F. ) ;
      ON RELEASE Proc_ON_RELEASE( hBitmap1, hBitmap2 ) ;
      VIRTUAL WIDTH 1100 ;
      VIRTUAL HEIGHT 1100 ;
      NODWP

      DEFINE MAIN MENU
         DEFINE POPUP "Automatic"
            MENUITEM "Automatic background change" ;
               ACTION {|| Win1.Flag_Automatic.Checked := ! Win1.Flag_Automatic.Checked } ;
               NAME Flag_Automatic ;
               CHECKED
         END POPUP
      END MENU
      Win1.Flag_Automatic.Checked := .F.

      DEFINE TAB Tab_1 ;
         AT 30, 10 ;
         WIDTH 400 ;
         HEIGHT 300 ;
         VALUE 1 ;
         FONT "ARIAL" SIZE 10

         PAGE "Page1"
            @  55, 90 LABEL Label_1 ;
               VALUE "This is Page 1" ;
               WIDTH 100 ;
               HEIGHT 27 ;
               TRANSPARENT

            @ 100, 10 EDITBOX ED_ctrl ;
               WIDTH 200 ;
               HEIGHT 100 ;
               VALUE "Hello HMG World" ;
               BACKCOLOR YELLOW ;
               FONTCOLOR BLUE
         END PAGE

         DEFINE PAGE "Page2"
            @ 55, 90 LABEL Label_2 ;
               VALUE "This is Page 2" ;
               WIDTH 100 ;
               HEIGHT 27
         END PAGE
      END TAB

      @ 10, 450 GRID Grid_1 ;
         WIDTH 300 ;
         HEIGHT 330 ;
         HEADERS { "Column 1", "Column 2", "Column 3" } ;
         WIDTHS { 140, 140, 140 } ;
         VIRTUAL ;
         ITEMCOUNT 30 ;
         ON QUERYDATA {|| This.QueryData := STR( This.QueryRowIndex ) + "," + STR( This.QueryColIndex ) }

      @ 350, 100 IMAGE Image_1 ;
         PICTURE "img1.bmp" ;
         WIDTH 160 ;
         HEIGHT 120 ;
         STRETCH

      @ 500, 50 BUTTON button_1 ;
         CAPTION "On/Off Image" ;
         ACTION  Win1.image_1.visible := ! Win1.image_1.visible

      @ 500, 200 BUTTON button_2 ;
         CAPTION "On/Off TAB" ;
         ACTION Win1.Tab_1.visible := ! Win1.Tab_1.visible

      @ 500, 350 BUTTON button_3 ;
         CAPTION "On/Off GRID" ;
         ACTION Win1.Grid_1.visible := ! Win1.Grid_1.visible

      @ 500, 500 BUTTON button_4 ;
         CAPTION "CHANGE" ;
         ACTION Background_Change( @hBitmap, hBitmap1, hBitmap2, nMode, @Flag_Erase )

      @ 500, 650 BUTTON button_5 ;
         CAPTION "ERASE" ;
         ACTION Background_Erase( @Flag_Erase )

      @ 400, 650 BUTTON button_6 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      DRAW LINE IN WINDOW Win1 ;
         AT 0, 400 TO 600, 400 ;
         PENCOLOR RED ;
         PENWIDTH 2

      DRAW LINE IN WINDOW Win1 ;
         AT 300, 0 TO 300, 800 ;
         PENCOLOR RED ;
         PENWIDTH 3

      DEFINE TIMER Timer_1 ;
         INTERVAL 2000 ;
         ACTION IF( Win1.Flag_Automatic.Checked, Background_Change( @hBitmap, hBitmap1, hBitmap2, nMode, @Flag_Erase ), Nil )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE Background_Change( hBitmap, hBitmap1, hBitmap2, nMode, Flag_Erase )
   STATIC Flag_Image := .T.

   IF Flag_Image
      Flag_Image := .F.
      hBitmap    := hBitmap2
      nMode      := BT_COPY
   ELSE
      Flag_Image := .T.
      hBitmap    := hBitmap1
      nMode      := BT_STRETCH
   ENDIF

   Flag_Erase := .F.
   BT_ClientAreaInvalidateAll( "Win1", .T. )
RETURN


PROCEDURE Background_Erase( Flag_Erase )
   Flag_Erase := .T.
   BT_ClientAreaInvalidateAll( "Win1", .T. )
RETURN


PROCEDURE Proc_ON_RELEASE( hBitmap1, hBitmap2 )
   BT_BitmapRelease( hBitmap1 )
   BT_BitmapRelease( hBitmap2 )
RETURN


PROCEDURE Proc_ON_PAINT( nMode, Flag_Erase, hBitmap )
   LOCAL Width := BT_ClientAreaWidth( "Win1" )
   LOCAL Height := BT_ClientAreaHeight( "Win1" )
   LOCAL Row, Col, Width1, Height1
   LOCAL hDC, BTstruct

   hDC := BT_CreateDC( "Win1", BT_HDC_INVALIDCLIENTAREA, @BTstruct )
  
   IF nMode == BT_COPY
      Row := - Win1.VscrollBar.value
      Col := - Win1.HscrollBar.value
      Width1 := 1000
      Height1 := 1000
   ELSE
      Row := 0
      Col := 0
      Width1 := Width
      Height1 := Height
   ENDIF

   IF ! Flag_Erase
      BT_DrawGradientFillHorizontal( hDC, 0, 0, Width, Height, RED, BLACK )
      BT_DrawBitmap( hDC, Row, Col, Width1, Height1, nMode, hBitmap )
   ENDIF

   BTstruct[ 1 ] := BT_HDC_ALLCLIENTAREA
   BT_DeleteDC( BTstruct )
RETURN

/*
 * EOF
 */
