/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002-05 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
 *
 * eztw32.dll is public domain from
 * http://www.dosadi.com/eztwain1.htm
 *
 * Twerp 1.9  27 July 1998 by Spike <spike@dosadi.com>
 *
 * Copyright 2005 Walter Formigoni <walter.formigoni@uol.com.br>
 *
 * Copyright 2005-2006 Grigory Filatov <gfilatov@inbox.ru>
 *
 * Modified for OOHG October 2007 <bruno.luciani@gmail.com>
*/

#include "minigui.ch"

#define CLR_DARK_BLUE {0, 0, 128}

#define TWAIN_BW      0x0001   // 1-bit per pixel, B&W   (== TWPT_BW)
#define TWAIN_GRAY      0x0002   // 1,4, or 8-bit grayscale   (== TWPT_GRAY)
#define TWAIN_RGB      0x0004   // 24-bit RGB color      (== TWPT_RGB)
#define TWAIN_PALETTE      0x0008   // 1,4, or 8-bit palette   (== TWPT_PALETTE)
#define TWAIN_ANYTYPE      0x0000   // any of the above

Static hWnd, hpal, hdib, wPixTypes := TWAIN_ANYTYPE, fHideUI := 0

Procedure Main

   SET MULTIPLE OFF

   DEFINE WINDOW Win_1 ;
         AT 0,0 ;
         WIDTH 500 ;
         HEIGHT 350 ;
         TITLE 'Twerp - EZTwain sample app by Spike' ;
         ICON 'twerp.ico' ;
         MAIN ;
         ON INIT hWnd := GetFormHandle ('Win_1') ;
         ON RELEASE DiscardImage() ;
         ON PAINT OnPaint() ;
         BACKCOLOR CLR_DARK_BLUE

      ////  oWnd:=GetFormObject( "win_1" )

      DEFINE MAIN MENU
         DEFINE POPUP '&File'
            menuitem '&Select Source...' action TWAIN_SelectImageSource( hWnd )
            menuitem '&Acquire...'  action Acquire()
            menuitem 'Acquire to &File...'  action AcquireToFilename()
            menuitem 'Acquire to &Clipboard...' action AcquireToClipboard()
            menuitem 'Save A&s...' action SaveAs() NAME TW_APP_SAVEAS
            menuitem '&Open...' action OnOpen()
            separator
            menuitem 'E&xit' action ThisWindow.Release
         END POPUP
         DEFINE POPUP '&Options'
            MENUITEM "&All PixelTypes" action SetTypes() NAME TW_APP_ANYPIX CHECKED
            MENUITEM "&B&&W" action SetTypes() NAME TW_APP_BW
            MENUITEM "&Grayscale" action SetTypes() NAME TW_APP_GRAYSCALE
            MENUITEM "&RGB Color" action SetTypes() NAME TW_APP_RGB
            MENUITEM "&Palette Color" action SetTypes() NAME TW_APP_PALETTE
            SEPARATOR
            MENUITEM "&Show Source UI" action SetTypes() NAME TW_APP_SHOWUI CHECKED
            MENUITEM "&Hide Source UI" action SetTypes() NAME TW_APP_HIDEUI
         END POPUP
         DEFINE POPUP '&Help'
            menuitem '&About Twerp...' action ;
               MsgInfo ( "OOHG Sample Application for EZTwain" + CRLF + ;
               "Based upon a contribution by Walter Formigoni" + CRLF + ;
               "Written by Grigory Filatov (April, 2005)" + CRLF + CRLF + ;
               "Modified for OOHG - Bruno Luciani (October, 2007)" + CRLF + CRLF + ;
               "EZTwain Dll reports version " + Ltrim(Str(TWAIN_EasyVersion() / 100)) + CRLF + ;
               "TWAIN Services: " + IIf(EMPTY(TWAIN_IsAvailable()), "Not Available", "Available"), "About Twerp" )
         END POPUP
      END MENU

   END WINDOW

   Win_1.TW_APP_SAVEAS.Enabled := .F.

   CENTER WINDOW Win_1

   ACTIVATE WINDOW Win_1

   Return

