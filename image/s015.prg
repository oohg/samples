/*
 * Image Sample # 15
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create "transparent" checkbox
 * and radiogroup controls over an image control and how
 * to change the background at run time.
 *
 * You can download logo.jpg and back.bmp from:
 * https://github.com/oohg/samples/tree/master/image
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()
   LOCAL oImg

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 400 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "Controls with transparent background"

      @ 00, 00 IMAGE img_1 ;
         PICTURE "logo.jpg" ;
         WIDTH 450 HEIGHT 400 ;
         OBJ oImg1

      @ 00, 00 IMAGE img_2 ;
         PICTURE "back.bmp" ;
         WIDTH 450 HEIGHT 400 ;
         OBJ oImg2 INVISIBLE

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Change Image" ;
         FONTCOLOR BLUE ;
         ACTION SwitchImages()

      @ 100,160 CHECKBOX chk_1 OBJ oCheck ;
         WIDTH 130 ;
         VALUE .F. ;
         CAPTION 'CheckBox ' ;
         FONTCOLOR GREEN BOLD UNDERLINE SIZE 14 ;
         LEFTALIGN ;
         BACKGROUND oImg1

      @ 220,300 RADIOGROUP rdg_1 OBJ oRadio ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 25 ;
         FONTCOLOR RED BOLD SIZE 14 ;
         BACKGROUND oImg1

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION SwitchImages

   STATIC i := 1

   IF i == 1
      i := 2
      oImg2:Visible := .T.
      oImg1:Visible := .F.
      oRadio:oBkGrnd := oImg2
      oCheck:oBkGrnd := oImg2
   ELSE
      i := 1
      oImg1:Visible := .T.
      oImg2:Visible := .F.
      oRadio:oBkGrnd := oImg1
      oCheck:oBkGrnd := oImg1
   ENDIF

   RETURN NIL

/*
 * EOF
 */
