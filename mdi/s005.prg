/*
 * MDI Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place an INTERNAL window
 * into the MDICHILD windows.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE MAIN()
   LOCAL oMain

   DEFINE WINDOW wMain OBJ oMain ;
      AT 50,0 ;
      WIDTH  800 ;
      HEIGHT 600 ;
      TITLE "MDI" ;
      MDI MAIN

      DEFINE STATUSBAR
        STATUSITEM "OOHG Power !!!"
      END STATUSBAR

      DEFINE TOOLBAR TB BUTTONSIZE 70, 22 BORDER
         BUTTON TBN1 ;
            CAPTION "New" ;
            ACTION NewChild( oMain )
         BUTTON TBN2 ;
            CAPTION "Childs" ;
            ACTION ShowChilds( oMain )
         BUTTON TBN3 ;
            CAPTION "Cascade" ;
            ACTION ArrangeChilds( oMain, 1 )
         BUTTON TBN4 ;
            CAPTION "Tile Hor" ;
            ACTION ArrangeChilds( oMain, 2 )
         BUTTON TBN5 ;
            CAPTION "Tile Ver" ;
            ACTION ArrangeChilds( oMain, 3 )
         BUTTON TBN6 ;
            CAPTION "Arrange" ;
            ACTION ArrangeChilds( oMain, 4 )
         BUTTON TBN7 ;
            CAPTION "GetActive" ;
            ACTION AutoMsgBox( GetActiveChildName( oMain ) )
         BUTTON TBN8 ;
            CAPTION "IsActive" ;
            ACTION ShowActiveStatus( oMain )
      END TOOLBAR

      DEFINE MAIN MENU
         ITEM "Exit" ACTION oMain:Release()
      END MENU

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   ACTIVATE WINDOW wMain
RETURN

PROCEDURE ArrangeChilds( oMain, nAction )
   IF HB_IsObject( oMain:oWndClient )
      IF Len( oMain:oWndClient:SplitChildList ) > 0
         DO CASE
         CASE nAction == 1
            oMain:oWndClient:Cascade()
         CASE nAction == 2
            oMain:oWndClient:TileHorizontal()
         CASE nAction == 3
            oMain:oWndClient:TileVertical()
         CASE nAction == 4
            oMain:oWndClient:IconArrange()
         ENDCASE
      ENDIF
   ENDIF
RETURN

PROCEDURE GetActiveChildName( oMain )
   LOCAL cName := "No child is active !!!"

   IF HB_IsObject( oMain:oWndClient )
      cName := oMain:oWndClient:ActiveChild():Name
   ENDIF
RETURN cName

PROCEDURE ShowActiveStatus( oMain )
   LOCAL oChild, cActive := {}

   IF HB_IsObject( oMain:oWndClient )
      FOR EACH oChild IN oMain:oWndClient:SplitChildList
         aAdd( cActive, oChild:IsActive() )
      NEXT
      AutoMsgBox( cActive )
   ELSE
      AutoMsgBox( "No child is active !!!" )
   ENDIF
RETURN

PROCEDURE ShowChilds( oMain )
   LOCAL oChild, cNames := {}

   IF HB_IsObject( oMain:oWndClient )
      FOR EACH oChild IN oMain:oWndClient:SplitChildList
         aAdd( cNames, oChild:Name )
      NEXT
      AutoMsgBox( cNames )
   ELSE
      AutoMsgBox( "No child is active !!!" )
   ENDIF
RETURN

PROCEDURE NewChild( oMain )
   LOCAL oChild

   DEFINE WINDOW 0 OBJ oChild ;
      AT 0, 0 ;
      PARENT ( oMain ) ;
      WIDTH 500 ;
      HEIGHT 400 ;
      MDICHILD ;
      ON INIT InitChild( oMain, _OOHG_ThisForm ) ;
      ON RELEASE oMain:StatusBar:Item( 1, "" ) ;
      ON GOTFOCUS oMain:StatusBar:Item( 1, "Active: " + ThisWindow:Title )

      DEFINE STATUSBAR
         STATUSITEM oChild:Name
      END STATUSBAR

      DEFINE WINDOW 0 INTERNAL OBJ oInt ;
         AT 0,0 ;
         WIDTH 120 ;
         HEIGHT oChild:ClientHeight + oChild:StatusBar:ClientHeightUsed ;
         BACKCOLOR SILVER ;
         ON MOUSECLICK MsgInfo( "INT" )

         @ 20,10 BUTTON btn_1 ;
            CAPTION "Click me !!!" ;
            WIDTH 100 ;
            ACTION MsgInfo( "Is working ..." )

         @ 50,10 BUTTON btn_2 ;
            CAPTION "Click me !!!" ;
            WIDTH 100 ;
            ACTION MsgInfo( "Is working ..." )
      END WINDOW

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

RETURN

PROCEDURE InitChild( oMain, oChild )
   LOCAL nPos

   nPos := Len( oMain:oWndClient:SplitChildList )

   oChild:Title := "Documento n° " + Ltrim( Str( nPos ) )
   oChild:Row := ( nPos - 1 ) * 20
   oChild:Col := ( nPos - 1 ) * 20

   oMain:StatusBar:Item( 1, "New child: " + oChild:Name )

   /*
    * Note that at this point a runtime error occurs if you try to
    * access the oChild's statusBar or other controls.
    */
RETURN

/*
 * EOF
 */
