/*
 * Tab Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to place a CheckBox or RadioGroup
 * with transparent background inside a Tab control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'OOHG - Tab demo' ;
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
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX chk_2
               ROW 80
               COL 140
               WIDTH 160
               VALUE .F.
               CAPTION 'Red Caption Yellow Back'
               THREESTATE .T.
               FONTCOLOR RED
               BACKCOLOR YELLOW
            END CHECKBOX

            @ 200, 30 FRAME frm_1 ;
               WIDTH 160 ;
               HEIGHT 60 ;
               CAPTION "This is a frame"

            @ 280, 30 FRAME frm_2 ;
               WIDTH 200 ;
               HEIGHT 60 ;
               CAPTION "This is a TRANSPARENT frame" ;
               TRANSPARENT

            @ 280, 260 LABEL lbl_1 ;
               VALUE "This is a label" ;
               AUTOSIZE

            @ 320, 260 LABEL lbl_2 ;
               VALUE "This is a TRANSPARENT label" ;
               AUTOSIZE ;
               TRANSPARENT

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
