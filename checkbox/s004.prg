/*
 * Checkbox Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how the CHECKBOX control behaves
 * when is placed inside a Tab control defined without
 * BUTTONS style.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oImage1, oImage2

   SET TOOLTIP MULTILINE ON

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'OOHG - CheckBox inside a Tab without BUTTONS style' ;
      MAIN

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1

         PAGE 'No TRANSPARENT'

            DEFINE CHECKBOX ChkBox_11
               ROW 40
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               TOOLTIP "WINDRAW does not support FONTCOLOR clause"
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_12
               ROW 40
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               TOOLTIP "OOHGDRAW supports FONTCOLOR clause"
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_13
               ROW 80
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW leftalign'
               LEFTALIGN .T.
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_14
               ROW 80
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW leftalign'
               LEFTALIGN .T.
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_15
               ROW 120
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               BACKCOLOR YELLOW
               LEFTALIGN .T.
               WINDRAW .T.
               TOOLTIP "WINDRAW paints the caption over the box, FONTCOLOR is ignored and BACKCOLOR is honored"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_16
               ROW 120
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               BACKCOLOR YELLOW
               LEFTALIGN .T.
               OOHGDRAW .T.
               TOOLTIP "OOHGDRAW avoids painting the caption over the box by adding ellipsis, FONTCOLOR and BACKCOLOR are honored"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_17
               ROW 160
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW nofocusrect'
               NOFOCUSRECT .T.
               WINDRAW .T.
               TOOLTIP "WINDRAW ignores NOFOCUSRECT clause"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_18
               ROW 160
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW nofocusrect'
               NOFOCUSRECT .T.
               OOHGDRAW .T.
               TOOLTIP "OOHGDRAW honors NOFOCUSRECT clause"
            END CHECKBOX

            DEFINE IMAGE Image_1
               OBJECT oImage1
               ROW 200
               COL 0
               PICTURE "logo.jpg"
               IMAGESIZE .T.
               BORDER .T.
            END IMAGE

            DEFINE CHECKBOX ChkBox_19
               ROW 220
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW background image'
               FONTCOLOR RED
               BACKGROUND oImage1
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_110
               ROW 260
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW background image'
               FONTCOLOR RED
               BACKGROUND oImage1
               OOHGDRAW .T.
            END CHECKBOX

            @ 220, 250 LABEL Label_11 ;
               VALUE "Label" ;
               WIDTH 60 ;
               TOOLTIP "The background is painted with the form's background color"

            @ 220, 400 LABEL Label_12 ;
               VALUE "Label" ;
               WIDTH 60 ;
               TOOLTIP "The background is painted with the form's background color"

         END PAGE

         PAGE 'TRANSPARENT'

            DEFINE CHECKBOX ChkBox_21
               ROW 40
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               TRANSPARENT .T.
               WINDRAW .T.
               TOOLTIP "WINDRAW does not support FONTCOLOR clause"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_22
               ROW 40
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               TRANSPARENT .T.
               OOHGDRAW .T.
               TOOLTIP "OOHGDRAW supports FONTCOLOR clause"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_23
               ROW 80
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW leftalign'
               LEFTALIGN .T.
               TRANSPARENT .T.
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_24
               ROW 80
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW leftalign'
               LEFTALIGN .T.
               TRANSPARENT .T.
               OOHGDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_25
               ROW 120
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               BACKCOLOR YELLOW
               LEFTALIGN .T.
               TRANSPARENT .T.
               WINDRAW .T.
               TOOLTIP "WINDRAW paints the caption over the box, FONTCOLOR is ignored and TRANSPARENT takes precedence over BACKCOLOR thus BACKCOLOR is ignored"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_26
               ROW 120
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               BACKCOLOR YELLOW
               LEFTALIGN .T.
               TRANSPARENT .T.
               OOHGDRAW .T.
               TOOLTIP "OOHGDRAW avoids painting the caption over the box by adding ellipsis, FONTCOLOR is honored and TRANSPARENT takes precedence over BACKCOLOR thus BACKCOLOR is ignored"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_27
               ROW 160
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW nofocusrect'
               NOFOCUSRECT .T.
               TRANSPARENT .T.
               WINDRAW .T.
               TOOLTIP "WINDRAW ignores NOFOCUSRECT clause"
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_28
               ROW 160
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW nofocusrect'
               NOFOCUSRECT .T.
               TRANSPARENT .T.
               OOHGDRAW .T.
               TOOLTIP "OOHGDRAW honors NOFOCUSRECT clause"
            END CHECKBOX

            DEFINE IMAGE Image2
               OBJECT oImage2
               ROW 200
               COL 0
               PICTURE "logo.jpg"
               IMAGESIZE .T.
               BORDER .T.
            END IMAGE

            DEFINE CHECKBOX ChkBox_29
               ROW 220
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW background image'
               FONTCOLOR RED
               BACKGROUND oImage2
               TRANSPARENT .T.
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_210
               ROW 260
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW background image'
               FONTCOLOR RED
               BACKGROUND oImage2
               TRANSPARENT .T.
               OOHGDRAW .T.
            END CHECKBOX

            @ 220, 250 LABEL Label_21 ;
               VALUE "Label" ;
               WIDTH 60 ;
               TRANSPARENT ;
               TOOLTIP "TThe background is painted with a brush derived from the control located below"

            @ 220, 400 LABEL Label_22 ;
               VALUE "Label" ;
               WIDTH 60 ;
               TRANSPARENT ;
               TOOLTIP "TThe background is painted with a brush derived from the control located below"

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