*************************************
Function Acquire()

   // free up current image and palette if any
   DiscardImage()
   *   InvalidateRect( _HMG_MainHandle, 1 )

   TWAIN_SetHideUI(fHideUI)

   //   if TWAIN_OpenDefaultSource() > 0
   hdib = TWAIN_AcquireNative(hWnd, wPixTypes)
   if !EMPTY(hdib)
      // compute or guess a palette to use for display
      hpal = TWAIN_CreateDibPalette(hdib)

      // size the window to just contain the image
      ResizeWindow()
   endif
   //   else
   //      MsgStop( "Unable to open default Data Source.", "Error" )
   //   endif

   return nil
**********

*************************************
Function AcquireToFilename()
   Local nResult := 1
   Local cFilename := Putfile( { {'Windows Bitmaps (*.bmp)', '*.bmp'}, {'Jpg Files (*.jpg)', '*.jpg'}  }, , ;
      , @nResult )

   if !EMPTY(cFilename)
      *      cFilename := cFilePath(cFilename) + "\" + cFileNoExt(cFilename) + ".bmp"   GetMyDocumentsFolder()

      // free up current image and palette if any
      DiscardImage()
      *      InvalidateRect( _HMG_MainHandle, 1 )

      if TWAIN_AcquireToFilename( hWnd, cFilename ) == 0
         hdib = TWAIN_LoadNativeFromFilename( cFilename )
         if !EMPTY(hdib)
            // compute or guess a palette to use for display
            hpal = TWAIN_CreateDibPalette(hdib)

            // size the window to just contain the image
            ResizeWindow()

            if nResult == 2
               Bmp2Jpg( cFilename, cFileNoExt(cFilename) + ".jpg" )
               Ferase( cFilename )
            endif
         endif
      else
         MsgStop( "No image was acquired or transfer to the file failed.", "Error", , .f. )
      endif
   endif

   return nil
**********

**********************************
function AcquireToClipboard()

   if TWAIN_AcquireToClipboard( hWnd, TWAIN_ANYTYPE) == 0
      MsgStop( "No image was acquired or transfer to the clipboard failed.", "Error", , .f. )
   else
      MsgInfo( "The image was transfered to the clipboard.", "Twerp", , .f. )
   endif

   return nil
**********

*************************************
Function OnPaint()
   Local x := GetDesktopRectWidth(), y := GetDesktopRectHeight()
   Local pps, hDC, w, h

   // force repaint of window
   *   InvalidateRect( _HMG_MainHandle, 1 )

   pps := DefinePaintStru()
   hDC := BeginPaint(hWnd, pps )

   if valtype(hpal) == 'N'
      SetPalette(hDC, hpal)
   endif
   if valtype(hdib) == 'N'
      w := TWAIN_DibWidth(hdib)
      h := TWAIN_DibHeight(hdib)

      // wait cursor (hourglass)
      CursorWait()
      SetCursorPos(x / 2, y / 2)

      TWAIN_DrawDibToDC(hDC, 0, 0, w, h, hdib, 0, 0)

      // delay emulation for power PC
      InKey(.1)
      CursorArrow()

      Win_1.TW_APP_SAVEAS.Enabled := .T.
   endif

   EndPaint( hWnd, pps )

return nil
**********

*************************************
Function OnOpen()

   // free up current image and palette if any
   DiscardImage()
   *   InvalidateRect( _HMG_MainHandle, 1 )

   hdib = TWAIN_LoadNativeFromFilename(0)
   if !EMPTY(hdib)
      // compute or guess a palette to use for display
      hpal = TWAIN_CreateDibPalette(hdib)

      // size the window to just contain the image
      ResizeWindow()
   endif

   return nil
**********

****************
Function SaveAs()
   Local nResult := 1, aExt := { "bmp" , "jpg" }
   Local cFilename := Putfile( { {'Windows Bitmaps (*.bmp)', '*.bmp'}, {'Jpg Files (*.jpg)', '*.jpg'}  }, , ;
      , @nResult )

   if !Empty( cFilename )
      cFilename := IF( RAT( ".", cFilename ) == 4, cFilename, cFilename + "." + aExt[nResult] )
      if nResult == 1
         nResult := TWAIN_WriteNativeToFilename(hdib, cFilename)
         //   -1   user cancelled File Save dialog
         //   -2   could not create or open file for writing
         //   -3   (weird) unable to access DIB
         //   -4   writing to .BMP failed, maybe output device is full?
         if nResult < -1
            MsgStop( "Error writing DIB to file - is there room for the image?", "Error" )
         endif
      else
         Save2Jpg( hWnd, cFilename, TWAIN_DibWidth(hdib), TWAIN_DibHeight(hdib) )
      endif
   endif

   return nil
