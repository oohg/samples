/*
 * RichEditBox Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how replace the dot from the
 * numeric pad with a comma.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW MAIN ;
     TITLE "OOHG - Replace key in RichEditBox" ;
     WIDTH 400 HEIGHT 400 CLIENTAREA ;
     OBJ oMain

     @ 20, 20 RICHEDITBOX rch_Edit SUBCLASS MyRichEditBox ;
       OBJ oRich ;
       WIDTH oMain:ClientWidth - 40 ;
       HEIGHT oMain:ClientHeight - 40 ;
       FONT "Courier New" VERSION 41

    ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oMain:Center()
   oMain:Activate()

   RETURN Nil

#include "hbclass.ch"
#include "i_windefs.ch"

CLASS MyRichEditBox FROM TEditRich

   DATA lIgnoreKey INIT .F.
   METHOD Events

   ENDCLASS

METHOD Events( hWnd, nMsg, wParam, lParam ) CLASS MyRichEditBox

   IF nMsg == WM_KEYDOWN
      IF ! IsWindowStyle( ::hWnd, ES_READONLY )
         IF wParam == VK_DECIMAL
            ::lIgnoreKey := .T.
            InsertComma()
         ENDIF
      ENDIF
   ELSEIF nMsg == WM_CHAR
      IF ! IsWindowStyle( ::hWnd, ES_READONLY )
         IF wParam == Asc( "." ) .AND. ::lIgnoreKey
            ::lIgnoreKey := .F.
            RETURN 0
         ENDIF
      ENDIF
   ENDIF

   RETURN ::Super:Events( hWnd, nMsg, wParam, lParam )

#pragma BEGINDUMP

#include <windows.h>
#include "hbapi.h"

HB_FUNC( INSERTCOMMA )
{
   keybd_event(
      VK_OEM_COMMA,    // virtual-key code
      0,               // hardware scan code
      0,               // flags specifying various function options
      0                // additional data associated with keystroke
   );
}

#pragma ENDDUMP

/*
 * EOF
 */
