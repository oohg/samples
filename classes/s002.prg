/*
 * Classes Sample 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on the original works of Pompeo (Guaratingueta)
 * and William De Brito Adami.
 *
 * This class detects when the application was inactive
 * for a given number of seconds and then calls a
 * predetermined function.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Sample ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Timeout" ;
      MAIN ;
      ON INIT oTO := TTimeOut():Define( NIL, 5000, "LogOff()", .F. )

      DEFINE STATUSBAR
         STATUSITEM ""
         CLOCK
      END STATUSBAR

      @ 12, 10 LABEL Label_1 ;
         VALUE "Text_1" ;
         WIDTH 80 ;
         RIGHTALIGN

      @ 10, 95 TEXTBOX Text_1 ;
         VALUE 10 ;
         NUMERIC

      @ 42, 10 LABEL Label_2 ;
         VALUE "Text_2" ;
         WIDTH 80 ;
         RIGHTALIGN

      @ 40, 95 TEXTBOX Text_2 ;
         VALUE 20 ;
         NUMERIC

      @ 72, 10 LABEL Label_3 ;
         VALUE "Text_3" ;
         WIDTH 80 ;
         RIGHTALIGN

      @ 70, 95 TEXTBOX Text_3 ;
         VALUE 30 ;
         NUMERIC

   END WINDOW

   Sample.Text_1.SetFocus

   CENTER WINDOW Sample
   ACTIVATE WINDOW Sample

RETURN NIL


FUNCTION LogOff

   MsgExclamation( "Timeout exceeded. App will be ended.", "Notice" )
   Sample.Release

RETURN NIL


#include "hbclass.ch"

CLASS TTimeOut FROM TControl

   DATA nTimeOut       INIT 60000
   DATA cFunction      INIT NIL
   DATA lResume        INIT .F.
   DATA oTimer         INIT NIL PROTECTED
   DATA cLastCheck     INIT NIL PROTECTED
   DATA nPreviousInput INIT NIL PROTECTED

   METHOD Define
   METHOD Check
   METHOD Release      BLOCK { |Self| ::oTimer:Release() }
   METHOD Restart      BLOCK { |Self| ::cLastCheck := hb_MilliSeconds(), ::oTimer:Enabled := .T. }

ENDCLASS


METHOD Define( cForm, nTimeOut, cFunction, lResume ) CLASS TTimeOut

   ASSIGN cForm       VALUE cForm     TYPE "CM" DEFAULT _OOHG_Main
   ASSIGN ::nTimeOut  VALUE nTimeOut  TYPE "N"
   ASSIGN ::cFunction VALUE cFunction TYPE "CM"
   ASSIGN ::lResume   VALUE lResume   TYPE "L"

   ::nPreviousInput := GetInputState()
   ::cLastCheck := hb_MilliSeconds()
   ::oTimer := TTimer():Define( NIL, cForm, 1000, {|| ::Check() } )
   ::oTimer:Enabled := .T.

   RETURN Self


METHOD Check() CLASS TTimeOut

   IF GetInputState() > ::nPreviousInput
     ::nPreviousInput := GetInputState()
     ::cLastCheck := hb_MilliSeconds()
   ELSEIF hb_MilliSeconds() > ( ::cLastCheck + ::nTimeOut )
      ::oTimer:Enabled := .F.
      &( ::cFunction )
      IF ::lResume
         ::Restart()
      ENDIF
   ENDIF

   RETURN NIL


METHOD Release() CLASS TTimeOut

   ::oTimer:Release()

   RETURN ::Super:Release()


METHOD Restart() CLASS TTimeOut

   ::cLastCheck := hb_MilliSeconds()
   ::oTimer:Enabled := .T.

   RETURN NIL


#pragma BEGINDUMP

#include "windows.h"
#include "hbapi.h"

typedef BOOL ( WINAPI * GETLASTINPUTINFO ) ( PLASTINPUTINFO );

HB_FUNC( GETINPUTSTATE )
{
   GETLASTINPUTINFO pFunc;
   LASTINPUTINFO lpi;
   HINSTANCE handle = LoadLibrary( "user32.dll" );

   if( handle )
   {
      pFunc = (GETLASTINPUTINFO) GetProcAddress( handle, "GetLastInputInfo" );
      if( pFunc )
      {
         lpi.cbSize = sizeof( LASTINPUTINFO );
         if( pFunc( &lpi ) )
         {
            hb_retni( lpi.dwTime );
         }
         else
         {
            hb_retni( 0 );
         }
      }
      else
      {
         hb_retni( 0 );
      }
      FreeLibrary( handle );
   }
   else
   {
      hb_retni( 0 );
   }
}

#pragma ENDDUMP
