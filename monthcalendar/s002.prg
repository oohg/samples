/*
 * MonthCalendar Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Adapted from a MINIGUI sample by
 * Roberto Lopez <roblez@ciudad.com.ar>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE "Month Calendar Control Demo" ;
      ICON "DEMO.ICO" ;
      MAIN

      @ 10,10 MONTHCALENDAR Month_1 ;
         VALUE Date() ;
         TOOLTIP "Month Calendar Control NoToday" ;
         NOTODAY ;
         ON CHANGE { || MsgInfo( "Month_1 Change" ) }

      @ 10,300 BUTTON Button_1 ;
         CAPTION "SET DATE" ;
         ACTION Form_1.Month_1.Value := Date()

      @ 50,300 BUTTON Button_2 ;
         CAPTION "GET DATE" ;
         ACTION MsgInfo( GetDate( Form_1.Month_1.Value ) )

      @ 210,10 MONTHCALENDAR Month_2 ;
         VALUE CToD( "01/01/2001" ) ;
         TOOLTIP "Month Calendar Control NoTodayCircle WeekNumbers" ;
         NOTODAYCIRCLE ;
         WEEKNUMBERS ;
         ON CHANGE { || MsgInfo( "Month_2 Change" ) }

      @ 210,300 BUTTON Button_3 ;
         CAPTION "SET DATE" ;
         ACTION Form_1.Month_2.Value := CToD( "01/01/2001" )

      @ 250,300 BUTTON Button_4 ;
         CAPTION "GET DATE" ;
         ACTION MsgInfo( GetDate( Form_1.Month_2.Value ) )

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

STATIC FUNCTION GetDate( dDate )
   LOCAL cRet := ""

   cRet += "Day: " + StrZero( Day( dDate ), 2 )
   cRet += Space( 2 )
   cRet += "Month: " + StrZero( Month( dDate ), 2 )
   cRet += Space( 2 )
   cRet += "Year: " + StrZero( Year( dDate ), 4 )

   RETURN cRet

/*
 * EOF
 */

