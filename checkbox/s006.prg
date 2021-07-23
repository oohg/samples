/*
 * Checkbox Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how change the text alignment.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'OOHG - Checkbox text alignment and color' ;
      MAIN

      @ 40, 40 LABEL 0 ;
         VALUE "With clause OOHGDRAW ommited or set to .T." ;
         AUTOSIZE

      DEFINE CHECKBOX 0
         ROW 80
         COL 40
         WIDTH 160
         VALUE .F.
         CAPTION 'At Right No Fill'
         THREESTATE .T.
      // LEFTALIGN .F. is not needed because is the default value
      // FILLRECT .F. is not needed because is the default value when LEFTALIGN is .F.
         FONTCOLOR BLUE
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 80
         COL 330
         WIDTH 160
         VALUE .F.
         CAPTION 'At Left Fill'
         THREESTATE .T.
         LEFTALIGN .T.
      // FILLRECT .T. is not needed because is the default value when LEFTALIGN is .T.
         FONTCOLOR RED
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 120
         COL 40
         WIDTH 160
         VALUE .F.
         CAPTION 'At Right Fill'
         THREESTATE .T.
      // LEFTALIGN .F. is not needed because is the default value
         FILLRECT .T.
         FONTCOLOR BLUE
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 120
         COL 330
         WIDTH 160
         VALUE .F.
         CAPTION 'At Left No Fill'
         THREESTATE .T.
         LEFTALIGN .T.
         FILLRECT .F.
         FONTCOLOR RED
      END CHECKBOX

      @ 200, 40 LABEL 0 ;
         VALUE "With clause OOHGDRAW .F." ;
         AUTOSIZE

      DEFINE CHECKBOX 0
         ROW 240
         COL 40
         WIDTH 160
         VALUE .F.
         CAPTION 'At Right No Fill'
         THREESTATE .T.
      // LEFTALIGN .F. is not needed because is the default value
      // FILLRECT .F. is not needed because is the default value when LEFTALIGN is .F.
         FONTCOLOR BLUE
         OOHGDRAW .F.
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 240
         COL 330
         WIDTH 160
         VALUE .F.
         CAPTION 'At Left Fill'
         THREESTATE .T.
         LEFTALIGN .T.
      // FILLRECT .T. is not needed because is the default value when LEFTALIGN is .T.
         FONTCOLOR RED
         OOHGDRAW .F.
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 280
         COL 40
         WIDTH 160
         VALUE .F.
         CAPTION 'At Right Fill'
         THREESTATE .T.
      // LEFTALIGN .F. is not needed because is the default value
         FILLRECT .T.
         FONTCOLOR BLUE
         OOHGDRAW .F.
      END CHECKBOX

      DEFINE CHECKBOX 0
         ROW 280
         COL 330
         WIDTH 160
         VALUE .F.
         CAPTION 'At Left No Fill'
         THREESTATE .T.
         LEFTALIGN .T.
         FILLRECT .F.
         FONTCOLOR RED
         OOHGDRAW .F.
      END CHECKBOX

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   Form_1.Center
   Form_1.Activate

RETURN Nil

/*
 * EOF
 */
