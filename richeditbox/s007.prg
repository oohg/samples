/*
 * RichEditBox Sample # 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to print the contents of a
 * RICHEDITBOX control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "winprint.ch"

FUNCTION Main

   LOCAL cRchTxt := FillText(), oRich

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 520 ;
      NOSIZE ;
      NOMAXIMIZE ;
      FONT "Arial" ;
      SIZE 12 ;
      TITLE "oohg - Print the contents of a RICHEDITBOX control"

      @ 10,10 RICHEDITBOX rch_1 OBJ oRich ;
         WIDTH 600 ;
         HEIGHT 300 ;
         VALUE cRchTxt

      DEFINE CONTEXT MENU CONTROL rch_1
         MENUITEM "Cut" ACTION oRich:Cut()
         SEPARATOR
         MENUITEM "Copy" ACTION oRich:Copy()
         SEPARATOR
         MENUITEM "Paste" ACTION oRich:Paste()
         SEPARATOR
         MENUITEM "Clear" ACTION oRich:Clear()
         SEPARATOR
         MENUITEM 'Select all' ACTION oRich:SetSelection( 0, -1 )
      END MENU

      @ 450, 10 BUTTON btn_Print ;
         CAPTION "PRINT" ;
         ACTION PrintRTF( oRich, .T., 210, 297, 10, 20, 10, 20 )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION FillText

   LOCAL i
   LOCAL cTxt := "{\rtf1\fbidis\ansi\ansicpg1252\deff0\deflang3082{\fonttbl{\f0\fnil\fcharset0 Courier New;}{\f1\fswiss\fprq2\fcharset0 Calibri;}}" + ;
                 "{\colortbl ;\red0\green0\blue0;\red255\green0\blue0;}" + ;
                 "\viewkind4\uc1"

   FOR i := 1 TO 300
      cTxt += "\pard\ltrpar\cf1\f0\fs20 " + StrZero( i, 3, 0 ) + ". This is {\b line} "+ StrZero( i, 3, 0 ) + ".\par"
   NEXT i

   cTxt += "}"

   RETURN cTxt

FUNCTION PrintRTF( oRich, lPreview, nPageWidth, nPageHeight, nLeftMargin, nRightMargin, nTopMargin, nBottomMargin )

   LOCAL hbprn, nCPMin, nLenMax, i, ret, nTop, nLeft, nHeight, nWidth

   hbprn := HBPrinter():New()
   hbprn:SelectPrinter( "", lPreview )

   IF hbprn:error != 0
      MsgStop( "Print cancelled!" )
      RETURN NIL
   ENDIF

   hbprn:SetUnits( 1 ) // mm
   hbprn:StartDoc()

   // Print area
   nTop    := nTopMargin * 20
   nLeft   := nLeftMargin * 20
   nHeight := ( nPageHeight - nTopMargin - nBottomMargin ) * 56.7
   nWidth  := ( nPageWidth - nLeftMargin - nRightMargin ) * 56.7

   SET PRINT MARGINS TOP nTopMargin LEFT nLeftMargin

   hbprn:SetDevMode( DM_ORIENTATION, DMORIENT_PORTRAIT )
   hbprn:SetDevMode( DM_PAPERSIZE, DMPAPER_A4 )

   IF hbprn:nWhatToPrint < 2
      hbprn:nToPage := 0
   ENDIF

   // Print all
   nCPMin  := 0
   nLenMax := oRich:GetTextLength()

   // Render the pages
   ret := 0; i := 1
   DO WHILE ret < nLenMax .and. ret != -1
      IF i >= hbprn:nFromPage .AND. ( i <= hbprn:nToPage .OR. hbprn:nToPage == 0 )
         hbprn:StartPage()
         ret := oRich:Render( hbprn:hDC, nTop, nLeft, nHeight, nWidth, nCPMin, -1, .T. )
         hbprn:EndPage()
      ELSE
         ret := oRich:Render( hbprn:hDC, nTop, nLeft, nHeight, nWidth, nCPMin, -1, .F. )
      ENDIF
      i++
      nCPMin := ret
   ENDDO

   hbprn:EndDoc()
   hbprn:End()

   RETURN NIL

/*
 * EOF
 */
