/*
 * Combobox Sample # 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set, get and change the height
 * of the editbox and of the options in the listbox.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'ComboBox Demo' ;
      MAIN

      @ 10,10 COMBOBOX cmb_1 ;
         OBJ oCombo ;
         ITEMS { "A", "B", "C", "D", "E", "F", "G", "H", "I"  } ;
         VALUE 3 ;
         EDITHEIGHT 17 ;
         OPTIONSHEIGHT 15

      @ 10, 200 LABEL lbl_1 ;
         VALUE "HEIGHT" ;
         AUTOSIZE

      @ 60, 200 BUTTON btn_1 ;
         CAPTION "Show" ;
         ACTION AutoMsgBox( { "EditHeight=", oCombo:EditHeight, "OptionsHeight", oCombo:OptionsHeight } )

      @ 110, 200 LABEL lbl_2 ;
         VALUE "edit" ;
         WIDTH 40

      @ 110, 250 TEXTBOX txt_1 OBJ oEdHt ;
         NUMERIC PICTURE "999" ;
         WIDTH 50 ;
         TOOLTIP "Enter new EditHeight and press 'Change Heights'."

      @ 160, 200 LABEL lbl_3 ;
         VALUE "opt." ;
         WIDTH 40

      @ 160, 250 TEXTBOX txt_2 OBJ oOpHt ;
         NUMERIC PICTURE "999" ;
         WIDTH 50 ;
         TOOLTIP "Enter new OptionsHeight and press 'Change Heights'."

      @ 210, 200 BUTTON btn_2 ;
         CAPTION "Change Heights" ;
         ACTION ( oCombo:EditHeight := oEdHt:Value, oCombo:OptionsHeight := oOpHt:Value )

      @ 10, 400 LABEL lbl_4 ;
         VALUE "FONT" ;
         AUTOSIZE

      @ 60, 400 BUTTON btn_3 ;
         CAPTION "Show" ;
         ACTION AutoMsgBox( { oCombo:FontName, oCombo:FontSize } )

      @ 110, 400 LABEL lbl_5 ;
         VALUE "size" ;
         WIDTH 40

      @ 110, 450 TEXTBOX txt_3 OBJ oSize ;
         NUMERIC PICTURE "999" ;
         WIDTH 50 ;
         TOOLTIP "Enter new font size and press 'Change Font'."

      @ 210, 400 BUTTON btn_4 ;
         CAPTION "Change Font" ;
         ACTION oCombo:SetFont( NIL, oSize:Value )

      @ 260, 10 LABEL lbl_6 ;
         WIDTH 600 ;
         HEIGHT 200 ;
         VALUE "Under Win7/10 the defaults are EDITHEIGHT = 17 and OPTIONSHEIGHT = 15." + CRLF + ;
               "The control, by default, sizes the editbox to fit the font size." + CRLF + ;
               "If you change the font, the control is resized and the previous values of EditHeight and OptionsHeight are lost." + CRLF + ;
               "To keep then, use:" + CRLF + ;
               "   nOldEditHeight := oCombo:EditHeight" + CRLF + ;
               "   nOldOptionsHeight := oCombo:OptionsHeight" + CRLF + ;
               "   oCombo:SetFont( ... )" + CRLF + ;
               "   oCombo:EditHeight := nOldEditHeight" + CRLF + ;
               "   oCombo:OptionsHeight := nOldOptionsHeight" + CRLF + ;
               "Note that the item displayed in the editbox is always placed at the top-left corner by Windows."


      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
