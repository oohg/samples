/*
 * $Id: activexdemo.prg,v 1.1 2007/03/25 22:41:42 guerra000 Exp $
 */
/*
   Marcelo Torres, Noviembre de 2006.
   TActivex para [x]Harbour Minigui.
   Adaptacion del trabajo de:
   ---------------------------------------------
   Lira Lira Oscar Joel [oSkAr]
   Clase TAxtiveX_FreeWin para Fivewin
   Noviembre 8 del 2006
   email: oscarlira78@hotmail.com
   http://freewin.sytes.net
   @CopyRight 2006 Todos los Derechos Reservados
   ---------------------------------------------
*/

#include "oohg.ch"
#include "hbclass.ch"

///////////////////// internet explorer events BEGIN

#define AX_SE2_STATUSTEXTCHANGE           102
#define AX_SE2_PROGRESSCHANGE             108
#define AX_SE2_COMMANDSTATECHANGE         105
#define AX_SE2_DOWNLOADBEGIN              106
#define AX_SE2_DOWNLOADCOMPLETE           104
#define AX_SE2_TITLECHANGE                113
#define AX_SE2_PROPERTYCHANGE             112
#define AX_SE2_BEFORENAVIGATE2            250
#define AX_SE2_NEWWINDOW2                 251
#define AX_SE2_NAVIGATECOMPLETE2          252
#define AX_SE2_DOCUMENTCOMPLETE           259
#define AX_SE2_ONQUIT                     253
#define AX_SE2_ONVISIBLE                  254
#define AX_SE2_ONTOOLBAR                  255
#define AX_SE2_ONMENUBAR                  256
#define AX_SE2_ONSTATUSBAR                257
#define AX_SE2_ONFULLSCREEN               258
#define AX_SE2_ONTHEATERMODE              260
#define AX_SE2_WINDOWSETRESIZABLE         262
#define AX_SE2_WINDOWSETLEFT              264
#define AX_SE2_WINDOWSETTOP               265
#define AX_SE2_WINDOWSETWIDTH             266
#define AX_SE2_WINDOWSETHEIGHT            267
#define AX_SE2_WINDOWCLOSING              263
#define AX_SE2_CLIENTTOHOSTWINDOW         268
#define AX_SE2_SETSECURELOCKICON          269
#define AX_SE2_FILEDOWNLOAD               270
#define AX_SE2_NAVIGATEERROR              271
#define AX_SE2_PRINTTEMPLATEINSTANTIATION 225
#define AX_SE2_PRINTTEMPLATETEARDOWN      226
#define AX_SE2_UPDATEPAGESTATUS           227
#define AX_SE2_PRIVACYIMPACTEDSTATECHANGE 272
#define AX_SE2_NEWWINDOW3                 273
#define AX_SE2_SETPHISHINGFILTERSTATUS    282
#define AX_SE2_WINDOWSTATECHANGED         283

///////////////////// internet explorer events END

Static oActiveX, bVerde, WinDemo

FUNCTION Main()
   DEFINE WINDOW WinDemo obj Windemo ;
      AT 118,73 ;
      WIDTH 808 ;
      HEIGHT 534 ;
      TITLE 'ooHG ActiveX Support Sample' ;
      MAIN ;
      ON SIZE Ajust() ;
      ON MAXIMIZE Ajust() ;
      BACKCOLOR {236 , 233 , 216 } ;
      FONT 'Verdana' ;
      SIZE 10

      @ Windemo:height - 60 , 10 LABEL LSemaforo ;
         VALUE " " ;
         WIDTH 27 ;
         HEIGHT 27 ;
         FONTCOLOR {255,0,0} ;
         BACKCOLOR {255,0,0}

      @ windemo:height - 57 , 43 TEXTBOX URL_ToNavigate  ;
         HEIGHT 23 ;
         WIDTH windemo:width - 165 ;
         Font 'Verdana' ;
         ON ENTER Navegar() ;

      @ windemo:height - 60 , windemo:width - 115 BUTTON BNavigate ;
         CAPTION 'Navigate' ;
         ACTION ( oActiveX:visible := .F., Navegar() ) ;
         WIDTH 100 ;
         HEIGHT 28 ;
         FONT 'Verdana' ;


      @  0, 0 ACTIVEX ActiveX WIDTH WinDemo:width - 7 HEIGHT WinDemo:height - 72 PROGID "Shell.Explorer.2" OBJ oActiveX INVISIBLE

     oActiveX:EventMap( AX_SE2_TITLECHANGE, { |cTitle| WinDemo:Title := cTitle } )

      bVerde := .F.
      oActiveX:Navigate( "www.oohg.org" )

      DEFINE TIMER TSemaforo ;
         INTERVAL    1000 ;
         ACTION SwitchSemaforo() ;

   END WINDOW

   Center window WinDemo

   Activate window WinDemo

RETURN NIL

Procedure SwitchSemaforo()
   if oActiveX:Busy()
      if bVerde
         bVerde := .F.
         WinDemo:LSemaforo:BackColor := {255,0,0}
      endif
   else
      if !bVerde
         bVerde := .T.
         WinDemo:LSemaforo:BackColor := {0,255,0}
         windemo:URL_tonavigate:value := oActiveX:LocationURL()
      endif
   endif
Return

Procedure Navegar()
   oActivex:Navigate(windemo:URL_tonavigate:value)
   AutoMsgBox("here")
   oActiveX:visible := .T.
Return

Procedure Ajust()
   windemo:lsemaforo:row := WinDemo:height - 60
   windemo:URL_tonavigate:row := WinDemo:height - 57
   windemo:URL_tonavigate:width :=  WinDemo:width- 165
   windemo:Bnavigate:row := WinDemo:height- 60
   windemo:bnavigate:col := WinDemo:width- 115
   oActiveX:width := WinDemo:width - 7
   oActiveX:height := WinDemo:height - 72
Return
