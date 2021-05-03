/*
 * Textbox Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to handle a password using a textbox.
 * Please notice this ChangeLog entry:
 *
 * 2018-04-30 13:33 UTC-0300 Fernando Yurisich <fyurisich@oohg.org>
 *   ; Data nOnFocusPos controls the behaviour of textbox, editbox and
 *     richeditbox controls whenever those controls got the focus.
 *   ; When nOnFocusPos is < -3, no text is selected, and the caret
 *     is placed before the first character.
 *   ; When nOnFocusPos == -3, the control's leftmost non-blank
 *     characters are selected, the first character becomes the
 *     anchor point and the caret is placed after the last character.
 *   ; When nOnFocusPos == -2, all the text is selected, the first
 *     character becomes the anchor point and the caret is placed
 *     after the last character.
 *   ; When nOnFocusPos == -1, no text is selected and the caret is
 *     placed after the last character.
 *   ; When nOnFocusPos >= 0 and < Len(text), no text is selected
 *     and the caret is placed before the corresponding character,
 *     being 0 the first.
 *   ; When nOnFocusPos >= Len(text), it behaves likes -1.
 *   ; For editbox and richeditbox controls defaults to -4.
 *   ; For textbox controls defaults to -2.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 300 ;
      TITLE "OOHG - How to use Textbox's FOCUSEDPOS property" ;
      NOMAXIMIZE ;
      NOMINIMIZE ;
      NOSIZE ;
      MAIN

      @ 20,10 TEXTBOX txt_1 OBJ oTxt1 ;
         WIDTH 200 ;
         DATE ;
         FOCUSEDPOS -4

      @ 90,10 TEXTBOX txt_2 OBJ oTxt2 ;
         WIDTH 200 ;
         DATE

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

	Form_1.Center
	Form_1.Activate

   RETURN NIL

/*
 * EOF
 */

