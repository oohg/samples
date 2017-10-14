#include "oohg.ch"

DECLARE DLL_TYPE_LONG TWAIN_IsAvailable()                                                        IN eztw32.dll ALIAS TWAIN_IsAvailable
DECLARE DLL_TYPE_LONG TWAIN_SelectImageSource( DLL_TYPE_HWND hWnd )                              IN eztw32.dll ALIAS TWAIN_SelectImageSource
DECLARE DLL_TYPE_INT  TWAIN_AcquireToFilename( DLL_TYPE_HWND hWnd, DLL_TYPE_LPCSTR lpString )    IN eztw32.dll ALIAS TWAIN_AcquireToFilename
DECLARE DLL_TYPE_LONG TWAIN_AcquireToClipboard( DLL_TYPE_LONG hwndApp, DLL_TYPE_LONG wPixTypes ) IN eztw32.dll ALIAS TWAIN_AcquireToClipboard
DECLARE DLL_TYPE_LONG TWAIN_EasyVersion()                                                        IN eztw32.dll ALIAS TWAIN_EasyVersion

FUNCTION Main

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE 'Scanner or WebCam Capture using EZTwain free library' ;
      MAIN

      DEFINE MAIN MENU
         MENUITEM 'Test' ACTION Acquire()
      END MENU

      @ 20, 20 IMAGE Image_1 ;
         PICTURE 'ZZZ_AAAOOHG' ;
         WIDTH 560 ;
         HEIGHT 560

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN Nil

FUNCTION Acquire
   LOCAL cFileName := "Image_" + DToS( Date () ) + "_" + StrTran( Time(), ":", "" ) + ".bmp"

   TWAIN_AcquireToFilename( Win_1.hWnd, cFileName )
   Win_1.Image_1.Picture := cFileName

RETURN Nil

/*
 * EOF
 */
