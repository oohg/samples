#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 320 ;
      HEIGHT 600 ;
      MAIN ;
      TITLE "Mix Button Demo"

      @ 10, 80 BUTTON Button_1 OBJ oBut1 ;
         CAPTION "&Click Me" ;
         PICTURE "hbprint_print" ;
         ACTION oBut1:lLibDraw := ! oBut1:lLibDraw ;
         LEFT ;
         WIDTH 140 ;
         BACKCOLOR RED ;
         HEIGHT 70

oBut1:FontColor := RED
//oBut1:Transparent := .T.

      @ 110, 80 BUTTON Button_2 ;
         CAPTION "Cambio &Texto" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 1 ) ;
         RIGHT ;
         WIDTH 140 ;
         BACKCOLOR RED ;
         HEIGHT 70 NOHOTLIGHT

      @ 210, 80 BUTTON Button_3 ;
         CAPTION "Cambio &Imagen" ;
         PICTURE "hbprint_print" ;
         ACTION Cambia( 2 ) ;
         TOP ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         HEIGHT 70 WINDRAW

      @ 310, 80 BUTTON Button_4 OBJ oBut4 ;
         CAPTION "&Deshabilita" ;
         PICTURE "hbprint_save" ;
         ACTION Cambia( 3 ) ;
         BOTTOM ;
         BACKCOLOR RED ;
         WIDTH 140 ;
         HEIGHT 70 WINDRAW

oBut4:Transparent := .T.

      @ 400, 80 BUTTON Button_5 OBJ oBut5 ;
         CAPTION "&Habilita"  ;
         ACTION Cambia( 4 ) ;
         TOOLTIP "boton de texto" ;
         WIDTH 140 ;
         BACKCOLOR RED ;
         BOLD

oBut5:Transparent := .F.

      @ 450, 80 BUTTON Button_6 OBJ oBut6 ;
         PICTURE "Button5.bmp"  ;
         ACTION Msgbox( "action" ) ;
         TOOLTIP "boton de imagen" ;
         BACKCOLOR RED ;
         WIDTH 140

oBut6:Transparent := .F.

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1
RETURN

PROCEDURE Cambia( nPar )

   If nPar == 1
      Form_1.Button_1.Caption := "Nuevo Texto"
   ElseIf nPar == 3
      Form_1.Button_1.Enabled := .F.
   ElseIf nPar == 4
      Form_1.Button_1.Enabled := .T.
   Else
      Form_1.Button_4.Picture := "button5.bmp"
   EndIf
RETURN

/*
 * EOF
 */
