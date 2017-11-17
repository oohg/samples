/*
 * Bos Taurus Sample n° 8
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use different functions to draw
 * on a bitmap, and how to use the resulting bitmap to
 * paint the window's background.
 *
 * Based on a sample from Bos Taurus library for HMG
 * created by Dr. CLAUDIO SOTO (from Uruguay) <srvet@adinet.com.uy>
 * <http://srvet.blogspot.com.uy/>
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 *
 * You can download cowbook.bmp and bostaurus_logo.bmp from:
 * https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/BosTaurus
 */

#include "oohg.ch"
#include "bostaurus.ch"

PROCEDURE MAIN
   LOCAL aRows := { {"Simpson",   "Homer",     "555-5555"}, ;
                    {"Mulder",    "Fox",       "324-6432"}, ;
                    {"Smart",     "Max",       "432-5892"}, ;
                    {"Grillo",    "Pepe",      "894-2332"}, ;
                    {"Kirk",      "James",     "346-9873"}, ;
                    {"Barriga",   "Carlos",    "394-9654"}, ;
                    {"Flanders",  "Ned",       "435-3211"}, ;
                    {"Smith",     "John",      "123-1234"}, ;
                    {"Pedemonti", "Flavio",    "000-0000"}, ;
                    {"Gomez",     "Juan",      "583-4832"}, ;
                    {"Fernandez", "Raul",      "321-4332"}, ;
                    {"Borges",    "Javier",    "326-9430"}, ;
                    {"Alvarez",   "Alberto",   "543-7898"}, ;
                    {"Gonzalez",  "Ambo",      "437-8473"}, ;
                    {"Vinazzi",   "Amigo",     "394-5983"}, ;
                    {"Pedemonti", "Flavio",    "534-7984"}, ;
                    {"Samarbide", "Armando",   "854-7873"}, ;
                    {"Pradon",    "Alejandra", "???-????"} }
   LOCAL hBitmap, hBitmap_aux, hDC, BTstruct
   LOCAL nTypeText, nAlignText, nOrientation, oAct

   /*
    * Because OOHG executes ON PAINT before executing ON INIT
    * the image must be loaded before the window's activation.
    *
    * All loaded bitmaps must be released to avoid memory leaks.
    */

   hBitmap := BT_BitmapCreateNew( 800, 600 )

   hDC := BT_CreateDC( hBitmap, BT_HDC_BITMAP, @BTstruct )

   BT_DrawGradientFillVertical( hDC, 0, 0, 800, 600, { 245, 245, 245 }, BLACK )

   nTypeText    := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD
   nAlignText   := BT_TEXT_LEFT + BT_TEXT_TOP
   nOrientation := BT_TEXT_NORMAL_ORIENTATION
   BT_DrawText( hDC, 20, 50, "My Application - ver. 1.0", "Times New Roman", 24, ORANGE, WHITE, nTypeText, nAlignText, nOrientation )

   nAlignText   := BT_TEXT_CENTER + BT_TEXT_TOP
   BT_DrawText( hDC, 515, 350, "Copyright your programmer with the help of the Graphics Library Bos Taurus", "Book Antiqua", 12, ORANGE, WHITE, nTypeText, nAlignText, nOrientation )

   nAlignText   := BT_TEXT_LEFT + BT_TEXT_TOP
   nOrientation := BT_TEXT_DIAGONAL_ASCENDANT
   BT_DrawText( hDC, 450, 50, "The Power of OOHG", "Book Antiqua", 50, { 20, 20, 20 }, WHITE, nTypeText, nAlignText, nOrientation )

   BT_DrawRectangle( hDC, 10, 5, 680, 550, GRAY, 3 )

   BT_DeleteDC( BTstruct )

   hBitmap_aux := BT_BitmapLoadFile( "bostaurus_logo.bmp" )
   BT_BitmapPaste( hBitmap, 20, 500, 132, 132, BT_SCALE, hBitmap_aux )
   BT_BitmapRelease( hBitmap_aux )

   DEFINE WINDOW Win1 ;
      AT 0, 0 ;
      WIDTH 700 ;
      HEIGHT 600 ;
      TITLE "Bos Taurus: Draw in BITMAP" ;
      NOSIZE ;
      NOMAXIMIZE ;
      MAIN ;
      ON RELEASE BT_BitmapRelease( hBitmap ) ;
      ON PAINT Proc_ON_PAINT( hBitmap )

      DEFINE TAB Tab_1 ;
         AT 100, 50 ;
         WIDTH 400 ;
         HEIGHT 300 ;
         ON CHANGE Win1.RadioGroup_1.Value := Win1.Tab_1.Value

         DEFINE PAGE "Image"
            @ 30, 80 IMAGE Image_1 ;
               PICTURE "cowbook.bmp" ;
               WIDTH 256 ;
               HEIGHT 256
         END PAGE

         DEFINE PAGE "Grid"
            @ 40, 30 GRID Grid_1 ;
               WIDTH 350 ;
               HEIGHT 220 ;
               HEADERS { "Last Name", "First Name", "Phone" } ;
               WIDTHS { 140, 140, 140 } ;
               ITEMS aRows ;
               VALUE { 1, 1 } ;
               EDIT ;
               JUSTIFY { GRID_JTFY_CENTER, GRID_JTFY_RIGHT, GRID_JTFY_RIGHT } ;
               NAVIGATEBYCELL
         END PAGE

         DEFINE PAGE "EditBox"
            @ 50, 50 EDITBOX EditBox_1 ;
               WIDTH 300 ;
               HEIGHT 120 ;
               VALUE "Write your memories here." + CRLF + CRLF ;
               BOLD ;
               BACKCOLOR ORANGE
         END PAGE

         DEFINE PAGE "ActiveX"
            DEFINE ACTIVEX ActiveX_1
               OBJECT oAct
               ROW 60
               COL 40
               WIDTH 320
               HEIGHT 200
               PROGID "ShockwaveFlash.ShockwaveFlash.9"
            END ACTIVEX
            Win1.ActiveX_1.Object:Movie := "http://www.youtube.com/v/58CZcCvwND4&hl=en&fs=1"
         END PAGE
      END TAB

      @ 450, 200 BUTTON Button_1 ;
         CAPTION "On/Off" ;
         ACTION OnOff( oAct )

      @ 450, 400 BUTTON Button_2 ;
         CAPTION "Credits" ;
         ACTION MsgInfo( BT_InfoName() + Space(3) + BT_InfoVersion() + CRLF + BT_InfoAuthor(), "Info" )

      @ 230, 500 RADIOGROUP RadioGroup_1 ;
         OPTIONS { "Image", "Grid", "EditBox", "ActiveX" } ;
         VALUE 1 ;
         TRANSPARENT ;
         ON CHANGE Win1.Tab_1.Value := Win1.RadioGroup_1.Value

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win1
   ACTIVATE WINDOW Win1
RETURN


PROCEDURE OnOff( oAct )
   Win1.Tab_1.Visible := ! Win1.Tab_1.Visible
   Win1.RadioGroup_1.Visible := Win1.Tab_1.Visible
   oAct:SetFocus()
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
   BT_DrawBitmap( hDC, 0, 0, 800, 600, BT_COPY, hBitmap )
   BT_DeleteDC( BTstruct )
RETURN

/*
 * EOF
 */
