
#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW MAIN ;
      WIDTH 320 ;
      HEIGHT 240 ;
      TITLE "oohg - Text to Speech"

      @ 20, 20 TEXTBOX txt_Data OBJ oText ;
         WIDTH 200 ;
         VALUE "Hola, soy tu computadora."

      @ 90, 20 BUTTON btn_Speak;
         CAPTION "Speak" ;
         ACTION Speak()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN

PROCEDURE Speak

   oTalk := win_OleCreateObject( "SAPI.SPVoice" )
   oTalk:Speak( oText:Value )
   oTalk:WaitUntilDone( 1 )

RETURN

/*
 * EOF
 */
