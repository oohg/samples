/*
 * Zebra Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create barcodes using Zebra library.
 *
 * Adapted from "HMG_Zebra" sample included in HMG Extended package.
 *
 * To build execute:
 *    BUILDAPP demo -ic:\oohg\hb32\contrib\hbzebra
 * or:
 *    COMPILE demo -ic:\oohg\hb32\contrib\hbzebra
 * or:
 *    BUILD.BAT
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"
#include "i_windefs.ch"
#include "hbzebra.ch"

MEMVAR aTypeItems
MEMVAR aValues
MEMVAR aBarColor
MEMVAR aBackColor

FUNCTION Main
   PRIVATE aTypeItems := { "EAN13", ;
                           "EAN8", ;
                           "UPCA", ;
                           "UPCE", ;
                           "CODE39", ;
                           "ITF", ;
                           "MSI", ;
                           "CODABAR", ;
                           "CODE93", ;
                           "CODE11", ;
                           "CODE128", ;
                           "PDF417", ;
                           "DATAMATRIX", ;
                           "QRCODE" }
   PRIVATE aValues := { "477012345678", ;
                        "1234567", ;
                        "01234567891", ;
                        "123456", ;
                        "ABC123", ;
                        "12345678901", ;
                        "1234", ;
                        "1234567", ;
                        "-1234", ;
                        "ABC-123", ;
                        "Code 128", ;
                        "Hello, World of Harbour! It's 2D barcode PDF417", ;
                        "Hello, World of Harbour! It's 2D barcode DataMatrix", ;
                        "https://harbour.github.io/" }
   PRIVATE aBarColor := { 0, 0, 0 }
   PRIVATE aBackColor := { 255, 255, 255 }

   SET DEFAULT ICON TO 'demo.ico'

   DEFINE WINDOW frm_barcode OBJ oWin ;
      AT 0, 0 ;
      WIDTH 450 HEIGHT 270 ;
      MAIN ;
      TITLE 'OOHG - BarCode Generator' ;
      NOMAXIMIZE NOSIZE ;
      NODWP

      DEFINE LABEL lbl_barcodetype
         ROW 10
         COL 10
         WIDTH 120
         VALUE 'Select Barcode Type'
      END LABEL

      DEFINE COMBOBOX cmb_type
         ROW 10
         COL 130
         WIDTH 100
         ITEMS aTypeItems
         ON CHANGE frm_barcode.txt_code.Value := aValues[ frm_barcode.cmb_type.Value ]
      END COMBOBOX

      DEFINE LABEL lbl_code
         ROW 40
         COL 10
         WIDTH 100
         VALUE 'Enter the Code'
      END LABEL

      DEFINE TEXTBOX txt_code
         ROW 40
         COL 130
         WIDTH 300
      END TEXTBOX

      DEFINE LABEL lbl_width
         ROW 70
         COL 10
         WIDTH 100
         VALUE 'Line Width'
      END LABEL

      DEFINE SPINNER spn_linewidth
         ROW 70
         COL 130
         WIDTH 100
         VALUE 2
         RIGHTALIGN .T.
         RANGEMIN 1
         RANGEMAX 200
      END SPINNER

      DEFINE LABEL lbl_height
         ROW 100
         COL 10
         WIDTH 100
         VALUE 'Barcode Height'
      END LABEL

      DEFINE SPINNER spn_lineheight
         ROW 100
         COL 130
         WIDTH 100
         VALUE 110
         RIGHTALIGN .T.
         INCREMENT 10
         RANGEMIN 10
         RANGEMAX 2000
      END SPINNER

      DEFINE LABEL lbl_barcolor
         ROW 130
         COL 10
         WIDTH 110
         VALUE 'Barcode Color'
         TOOLTIP 'Click to change color!'
         ACTION ChangeBarColor()
         VCENTERALIGN .T.
      END LABEL

      DEFINE LABEL lbl_backgroundcolor
         ROW 130
         COL 130
         WIDTH 100
         BACKCOLOR { 255, 255, 255 }
         VALUE 'Back Color'
         TOOLTIP 'Click to change color!'
         ACTION ChangeBackColor()
         CENTERALIGN .T.
         VCENTERALIGN .T.
         BORDER .T.
      END LABEL

      DEFINE CHECKBOX chk_showdigits
         ROW 160
         COL 10
         WIDTH 120
         CAPTION 'Display Code'
         VALUE .T.
      END CHECKBOX

      DEFINE CHECKBOX chk_checksum
         ROW 160
         COL 130
         WIDTH 120
         CAPTION 'Add Checksum'
         VALUE .T.
      END CHECKBOX

      DEFINE CHECKBOX chk_wide2_5
         ROW 190
         COL 10
         WIDTH 120
         CAPTION 'Wide 2.5'
         ONCHANGE IIF( This.Value, frm_barcode.chk_wide3.Value := .F., Nil )
      END CHECKBOX

      DEFINE CHECKBOX chk_wide3
         ROW 190
         COL 130
         WIDTH 120
         CAPTION 'Wide 3'
         ONCHANGE IIF( This.Value, frm_barcode.chk_wide2_5.Value := .F., Nil )
      END CHECKBOX

      DEFINE BUTTON btn_ok
         ROW 150
         COL 300
         WIDTH 90
         CAPTION 'Show Barcode'
         ACTION ShowBarcode()
         BOTTOM .T.
      END BUTTON

      DEFINE BUTTON btn_png
         ROW 190
         COL 300
         WIDTH 90
         CAPTION 'Save to PNG'
         ACTION SaveBarcodeToPNG()
      END BUTTON

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   frm_barcode.cmb_type.Value := 1
   frm_barcode.Center
   frm_barcode.Activate
RETURN Nil


FUNCTION ShowBarcode
   LOCAL hBitMap

   hBitMap := CreateBarCode( frm_barcode.txt_code.Value, ;
                             frm_barcode.cmb_type.Item( frm_barcode.cmb_type.Value ), ;
                             frm_barcode.spn_linewidth.Value, ;
                             frm_barcode.spn_lineheight.Value, ;
                             frm_barcode.chk_showdigits.Value, ;
                             '', ;
                             aBarColor, ;
                             aBackColor, ;
                             frm_barcode.chk_checksum.Value, ;
                             frm_barcode.chk_wide2_5.Value, ;
                             frm_barcode.chk_wide3.Value )
   IF hBitMap == 0
      RETURN Nil
   ENDIF

   IF OSisWinXPorLater()
      SET WINDOW frm_barcode TRANSPARENT TO 150
   ENDIF

   DEFINE WINDOW frm_showbarcode ;
      AT BT_DesktopHeight() / 2, BT_DesktopWidth() / 2 ;
      WIDTH  BT_BitmapWidth( hBitmap ) + 300 ;
      HEIGHT BT_BitmapHeight( hBitmap ) + 150 ;
      TITLE 'Display Bar Code' ;
      MODAL NOMAXIMIZE ;
      ON RELEASE {|| BT_BitmapRelease( hBitmap ), IIF( OSisWinXPorLater(), SET WINDOW frm_barcode TRANSPARENT TO OPAQUE, Nil ) }

      @ 10, 10 IMAGE img_barcode HBITMAP hBitmap
   END WINDOW

   FLASH WINDOW frm_showbarcode COUNT 5 INTERVAL 50

   ACTIVATE WINDOW frm_showbarcode
RETURN Nil


FUNCTION SaveBarcodeToPNG
   LOCAL cImageFileName

   cImageFileName := PutFile( { { "PNG Files", "*.png" } }, "Save Barcode to PNG File" )
   IF LEN( cImageFileName ) == 0
      RETURN Nil
   ENDIF
   IF FILE( cImageFileName )
      IF MsgYesNo( 'Image file already exists. Do you want to overwrite?', 'Confirmation' )
         FERASE( cImageFileName )
      ELSE
         RETURN Nil
      ENDIF
   ENDIF
   CreateBarcode( frm_barcode.txt_code.Value, ;
                  frm_barcode.cmb_type.Item( frm_barcode.cmb_type.Value ), ;
                  frm_barcode.spn_linewidth.Value, ;
                  frm_barcode.spn_lineheight.Value, ;
                  frm_barcode.chk_showdigits.Value, ;
                  cImageFileName, ;
                  aBarColor, ;
                  aBackColor, ;
                  frm_barcode.chk_checksum.Value, ;
                  frm_barcode.chk_wide2_5.Value, ;
                  frm_barcode.chk_wide3.Value )
   IF FILE( cImageFileName )
      EXECUTE FILE cImageFileName
   ENDIF
RETURN Nil


FUNCTION ChangeBarColor
   LOCAL aColor := GetColor( frm_barcode.lbl_barcolor.FontColor )

   IF VALTYPE( aColor[ 1 ] ) == 'N'
      frm_barcode.lbl_barcolor.FontColor := aColor
      aBarColor := aColor
   ENDIF
RETURN Nil
   

FUNCTION ChangeBackColor
   LOCAL aColor := GetColor( frm_barcode.lbl_backgroundcolor.BackColor )

   IF VALTYPE( aColor[ 1 ] ) == 'N'
      frm_barcode.lbl_backgroundcolor.BackColor := aColor
      aBackColor := aColor
   ENDIF
RETURN Nil


/*
  CreateBarcode() function can be used to create barcode image in PNG file format if cImageFileName parameter is included.
  If cImageFileName is omitted, the function returns the hBitMap handle of the barcode.
  Anyone of the following barcode types is allowed:
  { "EAN13", "EAN8", "UPCA", "UPCE", "CODE39", "ITF", "MSI", "CODABAR", "CODE93", "CODE11", "CODE128", "PDF417", "DATAMATRIX", "QRCODE" }
  The check digit will be generated by the library if omitted.
*/