**********

****************
Function SetTypes()
   Local cItem := This.name, cCurrentType

   if !"UI" $ cItem
      do case
      case wPixTypes = TWAIN_BW
         cCurrentType := "TW_APP_BW"
      case wPixTypes = TWAIN_GRAY
         cCurrentType := "TW_APP_GRAYSCALE"
      case wPixTypes = TWAIN_RGB
         cCurrentType := "TW_APP_RGB"
      case wPixTypes = TWAIN_PALETTE
         cCurrentType := "TW_APP_PALETTE"
      case wPixTypes = TWAIN_ANYTYPE
         cCurrentType := "TW_APP_ANYPIX"
      endcase
      //      Win_1.&cCurrentType.Checked := .F.
      SetProperty("Win_1", cCurrentType, "Checked", .F.)
   endif

   do case
   case cItem == "TW_APP_BW"
      wPixTypes := TWAIN_BW
   case cItem == "TW_APP_GRAYSCALE"
      wPixTypes := TWAIN_GRAY
   case cItem == "TW_APP_RGB"
      wPixTypes := TWAIN_RGB
   case cItem == "TW_APP_PALETTE"
      wPixTypes := TWAIN_PALETTE
   case cItem == "TW_APP_ANYPIX"
      wPixTypes := TWAIN_ANYTYPE
   case cItem == "TW_APP_SHOWUI"
      fHideUI = 0
      Win_1.TW_APP_HIDEUI.Checked := .F.
   case cItem == "TW_APP_HIDEUI"
      fHideUI = 1
      Win_1.TW_APP_SHOWUI.Checked := .F.
   endcase
   //   Win_1.&cItem.Checked := .T.
   SetProperty("Win_1", cItem, "Checked", .T.)

   return nil
**********

****************
Procedure ResizeWindow()
   Local w := GetDesktopRectWidth(), h := GetDesktopRectHeight()

   Win_1.Hide

   Win_1.Width := Max( Min( w, TWAIN_DibWidth(hdib) + 2 * GetBorderWidth() ), GetMinWidth(hWnd) )
   Win_1.Height := Min( h, TWAIN_DibHeight(hdib) + GetTitleHeight() + 2 * GetBorderHeight() + GetMenuBarHeight() )

   if GetProperty( "Win_1", "Width" ) >= w .OR. GetProperty( "Win_1", "Height" ) >= h
      Win_1.Row := 0
      Win_1.Col := 0
   else
      Win_1.Center
   endif

   Win_1.Show

   return
**********

*************************************
Function DiscardImage()
   // delete/free global palette, and dib, as necessary.
   if hpal # NIL
      DeleteObject(hpal)
      hpal = NIL
   endif
   if hdib # NIL
      TWAIN_FreeNative(hdib)
      hdib = NIL
      Win_1.TW_APP_SAVEAS.Enabled := .F.
   endif

   return nil
**********

*------------------------------------------------------------------------------*
DECLARE DLL_TYPE_VOID SaveToJpgEx(DLL_TYPE_LONG hWnd, DLL_TYPE_LPCSTR cFileName, ;
   DLL_TYPE_INT nWidth, DLL_TYPE_INT nHeight) IN JPG.DLL ALIAS SAVE2JPG

DECLARE DLL_TYPE_VOID BmpToJpg(DLL_TYPE_LPCSTR BmpFile, DLL_TYPE_LPCSTR JpgFile) IN JPG.DLL ALIAS BMP2JPG
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
* EZTwain wrappers for (x)Harbour
*
* Copyright 2005 Walter Formigoni <walter.formigoni@uol.com.br>
*
* Copyright 2005 Grigory Filatov <gfilatov@inbox.ru>
*------------------------------------------------------------------------------*
declare DLL_TYPE_INT TWAIN_IsAvailable() in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_SelectImageSource( DLL_TYPE_HWND hWnd ) in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_AcquireToFilename( DLL_TYPE_HWND hWnd, DLL_TYPE_LPCSTR lpString ) in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_AcquireToClipboard( DLL_TYPE_HWND hwndApp, DLL_TYPE_LONG wPixTypes ) in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_EasyVersion() in EZTW32.DLL

