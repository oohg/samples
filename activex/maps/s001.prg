/*
 * ActiveX Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display a map using an ACTIVEX
 * object to load Google's API.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

#ifndef __XHARBOUR__

#xtranslate CurDrive() + ':\' + CurDir() + '\' + 'temp.html' ;
      => ;
      hb_cwd() + 'temp.html'

#endif

/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION Main()

   LOCAL oForm, oActiveX, oLat, oLng, oAddr, oCity, oCntr

   // The compatibility key must be set before creating the ActiveX object
   CreateCompatibilityKey()

   DEFINE WINDOW Form OBJ oForm ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE "Show a Google Map" ;
      MAIN ;
      NOMAXIMIZE ;
      NOSIZE ;
      BACKCOLOR WHITE ;
      ON INIT ShowLocationByCoords( oActiveX, oLat:Value, oLng:Value ) ;
      ON RELEASE ( FErase( CurDrive() + ':\' + CurDir() + '\' + 'temp.html' ), DeleteCompatibilityKey() )

      @ 0, 0 ACTIVEX ActiveX OBJ oActiveX ;
         WIDTH 800 ;
         HEIGHT 490 ;
         PROGID "Shell.Explorer.2"

      @ 500, 10 LABEL lbl_Lat ;
         WIDTH 80 ;
         VALUE "Latitude:"

      @ 500, 90 TEXTBOX txt_Lat OBJ oLat ;
         WIDTH 100 ;
         INPUTMASK "9999.999999" ;
         NUMERIC ;
         VALUE -34.855202

      @ 500, 210 LABEL lbl_Lng ;
         WIDTH 80 ;
         VALUE "Longitude:"

      @ 500, 290 TEXTBOX txt_Lng OBJ oLng ;
         WIDTH 100 ;
         NUMERIC ;
         INPUTMASK "9999.999999" ;
         VALUE -56.194813

      @ 500, 640 BUTTON btn_SearchCoord ;
         WIDTH 150 ;
         ACTION ShowLocationByCoords( oActiveX, oLat:Value, oLng:Value ) ;
         CAPTION "Search By Coordinates"

      @ 530, 10 LABEL lbl_Address ;
         WIDTH 120 ;
         VALUE "Street and number:"

      @ 530, 130 TEXTBOX txt_Address OBJ oAddr ;
         WIDTH 300

      @ 530, 640 BUTTON btn_SearchAddr ;
         WIDTH 150 ;
         ACTION ShowLocationByAddress( oActiveX, oAddr:Value, oCity:Value, oCntr:Value ) ;
         CAPTION "Search By Address"

      @ 560, 10 LABEL lbl_City ;
         WIDTH 50 ;
         VALUE "City:"

      @ 560, 60 TEXTBOX txt_City OBJ oCity ;
         WIDTH 160

      @ 560, 240 LABEL lbl_Country ;
         WIDTH 70 ;
         VALUE "Country:"

      @ 560, 310 TEXTBOX txt_Country OBJ oCntr ;
         WIDTH 120

      @ 560, 640 BUTTON btn_Exit ;
         WIDTH 150 ;
         ACTION oForm:Release() ;
         CAPTION "Exit"

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

   RETURN NIL


/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION ShowLocationByCoords( oActiveX, nLat, nLng )

   LOCAL cHtml := MemoRead( "gmap2.html" )

   cHtml := StrTran( cHtml, "<<LAT>>", LTrim( Str( nLat ) ) )
   cHtml := StrTran( cHtml, "<<LNG>>", LTrim( Str( nLng ) ) )
   cHtml := StrTran( cHtml, "604px", LTrim( Str( oActiveX:Width - GETBORDERWIDTH() * 2 ) ) + "px" )
   cHtml := StrTran( cHtml, "408px", LTrim( Str( oActiveX:Height - 34 ) ) + "px" )

   MemoWrit( "temp.html", cHtml )

   oActiveX:Navigate( CurDrive() + ':\' + CurDir() + '\' + 'temp.html' )

   RETURN NIL


/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION ShowLocationByAddress( oActiveX, cAddress, cCity, cCountry )

   LOCAL cHtml := MemoRead( "gmap1.html" )

   cHtml := StrTran( cHtml, "<<STREET>>", AllTrim( cAddress ) )
   cHtml := StrTran( cHtml, "<<CITY>>", AllTrim( cCity ) )
   cHtml := StrTran( cHtml, "<<COUNTRY>>", AllTrim( cCountry ) )
   cHtml := StrTran( cHtml, "604px", LTrim( Str( oActiveX:Width ) ) + "px" )
   cHtml := StrTran( cHtml, "408px", LTrim( Str( oActiveX:Height ) ) + "px" )

   MemoWrit( "temp.html", cHtml )

   oActiveX:Navigate( CurDrive() + ':\' + CurDir() + '\' + 'temp.html' )

   RETURN NIL


#define cKey "Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE CreateCompatibilityKey( lEnableMsgs )

   LOCAL nVal

   ASSIGN lEnableMsgs VALUE lEnableMsgs TYPE "L" DEFAULT .F.

   IF IsRegistryKey( HKEY_CURRENT_USER, cKey )
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " already exists !" )
      ENDIF
   ELSE
      IF CreateRegistryKey( HKEY_CURRENT_USER, cKey )
         IF lEnableMsgs
            AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " was created !" )
         ENDIF
      ELSE
         IF lEnableMsgs
            AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " can't be created !" )
         ENDIF
      ENDIF
   ENDIF

   nVal := GetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 'N' )
   IF nVal == NIL
      IF SetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 11001, REG_DWORD )
         nVal := GetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 'N' )
         IF nVal == NIL
            IF lEnableMsgs
               AutoMsgBox( "Unable to read just created registry value !" )
            ENDIF
         ELSE
            IF lEnableMsgs
               AutoMsgBox( "Registry value was created !" + CRLF + "Value is: " + hb_ntos( nVal ) )
            ENDIF
         ENDIF
      ELSE
         IF lEnableMsgs
            AutoMsgBox( "Can't create registry value !" )
         ENDIF
      ENDIF
   ELSE
      IF lEnableMsgs
         AutoMsgBox( "Registry value is: " + hb_ntos( nVal ) )
      ENDIF
   ENDIF

   RETURN


/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE DeleteCompatibilityKey( lEnableMsgs )

   ASSIGN lEnableMsgs VALUE lEnableMsgs TYPE "L" DEFAULT .F.

   IF DeleteRegistryVar( HKEY_CURRENT_USER, cKey, App.FileName )
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " was deleted !" )
      ENDIF
   ELSE
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " can't be deleted !" )
      ENDIF
   ENDIF

   RETURN

/*
 * EOF
 */
