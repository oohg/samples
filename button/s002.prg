/*
 * Button Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Partially adapted from ooHG's distribution sample (see
 * samples\button_mix) mantained by Ciro Vargas Clemow
 * <pcman2010@yahoo.com>
 *
 * This sample shows how to display buttons with text and/or an image.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download Button6.bmp from
 * https://github.com/oohg/samples/tree/master/button
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 600 ;
      MAIN ;
      TITLE "ooHG - Button Demo" ;
      BACKCOLOR YELLOW

      @ 10,80 BUTTON btn_11 ;
         OBJ But1 ;
         CAPTION "&Click Me" ;
         PICTURE "hbprint_print" ;
         ACTION if( But1:ImageMargin()[1] == 0, But1:ImageMargin( {-20, 0, 0, 0} ), But1:ImageMargin( {0, 10, 0, 0} ) ) ;
         LEFT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Click to change image's margins." ;
         IMAGEMARGIN {0, 10, 0, 0} ;
         WINDRAW

      @ 80,80 BUTTON btn_12 ;
         CAPTION "On the right" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_12') ;
         RIGHT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the right) button." ;
         IMAGEMARGIN {0, 0, 0, 10} ;
         WINDRAW

      @ 150,80 BUTTON btn_13 ;
         CAPTION "On the top" ;
         PICTURE "hbprint_print"  ;
         ACTION MsgInfo('btn_13') ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the top) button." ;
         IMAGEMARGIN {10, 0, 0, 0} ;
         WINDRAW

      @ 220,80 BUTTON btn_14 ;
         CAPTION "On the bottom" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_14') ;
         BOTTOM ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the bottom) button." ;
         IMAGEMARGIN {0, 0, 10, 0} ;
         WINDRAW

      @ 290,80 BUTTON btn_15 ;
         CAPTION "Really Long &Multiline Text Only Button"  ;
         MULTILINE ;
         ACTION MsgInfo('btn_15') ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Multiline text only button." ;
         IMAGEMARGIN {150, 150, 150, 150} ;
         WINDRAW

      @ 360,80 BUTTON btn_16 ;
         PICTURE "Button6.bmp" ;
         ACTION MsgInfo('btn_16') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Image (centered) only button, OOHGDRAW." ;
         WINDRAW

      @ 430,80 BUTTON btn_17 ;
         CAPTION "Texto y             &Bitmap" ;
         PICTURE  "hbprint_save"   ;
         ACTION MsgInfo('btn_17') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (centered) button." ;
         WINDRAW

      @ 510,80 LABEL lbl_1 ;
          VALUE "WINDRAW" ;
          BOLD ;
          TRANSPARENT

      @ 10,400 BUTTON btn_21 ;
         OBJ But1 ;
         CAPTION "&Click Me" ;
         PICTURE "hbprint_print" ;
         ACTION if( But1:ImageMargin()[1] == 0, But1:ImageMargin( {-20, 0, 0, 0} ), But1:ImageMargin( {0, 10, 0, 0} ) ) ;
         LEFT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Click to change image's margins." ;
         IMAGEMARGIN {0, 10, 0, 0} ;
         OOHGDRAW

      @ 80,400 BUTTON btn_22 ;
         CAPTION "On the right" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_22') ;
         RIGHT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the right) button." ;
         IMAGEMARGIN {0, 0, 0, 10} ;
         OOHGDRAW

      @ 150,400 BUTTON btn_23 ;
         CAPTION "On the top" ;
         PICTURE "hbprint_print"  ;
         ACTION MsgInfo('btn_23') ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the top) button." ;
         IMAGEMARGIN {10, 0, 0, 0} ;
         OOHGDRAW

      @ 220,400 BUTTON btn_24 ;
         CAPTION "On the bottom" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_24') ;
         BOTTOM ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the bottom) button." ;
         IMAGEMARGIN {0, 0, 10, 0} ;
         OOHGDRAW

      @ 290,400 BUTTON btn_25 ;
         CAPTION "Really Long &Multiline Text Only Button"  ;
         MULTILINE ;
         ACTION MsgInfo('btn_25') ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Multiline text only button." ;
         IMAGEMARGIN {150, 150, 150, 150} ;
         OOHGDRAW

      @ 360,400 BUTTON btn_26 ;
         PICTURE "Button6.bmp" ;
         ACTION MsgInfo('btn_26') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Image (centered) only button, OOHGDRAW." ;
         OOHGDRAW

      @ 430,400 BUTTON btn_27 ;
         CAPTION "Texto y             &Bitmap" ;
         PICTURE  "hbprint_save"   ;
         ACTION MsgInfo('btn_27') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (centered) button." ;
         OOHGDRAW

      @ 510,400 LABEL lbl_2 ;
          VALUE "OOHGDRAW" ;
          BOLD ;
          TRANSPARENT

      ON KEY ESCAPE ACTION Form_1.Release

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
