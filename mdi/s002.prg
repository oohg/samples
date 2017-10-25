/*
* MDI Sample n� 2
* Author: Fernando Yurisich <fernando.yurisich@gmail.com>
* Licensed under The Code Project Open License (CPOL) 1.02
* See <http://www.codeproject.com/info/cpol10.aspx>
*
* This sample shows how to change the controls of the
* child windows of a MDI app.
*
* Visit us at https://github.com/fyurisich/OOHG_Samples or at
* http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
*/
#include "oohg.ch"

PROCEDURE MAIN()

   LOCAL oMain

   DEFINE WINDOW wMain OBJ oMain ;
         AT 50,0 ;
         WIDTH  800 ;
         HEIGHT 600 ;
         TITLE "MDI" ;
         MDI
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
         BUTTON TBN9 ;
            CAPTION "Change Lbl" ;
            ACTION ChangeLabelValue( oMain )
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

   DEFINE WINDOW 0 ;
         AT 0, 0 ;
         PARENT wMain ;
         WIDTH 300 ;
         HEIGHT 200 ;
         MDICHILD ;
         ON INIT InitChild( oMain, _OOHG_ThisForm ) ;
         ON RELEASE oMain:StatusBar:Item( 1, "" ) ;
         ON GOTFOCUS oMain:StatusBar:Item( 1, "Active: " + ThisWindow:Title )
      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR
      ThisWindow:StatusBar:Item( 1, ThisWindow:Name )
      @ 20, 20 LABEL lbl_1 ;
         PARENT ( ThisWindow:Name ) ;
         VALUE "Label on " + _OOHG_ThisForm:Title + " - Click me !!!" ;
         AUTOSIZE ;
         FONTCOLOR RED BOLD ;
         ACTION MyMessage( oMain:oWndClient:ActiveChild() )
      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   RETURN

PROCEDURE InitChild( oMain, oChild )

   LOCAL nPos

   nPos := Len( oMain:oWndClient:SplitChildList )
   oChild:Title := "Documento n� " + Ltrim( Str( nPos ) )
   oChild:Row := ( nPos - 1 ) * 20
   oChild:Col := ( nPos - 1 ) * 20
   @ 50, 20 BUTTON but_1 ;
      PARENT ( oChild ) ;
      CAPTION "Close" ;
      ACTION oChild:Release()
   oMain:StatusBar:Item( 1, "New child: " + oChild:Name )
   /*
   * Note that at this point a runtime error occurs if you try to
   * access the oChild:StatusBar or oChild:lbl_1 controls.
   */

   RETURN

PROCEDURE MyMessage( oWin )

   MsgBox( "You just clicked on lbl_1 of " + oWin:Name )

   RETURN

PROCEDURE ChangeLabelValue( oMain )

   LOCAL oActiveChild

   IF HB_IsObject( oMain:oWndClient )
      oActiveChild := oMain:oWndClient:ActiveChild()
      oActiveChild:lbl_1:Value := "lbl_1 on " + oActiveChild:Title + " (click me)"
   ELSE
      MsgBox( "No child window is defined !!!" )
   ENDIF
   /*
   * EOF
   */
