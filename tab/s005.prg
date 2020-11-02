/*
 * Tab Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on an original contribution by CAS and
 * modified by Ciro Vargas Clemow.
 *
 * This sample shows how to dynamically add tabpages,
 * delete tabpages and change tabpages captions.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

MEMVAR FrmMain

FUNCTION Main

   PRIVATE FrmMain

   DEFINE WINDOW FrmMain ;
	   AT 0,0 WIDTH 480 HEIGHT 300 ;
      TITLE "OOHG - Tabpages demo" ;
	   MAIN ;
      ON INIT ShowStatus()

	   DEFINE MAIN MENU
         DEFINE POPUP "Option"
            MENUITEM "Add page"    ACTION FrmMain.Tab_1.AddPage( 2, "New Page", "bmp.Bmp" )
            MENUITEM "Delete Page" ACTION iif( FrmMain.Tab_1.ItemCount > 1, ( FrmMain.Tab_1.DeletePage( 2 ), ShowStatus() ), NIL )
            MENUITEM "Change Page" ACTION ( EditTabCaption(), ShowStatus() )
         END POPUP
	   END MENU

	   ON KEY F1 ACTION PosToTab( 1 )
	   ON KEY F2 ACTION iif( FrmMain.Tab_1.ItemCount > 1, PosToTab( 2 ), NIL )

	   DEFINE STATUSBAR
		   STATUSITEM ""
	   END STATUSBAR

	   DEFINE TAB Tab_1 ;
		   AT         10, 10 ;
		   WIDTH      450 ;
		   HEIGHT     200 ;
		   VALUE      1 ;
		   TOOLTIP   "Tab Control" ;
		   ON CHANGE ShowStatus()

		   PAGE "Press F1"
			   @  60, 10 TEXTBOX txt_1 VALUE "1-uno"
			   @  90, 10 TEXTBOX txt_2 VALUE "2-Dos"
			   @ 120, 10 TEXTBOX txt_3 VALUE "3-Tres"
		   END PAGE

		   PAGE "Press F2"
			   @ 40, 10  TEXTBOX txt_a VALUE "A-Uno" WIDTH 90
			   @ 40, 110 TEXTBOX txt_b VALUE "B-Dos" WIDTH 90

            DEFINE TAB Tab_2 ;
               AT 70,10 ;
		         WIDTH 200 ;
		         HEIGHT 100 ;

               PAGE "IN1"
                  @  60,10 TEXTBOX txt_4 VALUE "4-cuatro"
               END PAGE

               PAGE "IN2"
                  @  60,10 TEXTBOX txt_5 VALUE "5-cinco"
               END PAGE
	         END TAB
         END PAGE
      END TAB

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   FrmMain.Center()
   FrmMain.Activate()

   RETURN NIL

FUNCTION PosToTab( nItem )

   FrmMain.Tab_1.Value := nItem
   ShowStatus()

   RETURN NIL

FUNCTION EditTabCaption()

   LOCAL nItem, cCaption

   nItem     := FrmMain.Tab_1.Value
   cCaption  := FrmMain.Tab_1.Caption( nItem )
	cCaption  := InputBox( "Label", "Title", cCaption )
	IF ! Empty( cCaption )
      FrmMain.Tab_1.Caption( nItem ) := cCaption
	ENDIF

   RETURN NIL

FUNCTION ShowStatus()

   LOCAL nItem := FrmMain.Tab_1.Value

   FrmMain.StatusBar.Item( 1 ) := ;
      'FrmMain.Tab_1.Caption(' + AllTrim( Str( nItem ) ) + ') = "' + ;
      FrmMain.Tab_1.Caption( nItem ) + '"'

   RETURN NIL

/*
 * EOF
 */
