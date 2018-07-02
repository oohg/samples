/*
 * Checkbox Sample n° 7
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how set and get some properties.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 97, 62 ;
      WIDTH 448 ;
      HEIGHT 400 ;
      MAIN ;
      TITLE "OOHG - Checkbox demo"

      DEFINE TAB Tab_1 ;
         AT 20, 20 ;
         WIDTH 400 ;
         HEIGHT 200

         DEFINE PAGE "p1"

            @ 30, 34 CHECKBOX CheckBox_1 ;
               CAPTION "CheckBox_1" ;
               WIDTH 100 ;
               HEIGHT 28 ;
               TRANSPARENT

            @ 30, 203 CHECKBOX CheckBox_2 ;
               CAPTION "CheckBox_2" ;
               WIDTH 100 ;
               HEIGHT 28 ;
               LEFTALIGN

            DEFINE CHECKBOX Check_1a
               ROW 60
               COL 34
               CAPTION 'Check 1a'
               VALUE .T.
               TOOLTIP 'CheckBox'
            END CHECKBOX

            @ 90, 203 LABEL Label_1 ;
               VALUE "Label" ;
               TRANSPARENT

         END PAGE

         DEFINE PAGE "p2"

            DEFINE CHECKBOX Check_1b
               ROW  50
               COL 203
               CAPTION 'Check 1b'
               VALUE .T.
               TOOLTIP 'CheckBox'
            END CHECKBOX

         END PAGE

      END TAB

      DEFINE MAIN MENU
         POPUP 'M&isc'
            ITEM 'Get CheckBox_1 Value Property' ACTION MsgInfo( iif( Form_1.CheckBox_1.Value, "True", "False" ), 'CheckBox_1' )
            ITEM 'Set CheckBox_1 Row Property'   ACTION Form_1.CheckBox_1.Row := Max( Val( InputBox( 'Enter Row', '' ) ), 1 )
            ITEM 'Set CheckBox_1 Col Property'   ACTION Form_1.CheckBox_1.Col := Max( Val( InputBox( 'Enter Col', '' ) ), 1 )
            SEPARATOR
            ITEM 'Set CheckBox_2 Value Property' ACTION Form_1.CheckBox_2.Value := ! Form_1.CheckBox_2.Value
            ITEM 'Get CheckBox_2 Value Property' ACTION MsgInfo( iif( Form_1.CheckBox_2.Value, "True", "False" ), 'CheckBox_2' )
            ITEM 'Set CheckBox_2 Row Property'   ACTION Form_1.CheckBox_2.Row := Max( Val( InputBox( 'Enter Row', '' ) ), 1 )
            ITEM 'Set CheckBox_2 Col Property'   ACTION Form_1.CheckBox_2.Col := Max( Val( InputBox( 'Enter Col', '' ) ), 1 )
         END POPUP
      END MENU

      @ 260, 203 CHECKBOX CheckBox_98 ;
         CAPTION "CheckBox_98" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         TRANSPARENT

      @ 290, 203 CHECKBOX CheckBox_99 ;
         CAPTION "CheckBox_99" ;
         WIDTH 100 ;
         HEIGHT 28

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */