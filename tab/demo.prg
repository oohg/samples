////// By CAS
////// Modified Ciro Vargas Clemow

#include "oohg.ch"

MEMVAR FrmMain

FUNCTION Main

   DEFINE WINDOW FrmMain OBJ FrmMain ;
	   AT 0,0 WIDTH 480 HEIGHT 300 ;
      TITLE "TAB / Page    -    DEMO" ;
	   MAIN

	   DEFINE MAIN MENU
         DEFINE POPUP "Option"
            MENUITEM "Add page"    ACTION FrmMain.Tab_1.AddPage( 2 , "New Page" , "bmp.Bmp" )
            MENUITEM "Delete Page" ACTION ( FrmMain.Tab_1.DeletePage( 2 ), FrmMain.Tab_1.refresh() )
            MENUITEM "Change Page" ACTION ( EditTabCaption(), FrmMain.Tab_1.Refresh() )
         END POPUP
	   END MENU

	   ON KEY F1 ACTION PosToTab( 1 )
	   ON KEY F2 ACTION PosToTab( 2 )

	   DEFINE STATUSBAR
		   STATUSITEM "" ACTION nil
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

	   ShowStatus()

   END WINDOW

   FrmMain:Center()
   FrmMain:Activate()

   RETURN Nil

FUNCTION PosToTab( nItem )

   FrmMain.Tab_1.Value := nItem
   ShowStatus()

   RETURN NIL

FUNCTION EditTabCaption()

   LOCAL nItem, cCaption

   nItem     := FrmMain:Tab_1:Value
   cCaption  := FrmMain:tab_1:caption( nItem )
	cCaption  := InputBox( "Label", "Title", cCaption )
	IF ! Empty( cCaption )
      FrmMain.tab_1.caption( nItem ) := cCaption
	ENDIF

   RETURN nil

FUNCTION ShowStatus()

   LOCAL nItem

   nItem = FrmMain:tab_1:value

   IF nItem = 1
      FrmMain:txt_1:setfocus()
   ELSE
      FrmMain:txt_a:setfocus()
   ENDIF

   FrmMain.StatusBar.Item(1) := ;
      "FrmMain.Tab_1.Caption(" + alltrim( str( nItem ) ) + ") = " + ;
      FrmMain.tab_1.caption( FrmMain.tab_1.value )

   RETURN nil
