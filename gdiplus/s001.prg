/*
 * GDIPlus Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use GDI+ library to load
 * and save bmp, jpeg, gif, tiff and png images.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download the images used in this sample from:
 * https://github.com/oohg/samples/tree/master/GDIPlus
 */

#include "oohg.ch"

#define HBITMAP_WIDTH     1
#define HBITMAP_HEIGHT    2
#define HBITMAP_BITSPIXEL 3

MEMVAR cPicture, cType, aSize, aMimeType, oImage, oForm, i

PROCEDURE Main()
   PUBLIC cPicture, cType, aSize, aMimeType, oImage, oForm, i

   SetOneArrayItemPerLine( .T. )

   IF ! gPlusInit()
      MsgStop( "Init GDI+ Error", "Error" )
      RETURN
   ENDIF

   aMimeType := gPlusGetEncoders()
   /*
    * Default types:
    * image/bmp
    * image/jpeg
    * image/gif
    * image/tiff
    * image/png
    */

   DEFINE WINDOW Form_Main OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'GDI+: Save Bitmap To File' ;
      MAIN ;
      NOMAXIMIZE ;
      NOSIZE ;
      ON RELEASE IIF( gPlusDeInit(), ;
                      NIL, ;
                      MsgExclamation( "Exit GDI+ Error", "Error" ) )

      DEFINE MAIN MENU
         DEFINE POPUP "&File"
            FOR i := 1 TO Len( aMimeType )
               IF "jpeg" $ aMimeType[i]
                  MENUITEM 'Save as JPEG' NAME mnu_JPEG DISABLED ;
                     ACTION SaveToFile( oImage:HBitMap, ;
                                        "new.jpeg", ;
                                        aSize[HBITMAP_WIDTH], ;
                                        aSize[HBITMAP_HEIGHT], ;
                                        "image/jpeg", ;
                                        100 )
               ENDIF
               IF "gif" $ aMimeType[i]
                  MENUITEM 'Save as GIF' NAME mnu_GIF DISABLED ;
                     ACTION SaveToFile( oImage:HBitMap, ;
                                        "new.gif", ;
                                        aSize[HBITMAP_WIDTH], ;
                                        aSize[HBITMAP_HEIGHT], ;
                                        "image/gif", ;
                                        100 )
               ENDIF
               IF "tiff" $ aMimeType[i]
                  MENUITEM 'Save as TIFF' NAME mnu_TIFF DISABLED ;
                     ACTION SaveToFile( oImage:HBitMap, ;
                                        "new.tiff", ;
                                        aSize[HBITMAP_WIDTH], ;
                                        aSize[HBITMAP_HEIGHT], ;
                                        "image/tiff", ;
                                        100 )
               ENDIF
               IF "png" $ aMimeType[i]
                  MENUITEM 'Save as PNG' NAME mnu_PNG DISABLED ;
                     ACTION SaveToFile( oImage:HBitMap, ;
                                        "new.png", ;
                                        aSize[HBITMAP_WIDTH], ;
                                        aSize[HBITMAP_HEIGHT], ;
                                        "image/png", ;
                                        100 )
               ENDIF
               IF "bmp" $ aMimeType[i]
                  MENUITEM 'Save as BMP' NAME mnu_BMP DISABLED ;
                     ACTION SaveToFile( oImage:HBitMap, ;
                                        "new.bmp", ;
                                        aSize[HBITMAP_WIDTH], ;
                                        aSize[HBITMAP_HEIGHT], ;
                                        "image/bmp", ;
                                        100 )
               ENDIF
            NEXT
            SEPARATOR
            MENUITEM "E&xit" ACTION ThisWindow.Release
         END POPUP
         DEFINE POPUP "&?"
            MENUITEM 'Get number of image encoders' ;
               ACTION MsgInfo( "Number of image encoders: " + ;
                                  LTrim( Str( gPlusGetEncodersNum() ) ), ;
                               "Info" )
            SEPARATOR
            MENUITEM "Image Info" NAME mnu_INFO DISABLED ;
               ACTION AutoMsgInfo( { "Name: " + hb_OSNewLine() + ;
                                        cPicture, ;
                                     "Width: " + hb_OSNewLine() + ;
                                        LTrim( Str( aSize[HBITMAP_WIDTH] ) ), ;
                                     "Height: " + hb_OSNewLine() + ;
                                        LTrim( Str( aSize[HBITMAP_HEIGHT] ) ), ;
                                     "Bits per Pixel: " + hb_OSNewLine() + ;
                                        LTrim( Str( aSize[HBITMAP_BITSPIXEL] ) ) }, ;
                                   "Image Info" )
            MENUITEM '"rainbow.jpg" Info' ;
               ACTION GetImageInfo( GetStartupFolder() + "\rainbow.jpg" )
            MENUITEM '"fondo.jpg" Info' ;
               ACTION GetImageInfo( GetStartupFolder() + "\fondo.jpg" )
            MENUITEM '"ohh.png" Info' ;
               ACTION GetImageInfo( GetStartupFolder() + "\ohh.png" )
         END POPUP
      END MENU

      @ 05, 20 LABEL lbl_Type ;
         VALUE "Type:" ;
         WIDTH 50 ;
         HEIGHT 24

      @ 05, 70 COMBOBOX cmb_Type ;
         WIDTH 150 ;
         ITEMS {'bmp','jpeg','gif','tiff','png','emf'} ;
         VALUE 0 ;
         ON CHANGE LoadImage( Form_Main.cmb_Type.Value )

      @ 05, 240 LABEL lbl_Image ;
         VALUE "Image loaded: <none>" ;
         WIDTH 350 ;
         HEIGHT 24

      @ 40, 20 IMAGE Image_1 OBJ oImage ;
         IMAGESIZE

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_Main
   ACTIVATE WINDOW Form_Main
