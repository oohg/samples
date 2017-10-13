/*
 * Tab Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a CheckBox or RadioGroup
 * with transparent background inside a Tab control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'CheckBox and RadioGroup with transparent background inside Tab' ;
      MAIN

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1

         PAGE 'Page &1'
            @ 40,20 RADIOGROUP rdg_1 ;
               OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
               WIDTH 80 ;
               SPACING 24 ;
               FONTCOLOR GREEN

            DEFINE CHECKBOX chk_1
               ROW 40
               COL 140
               WIDTH 160
               VALUE .F.
               CAPTION 'Left Align Red Caption'
               THREESTATE .T.
               LEFTALIGN .T.
               FONTCOLOR RED
            END CHECKBOX
         END PAGE

      END TAB

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   Form_1.Center
   Form_1.Activate

RETURN Nil

/*
 * EOF
 */
