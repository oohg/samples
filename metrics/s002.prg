/*
 * Windows Metrics Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to get the current system's fonts and
 * other metrics.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

#define MESSAGE_FONT   1
#define CAPTION_FONT   2
#define SMCAPTION_FONT 3
#define MENU_FONT      4
#define STATUS_FONT    5

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 520 ;
      NOSIZE ;
      NOMAXIMIZE ;
      FONT "Arial" ;
      SIZE 12 ;
      TITLE "System Fonts and Metrics"

      @ 10, 10 LABEL label_01 ;
         VALUE "Default Font: " + GetDefaultFontName() + ;
               LTrim( Str( GetDefaultFontSize() ) ) + ;
               " (Height: " + LTrim( Str( GetDefaultFontHeight() ) ) + ")"  + ;
               " - " + Str( GetScreenDPIX() ) ;
         AUTOSIZE
  
      // See https://technet.microsoft.com/en-us/library/cc951790.aspx
      aCaptionFont   := xGetSystemFont( CAPTION_FONT )
      aSmCaptionFont := xGetSystemFont( SMCAPTION_FONT )
      aMenuFont      := xGetSystemFont( MENU_FONT )
      aStatusFont    := xGetSystemFont( STATUS_FONT )
      aMessageFont   := xGetSystemFont( MESSAGE_FONT )

      @ 40,  10 LABEL label_04 ;
         VALUE "NonClientMetrics" BOLD AUTOSIZE
      @ 70,  10 LABEL label_05 ;
         VALUE "Caption Font: " + FontData(aCaptionFont) AUTOSIZE
      @ 100, 10 LABEL label_06 ;
         VALUE "Small Caption Font: " + FontData(aSmCaptionFont) AUTOSIZE
      @ 130, 10 LABEL label_07 ;
         VALUE "Menu Font: " + FontData(aMenuFont) AUTOSIZE
      @ 160, 10 LABEL label_08 ;
         VALUE "Status Font: " + FontData(aStatusFont) AUTOSIZE
      @ 190, 10 LABEL label_09 ;
         VALUE "Message Font: " + FontData(aMessageFont) AUTOSIZE

      aOthers := GetOtherMetrics()

      @ 220, 10 LABEL label_10 ;
         VALUE "Border Width: " + ltrim(str(aOthers[1])) AUTOSIZE
      @ 250, 10 LABEL label_11 ;
         VALUE "Scroll Width: " + ltrim(str(aOthers[2])) AUTOSIZE
      @ 280, 10 LABEL label_12 ;
         VALUE "Scroll Height: " + ltrim(str(aOthers[3])) AUTOSIZE
      @ 310, 10 LABEL label_13 ;
         VALUE "Caption Width: " + ltrim(str(aOthers[4])) AUTOSIZE
      @ 340, 10 LABEL label_14 ;
         VALUE "Caption Height: " + ltrim(str(aOthers[5])) AUTOSIZE
      @ 370, 10 LABEL label_15 ;
         VALUE "Small Caption Width: " + ltrim(str(aOthers[6])) AUTOSIZE
      @ 400, 10 LABEL label_16 ;
         VALUE "Small Caption Height: " + ltrim(str(aOthers[7])) AUTOSIZE
      @ 430, 10 LABEL label_17 ;
         VALUE "Menu Width: " + ltrim(str(aOthers[8])) AUTOSIZE
      @ 460, 10 LABEL label_18 ;
         VALUE "Menu Height: " + ltrim(str(aOthers[9])) AUTOSIZE

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION FontData( aFont )
   
RETURN ( aFont[1] + " " + ;
         Alltrim(str(aFont[2])) + " " + ;
         IF( aFont[3], "Bold ", "" ) + ;
         IF( aFont[4], "Italic ", "" ) + ;
         IF( aFont[5], "Underline ", "" ) + ;
         IF( aFont[6], "StrikeOut ", "" ) + ;
         "Charset: " + AllTrim( Str( aFont[7] ) ) )

//--------------------------------------------------------------------------
#pragma BEGINDUMP

#include "oohg.h"

HB_FUNC( GETSCREENDPIX )
{
	HDC  hDC;
	int cyp;

	memset ( &cyp, 0, sizeof ( cyp ) ) ;
	memset ( &hDC, 0, sizeof ( hDC ) ) ;

	hDC = GetDC ( HWND_DESKTOP ) ;

	cyp = GetDeviceCaps ( hDC, LOGPIXELSY ) ;

	ReleaseDC ( HWND_DESKTOP, hDC ) ;

  hb_retni( cyp);
}

HB_FUNC( GETDEFAULTFONTNAME )
{
LOGFONT lf;
GetObject( ( HFONT ) GetStockObject( DEFAULT_GUI_FONT ) , sizeof( LOGFONT ), &lf );
hb_retc( lf.lfFaceName );
}

HB_FUNC( GETDEFAULTFONTHEIGHT )
{
LOGFONT lf;
GetObject( ( HFONT ) GetStockObject( DEFAULT_GUI_FONT ) , sizeof( LOGFONT ), &lf );
hb_retni( lf.lfHeight );
}

HB_FUNC( GETDEFAULTFONTSIZE )
{
LOGFONT lf;
long PointSize ;
GetObject( ( HFONT ) GetStockObject( DEFAULT_GUI_FONT ) , sizeof( LOGFONT ), &lf );
PointSize = -MulDiv ( lf.lfHeight , 72 , GetDeviceCaps(GetDC(GetActiveWindow()), LOGPIXELSY) ) ;
hb_retnl( PointSize );
}

HB_FUNC( XGETSYSTEMFONT )
{
   NONCLIENTMETRICS ncm = {0};
	LONG PointSize;
	INT isBold;
   LOGFONT lf;
  
   ncm.cbSize = sizeof(ncm);

	if ( ! SystemParametersInfo(SPI_GETNONCLIENTMETRICS, sizeof(ncm), &ncm, 0) )
	{
		hb_reta( 7 );
		HB_STORC( "", -1, 1 );
		HB_STORNL3( 0, -1, 2 );
		HB_STORL( 0, -1, 3 );
		HB_STORL( 0, -1, 4 );
		HB_STORNL3( 0, -1, 5 );
		HB_STORL( 0, -1, 6 );
		HB_STORL( 0, -1, 7 );
		return;
	}

  switch( hb_parni(1) )
  {
    case 1:
      lf = ncm.lfMessageFont;
      break;
    case 2:
      lf = ncm.lfCaptionFont;
      break;
    case 3:
      lf = ncm.lfSmCaptionFont;
      break;
    case 4:
      lf = ncm.lfMenuFont;
      break;
    case 5:
      lf = ncm.lfStatusFont;
      break;
   }
  
   PointSize  = - MulDiv ( lf.lfHeight , 72 , GetDeviceCaps(GetDC(GetActiveWindow()), LOGPIXELSY) );
  
   if (lf.lfWeight == 700)
	{
		isBold = 1;
	}
	else
	{
		isBold = 0;
	}
	
   hb_reta( 7 );
	HB_STORC( lf.lfFaceName, -1, 1 );
	HB_STORNL3( PointSize, -1, 2 );
	HB_STORL( isBold, -1, 3 );
	HB_STORL( lf.lfItalic, -1, 4 );
	HB_STORL( lf.lfUnderline, -1, 5 );
	HB_STORL( lf.lfStrikeOut, -1, 6 );
	HB_STORNI( lf.lfCharSet, -1, 7 );

}

HB_FUNC( GETOTHERMETRICS )
{
  NONCLIENTMETRICS ncm = {0};
  
  ncm.cbSize = sizeof(ncm);

	if ( ! SystemParametersInfo(SPI_GETNONCLIENTMETRICS, sizeof(ncm), &ncm, 0) )
	{
		hb_reta( 9 );
		HB_STORNI( 0 , -1, 1 );
		HB_STORNI( 0 , -1, 2 );
		HB_STORNI( 0 , -1, 3 );
		HB_STORNI( 0 , -1, 4 );
		HB_STORNI( 0 , -1, 5 );
		HB_STORNI( 0 , -1, 6 );
		HB_STORNI( 0 , -1, 7 );
		HB_STORNI( 0 , -1, 8 );
		HB_STORNI( 0 , -1, 9 );
		return;
	}

  hb_reta( 9 );
	HB_STORNI( ncm.iBorderWidth , -1, 1 );
	HB_STORNI( ncm.iScrollWidth , -1, 2 );
	HB_STORNI( ncm.iScrollHeight , -1, 3 );
	HB_STORNI( ncm.iCaptionWidth , -1, 4 );
	HB_STORNI( ncm.iCaptionHeight , -1, 5 );
	HB_STORNI( ncm.iSmCaptionWidth , -1, 6 );
	HB_STORNI( ncm.iSmCaptionHeight , -1, 7 );
	HB_STORNI( ncm.iMenuWidth , -1, 8 );
	HB_STORNI( ncm.iMenuHeight , -1, 9 );

}
 
#pragma ENDDUMP

/*
 * EOF
 */
