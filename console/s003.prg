/*
 * Console Sample #3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how build and run a mixed mode program.
 *
 * Based on a sample from Minigui Extended.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

/*
 * Build with
 *   COMPILE mixedmode /c /nr
 * or
 *   BUILDAPPD mixedmode -gtwin /nr
 *
 * Execute with double click.
 * Do not autorun because if the
 * console has no title then it can't
 * be hide and showed.
 */

REQUEST HB_GT_WIN_DEFAULT

MEMVAR cTitle, oForm

FUNCTION Main()

   PUBLIC oForm, cTitle := GetModuleFileName()

   SET STATIONNAME TO "MAIN"

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      TITLE 'OOHG - Mixed Mode Demo' ;
      MAIN ON INIT ( oForm:BringToTop(), HideConsole( cTitle ) )

      @ 20, 20 LABEL lbl1 AUTOSIZE ;
         VALUE 'Click "Open 1" button to open the console and capture some data'

      @ 60, 20 BUTTON btn1 ;
         CAPTION 'Open 1' ;
         ACTION Form_1.btn1.Caption := AllTrim( Str( GetData( fn1() ) ) )

      @ 100, 20 BUTTON btn2 ;
         CAPTION 'Show Msg' ;
         ACTION  fn2( 3 )

      @ 140, 20 BUTTON btn3 ;
         CAPTION 'Exit' ;
         ACTION Form_1.Release

      @ 180, 20 LABEL lbl2 WIDTH 300 ;
         VALUE "In case the console title is not"

      @ 220, 20 TEXTBOX txt1 ;
        WIDTH 400 ;
        VALUE cTitle

      @ 260, 20 LABEL lbl3 WIDTH 500 ;
         VALUE "enter its exact title in the previous textbox and click Change, then 'Open 1' or 'Show Msg'"

      @ 300, 20 BUTTON btn4 ;
         CAPTION "Change" ;
         ACTION cTitle := iif( Empty( Form_1.txt1.Value ), NIL, Form_1.txt1.Value )

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   Form_1.Center()
   Form_1.Activate()

RETURN NIL

FUNCTION fn1()

   LOCAL r1 := 0
   LOCAL r2 := 0
   MEMVAR GetList

   HIDE WINDOW Form_1
   ShowConsole( cTitle )
   CLEAR SCREEN

   @ 10, 10 SAY ' S1 ' GET r1 PICTURE '9999'
   @ 12, 10 SAY ' S2 ' GET r2 PICTURE '9999'
   READ

   SendData( "MAIN", r2 )
   RESTORE WINDOW Form_1
   HideConsole( cTitle )

RETURN NIL

FUNCTION fn2( n )

   LOCAL i

   HIDE WINDOW Form_1
   IF ShowConsole( cTitle )
      CLEAR SCREEN

      FOR i := 1 TO n
         ? i
      NEXT
      WAIT
   ENDIF
   RESTORE WINDOW Form_1
   HideConsole( cTitle )

RETURN NIL

#pragma BEGINDUMP

#include <windows.h>
#include "hbapi.h"

HB_FUNC( HIDECONSOLE )
{
    ShowWindow( FindWindow( NULL, hb_parc( 1 ) ), SW_MINIMIZE );
}

HB_FUNC( SHOWCONSOLE )
{
   HWND hwnd = FindWindow( NULL, hb_parc( 1 ) );

   if( hwnd )
   {
      ShowWindow( hwnd, SW_RESTORE );
      hb_retl( TRUE );
   }
   else
   {
      char cBuffError[ 1000 ];
      sprintf( cBuffError, "%s %s %s", "Error:", hb_parc( 1 ), "not found!" );
      MessageBox( 0, cBuffError, "Error!", MB_OK | MB_SYSTEMMODAL );
      hb_retl( FALSE );
   }
}

#pragma ENDDUMP
