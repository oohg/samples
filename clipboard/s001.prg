/*
 * Clipboard Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to copy text to and from a
 * TextBox control.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()

  DEFINE WINDOW Form_1 ;
     OBJ oForm ;
     AT 0, 0 ;
     WIDTH 400 ;
     HEIGHT 200 ;
     MAIN ;
     NOSIZE ;
     NOMAXIMIZE ;
     TITLE "ooHG Demo - How to use the Clipboard"

    @ 10,10 LABEL lbl_Content ;
      VALUE "Content:" ;
      WIDTH 60 ;
      HEIGHT 24

    @ 10,70 TEXTBOX txt_Content ;
      VALUE "" ;
      WIDTH 300 ;
      HEIGHT 24 ;
      READONLY ;
      NOTABSTOP

    @ 50,10 LABEL lbl_NewText ;
      VALUE "New text:" ;
      WIDTH 60 ;
      HEIGHT 24

    @ 50,70 TEXTBOX txt_NewText ;
      VALUE "" ;
      WIDTH 300 ;
      HEIGHT 24 ;
      ON CHANGE oForm:btn_SetGet:Enabled := ! EMPTY(oForm:txt_NewText:Value)

    @ 100, 10 BUTTON btn_SetGet ;
       CAPTION "Set+Get" ;
       ACTION (SetClipboardText(oForm:txt_NewText:Value), ;
               oForm:txt_Content:Value := GetClipboardText()) ;
       DISABLED

    @ 100, 130 BUTTON btn_Get ;
       CAPTION "Get" ;
       ACTION oForm:txt_Content:value := GetClipboardText()
  END WINDOW

  oForm:Center()
  ON KEY ESCAPE OF (oForm) ACTION oForm:Release()

  oForm:txt_NewText:SetFocus()
  oForm:Activate()

RETURN Nil

/*
 * EOF
 */
