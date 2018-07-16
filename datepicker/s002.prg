/*
 * DatePicker Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define customized formats.
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
      TITLE "ooHG DatePicker Demo" ;
      MAIN

      @ 10,10 DATEPICKER Date_1 ;
         VALUE CToD("01/01/2001") ;
         TOOLTIP "DatePicker Control" ;
         DATEFORMAT "'Selected: 'hh':'mm':'ss ddddMMMdd', 'yyy" ;
         WIDTH 290

      @ 10,400 DATEPICKER Date_2 OBJ oDate2 ;
         VALUE CToD("01/01/2001") ;
         TOOLTIP "DatePicker Control ShowNone RightAlign" ;
         SHOWNONE ;
         RIGHTALIGN ;
         DATEFORMAT "dd'.'MM'.'yyy"

      @ 100,10 DATEPICKER Date_3 ;
         VALUE CToD("01/01/2001") ;
         TOOLTIP "DatePicker Control" ;
         WIDTH 290 ;
         DATEFORMAT "dddd'--'MMM'--'yy"

      @ 100,400 DATEPICKER Date_4 OBJ oDate4 ;
         VALUE CToD("01/01/2001") ;
         TOOLTIP "DatePicker Control ShowNone RightAlign" ;
         SHOWNONE ;
         RIGHTALIGN

      @ 230, 010 BUTTON but_1 CAPTION "Clear 2" ACTION oDate2:Value := CToD( "//" )
      @ 230, 310 BUTTON but_2 CAPTION "Clear 4" ACTION oDate4:Value := 0
      @ 270, 010 BUTTON but_3 CAPTION "Set 2 current" ACTION oDate2:Value := Date()

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