FUNCTION CreateBarcode( cCode, cType, nLineWidth, nLineHeight, lShowDigits, cImageFileName, aBarColor, aBackColor, lCheckSum, lWide2_5, lWide3 )
   LOCAL hBitmap, cTextCode, nFlags

   DEFAULT nLineWidth := 2
   DEFAULT nLineHeight := 100
   DEFAULT aBarColor := BLACK
   DEFAULT aBackColor := WHITE
   DEFAULT lCheckSum := .F.
   DEFAULT lWide2_5 := .F.
   DEFAULT lWide3 := .F.
   DEFAULT lShowDigits := .F.
   DEFAULT cImageFileName := ''

   nFlags := 0
   IF lChecksum
      nFlags := nFlags + HB_ZEBRA_FLAG_CHECKSUM
   ENDIF
   IF lWide2_5
      nFlags := nFlags + HB_ZEBRA_FLAG_WIDE2_5
   ENDIF
   IF lWide3
      nFlags := nFlags + HB_ZEBRA_FLAG_WIDE3
   ENDIF

   IF nFlags == 0
      nFlags := Nil
   ENDIF

   cTextCode := ""
   hBitmap := Zebra_CreateBitmapBarcode( aBarColor, aBackColor, nLineWidth, nLineHeight, cType, cCode, nFlags, lShowDigits, @cTextCode )

   IF hBitmap == 0
      RETURN hBitmap
   ENDIF

   IF LEN( cImageFileName ) <> 0
      BT_BitmapSaveFile( hBitmap, cImageFileName, BT_FILEFORMAT_PNG )
      BT_BitmapRelease( hBitmap )
      RETURN 1
   ENDIF
