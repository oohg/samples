/*
 * MonthCalendar Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set the position of a
 * MonthCalendar control and how to get some properties.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 500 ;
      TITLE 'Win_1' ;
      MAIN ;
      NOSIZE

      DEFINE MAIN MENU
         DEFINE POPUP 'Test'
            MENUITEM 'Set Row'    ACTION Win_1.Control_1.Row := Val( InputBox( 'Enter Row', '' ) )
            MENUITEM 'Set Col'    ACTION Win_1.Control_1.Col := Val( InputBox( 'Enter Col', '' ) )
            MENUITEM 'Get Row'    ACTION MsgInfo( Str( Win_1.Control_1.Row ) )
            MENUITEM 'Get Col'    ACTION MsgInfo( Str( Win_1.Control_1.Col ) )
            MENUITEM 'Get Width'  ACTION MsgInfo( Str( Win_1.Control_1.Width ) )
            MENUITEM 'Get Height' ACTION MsgInfo( Str( Win_1.Control_1.Height ) )
         END POPUP
      END MENU

      @ 10,10 MONTHCALENDAR CONTROL_1

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN NIL

/*
 * EOF
 */


