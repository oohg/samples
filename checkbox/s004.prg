/*
 * Checkbox Sample n° 4
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define various checkboxes
 * with transparent background inside a Tab control
 * defined without BUTTONS style.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oImage

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'ooHg - Transparent CheckBox inside Tab without BUTTONS style' ;
      MAIN

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1

         PAGE 'Page &1'

            DEFINE CHECKBOX ChkBox1
               ROW 40
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by Windows (WINDRAW)'
               FONTCOLOR BLUE
               THREESTATE .T.
               WINDRAW .T.
            END CHECKBOX
            // No TRANSPARENT + No BACKCOLOR -> Draw transparently using a brush derived from TAB.
            // WINDRAW does not support FONTCOLOR clause.

            DEFINE CHECKBOX ChkBox2
               ROW 40
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by OOHG (OOHGDRAW)'
               FONTCOLOR BLUE
               THREESTATE .T.
               OOHGDRAW .T.
            END CHECKBOX
            // OOHGDRAW supports FONTCOLOR clause.

            DEFINE CHECKBOX ChkBox3
               ROW 80
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by Windows (WINDRAW)'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox4
               ROW 80
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by OOHG (OOHGDRAW)'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox5
               ROW 120
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by Windows (WINDRAW)'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               WINDRAW .T.
               BACKCOLOR RED
            END CHECKBOX

            DEFINE CHECKBOX ChkBox6
               ROW 120
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by OOHG (OOHGDRAW)'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               OOHGDRAW .T.
               BACKCOLOR RED
            END CHECKBOX

            DEFINE CHECKBOX ChkBox7
               ROW 160
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by Windows (WINDRAW)'
               NOFOCUSRECT .T.
               WINDRAW .T.
            END CHECKBOX
            // WINDRAW does not support NOFOCUSRECT clause.

            DEFINE CHECKBOX ChkBox8
               ROW 160
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by OOHG (OOHGDRAW)'
               NOFOCUSRECT .T.
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE IMAGE Image
               OBJECT oImage
               ROW 200
               COL 0
               PICTURE "logo.jpg"
               IMAGESIZE .T.
               BORDER .T.
            END IMAGE

            DEFINE CHECKBOX ChkBox9
               ROW 220
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by Windows (WINDRAW)'
               BACKGROUND oImage
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox10
               ROW 260
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'Drew by OOHG (OOHGDRAW)'
               BACKGROUND oImage
               OOHGDRAW .T.
            END CHECKBOX

         END PAGE

         PAGE 'Page &2'
         END PAGE

      END TAB

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
