/*
 * ProgressBar Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a ProgressBar with Marquee
 * style (the control shows a never stopping animated bar),
 * and how to programmaticaly change the style.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL nPrevious := 10

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 466 + GetBorderWidth() ;
      HEIGHT 200 + GetTitleHeight() + 2 * GetBorderHeight() ;
      TITLE "ooHG - Marquee and Normal Styles of ProgressBar Controls" ;
      MAIN

      @ 20,20 PROGRESSBAR Progress_1 ;
         OBJ oProg1 ;
         WIDTH 420 ;
         HEIGHT 26 ;
         SMOOTH ;
         TOOLTIP 'ProgressBar Control with Marquee Style. Click "Stop" button to stop the animation.' ;
         MARQUEE 90
      /*
       * 90 is the time, in milliseconds, between marquee animation updates.
       * The higher the number the slower the pace.
       * If this parameter is zero or negative, the animation is stoped.
       */

      @ 80,20 PROGRESSBAR Progress_2 ;
         OBJ oProg2 ;
         RANGE 0, 100 ;
         WIDTH 420 ;
         HEIGHT 26 ;
         SMOOTH ;
         VALUE 30 ;
         TOOLTIP 'Normal ProgressBar Control. Click "Change Style" button to turn me into Marquee style.'

      @ 140,20 BUTTON Button_1 ;
         OBJ oBut1 ;
         CAPTION "Change Style" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         ACTION nPrevious := ChangeStyle( oProg2, nPrevious, oBut1 ) ;
         TOOLTIP 'Click to turn second ProgressBar into Marquee style and start the animation.'

      @ 140,340 BUTTON Button_2 ;
         OBJ oBut2 ;
         CAPTION "Stop" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         ACTION ToggleMarquee( oProg1, oBut2 ) ;
         TOOLTIP 'Click to stop first marquee.'

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ChangeStyle( oProg, nValue, oBut )

   IF oProg:IsStyleNormal()
      nValue := oProg:Value

      oProg:SetStyleMarquee( 20 )
      oBut:ToolTip := 'Click to turn second ProgressBar into Normal style.'
      oProg:ToolTip := 'Marquee ProgressBar Control. Click "Change Style" button to turn me into Normal style.'
   ELSE
      oProg:SetStyleNormal( nValue )
      oBut:ToolTip := 'Click to turn second ProgressBar into Marquee style.'
      oProg:ToolTip := 'Normal ProgressBar Control. Click "Change Style" button to turn me into Marquee style.'
   ENDIF

   /*
    * SetStyleNormal() sets the progressbar to normal style.
    * If it's parameter is omited or is not numeric or is
    * negative, zero is assumed. This paramater sets the
    * control's value.
    *
    * SetStyleMarquee() sets the progressbar to marquee style.
    * If it's parameter is omited or is not numeric or is
    * negative, the style is changed but the animation doesn't
    * starts. This parameter is the time, in milliseconds,
    * between marquee animation updates.
    *
    * Setting normal style doesn't restores the control's value
    * to the value before setting marquee style. Your must save
    * the control's value if you want to restore it later.
    */

RETURN nValue

FUNCTION ToggleMarquee( oProg, oBut )

   IF oProg:IsStyleMarquee()
      IF oProg:IsMarqueeRunning()
         oProg:StopMarquee()
         oBut:Caption := "Start"
         oBut:ToolTip := 'Click to start first marquee.'
         oProg:ToolTip := 'Marquee ProgressBar Control. Click "Start" button to start the animation.'
      ELSE
         oProg:StartMarquee()
         oBut:Caption := "Stop"
         oBut:ToolTip := 'Click to stop first marquee.'
         oProg:ToolTip := 'Normal ProgressBar Control. Click "Stop" button to stop the animation.'
      ENDIF
   ENDIF

   /*
    * StartMarquee() uses the currently setted time.
    * If this time is negative or zero, it's set to 30.
    *
    * In marquee style, control's value is always 1, so
    * it's not posible to restart the animation from the
    * point it stopped. It always starts from the begining.
    */

RETURN NIL

/*
 * EOF
 */