RETURN

FUNCTION LoadImage( i )
   cType          := {'bmp','jpeg','gif','tiff','png','emf'}[i]
   cPicture       := "demo." + cType
   aSize          := _OOHG_SizeOfBitmapFromFile( cPicture )
   oImage:Picture := cPicture

   oForm:lbl_Image:Value  := "Image loaded: " + cPicture
   oForm:mnu_BMP:Enabled  := ( i # 1 )
   oForm:mnu_JPEG:Enabled := ( i # 2 )
   oForm:mnu_GIF:Enabled  := ( i # 3 )
   oForm:mnu_TIFF:Enabled := ( i # 4 )
   oForm:mnu_PNG:Enabled  := ( i # 5 )
   oForm:mnu_INFO:Enabled := .T.
RETURN NIL

FUNCTION GetImageInfo( cFile )
   LOCAL nImage, nWidth, nHeight

   nImage  := gPlusLoadImageFromFile( cFile )
   nWidth  := gPlusGetImageWidth( nImage )
   nHeight := gPlusGetImageHeight( nImage )

   AutoMsgInfo( { "Name: " + hb_OSNewLine() + cFile, ;
                  "Width: "  + hb_OSNewLine() + LTrim( Str( nWidth ) ), ;
                  "Height: " + hb_OSNewLine() + LTrim( Str( nHeight ) ) }, ;
                "Image Info" )
RETURN NIL

FUNCTION SaveToFile( hBitMap, cFile, nWidth, nHeight, cMimeType, nQuality )
   LOCAL lRet := gPlusSaveHBitmapToFile( hBitMap, ;
                                         cFile, ;
                                         nWidth, ;
                                         nHeight, ;
                                         cMimeType, ;
                                         nQuality, ;
                                         24 )
RETURN MsgInfo( IIF( lRet, "Saved to " + cFile, "Failure" ), "Result" )

/*
 * EOF
 */
