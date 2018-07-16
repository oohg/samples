/*
 * Form Sample n° 11
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to save the current values of the
 * controls of a given form to an array.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION MAIN
   LOCAL oWin, aData := Array(5)

   SetOneArrayItemPerLine( .T. )

   DEFINE WINDOW Win_1 OBJ oWin ;
      AT 0, 0 ;
      TITLE "Save control's values" ;
      WIDTH 400 ;
      HEIGHT 330 ;
      MAIN

      DEFINE TAB Tab1 OBJ oT ;
         AT 5, 5 ;
         WIDTH 300 ;
         HEIGHT 220

         DEFINE PAGE "Data"

            @ 40, 20 COMBOBOX cmb_1 ;
               WIDTH 140 ;
               HEIGHT 100 ;
               ITEMS {"A123456789", "B123456789", "C123456890"} ;
               VALUE 1
            oWin:cmb_1:Block := {|x| aData[1] := x}

            @ 75, 20 TEXTBOX txt_1 ;
               WIDTH 100 ;
               VALUE "Save"
            oWin:txt_1:Block := {|x| aData[2] := x}

            @ 110, 20 TEXTBOX txt_2 ;
               WIDTH 100 ;
               VALUE "Control's"
            oWin:txt_2:Block := {|x| aData[3] := x}

            @ 145, 20 TEXTBOX txt_3 ;
               WIDTH 100 ;
               VALUE "value to"
            oWin:txt_3:Block := {|x| aData[4] := x}

            @ 180, 20 TEXTBOX txt_4 ;
               WIDTH 100 ;
               VALUE "an array."
            oWin:txt_4:Block := {|x| aData[5] := x}

         END PAGE

      END TAB

      @ 250, 20 BUTTON btn_Save ;
         CAPTION 'Save' ;
         ACTION { || oWin:SaveData(), AutoMsgBox( { "Saved values:", hb_DumpVar( aData ) } ) }

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN Nil

/*
 * EOF
 */
