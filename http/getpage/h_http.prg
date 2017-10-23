/*
 * $Id: h_http.prg,v 1.6 2017-08-25 19:28:44 fyurisich Exp $
 */
/*
 * ooHG source code:
 * HTTP class call
 *
 * Copyright 2005-2017 Vicente Guerra <vicente@guerra.com.mx>
 * https://sourceforge.net/projects/oohg/
 *
 * Portions of this project are based upon Harbour MiniGUI library.
 * Copyright 2002-2005 Roberto Lopez <roblez@ciudad.com.ar>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1335,USA (or download from http://www.gnu.org/licenses/).
 *
 * As a special exception, the ooHG Project gives permission for
 * additional uses of the text contained in its release of ooHG.
 *
 * The exception is that, if you link the ooHG libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the ooHG library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the ooHG
 * Project under the name ooHG. If you copy code from other
 * ooHG Project or Free Software Foundation releases into a copy of
 * ooHG, as the General Public License permits, the exception does
 * not apply to the code that you add in this way. To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for ooHG, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */
/*----------------------------------------------------------------------------
 MINIGUI - Harbour Win32 GUI library source code

 Copyright 2002-2005 Roberto Lopez <roblez@ciudad.com.ar>
 http://www.geocities.com/harbour_minigui/

 This program is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation; either version 2 of the License, or (at your option) any later
 version.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License along with
 this software; see the file COPYING. If not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA (or
 visit the web site http://www.gnu.org/).

 As a special exception, you have permission for additional uses of the text
 contained in this release of Harbour Minigui.

 The exception is that, if you link the Harbour Minigui library with other
 files to produce an executable, this does not by itself cause the resulting
 executable to be covered by the GNU General Public License.
 Your use of that executable is in no way restricted on account of linking the
 Harbour-Minigui library code into it.

 Parts of this project are based upon:

   "Harbour GUI framework for Win32"
    Copyright 2001 Alexander S.Kresin <alex@belacy.belgorod.su>
    Copyright 2001 Antonio Linares <alinares@fivetech.com>
   www - http://www.harbour-project.org

   "Harbour Project"
   Copyright 1999-2003, https://harbour.github.io/
---------------------------------------------------------------------------*/

*-----------------------------------------------------------------------------*
Function httpconnect( Connection, Server, Port )
*-----------------------------------------------------------------------------*
Local oUrl

   If ! Upper( Left( Server, 7 ) ) == "HTTP://"
      Server := "http://" + Server
   EndIf

   oUrl := tURL():New( Server + ":" + Ltrim( Str( Port ) ) )

   If HB_IsString( Connection )
      Public &Connection

      If Empty( oUrl )
         &Connection := Nil
      Else
         &Connection := TIpClientHttp():New( oUrl )

         If ! (&Connection):Open()
            &Connection := Nil
         EndIf
      EndIf
   Else
      If Empty( oUrl )
         Connection := Nil
      Else
         Connection := TIpClientHttp():New( oUrl )

         If ! Connection:Open()
            Connection := Nil
         EndIf
      EndIf
   EndIf

Return Nil

*-----------------------------------------------------------------------------*
Function httpgeturl( Connection, cPage, uRet )
*-----------------------------------------------------------------------------*
Local cUrl, cResponse, cHeader, i, cRet

   cUrl := "http://"
   If ! Empty( Connection:oUrl:cUserid )
      cUrl += Connection:oUrl:cUserid
      If ! Empty( Connection:oUrl:cPassword )
         cUrl += ":" + Connection:oUrl:cPassword
      EndIf
      cUrl += "@"
   EndIf
   If ! Empty( Connection:oUrl:cServer )
      cUrl += Connection:oUrl:cServer
      If Connection:oUrl:nPort > 0
         cUrl += ":" + hb_ntos( Connection:oUrl:nPort )
      EndIf
   EndIf
   cUrl += cPage

   If Connection:Open( cUrl )
      cResponse := Connection:Read()
      If ! hb_IsString( cResponse )
         cResponse := "<No data returned>"
      EndIf

      If hb_IsLogical( uRet )
         cHeader := Connection:cReply
         If ! hb_IsString( cHeader )
            cHeader := "<No header returned>"
         EndIf
         cHeader += hb_OsNewLine()

         For i := 1 to Len( Connection:hHeaders )
            #ifdef __XHARBOUR__
               cHeader += hGetKeyAt( Connection:hHeaders, i ) + ": " + hGetValueAt( Connection:hHeaders, i ) + hb_OsNewLine()
            #else
               cHeader += hb_HKeyAt( Connection:hHeaders, i ) + ": " + hb_HValueAt( Connection:hHeaders, i ) + hb_OsNewLine()
            #endif
         Next
         cHeader += hb_OsNewLine()

         If uRet                       // return DATA and HEADERS
            cRet := cHeader + cResponse
         Else                          // return HEADERS only
            cRet := cHeader
         EndIf
      Else                             // return DATA only
         cRet := cResponse
      EndIf
   Else
      cRet := "<Error opening URL>"
   EndIf

Return cRet

