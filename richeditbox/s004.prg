/*
 * RichEditBox Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how change the font of the selected text.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL cRchTxt := "{\rtf1\fbidis\ansi\ansicpg1252\deff0\deflang3082{\fonttbl{\f0\fnil\fcharset0 Courier New;}{\f1\fswiss\fprq2\fcharset0 Calibri;}}" + ;
                    "{\colortbl ;\red0\green0\blue0;\red255\green0\blue0;}" + ;
                    "\viewkind4\uc1\pard\ltrpar\cf1\f0\fs24 Acidez (en \'e1.oleico, CEE 2568/91 Anexo II):.......      %\par" + ;
                    "\pard\ltrpar\sa160\sl252\slmult1\cf2\ul\b\f1\fs72 PRUEBA\ulnone\b0\fs22\par" + ;
                    "\ul\b\fs72\par" + ;
                    "\pard\ltrpar\cf1\ulnone\b0\f0\fs24\par}"

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 520 ;
      NOSIZE ;
      NOMAXIMIZE ;
      FONT "Arial" ;
      SIZE 12 ;
      TITLE "Change the selection's font"

      @ 10,10 RICHEDITBOX rch_1 OBJ oRich ;
         WIDTH 600 ;
         HEIGHT 400 ;
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
         SEPARATOR
         MENUITEM 'Change font' ACTION {|| ChangeFont( oRich )  }
      END MENU

      @ 430, 10 LABEL lbl_1 AUTOSIZE ;
         VALUE "Use the context menú to change de font!"

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION ChangeFont( oRich )

   LOCAL aPos, aOldFont, aNewFont

   aPos := oRich:GetSelection()
   IF Empty( oRich:Value ) .OR. ( aPos[2] <= aPos[1] )
      MsgInfo( "Can't change font because no text is selected !" )
      RETURN NIL
   ENDIF

   aOldFont := oRich:GetSelectionFont()          // { cFontName, nFontSize, lBold, lItalic, nTextColor, lUnderline, lStrikeout, nCharset }

   aNewFont := GetFont( aOldFont[1], aOldFont[2], aOldFont[3], aOldFont[4], aOldFont[5], aOldFont[6], aOldFont[7], aOldFont[8] )

   IF aOldFont[1] == aNewFont[1] .AND. aOldFont[2] == aNewFont[2] .AND. aOldFont[3] == aNewFont[3] .AND. aOldFont[4] == aNewFont[4] .AND. ;
      aOldFont[5, 1] == aNewFont[5, 1] .AND. aOldFont[5,2] == aNewFont[5, 2] .AND. aOldFont[5, 3] == aNewFont[5, 3]  .AND. ;
      aOldFont[6] == aNewFont[6] .AND. aOldFont[7] == aNewFont[7] .AND. aOldFont[8] == aNewFont[8]
      MsgInfo( "No property was modified !" )
      RETURN NIL
   ENDIF

   IF Empty( aNewFont[1] )
      MsgInfo( "Change was canceled by user !" )
   ELSE
      oRich:SetSelectionFont( .T., aNewFont[1], aNewFont[2], aNewFont[3], aNewFont[4], aNewFont[5], aNewFont[6], aNewFont[7] )
   ENDIF

   RETURN NIL

/*
 * EOF
 */
