/*
 * AniGIF Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an ANIGIF control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE Main()

   SetOneArrayItemPerLine( .T. )

   DEFINE WINDOW Form_Main ;
      AT 0, 0 ;
      WIDTH 320 ;
      HEIGHT 240 ;
      TITLE 'ANIGIF Demo' ;
      MAIN

      DEFINE MAIN MENU
         MENUITEM '&Play' ACTION oAniGif:Play()
         MENUITEM '&Stop' ACTION oAniGif:Stop()
         MENUITEM '&Info' ACTION ShowInfo()
         MENUITEM 'E&xit' ACTION Form_Main.Release()
      END MENU

      // from disk
      @ 20, 20 ANIGIF myGIF_1 ;
         OBJ oAniGif ;
         FILE "ani-free.gif" ;
         BORDER

      // from rc file
      @ 20, 200 ANIGIF myGIF_2 ;
         FILE "MYGIF" ;
         BORDER

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_Main
   ACTIVATE WINDOW Form_Main

RETURN


PROCEDURE ShowInfo

   oAniGif:Stop()
   AutoMsgBox( { "Name"  + Chr( 9 ) + ": " + oAniGif:FileName, ;
                 "Version"   + Chr( 9 ) + ": " + oAniGif:Version, ;
                 "Width"   + Chr( 9 ) + ": " + LTrim( Str( oAniGif:FrameWidth ) ), ;
                 "Height"  + Chr( 9 ) + ": " + LTrim( Str( oAniGif:FrameHeight ) ), ;
                 "Frames"  + Chr( 9 ) + ": " + LTrim( Str( oAniGif:FrameCount ) ) }, ;
               "GIF Info" )
   oAniGif:Play()

RETURN

/*
 * EOF
 */
