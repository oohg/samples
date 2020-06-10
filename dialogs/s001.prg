/*
 * Dialog Sample # 1
 * Author: Unknown, freshen up by
 * Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use Windows common dialog
 * functions to get a file, create a file, get a font,
 * get a color and get a folder.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 320 HEIGHT 240 ;
      TITLE 'OOHG - Common Dialogs Demo' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power!'
      END STATUSBAR

      DEFINE MAIN MENU
         POPUP 'Common &Dialog Functions'
            ITEM 'GetFile()'   ACTION GetFile_click()
            ITEM 'PutFile()'   ACTION PutFile_click()
            ITEM 'GetFont()'   ACTION GetFont_click()
            ITEM 'GetColor()'  ACTION GetColor_click()
            ITEM 'GetFolder()' ACTION GetFolder_click()
         END POPUP

         POPUP 'H&elp'
            ITEM 'About'       ACTION MsgInfo( "Free GUI library for (x)Harbour", "OOHG Demo" )
         END POPUP
      END MENU

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL


/*
 * This function uses Windows SHBrowseForFolder dialog.
 */
PROCEDURE GetFolder_click

   LOCAL a := GetFolder( "Title" )

   IF Empty( a )
      MsgInfo( "Dialog was canceled!" )
   ELSE
      MsgInfo( a )
   ENDIF

RETURN


/*
 * This function uses Windows GetSaveFileName dialog.
 */
PROCEDURE PutFile_click

   LOCAL a := PutFile( { {'Images','*.jpg'} }, 'Save Image', 'C:\' )

   IF Empty( a )
      MsgInfo( "Dialog was canceled!" )
   ELSE
     MsgInfo( a )
   ENDIF

RETURN


/*
 * This function uses Windows GetOpenFileName dialog.
 */
PROCEDURE GetFile_click

   LOCAL a := GetFile( { {'Images','*.jpg'} }, 'Open Image' )

   IF Empty( a )
      MsgInfo( "Dialog was canceled!" )
   ELSE
     MsgInfo( a )
   ENDIF

RETURN


/*
 * This function uses Windows ChooseColor dialog.
 */
PROCEDURE GetColor_click

   LOCAL Color := GetColor(), cColor

   IF Color[1] <> NIL
      cColor := "{" + LTrim( Str( Color[1] ) ) + ", " + ;
                      LTrim( Str( Color[2] ) ) + ", " + ;
                      LTrim( Str( Color[3] ) ) + "}"

      AutoMsgInfo( cColor, "RGB Color" )
   ELSE
      MsgInfo( "Dialog was canceled!" )
   ENDIF

RETURN


/*
 * This function uses Windows ChooseFont dialog.
 */
PROCEDURE GetFont_click

   LOCAL a := GetFont( 'Arial', 12, .T., .T., {0,0,255}, .F., .F., 0 ), cFont

   IF Empty( a[1] )
      MsgInfo( 'Dialog was canceled!' )
   ELSE
      cFont := a[1] + " " + LTrim( Str( a[2] ) + CRLF
      IF a[3]
         cFont += "Bold" + CRLF
      ELSE
         cFont += "Non Bold" + CRLF
      ENDIF

      IF a[4]
         cFont += "Italic" + CRLF
      ELSE
         cFont += "Non Italic" + CRLF
      ENDIF

      IF a[5] <> NIL
         cFont += "RGB color {" + LTrim( Str( a[5][1] ) ) + ", " + ;
                                  LTrim( Str( a[5][2] ) ) + ", " + ;
                                  LTrim( Str( a[5][3] ) ) + "}" + CRLF
      ENDIF

      IF a[6]
         cFont += "Underline" + CRLF
      ELSE
         cFont += "Non Underline" + CRLF
      ENDIF

      IF a[7]
         cFont += "StrikeOut" + CRLF
      ELSE
         cFont += "Non StrikeOut" + CRLF
      ENDIF

      cFont += "Charset " + LTrim( Str( a[8] )

      MsgInfo( cFont, "Font" )
   ENDIF

RETURN

/*
 * EOF
 */