//declare DLL_TYPE_INT TWAIN_OpenDefaultSource() in EZTW32.DLL

declare DLL_TYPE_HANDLE TWAIN_AcquireNative( DLL_TYPE_HWND hWnd, DLL_TYPE_LONG wPixTypes ) in EZTW32.DLL

declare DLL_TYPE_HANDLE TWAIN_LoadNativeFromFilename( DLL_TYPE_LPCSTR pszFile ) in EZTW32.DLL
declare DLL_TYPE_VOID TWAIN_FreeNative( DLL_TYPE_HANDLE hdib ) in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_WriteNativeToFilename( DLL_TYPE_HANDLE hdib, DLL_TYPE_LPCSTR pszFile ) in EZTW32.DLL

declare DLL_TYPE_HANDLE TWAIN_CreateDibPalette( DLL_TYPE_HANDLE hdib ) in EZTW32.DLL

declare DLL_TYPE_INT TWAIN_DibWidth( DLL_TYPE_HANDLE hdib ) in EZTW32.DLL
declare DLL_TYPE_INT TWAIN_DibHeight( DLL_TYPE_HANDLE hdib ) in EZTW32.DLL

declare DLL_TYPE_VOID TWAIN_DrawDibToDC(DLL_TYPE_HDC hDC, ;
   DLL_TYPE_INT dx, DLL_TYPE_INT dy, DLL_TYPE_INT w, DLL_TYPE_INT h, ;
   DLL_TYPE_HANDLE hdib, DLL_TYPE_INT sx, DLL_TYPE_INT sy) in EZTW32.DLL

declare DLL_TYPE_VOID TWAIN_SetHideUI( DLL_TYPE_INT fHide ) in EZTW32.DLL
*------------------------------------------------------------------------------*

#pragma BEGINDUMP

#define HB_OS_WIN_32_USED
#define _WIN32_WINNT   0x0400
#include <windows.h>
#include "hbapi.h"
#include "hbapiitm.h"

HB_FUNC( GETDESKTOPRECTWIDTH )
{
   RECT rect;
   SystemParametersInfo( SPI_GETWORKAREA, 0, &rect, 0 );
   hb_retni(rect.right - rect.left);
}

HB_FUNC( GETDESKTOPRECTHEIGHT )
{
   RECT rect;
   SystemParametersInfo( SPI_GETWORKAREA, 0, &rect, 0 );
   hb_retni(rect.bottom - rect.top);
}

HB_FUNC( SETPALETTE )
{
   HDC hDC = (HDC) hb_parnl(1);
   HPALETTE hPal = (HPALETTE) hb_parnl(2);

   SelectPalette (hDC, hPal, FALSE);
   RealizePalette (hDC);
}

HB_FUNC( DEFINEPAINTSTRU )
{
   PAINTSTRUCT *pps = (PAINTSTRUCT*) hb_xgrab( sizeof( PAINTSTRUCT ) );
   hb_retnl( (LONG) pps );
}

HB_FUNC( BEGINPAINT )
{
   PAINTSTRUCT *pps = (PAINTSTRUCT*) hb_parnl( 2 );
   HDC hDC = BeginPaint( (HWND) hb_parnl( 1 ), pps );
   hb_retnl( (LONG) hDC );
}

HB_FUNC( ENDPAINT )
{
   PAINTSTRUCT *pps = (PAINTSTRUCT*) hb_parnl( 2 );
   EndPaint( (HWND) hb_parnl( 1 ), pps );
   hb_xfree( pps );
}

HB_FUNC( GETMINWIDTH )
{
   HWND  hwnd = (HWND) hb_parnl(1);
   HDC   hDC = GetDC(hwnd);
   int   xMin;
   if (hDC) {
      xMin = LOWORD(GetTabbedTextExtent(hDC, "Twerp - EZTwain sample app by Spike", 36, 0, NULL));
      ReleaseDC(hwnd, hDC);
      hb_retni(xMin);
    }
}

#pragma ENDDUMP

