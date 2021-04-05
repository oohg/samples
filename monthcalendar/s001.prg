/*
 * MonthCalendar Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample is a test case for the MonthCalendar control.
 *
 * Note that changing the current view in a MULTISELECT control,
 * from MCMV_MONTH to another view, generates a change in the
 * control's value. The previous value is lost and a new range
 * is set: for MCMV_YEAR the last days of the month are set,
 * for MCMV_DECADE the last days of the year are set and for
 * MCMV_CENTURY the last days of the decade are set.
 *
 * Note that you can't change the default font if the control
 * uses visual styles.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

PROCEDURE Main

   LOCAL v

   SET DATE BRITISH

   DEFINE WINDOW Win_1 OBJ oWin ;
      AT 0, 0 ;
      WIDTH 1000 ;
      HEIGHT 500 ;
      TITLE "MonthCalendar Control" ;
      MAIN ;
      ON INIT Resize()

      DEFINE MAIN MENU
         POPUP "Actions"
            ITEM "Set Selection Count" ACTION SetMSC()
            ITEM "Get Selection Count" ACTION GetMSC()
            SEPARATOR
            ITEM "Get Current View #1" ACTION AutoMsgBox( oMC1:CurrentView() )
            ITEM "Set Current View #1" ACTION oMC1:CurrentView( Val( InputBox( 'New View 0-3' ) ) )
            ITEM "Get Current View #2" ACTION AutoMsgBox( oMC2:CurrentView() )
            ITEM "Set Current View #2" ACTION oMC2:CurrentView( Val( InputBox( 'New View 0-3' ) ) )
            SEPARATOR
            ITEM "Double #1's width" ACTION ( oMC1:Width *= 2, Resize() )
            ITEM "Double #1's height" ACTION ( oMC2:Height *= 2, Resize() )
            SEPARATOR
            ITEM "Size #1" ACTION AutoMsgBox( { oMC1:Width, oMC1:Height } )
            ITEM "Size #2" ACTION AutoMsgBox( { oMC2:Width, oMC2:Height } )
            SEPARATOR
            ITEM "Set Font #1 Arial 8" ACTION ( oMC1:DisableVisualStyle(), oMC1:SetFont( "Arial", 8 ) )
            ITEM "Set Font #2 Times New 14" ACTION ( oMC1:DisableVisualStyle(), oMC2:SetFont( "Times New", 14 ) )
            SEPARATOR
            ITEM "Month range #1" ACTION AutoMsgBox( oMC1:MonthRange() )
            ITEM "Month range #2" ACTION AutoMsgBox( oMC2:MonthRange() )
            SEPARATOR
            ITEM "Bold previous day" ACTION oMC1:AddBoldDay( oMC1:Value - 1 )
            ITEM "Bold next day" ACTION oMC1:AddBoldDay( oMC1:Value + 1 )
            ITEM "Remove bold days" ACTION ( oMC1:DelBoldDay( oMC1:Value - 1 ), oMC1:DelBoldDay( oMC1:Value + 1 ) )
         END POPUP
      END MENU

      DEFINE STATUSBAR
         STATUSITEM "OOHG Power - Press Esc to Exit"
      END STATUSBAR

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Click" ;
         TOOLTIP "Click me to test LostFocus event" ;
         ACTION AutoMsgBox( "MaxSelCount = " + LTrim( Str( oMC2:MaxSelCount() ) ) )

      @ 50, 10 MONTHCALENDAR mcl_1 OBJ oMC1 ;
         TOOLTIP "Click me to test GotFocus event" ;
         ON GOTFOCUS oLst:AddItem( "GotFocus MC1" ) ;
         ON LOSTFOCUS oLst:AddItem( "LostFocus MC1" ) ;
         ON CHANGE ( oLst:AddItem( "Value MC1 " + DToC( oMC1:Value ) ), oLst:Value := oLst:ItemCount )

      @ 240, 10 MONTHCALENDAR mcl_2 OBJ oMC2 ;
         MULTISELECT ;
         TOOLTIP "Click me to test GotFocus event" ;
         ON GOTFOCUS oLst:AddItem( "GotFocus MC2" ) ;
         ON LOSTFOCUS oLst:AddItem( "LostFocus MC2" ) ;
         ON CHANGE ( v := oMC2:Value, oLst:AddItem( "Value MC2 { " + DToC( v[1] ) + ", " + DToC( v[2] ) + " }" ), oLst:Value := oLst:ItemCount )

      @ 10, 720 LISTBOX lst_3 OBJ oLst ;
         WIDTH 250 ;
         HEIGHT 400

      ON KEY ESCAPE ACTION Win_1.Release()
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN

PROCEDURE SetMSC
   AutoMsgBox( "MaxSelCount = " + LTrim( Str( oMC2:MaxSelCount( Val( InputBox( 'New MaxSelCount' ) ) ) ) ) )
RETURN

PROCEDURE GetMSC
   AutoMsgBox( "MaxSelCount = " + LTrim( Str( oMC2:MaxSelCount() ) ) )
RETURN

PROCEDURE Resize
   oWin:ClientWidth := Max( oMC1:Col + oMC1:Width, oMC2:Col + oMC2:Width ) + 20 + oLst:Width + 20
   oLst:Col := oWin:ClientWidth - 20 - oLst:Width
RETURN

/*
 * EOF
 */
