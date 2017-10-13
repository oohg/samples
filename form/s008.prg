/*
 * Form Sample n° 8
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Adapted from "Transparency Sample By Grigory Filatov"
 * included in HMG Extended package.
 *
 * This sample shows how to use transparency in a form.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm1

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      MAIN ;
      TITLE "ooHG - Window with transparency" ;
      BACKCOLOR YELLOW ;
      ON INIT ( oForm1:Slider_1:Enabled := .f., ;
                MakeOpaque( oForm1 ), ;
                oForm1:TextBox_1:Enabled := .f., ;
                oForm1:Button_1:Enabled := .t., ;
                oForm1:Button_2:Enabled := .f. )
              
      ON KEY ESCAPE ACTION oForm1:Release()

      @ 10, 200 LABEL lbl_aviso ;
         VALUE "CLICK HERE TO RESTORE INVISIBLE WINDOW" ;
         WIDTH 190 ;
         HEIGHT 40 ;
         BORDER ;
         BACKCOLOR GREEN ;
         FONTCOLOR BLUE ;
         CENTER ;
         ON CLICK ( oForm1:Slider_1:Enabled := .f., ;
                     MakeOpaque( oForm1 ), ;
                     oForm1:TextBox_1:Enabled := .f., ;
                     oForm1:Button_1:Enabled := .t., ;
                     oForm1:Button_2:Enabled := .f. )

      @ 10, 10 BUTTON Button_1 ;
         OBJ oBut1 ;
         CAPTION 'Set Transparency ON' ;
         WIDTH   140 ;
         ACTION ( oForm1:Slider_1:Enabled := .t., ;
                  oForm1:TextBox_1:Enabled := .t., ;
                  oForm1:Button_1:Enabled := .f., ;
                  oForm1:Button_2:Enabled := .t., ;
                  oForm1:Slider_1:Value := 180 )
      oBut1:Transparent := .T.

      @ 40, 10 BUTTON Button_2 ;
         OBJ oBut2 ;
         CAPTION 'Set Transparency OFF' ;
         WIDTH   140 ;
         ACTION ( oForm1:Slider_1:Enabled := .f., ;
                  MakeOpaque( oForm1 ), ;
                  oForm1:TextBox_1:Enabled := .f., ;
                  oForm1:Button_1:Enabled := .t., ;
                  oForm1:Button_2:Enabled := .f. )
      oBut2:Transparent := .T.

      @ 50, 200 BUTTON Button_3 ;
         OBJ oBut3 ;
         CAPTION "Invisible Background" ;
         WIDTH   140 ;
         ACTION {|| SetBackgroundInvisible( oBut1:hWnd, oForm1:BackColorCode ), ;
                    SetBackgroundInvisible( oBut2:hWnd, oForm1:BackColorCode ), ;
                    SetBackgroundInvisible( oBut3:hWnd, oForm1:BackColorCode ), ;
                    SetBackgroundInvisible( oForm1:hWnd, oForm1:BackColorCode ) }
      oBut3:Transparent := .T.

      DEFINE SLIDER Slider_1
         ROW 80
         COL 10
         VALUE 255
         WIDTH 310
         HEIGHT 50
         RANGEMIN 0
         RANGEMAX 255
         ON CHANGE Slider_Change( oForm1 )
      END SLIDER

      @ 140, 10 LABEL lbl_transparent ;
         VALUE "TRANSPARENT" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         TRANSPARENT ;
         BORDER

      @ 140, 10 LABEL lbl_Below ;
         VALUE "THIS IS A LONG TEXT TO SHOW AT THE VERY BACKGROUND" ;
         WIDTH 390 ;
         HEIGHT 24 ;
         CENTER

      @ 140, 220 LABEL lbl_opaque ;
         VALUE "OPAQUE" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         RIGHTALIGN ;
         BORDER

      @ 85, 330 TEXTBOX TextBox_1 ;
         VALUE 255 ;
         INPUTMASK "999" ;
         WIDTH 50 ;
         HEIGHT 24 ;
         DISABLED ;
         ON CHANGE TextBox_Change( oForm1 )

   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

FUNCTION TextBox_Change (oWin)

  WITH OBJECT oWin
    :Slider_1:Value := :TextBox_1:Value

     IF .not. SetTransparency( :hWnd, :Slider_1:Value )
        MsgStop( "Transparency is not supported by OS !!!", "Error" )
     ENDIF
  END WITH

RETURN NIL

FUNCTION Slider_Change (oWin)

  WITH OBJECT oWin
     :TextBox_1:Value := :Slider_1:Value

     IF .not. SetTransparency( :hWnd, :Slider_1:Value )
        MsgStop( "Transparency is not supported by OS !!!", "Error" )
     ENDIF
  END WITH

RETURN NIL

FUNCTION MakeOpaque( oWin )

  WITH OBJECT oWin
    :Slider_1:Value := 255
    :TextBox_1:Value := 255

    RemoveTransparency( :hWnd )
  END WITH

RETURN NIL

#pragma BEGINDUMP

#define HB_OS_WIN_32_USED
#define _WIN32_WINNT 0x0500

#include <windows.h>
#include <winuser.h>
#include <commctrl.h>
#include "hbapi.h"
#include "oohg.h"

/*
 * The SetLayeredWindowAttributes function sets the opacity and transparency
 * color key of a layered window.
 * Parameters:
 * - hwnd   Handle to the layered window.
 * - crKey   Pointer to a COLORREF value that specifies the transparency color
 *   key to be used.
 *    (When making a certain color transparent...).
 * - bAlpha   Alpha value used to describe the opacity of the layered window.
 *    0 = Invisible, 255 = Fully visible
 * - dwFlags   Specifies an action to take. This parameter can be LWA_COLORKEY
 *    (When making a certain color transparent...) or LWA_ALPHA.
 */

