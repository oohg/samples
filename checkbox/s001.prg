/*
 * Checkbox Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how the CHECKBOX control behaves
 * when is placed inside a Tab control defined with
 * BUTTONS style.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oImage1, oImage2

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'ooHg - CheckBox inside Tab with BUTTONS style' ;
      MAIN

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         BUTTONS

         PAGE 'No TRANSPARENT'

            DEFINE CHECKBOX ChkBox_11
               ROW 40
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               WINDRAW .T.
            END CHECKBOX
            // WINDRAW does not support FONTCOLOR clause
            // except on XP with theme "Window Classic"

            DEFINE CHECKBOX ChkBox_12
               ROW 40
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               OOHGDRAW .T.
            END CHECKBOX
            // OOHGDRAW supports FONTCOLOR clause.

            DEFINE CHECKBOX ChkBox_13
               ROW 80
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_14
               ROW 80
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor leftalign'
               FONTCOLOR BLUE
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
               LEFTALIGN .T.
               WINDRAW .T.
               BACKCOLOR RED
            END CHECKBOX
            // WINDRAW does not truncate long captions on Win10

            DEFINE CHECKBOX ChkBox_16
               ROW 120
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               OOHGDRAW .T.
               BACKCOLOR RED
            END CHECKBOX
            // OOHGDRAW truncates long captions

            DEFINE CHECKBOX ChkBox_17
               ROW 160
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW nofocusrect'
               NOFOCUSRECT .T.
               WINDRAW .T.
            END CHECKBOX
            // WINDRAW ignores NOFOCUSRECT

            DEFINE CHECKBOX ChkBox_18
               ROW 160
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW nofocusrect'
               NOFOCUSRECT .T.
               OOHGDRAW .T.
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
               BACKGROUND oImage1
               WINDRAW .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_110
               ROW 260
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW background image'
               BACKGROUND oImage1
               OOHGDRAW .T.
            END CHECKBOX

            @ 220, 250 LABEL Label_11 ;
               VALUE "Label" ;
               WIDTH 60

            @ 220, 400 LABEL Label_12 ;
               VALUE "Label"

         END PAGE

         PAGE 'TRANSPARENT'

            // TRANSPARENT takes precedence over BACKCOLOR

            DEFINE CHECKBOX ChkBox_21
               ROW 40
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               WINDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX
            // WINDRAW supports FONTCOLOR clause
            // on XP with theme "Window Classic"
            // but not on XP with them "Windows XP"
            // WINDRAW does not support FONTCOLOR
            // clause on Win 10.

            DEFINE CHECKBOX ChkBox_22
               ROW 40
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor'
               FONTCOLOR BLUE
               THREESTATE .T.
               OOHGDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX
            // OOHGDRAW supports FONTCOLOR clause
            // on XP with theme "Window Classic"
            // but not on XP with them "Windows XP"
            // OOHGDRAW supports FONTCOLOR clause
            // on Win 10.

            DEFINE CHECKBOX ChkBox_23
               ROW 80
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               WINDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_24
               ROW 80
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               OOHGDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_25
               ROW 120
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               WINDRAW .T.
               BACKCOLOR RED
               TRANSPARENT .T.
            END CHECKBOX
            // WINDRAW does not truncate long captions under Win10
            // BACKCOLOR is ignored

            DEFINE CHECKBOX ChkBox_26
               ROW 120
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW fontcolor backcolor leftalign'
               FONTCOLOR BLUE
               LEFTALIGN .T.
               OOHGDRAW .T.
               BACKCOLOR RED
               TRANSPARENT .T.
            END CHECKBOX
            // OOHGDRAW truncates long captions
            // BACKCOLOR is ignored

            DEFINE CHECKBOX ChkBox_27
               ROW 160
               COL 10
               WIDTH 200
               VALUE .F.
               CAPTION 'WINDRAW nofocusrect'
               NOFOCUSRECT .T.
               WINDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX
            // WINDRAW ignores NOFOCUSRECT

            DEFINE CHECKBOX ChkBox_28
               ROW 160
               COL 260
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW nofocusrect'
               NOFOCUSRECT .T.
               OOHGDRAW .T.
               TRANSPARENT .T.
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
               BACKGROUND oImage2
               WINDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX

            DEFINE CHECKBOX ChkBox_210
               ROW 260
               COL 20
               WIDTH 200
               VALUE .F.
               CAPTION 'OOHGDRAW background image'
               BACKGROUND oImage2
               OOHGDRAW .T.
               TRANSPARENT .T.
            END CHECKBOX

            @ 220, 250 LABEL Label_21 ;
               VALUE "Label" ;
               WIDTH 60 ;
               TRANSPARENT

            @ 220, 400 LABEL Label_22 ;
               VALUE "Label" ;
               TRANSPARENT

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
