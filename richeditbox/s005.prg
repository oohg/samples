/*
 * RichEditBox Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to test if the last line of a
 * RICHEDITBOX control is visible.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL cRchTxt := "{\rtf1\fbidis\ansi\ansicpg1252\deff0\deflang3082{\fonttbl{\f0\fnil\fcharset0 Courier New;}{\f1\fswiss\fprq2\fcharset0 Calibri;}}" + ;
                    "{\colortbl ;\red0\green0\blue0;\red255\green0\blue0;}" + ;
                    "\viewkind4\uc1" + ;
                    "\pard\ltrpar\cf1\f0\fs20 01. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 02. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 03. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 04. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 05. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 06. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 07. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 08. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 09. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 10. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 11. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 12. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 13. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 14. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 15. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 16. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 17. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 18. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 19. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 20. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 21. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 22. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 23. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 24. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 25. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 26. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 27. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 28. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 29. Scroll until the last line is visible to enable button\par" + ;
                    "\pard\ltrpar\cf1\f0\fs20 30. Scroll until the last line is visible to enable button\par}"

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 520 ;
      NOSIZE ;
      NOMAXIMIZE ;
      FONT "Arial" ;
      SIZE 12 ;
      TITLE "oohg - Detect if the last line of a RICHEDITBOX control is visible"

      @ 10,10 RICHEDITBOX rch_1 OBJ oRich ;
         WIDTH 600 ;
         HEIGHT 300 ;
         VALUE cRchTxt ONVSCROLL oBtnOK:Enabled := ( oRich:GetLastVisibleLine() + 1 >= oRich:GetLineCount() )

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

      @ 450, 10 BUTTON btn_OK OBJ oBtnOK ;
         CAPTION "EXIT" ;
         ACTION Form_1.Release() ;
         DISABLED

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

/*
 * EOF
 */