typedef BOOL ( __stdcall *PFN_SETLAYEREDWINDOWATTRIBUTES ) ( HWND, COLORREF, BYTE, DWORD );

HB_FUNC( SETTRANSPARENCY )
{
   BOOL bRet = FALSE;
   PFN_SETLAYEREDWINDOWATTRIBUTES pfnSetLayeredWindowAttributes = NULL;
   HINSTANCE hLib = LoadLibrary( "user32.dll" );

   if( hLib != NULL )
   {
      pfnSetLayeredWindowAttributes = (PFN_SETLAYEREDWINDOWATTRIBUTES) GetProcAddress( hLib, "SetLayeredWindowAttributes" );

      if( pfnSetLayeredWindowAttributes != NULL )
      {
         SetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE, GetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE ) | WS_EX_LAYERED );

         bRet = (BOOL) pfnSetLayeredWindowAttributes( HWNDparam( 1 ), 0, hb_parni( 2 ), LWA_ALPHA );

         FreeLibrary( hLib );
      }
   }

   hb_retl( bRet );
}

HB_FUNC( SETBACKGROUNDINVISIBLE )
{
   BOOL bRet = FALSE;
   PFN_SETLAYEREDWINDOWATTRIBUTES pfnSetLayeredWindowAttributes = NULL;
   HINSTANCE hLib = LoadLibrary( "user32.dll" );

   if( hLib != NULL )
   {
      pfnSetLayeredWindowAttributes = (PFN_SETLAYEREDWINDOWATTRIBUTES) GetProcAddress( hLib, "SetLayeredWindowAttributes" );

      if( pfnSetLayeredWindowAttributes != NULL )
      {
         SetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE, GetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE ) | WS_EX_LAYERED );

         bRet = (BOOL) pfnSetLayeredWindowAttributes( HWNDparam( 1 ), hb_parni( 2 ), 0, LWA_COLORKEY );

         FreeLibrary( hLib );
      }
   }

   hb_retl( bRet );
}

HB_FUNC( REMOVETRANSPARENCY )
{
   SetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE, GetWindowLong( HWNDparam( 1 ), GWL_EXSTYLE ) & ~WS_EX_LAYERED ) ;

   RedrawWindow( HWNDparam( 1 ), NULL, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_ALLCHILDREN | RDW_ERASENOW | RDW_UPDATENOW );
}

#pragma ENDDUMP

/*
EOF
*/
