/*
 * App Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use Application object.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

MEMVAR oApp, oBtn2, oBtn3, oLbl12, oLbl13

FUNCTION Main( ... )
   PUBLIC oApp, oBtn2, oBtn3, oLbl12, oLbl13

   oApp := _OOHG_AppObject()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      CLIENTAREA WIDTH 640 HEIGHT 480 ;
      TITLE "Application Class Sample" ;
      MAIN ;
      HELPBUTTON

      @ 10, 10 LABEL lbl_1 ;
         AUTOSIZE ;
         VALUE "Exe name: " + oApp:ExeName

      @ 40, 10 LABEL lbl_2 ;
         AUTOSIZE ;
         VALUE "Drive: " + oApp:Drive

      @ 70, 10 LABEL lbl_3 ;
         AUTOSIZE ;
         VALUE "Path: " + oApp:Path

      @ 100, 10 LABEL lbl_4 ;
         AUTOSIZE ;
         VALUE "Filename: " + oApp:FileName

      @ 130, 10 LABEL lbl_5 ;
         AUTOSIZE ;
         VALUE "Argument Count: " + LTrim( Str( oApp:ArgC ) )

      @ 160, 10 LABEL lbl_6 ;
         AUTOSIZE ;
         VALUE AutoType( { "Argument List: ", oApp:Args } )

      @ 190, 10 LABEL lbl_7 ;
         AUTOSIZE ;
         VALUE "Main Form: " + oApp:MainName

      @ 220, 10 LABEL lbl_8 ;
         AUTOSIZE ;
         VALUE "BackColor: " + ColorToStr( oApp:BackColor )

      @ 250, 10 LABEL lbl_9 ;
         AUTOSIZE ;
         VALUE "Row, Col: " + LTrim( Str( oApp:Row ) ) + ", " + LTrim( Str( oApp:Col ) )

      @ 280, 10 LABEL lbl_10 ;
         AUTOSIZE ;
         VALUE "Width, Height: " + LTrim( Str( oApp:Width ) ) + ", " + LTrim( Str( oApp:Height ) )

      @ 310, 10 LABEL lbl_11 ;
         AUTOSIZE ;
         VALUE "Title: " + oApp:Title

      @ 340, 10 LABEL lbl_12 ;
         OBJ oLbl12 ;
         AUTOSIZE ;
         VALUE "Topmost: " + IF( oApp:Topmost, ".T.", ".F." )

      @ 370, 10 LABEL lbl_13 ;
         OBJ oLbl13 ;
         AUTOSIZE ;
         VALUE "Help Button: " + IF( oApp:HelpButton, ".T.", ".F." )

      @ 400, 10 BUTTON btn_1 ;
         CAPTION "Cursor Hand" ;
         ACTION oApp:Cursor := IDC_HAND

      @ 400, 120 BUTTON btn_2 ;
         OBJ oBtn2 ;
         CAPTION "Hide Help" ;
         ACTION ChangeHelpButton()

      @ 400, 230 BUTTON btn_3 ;
         OBJ oBtn3 ;
         CAPTION "Topmost" ;
         ACTION ChangeTopmost()

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

STATIC FUNCTION ColorToStr( nColor )
  LOCAL cRet

  IF nColor == NIL
     cRet := "NIL (COLOR_BTNFACE)"
  ELSE
     cRet := "{ " + ;
             LTrim( Str( GetRed( nColor ) ) ) + ;
             ", " + ;
             LTrim( Str( GetGreen( nColor ) ) ) + ;
             ", " + ;
             LTrim( Str( GetBlue( nColor ) ) ) + ;
             " }"
  ENDIF

RETURN cRet

STATIC FUNCTION ChangeTopmost()

   IF oApp:Topmost
      oApp:Topmost := .F.
      oBtn3:Caption := "Topmost"
      oLbl12:Value := "Topmost: " + ".F."
   ELSE
      oApp:Topmost := .T.
      oBtn3:Caption := "No Topmost"
      oLbl12:Value := "Topmost: " + ".T."
   ENDIF

RETURN Nil

STATIC FUNCTION ChangeHelpButton()

   IF oApp:HelpButton
      oApp:HelpButton := .F.
      oBtn2:Caption := "Show Help"
      oLbl13:Value := "Help Button: " + ".F."
   ELSE
      oApp:HelpButton := .T.
      oBtn2:Caption := "Hide Help"
      oLbl13:Value := "Help Button: " + ".T."
   ENDIF

RETURN Nil

/*
 * EOF
 */
