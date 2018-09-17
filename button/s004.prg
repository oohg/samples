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
 *
 * You can download the resource file and the images from
 * https://github.com/oohg/samples/tree/master/button
 */

#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 600 ;
      MAIN ;
      TITLE "Mix Button Demo" ;
      ON INIT Form_1.btn_Nothing.SetFocus()

      @ 10, 80 LABEL 0 ;
         VALUE "WINDRAW"

      @ 60, 80 BUTTON Button_11 OBJ oBut11 ;
         CAPTION "&Toggle HotLight" ;
         PICTURE "hbprint_print" ;
         ACTION ( oBut11:lNoHotLight := ! oBut11:lNoHotLight, oBut11:Redraw() ) ;          // Not supported by Windows
         LEFT ;
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW
      oBut11:FontColor := RED

      @ 160, 80 BUTTON Button_12 ;
         CAPTION "Cambio &Texto" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 11 ) ;
         RIGHT ;
         WIDTH 140 ;
         BACKCOLOR RED SOLID ;                                                                       // Not supported by Windows
         HEIGHT 70 ;
         NOHOTLIGHT ;                                                                      // Not supported by Windows
         WINDRAW

      @ 260, 80 BUTTON Button_13 ;
         CAPTION "Cambio &Imagen" ;
         PICTURE "hbprint_print" ;
         ACTION Cambia( 15 ) ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW

      @ 360, 80 BUTTON Button_14 OBJ oBut14 ;
         CAPTION "&Deshabilita" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 13 ) ;
         BOTTOM ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         HEIGHT 70 ;
         WINDRAW

      @ 450, 80 BUTTON Button_15 OBJ oBut15 ;
         CAPTION "&Habilita"  ;
         ACTION Cambia( 14 ) ;
         TOOLTIP "boton de texto" ;
         WIDTH 140 ;
         BOLD ;
         WINDRAW

      @ 500, 80 BUTTON Button_16 OBJ oBut16 ;
         PICTURE "Button5.bmp"  ;
         ACTION Msgbox( "action" ) ;
         TOOLTIP "boton de imagen" ;
         BACKCOLOR RED ;
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
         CAPTION "Cambio &Texto" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 21 ) ;
         RIGHT ;
         WIDTH 140 ;
         BACKCOLOR RED SOLID ;
         HEIGHT 70 ;
         NOHOTLIGHT ;
         OOHGDRAW

      @ 260, 400 BUTTON Button_23 ;
         CAPTION "Cambio &Imagen" ;
         PICTURE "hbprint_print" ;
         ACTION Cambia( 25 ) ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 70 ;
         OOHGDRAW

      @ 360, 400 BUTTON Button_24 OBJ oBut24 ;
         CAPTION "&Deshabilita" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 23 ) ;
         BOTTOM ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         HEIGHT 70 ;
         OOHGDRAW

      @ 450, 400 BUTTON Button_25 OBJ oBut25 ;
         CAPTION "&Habilita"  ;
         ACTION Cambia( 24 ) ;
         TOOLTIP "boton de texto" ;
         WIDTH 140 ;
         BOLD ;
         OOHGDRAW

      @ 500, 400 BUTTON Button_26 OBJ oBut26 ;
         PICTURE "Button5.bmp"  ;
         ACTION Msgbox( "action" ) ;
         TOOLTIP "boton de imagen" ;
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

PROCEDURE Cambia( nPar )

   IF nPar == 11
      Form_1.Button_11.Caption := "Nuevo Texto"
   ELSEIF nPar == 13
      Form_1.Button_11.Enabled := .F.
   ELSEIF nPar == 14
      Form_1.Button_11.Enabled := .T.
   ELSEIF nPar == 15
      Form_1.Button_14.Picture := "button5.bmp"
   ELSEIF nPar == 21
      Form_1.Button_21.Caption := "Nuevo Texto"
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
