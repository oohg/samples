/*
 * HTTP Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to connect to an http server
 * and get some information.
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
      TITLE 'HTTP GET Sample' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'Test with memvar'
            ITEM 'Get headers and data' ACTION TestHttpMem( 1 )
            ITEM 'Get headers only'     ACTION TestHttpMem( 2 )
            ITEM 'Get data only'        ACTION TestHttpMem( 3 )
         END POPUP
         POPUP 'Test with reference'
            ITEM 'Get headers and data' ACTION TestHttpRef( 1 )
            ITEM 'Get headers only'     ACTION TestHttpRef( 2 )
            ITEM 'Get data only'        ACTION TestHttpRef( 3 )
         END POPUP
      END MENU

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN

PROCEDURE TestHttpMem( nOption )
   LOCAL cResponse
   MEMVAR oConn

   // Creates a public memvar to hold the connection's object

   OPEN CONNECTION oConn SERVER 'www.itlnet.net' PORT 80 HTTP

   IF oConn == Nil
       AUTOMSGBOX( "No connection !!!" )
   ELSE
      DO CASE
      CASE nOption == 1
         GET URL '/programming/program/Reference/c53g01c/menu.html' TO cResponse CONNECTION oConn
      CASE nOption == 2
         GET URL '/programming/program/Reference/c53g01c/menu.html' TO cResponse CONNECTION oConn HEADERS
      OTHERWISE
         GET URL '/programming/program/Reference/c53g01c/menu.html' TO cResponse CONNECTION oConn NOHEADERS
      ENDCASE

      CLOSE CONNECTION oConn
      RELEASE oConn

      AUTOMSGBOX( cResponse )
   ENDIF

RETURN

PROCEDURE TestHttpRef( nOption )
   LOCAL cResponse, oConn

   // The connection's object is stored to an already existing variable

   OPEN CONNECTION OBJ oConn SERVER 'harbour.github.io' PORT 80 HTTP

   IF oConn == Nil
       AUTOMSGBOX( "No connection !!!" )
   ELSE
      DO CASE
      CASE nOption == 1
         GET URL '/index.html' TO cResponse CONNECTION oConn
      CASE nOption == 2
         GET URL '/index.html' TO cResponse CONNECTION oConn HEADERS
      OTHERWISE
         GET URL '/index.html' TO cResponse CONNECTION oConn NOHEADERS
      ENDCASE

      CLOSE CONNECTION oConn

      AUTOMSGBOX( cResponse )
   ENDIF

RETURN

/*
 * EOF
 */
