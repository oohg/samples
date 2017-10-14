/*
 * MINIGUI - Harbour Win32 GUI library Demo
 *
 * Copyright 2002-2005 Roberto Lopez <roblez@ciudad.com.ar>
 * http://www.geocities.com/harbour_minigui/
 *
 * Adapted for ooHG by MigSoft 2007 <fugaz_cl@yahoo.es>
*/

#include "oohg.ch"

Function Main()
Local nTra := 210, hWnd

	DEFINE WINDOW WinTr ;
		AT 0,0 ;
		WIDTH 300 ;
		HEIGHT 300 ;
		TITLE 'Transparent window' ;
		MAIN ;
		NOSIZE NOMAXIMIZE ;
		ON INIT ( hWnd := GetFormHandle('WinTR'), SetTransparent(hWnd, nTra) )

		@ 200,100 BUTTON But1 ;
			CAPTION "Click Me" ;
			HEIGHT 35 WIDTH 100 ;
			ACTION ( nTra := IIF(nTra == 100, 255, 100), SetTransparent(hWnd, nTra) )

	END WINDOW

	CENTER WINDOW WinTR

	ACTIVATE WINDOW WinTR

RETURN NIL


#pragma BEGINDUMP

#define _WIN32_IE 0x0500
#define HB_OS_WIN_32_USED
#define _WIN32_WINNT 0x0400

#define WS_EX_LAYERED 0x80000
#define LWA_ALPHA 0x02

#include <windows.h>
#include "hbapi.h"

HB_FUNC( SETTRANSPARENT )
{ 

	typedef BOOL (__stdcall *PFN_SETLAYEREDWINDOWATTRIBUTES) (HWND, COLORREF, BYTE, DWORD);

	PFN_SETLAYEREDWINDOWATTRIBUTES pfnSetLayeredWindowAttributes = NULL;

	HINSTANCE hLib = LoadLibrary("user32.dll");

	if (hLib != NULL)
	{
		pfnSetLayeredWindowAttributes = (PFN_SETLAYEREDWINDOWATTRIBUTES) GetProcAddress(hLib, "SetLayeredWindowAttributes");
	}

	if (pfnSetLayeredWindowAttributes)
	{
		SetWindowLong((HWND) hb_parnl (1), GWL_EXSTYLE, GetWindowLong((HWND) hb_parnl (1), GWL_EXSTYLE) | WS_EX_LAYERED);
		pfnSetLayeredWindowAttributes((HWND) hb_parnl (1), 0, hb_parni (2), LWA_ALPHA);
	}

	if (!hLib)
	{
		FreeLibrary(hLib);
	}

}

#pragma ENDDUMP