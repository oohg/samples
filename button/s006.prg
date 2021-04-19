/*
 * Button Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the fontcolor and
 * backcolor of a button control after its creation.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      OBJ oMain ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 200 ;
      TITLE "OOHG - Change button colors at runtime" ;
      MAIN

      @ 10, 10 BUTTON btn_Target1 ;
         OBJ oTarget1 ;
         CAPTION "TARGET 1" ;
         FONTCOLOR BLUE ;
         BACKCOLOR RED ;
         ACTION AutoMsgBox( {"FontColor is: ", oTarget1:FontColor} )

      @ 10, 150 BUTTON btn_Change1 ;
         OBJ oChange1 ;
         WIDTH 150 ;
         CAPTION "Change TARGET 1" ;
         ACTION ChangeColor( "oTarget1" )

      @ 60, 10 BUTTON btn_Target2 ;
         OBJ oTarget2 ;
         CAPTION "TARGET 2" ;
         FONTCOLOR BLUE ;
         BACKCOLOR RED ;
         SOLID ;
         ACTION AutoMsgBox( {"FontColor is: ", oTarget2:FontColor} )

      @ 60, 150 BUTTON btn_Change2 ;
         OBJ oChange2 ;
         WIDTH 150 ;
         CAPTION "Change TARGET 2" ;
         ACTION ChangeColor( "oTarget2" )

      ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oChange1:SetFocus()
   CENTER WINDOW MainForm
   ACTIVATE WINDOW MainForm

RETURN Nil

FUNCTION ChangeColor( cButton )

   IF aEqual( &cButton:FontColor, BLUE )
      &cButton:FontColor := RED
      &cButton:BackColor := BLUE
   ELSE
      &cButton:FontColor := BLUE
      &cButton:BackColor := RED
   ENDIF

RETURN NIL

/*
 * EOF
 */
