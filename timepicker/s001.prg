/*
 * TimePicker Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define TimePicker controls with
 * customized formats.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 400 ;
      TITLE "ooHG TimePicker Demo" ;
      MAIN

      @ 010, 010 LABEL Lbl_1 VALUE "1" AUTOSIZE

      @ 010, 020 TIMEPICKER Time_1 OBJ oTime1 ;
         VALUE "20:15:10" ;
         TOOLTIP "TimePicker Control" ;
         TIMEFORMAT "'Selected: 'hh':'mm':'ss ddddMMMdd', 'yyy" ;
         WIDTH 270

      @ 055, 010 LABEL Lbl_5 VALUE "5" AUTOSIZE

      @ 055, 020 TIMEPICKER Time_5 OBJ oTime5 ;
         VALUE "20:15:10" ;
         TOOLTIP "TimePicker Control"

      @ 010, 310 LABEL Lbl_2 VALUE "2" AUTOSIZE

      @ 010, 320 TIMEPICKER Time_2 OBJ oTime2 ;
         VALUE "20:15" ;
         TOOLTIP "TimePicker Control ShowNone" ;
         SHOWNONE ;
         TIMEFORMAT "HH' and 'mm' with 'ss' seconds'" ;
         WIDTH 200

      @ 100, 010 LABEL Lbl_3 VALUE "3" AUTOSIZE

      @ 100, 020 TIMEPICKER Time_3 ;
         VALUE "20:15" ;
         TOOLTIP "TimePicker Control"

      @ 100, 390 LABEL Lbl_4 VALUE "4" AUTOSIZE

      @ 100, 400 TIMEPICKER Time_4 OBJ oTime4 ;
         VALUE "20:15" ;
         TOOLTIP "TimePicker Control ShowNone" ;
         SHOWNONE

      // Set to "00:00:00"
      @ 190, 010 BUTTON but_1 CAPTION 'Set 1 to ""' ACTION oTime1:Value := ""
      // Set to "12:00:00"
      @ 230, 010 BUTTON but_2 CAPTION 'Set 5 to ""' ACTION oTime5:Value := ""
      // Not valid times are converted to "00:00:00"
      @ 270, 010 BUTTON but_3 CAPTION "Set 2 invalid" ACTION oTime2:Value := "99:99:99"
      // Set to a valid time
      @ 310, 010 BUTTON but_4 CAPTION "Set 2 valid" ACTION oTime2:Value := Time()
      // Set no time
      @ 190, 310 BUTTON but_5 CAPTION 'Set 2 to "" (clear)' ACTION oTime2:Value := Nil
      // Set current time (any number is the same)
      @ 230, 310 BUTTON but_6 CAPTION "Set 4 to current" ACTION oTime4:Value := 33
      // Set no time
      @ 270, 310 BUTTON but_7 CAPTION 'Set 4 to "" (clear)' ACTION oTime4:Value := Nil

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