RETURN hBitmap


FUNCTION Zebra_CreateBitmapBarcode( aBarColor, aBackColor, nLineWidth, nLineHeight, cType, cCode, nFlags, lShowDigits, cTextCode )
   LOCAL hBitmap := 0, hZebra
   LOCAL hDC, BTstruct, nFontSize
   LOCAL nSizeWidth, nSizeHeight
   LOCAL cFont := 'Arial'

   SWITCH cType
   CASE "EAN13"      ; hZebra := hb_zebra_create_ean13( cCode, nFlags )      ;                                                      EXIT
   CASE "EAN8"       ; hZebra := hb_zebra_create_ean8( cCode, nFlags )       ;                                                      EXIT
   CASE "UPCA"       ; hZebra := hb_zebra_create_upca( cCode, nFlags )       ;                                                      EXIT
   CASE "UPCE"       ; hZebra := hb_zebra_create_upce( cCode, nFlags )       ;                                                      EXIT
   CASE "CODE39"     ; hZebra := hb_zebra_create_code39( cCode, nFlags )     ;                                                      EXIT
   CASE "ITF"        ; hZebra := hb_zebra_create_itf( cCode, nFlags )        ;                                                      EXIT
   CASE "MSI"        ; hZebra := hb_zebra_create_msi( cCode, nFlags )        ;                                                      EXIT
   CASE "CODABAR"    ; hZebra := hb_zebra_create_codabar( cCode, nFlags )    ;                                                      EXIT
   CASE "CODE93"     ; hZebra := hb_zebra_create_code93( cCode, nFlags )     ;                                                      EXIT
   CASE "CODE11"     ; hZebra := hb_zebra_create_code11( cCode, nFlags )     ;                                                      EXIT
   CASE "CODE128"    ; hZebra := hb_zebra_create_code128( cCode, nFlags )    ;                                                      EXIT
   CASE "PDF417"     ; hZebra := hb_zebra_create_pdf417( cCode, nFlags )     ; nLineHeight := nLineWidth * 3 ; lShowDigits := .F. ; EXIT
   CASE "DATAMATRIX" ; hZebra := hb_zebra_create_datamatrix( cCode, nFlags ) ; nLineHeight := nLineWidth     ; lShowDigits := .F. ; EXIT
   CASE "QRCODE"     ; hZebra := hb_zebra_create_qrcode( cCode, nFlags )     ; nLineHeight := nLineWidth     ; lShowDigits := .F. ; EXIT
   ENDSWITCH

   IF hZebra != Nil
      IF hb_zebra_geterror( hZebra ) == 0
         cTextCode   := hb_zebra_getcode( hZebra )
         nSizeWidth  := Zebra_GetWidth( hZebra, nLineWidth, nLineHeight, Nil )
         nSizeHeight := Zebra_GetHeight( hZebra, nLineWidth, nLineHeight, Nil ) + IIF( lShowDigits, ( nLineWidth * 10 ) + 20, 0 )
         hBitmap     := BT_BitmapCreateNew( nSizeWidth, nSizeHeight, aBackColor )
         hDC         := BT_CreateDC( hBitmap, BT_HDC_BITMAP, @BTstruct )
         Zebra_Draw( hZebra, hDC, aBarColor, 0, 0, nLineWidth, nLineHeight, Nil )
         IF lShowDigits
            nFontSize := ( ( nSizeWidth / LEN( cTextCode ) ) / 96 * 72 * 1 )
            BT_DrawText( hDC, nSizeHeight - ( ( nLineWidth * 10 ) + 20 ) + 5, nSizeWidth / 2, cTextCode, cFont, nFontSize, aBarColor, aBackColor, Nil, BT_TEXT_CENTER )
         ENDIF
         BT_DeleteDC( BTstruct )
      ELSE
         MsgInfo( "Type " + cType + CRLF + "Code " + cCode + CRLF + "Error  " + LTRIM( HB_VALTOSTR( hb_zebra_geterror( hZebra ) ) ) )
      ENDIF
      hb_zebra_destroy( hZebra )
   ELSE
      MsgStop( "Invalid barcode type !", cType )
   ENDIF
