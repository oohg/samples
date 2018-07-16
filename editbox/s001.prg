/*
 * EditBox Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to detect when the last line of
 * the text is shown in the display area, using methods
 * GetLastVisibleLine and GetLineCount.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main
   PRIVATE oForm, oCtrl, oLbl, oTmr

   DEFINE WINDOW Frm_1 ;
      AT 0, 0 ;
      OBJ oForm ;
      WIDTH 430 ;
      HEIGHT 430 ;
      CLIENTAREA ;
      NOSIZE ;
      TITLE 'EditBox - Detect when last line scrolls into view' ;
      MAIN ;
      ON INIT FillCtrl()

      @ 10, 10 EDITBOX edt_1 ;
         OBJ oCtrl ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 60 ;
         READONLY ;
         NOHSCROLL

      @ oForm:ClientHeight - 40, 10 LABEL lbl_1 ;
         OBJ oLbl ;
         VALUE "" ;
         WIDTH 300 ;
         HEIGHT 30 ;
         FONTCOLOR BLUE

      DEFINE TIMER tmr_1 OBJ oTmr INTERVAL 200 ACTION CheckEnd()

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   CENTER WINDOW Frm_1
   ACTIVATE WINDOW Frm_1

RETURN NIL

FUNCTION FillCtrl
   LOCAL cLines, i

   cLines := "This is line 001"
   FOR i = 2 TO 100
      cLines += ( CRLF + "This is line " + StrZero( i, 3, 0 ) )
   NEXT
   oCtrl:Value := cLines

RETURN NIL

FUNCTION CheckEnd
   IF oCtrl:GetLastVisibleLine() + 1 == oCtrl:GetLineCount()
       oLbl:Value := "End Reached"
       oLbl:FontColor := RED
   ELSE
       oLbl:Value := "Last visible row " + LTrim( Str( oCtrl:GetLastVisibleLine() + 1 ) ) + " of " + LTrim( Str( oCtrl:GetLineCount() ) )
       oLbl:FontColor := BLUE
   ENDIF
RETURN NIL

/*
 * EOF
 */
