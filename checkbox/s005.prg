/*
 * Checkbox Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a "transparent" checkbox
 * over a form with a backimage.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download logo.jpg from:
 * https://github.com/oohg/samples/tree/master/CheckBox
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 97,62 ;
      WIDTH 682 ;
      HEIGHT 310 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "OOHG - Transparent CheckBox over a form with backimage" ;
      BACKIMAGE "logo.jpg" STRETCH

      @ 60,120 CHECKBOX chk_1 ;
         OBJ oCheck1 ;
         CAPTION "OOHGDRAW CheckBox" ;
         AUTOSIZE ;
         FONTCOLOR RED ;
         SIZE 20 BOLD ;
         HEIGHT 70 ;
         OOHGDRAW ;
         BACKGROUND oForm

      @ 160,120 CHECKBOX chk_2 ;
         OBJ oCheck2 ;
         CAPTION "WINDRAW CheckBox" ;
         AUTOSIZE ;
         FONTCOLOR RED ;
         SIZE 20 BOLD ;
         HEIGHT 50 ;
         WINDRAW ;
         BACKGROUND oForm

      @ 110,500 BUTTON btn_1 OBJ oButton ;
         CAPTION 'Hide/Show' ACTION ( oCheck1:Visible := ! oCheck1:Visible, oCheck2:Visible := ! oCheck2:Visible )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   oButton:SetFocus()

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */