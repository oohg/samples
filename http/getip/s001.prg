/*
 * HTTP Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to obtain your public IP address.
 * Note: it does not work if you are behind a proxy.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_socket.ch"
#include "h_http.prg"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'Get IP public address' ;
      MAIN

      @ 20, 20 BUTTON btn_1 ;
         CAPTION "Get" ;
         ACTION GetIP()

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN

PROCEDURE GetIP()
   LOCAL cResponse, oConn, nAt, cIP

   OPEN CONNECTION OBJ oConn SERVER 'whatismyipaddress.com' PORT 80 HTTP
   IF oConn == NIL
      AutoMsgBox( { "Can't connect to whatismyipaddress.com !!!", ;
                    "Check Internet connection and site status."} )
   ELSE
      GET URL '/' TO cResponse CONNECTION oConn
      CLOSE CONNECTION oConn

      IF Empty( cResponse )
         AutoMsgBox( { "Can't connect to whatismyipaddress.com !!!", ;
                       "Check Internet connection and site status."} )
      ELSE
         nAt := At( "Click for more about", cResponse )
         cIP := SubStr( cResponse, nAt + 20, 20 )
         nAt := At( '"', cIP )
         cIP := Left( cIP, nAt - 1 )
         IF Empty( cIP )
            AutoMsgBox( "Wrong response received from site !!!" )
         ELSE
            AutoMsgBox( cIP )
         ENDIF
      ENDIF
   ENDIF
RETURN NIL

/*
 * EOF
 */
