/*
 * RadioGroup Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how display different tooltips for
 * each option of a RadioGroup control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm1

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 588 ;
      HEIGHT 480 ;
      TITLE 'RadioGroup - Tooltips' ;
      MAIN

      @ 20,20 RADIOGROUP rdg_1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         TOOLTIP { 'Item 1', 'Item 2', 'Item 3', 'Item 4' } ;
         WIDTH 80 ;
         SPACING 24

      @ 20,120 RADIOGROUP rdg_2 ;
         OPTIONS { 'Uno', 'Dos', 'Tres', 'Cuatro' } ;
         TOOLTIP 'ToolTip' ;
         WIDTH 80 ;
         SPACING 24

      @ 200,20 LABEL lbl_1 ;
         VALUE "See what happens when you move the mouse over the items." ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

/*
 * EOF
 */
