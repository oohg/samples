/*
 * Button Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows the differences between WINDRAW and
 * OOHGDRAW buttons.
 * It also serves as a test case for the TButton class.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 600 ;
      MAIN ;
      TITLE "oohg - Button Demo" ;
      ON INIT Form_1.btn_Nothing.SetFocus()

      @ 10, 80 LABEL 0 ;
         VALUE "WINDRAW"

      @ 60, 80 BUTTON Button_11 OBJ oBut11 ;
         CAPTION "&Toggle HotLight" ;
         PICTURE "hbprint_print" ;
         ACTION ( oBut11:lNoHotLight := ! oBut11:lNoHotLight, oBut11:Redraw() ) ;   // Not supported by Windows
         LEFT ;
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW
      oBut11:FontColor := RED   // Not supported by Win 10

      @ 160, 80 BUTTON Button_12 ;
         CAPTION "Change &Text" ;
         PICTURE "hbprint_save" ;
         ACTION Change( 11 ) ;
         RIGHT ;
         WIDTH 140 ;
         HEIGHT 70 ;
         BACKCOLOR RED ;   // Applies to the border only
         SOLID ;           // Not supported by Windows
         NOHOTLIGHT ;      // Not supported by Windows
         WINDRAW

      @ 260, 80 BUTTON Button_13 ;
         CAPTION "Change &Image" ;
         PICTURE "hbprint_print" ;
         ACTION Change( 15 ) ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW

      @ 360, 80 BUTTON Button_14 OBJ oBut14 ;
         CAPTION "&Disable 1st btn" ;
         PICTURE "hbprint_save" ;
         ACTION Change( 13 ) ;
         BOTTOM ;
         BACKCOLOR RED ;   // Applies to the border only
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW

      @ 450, 80 BUTTON Button_15 OBJ oBut15 ;
         CAPTION "&Enable 1st btn"  ;
         ACTION Change( 14 ) ;
         TOOLTIP "Text-only button" ;
         WIDTH 140 ;
         BOLD ;
         WINDRAW

      @ 500, 80 BUTTON Button_16 OBJ oBut16 ;
         PICTURE "Button5.bmp"  ;
         ACTION Msgbox( "Action!" ) ;
         TOOLTIP "Image-only button" ;
         BACKCOLOR RED ;   // Applies to the border only
         WIDTH 140 ;
         WINDRAW

      @ 10, 400 LABEL 0 ;
         VALUE "OOHGDRAW"

      @ 60, 400 BUTTON Button_21 OBJ oBut21 ;
         CAPTION "&Toggle HotLight" ;
         PICTURE "hbprint_print" ;
         ACTION ( oBut21:lNoHotLight := ! oBut21:lNoHotLight, oBut21:Redraw() ) ;
         LEFT ;
         WIDTH 140 ;
         HEIGHT 70 ;
         OOHGDRAW
      oBut21:FontColor := RED

      @ 160, 400 BUTTON Button_22 ;
         CAPTION "Change &Text" ;
         PICTURE "hbprint_save" ;
         ACTION Change( 21 ) ;
         RIGHT ;
         WIDTH 140 ;
         HEIGHT 70 ;
         BACKCOLOR RED ;                      // Applies to the whole button resulting into a colored flat rectangle
         SOLID ;                              // Omit this clause to mimic Button_12
         NOHOTLIGHT ;
         OOHGDRAW

      @ 260, 400 BUTTON Button_23 ;
         CAPTION "Change &Image" ;
         PICTURE "hbprint_print" ;
         ACTION Change( 25 ) ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 70 ;
         OOHGDRAW

      @ 360, 400 BUTTON Button_24 OBJ oBut24 ;
         CAPTION "&Disable 1st btn" ;
         PICTURE "hbprint_save" ;
         ACTION Change( 23 ) ;
         BOTTOM ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         HEIGHT 70 ;
         OOHGDRAW

      @ 450, 400 BUTTON Button_25 OBJ oBut25 ;
         CAPTION "&Enable 1st btn"  ;
         ACTION Change( 24 ) ;
         TOOLTIP "Text-only button" ;
         WIDTH 140 ;
         BOLD ;
         OOHGDRAW

      @ 500, 400 BUTTON Button_26 OBJ oBut26 ;
         PICTURE "Button5.bmp"  ;
         ACTION Msgbox( "Action!" ) ;
         TOOLTIP "Image-only button" ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         OOHGDRAW

      @ 500, 260 BUTTON btn_Nothing ;
         ACTION NIL

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1
RETURN

PROCEDURE Change( nPar )

   IF nPar == 11
      Form_1.Button_11.Caption := "New Text"
   ELSEIF nPar == 13
      Form_1.Button_11.Enabled := .F.
   ELSEIF nPar == 14
      Form_1.Button_11.Enabled := .T.
   ELSEIF nPar == 15
      Form_1.Button_14.Picture := "button5.bmp"
   ELSEIF nPar == 21
      Form_1.Button_21.Caption := "New Text"
   ELSEIF nPar == 23
      Form_1.Button_21.Enabled := .F.
   ELSEIF nPar == 24
      Form_1.Button_21.Enabled := .T.
   ELSEIF nPar == 25
      Form_1.Button_24.Picture := "button5.bmp"
   ENDIF
RETURN

/*
 * EOF
 */
