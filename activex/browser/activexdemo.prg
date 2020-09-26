/*
 * ActiveX Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to instantiate an internet browser
 * using Shell.Explorer.2 ActiveX control.
 *
 * This sample is based on the works of Marcelo Torres
 * and Okcar Lira
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   PRIVATE WinDemo, oActiveX, lGreenLight := .F.

   // The compatibility key must be set before creating the ActiveX object
   CreateCompatibilityKey()

   DEFINE WINDOW WinDemo OBJ WinDemo ;
      AT 118,73 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE 'ooHG - ActiveX Support Sample' ;
      MAIN ;
      ON SIZE Adjust() ;
      ON MAXIMIZE Adjust() ;
      BACKCOLOR { 236, 233, 216 } ;
      FONT 'Verdana' ;
      SIZE 10 ;
      ON INIT ( Adjust(), oActiveX:navigate( WinDemo:txt_URL:value ) ) ;
      ON RELEASE DeleteCompatibilityKey()

      @ 560, 10 LABEL lbl_Semaphore ;
         VALUE " " ;
         WIDTH 25 ;
         HEIGHT 25 ;
         FONTCOLOR RED ;
         BACKCOLOR RED

      @ 560, 45 TEXTBOX txt_URL  ;
         HEIGHT 25 ;
         WIDTH 435 ;
         FONT 'Verdana' ;
         VALUE "https://oohg.github.io/" ;
         ON ENTER oActiveX:navigate( WinDemo:txt_URL:value )

      @ 560, 490 BUTTON btn_Navigate ;
         CAPTION 'Navigate' ;
         ACTION oActiveX:navigate( WinDemo:txt_URL:value ) ;
         WIDTH 100 ;
         HEIGHT 25 ;
         FONT 'Verdana'

      @  0, 0 ACTIVEX ActiveX WIDTH 800 HEIGHT 545 PROGID "Shell.Explorer.2" OBJ oActiveX
      oActiveX:EventMap( AX_SE2_TITLECHANGE, { |cTitle| WinDemo:Title := cTitle } )

      DEFINE TIMER tmr_Semaphore INTERVAL 1000 ACTION SwitchSemaphore()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW WinDemo
   ACTIVATE WINDOW WinDemo

RETURN NIL

PROCEDURE SwitchSemaphore()

   IF oActiveX:Busy()
      IF lGreenLight
         WinDemo:cursor := IDC_WAIT
         lGreenLight := .F.
         WinDemo:lbl_Semaphore:backcolor := RED
      ENDIF
   ELSE
      IF ! lGreenLight
         WinDemo:cursor := IDC_ARROW
         lGreenLight := .T.
         WinDemo:lbl_Semaphore:backcolor := GREEN
         WinDemo:txt_URL:value := oActiveX:LocationURL()
      ENDIF
   ENDIF

   RETURN

PROCEDURE Adjust()

   LOCAL nClientHeight := WinDemo:ClientHeight
   LOCAL nClientWidth  := WinDemo:ClientWidth

   WinDemo:lbl_Semaphore:row := ;
   WinDemo:txt_URL:row       := ;
   WinDemo:btn_Navigate:row  := nClientHeight - 40
   oActiveX:height           := nClientHeight - 55

   WinDemo:txt_URL:width     := nClientWidth - 165
   WinDemo:btn_Navigate:col  := nClientWidth - 110
   oActiveX:width            := nClientWidth

   RETURN

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