RETURN hBitmap


FUNCTION Zebra_Draw( hZebra, hDC, aBarColor, nRow, nCol, nLineWidth, nLineHeight, iFlags )
   IF hb_zebra_GetError( hZebra ) != 0
      RETURN HB_ZEBRA_ERROR_INVALIDZEBRA
   ENDIF
//     hb_zebra_draw( hZebra, bCodeBlock,                                                          dX,   dY,   dWidth,     dHeight,     iFlags )
RETURN hb_zebra_draw( hZebra, { |x, y, w, h| BT_DrawFillRectangle( hDC, y, x, w, h, aBarColor ) }, nCol, nRow, nLineWidth, nLineHeight, iFlags )


FUNCTION Zebra_GetWidth( hZebra, nLineWidth, nLineHeight, iFlags )
   LOCAL x1 := 0, y1 := 0, nBarWidth := 0, nBarHeight := 0

   // always --> nBarHeight = nLineHeight
   IF hb_zebra_GetError( hZebra ) != 0
      RETURN HB_ZEBRA_ERROR_INVALIDZEBRA
   ENDIF
// hb_zebra_draw( hZebra, bCodeBlock,                                                         dX, dY, dWidth,     dHeight,     iFlags )
   hb_zebra_draw( hZebra, { |x, y, w, h| nBarWidth := x + w - x1, nBarHeight := y + h - y1 }, x1, y1, nLineWidth, nLineHeight, iFlags )
RETURN nBarWidth


FUNCTION Zebra_GetHeight( hZebra, nLineWidth, nLineHeight, iFlags )
   LOCAL x1 := 0, y1 := 0, nBarWidth := 0, nBarHeight := 0

   // always --> nBarHeight = nLineHeight
   IF hb_zebra_GetError( hZebra ) != 0
      RETURN HB_ZEBRA_ERROR_INVALIDZEBRA
   ENDIF
// hb_zebra_draw( hZebra, bCodeBlock,                                                          dX, dY, dWidth,     dHeight,     iFlags )
   hb_zebra_draw( hZebra, { |x, y, w, h | nBarWidth := x + w - x1, nBarHeight := y + h - y1 }, x1, y1, nLineWidth, nLineHeight, iFlags )
RETURN nBarHeight

/*
 * EOF
 */
