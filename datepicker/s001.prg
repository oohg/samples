/*
 * DatePicker Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define DatePicker controls with
 * SHOWNONE, UPDOWN and RIGHTALIGN styles. How to set a range
 * to limit the date selection. How to change the range using
 * method SETRANGE. How to check the control's style. How to
 * query the selected date and how to check if the selected
 * date is empty.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

  SET DATE BRITISH

	DEFINE WINDOW Form_1 OBJ Ventana ;
      AT 0,0 ;
      WIDTH 600 HEIGHT 400 ;
      TITLE "ooHG DatePicker Demo" ;
      MAIN ;
      FONT "Arial" SIZE 10

      @ 10,10 DATEPICKER Date_1 OBJ Date_1 ;
      VALUE CTOD("01/01/1752") ;
      TOOLTIP "DatePicker Control" ;
      RANGE CTOD("01/01/1752"), CTOD("31/12/9999")
      // minimun and maximun date

      @ 10,310 DATEPICKER Date_2 OBJ Date_2 ;
      VALUE CTOD("01/07/2011") ;
      TOOLTIP "DatePicker Control ShowNone RightAlign" ;
      SHOWNONE ;
      RIGHTALIGN

      @ 230,10 DATEPICKER Date_3 OBJ Date_3 ;
      VALUE CTOD("01/01/2001") ;
      TOOLTIP "DatePicker Control UpDown" ;
      UPDOWN

      @ 230,310 DATEPICKER Date_4 OBJ Date_4 ;
      VALUE CTOD("01/01/2001") ;
      TOOLTIP "DatePicker Control ShowNone UpDown" ;
      SHOWNONE ;
      UPDOWN

      @ 10, 470 BUTTON btn_Set ;
      CAPTION "Change Range" ;
      ACTION Form_1.date_1.SETRANGE(DATE()-10, DATE()+10) ;
      WIDTH 100 ;
      HEIGHT 28

      @ 50, 470 BUTTON btn_1 ;
      CAPTION "Test Date_1" ;
      ACTION MSGBOX(IF(IsWindowStyle(Date_1:HWND, DTS_SHOWNONE), ;
                       "Date_1 has SHOWNONE style.", ;
                       "Date_1 doesn't has SHOWNONE style.")) ;
      WIDTH 100 ;
      HEIGHT 28

      @ 90, 470 BUTTON btn_2 ;
      CAPTION "Test Date_2" ;
      ACTION MSGBOX(IF(IsWindowStyle(Date_2:HWND, DTS_SHOWNONE), ;
                       "Date_2 has SHOWNONE style.", ;
                       "Date_2 doesn't has SHOWNONE style.")) ;
      WIDTH 100 ;
      HEIGHT 28

      @ 130, 470 BUTTON btn_3 ;
      CAPTION "Get Date_3" ;
      ACTION automsgbox(Date_3:value) ;
      WIDTH 100 ;
      HEIGHT 28

      @ 170, 470 BUTTON btn_4 ;
      CAPTION "Get Date_4" ;
      ACTION automsgbox(if(empty(Date_4:value), ;
                        "Date is empty", ;
                        dtoc(Date_4:value))) ;
      WIDTH 100 ;
      HEIGHT 28

      ON KEY ESCAPE ACTION Form_1.Release
	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
