/*
 * Button Sample n� 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Partially adapted from ooHG's distribution sample (see
 * samples\button_mix) mantained by Ciro Vargas Clemow
 * <pcman2010@yahoo.com>
 *
 * This sample shows how to display buttons with text
 * and/or an image.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/button
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 740 ;
      MAIN ;
      TITLE "ooHG - Button Demo" ;
      BACKCOLOR YELLOW

      @ 10,80 BUTTON btn_11 ;
         OBJ But11 ;
         CAPTION "&Click Me" ;
         PICTURE "hbprint_print" ;
         ACTION if( But11:ImageMargin()[2] == 0, But11:ImageMargin( {0, 10, 0, 0} ), But11:ImageMargin( {0, 0, 0, 0} ) ) ;
         IMAGEALIGN LEFT ;
         TEXTALIGNH CENTER ;
         TEXTALIGNV VCENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         FONTCOLOR RED ;                                  // Ignored by Windows.
         TOOLTIP "Click to change image's margins." ;
         IMAGEMARGIN {0, 0, 0, 0} ;
         WINDRAW

      @ 10,400 BUTTON btn_21 ;
         OBJ But21 ;
         CAPTION "&Click Me" ;
         PICTURE "hbprint_print" ;
         ACTION if( But21:ImageMargin()[2] == 3, But21:ImageMargin( {0, 13, 0, 0} ), But21:ImageMargin( {0, 3, 0, 0} ) ) ;
         IMAGEALIGN LEFT ;
         TEXTALIGNH CENTER ;
         TEXTALIGNV VCENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         FONTCOLOR RED ;
         TOOLTIP "Click to change image's margins." ;
         IMAGEMARGIN {0, 3, 0, 0} ;                       // Windows adds a 3px left margin to the image
         OOHGDRAW

      @ 80,80 BUTTON btn_12 ;
         CAPTION "On the right" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_12') ;
         IMAGEALIGN RIGHT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the right) button." ;
         WINDRAW

      @ 80,400 BUTTON btn_22 ;
         CAPTION "On the right" ;
         PICTURE "hbprint_save" ;
         ACTION MsgInfo('btn_22') ;
         IMAGEALIGN RIGHT ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the right) button." ;
         OOHGDRAW

      @ 150,80 BUTTON btn_13 ;
         CAPTION "On the top" ;
         PICTURE "hbprint_print" ;
         ACTION MsgInfo('btn_13') ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the top) button." ;
         WINDRAW

      @ 150,400 BUTTON btn_23 ;
         CAPTION "On the top" ;
         PICTURE "hbprint_print" ;
         ACTION MsgInfo('btn_23') ;
         TOP ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the top) button." ;
         OOHGDRAW

      @ 220,80 BUTTON btn_14 OBJ oBtn14 ;
         CAPTION "On the bottom" ;
         PICTURE "hbprint_save" ;
         ACTION AutoMsgBox( oBtn14:aImageMargin ) ;
         BOTTOM ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the bottom) button." ;
         NOFOCUSRECT ;
         WINDRAW
//         IMAGEMARGIN {10, 0, 10, 0} ;            // Windows wrongly adds the top to the bottom

      @ 220,400 BUTTON btn_24 OBJ oBtn24 ;
         CAPTION "On the bottom" ;
         PICTURE "hbprint_save" ;
         ACTION AutoMsgBox( oBtn24:aImageMargin ) ;
         BOTTOM ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (on the bottom) button." ;
         NOFOCUSRECT ;
         OOHGDRAW
//         IMAGEMARGIN {10, 0, 10, 0} ;            // OOHG works as expected

      @ 290,80 BUTTON btn_15 OBJ oBut15 ;
         CAPTION "Really Long &Multiline Text Only Button" ;
         MULTILINE ;
         ACTION ChangeTextAlignment( oBut15 ) ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Multiline text only button." ;
         WINDRAW

      @ 290,400 BUTTON btn_25 OBJ oBut25 ;
         CAPTION "Really Long &Multiline Text Only Button" ;
         MULTILINE ;
         ACTION ChangeTextAlignment( oBut25 ) ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Multiline text only button." ;
         TEXTMARGIN {0, 10, 0, 10} ;               // This mimics WINDRAW, default is {0,0,0,0}
         OOHGDRAW

      @ 360,80 BUTTON btn_16 ;
         PICTURE "Button6.bmp" ;
         ACTION MsgInfo('btn_16') ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Image (centered) only button, OOHGDRAW." ;
         WINDRAW

      @ 360,400 BUTTON btn_26 ;
         PICTURE "Button6.bmp" ;
         ACTION MsgInfo('btn_26') ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Image (centered) only button, OOHGDRAW." ;
         OOHGDRAW

      @ 430,80 BUTTON btn_17 ;
         CAPTION "Texto y             &Bitmap" ;
         PICTURE  "hbprint_save" ;
         ACTION MsgInfo('btn_17') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (centered) button." ;
         WINDRAW

      @ 430,400 BUTTON btn_27 ;
         CAPTION "Texto y             &Bitmap" ;
         PICTURE  "hbprint_save" ;
         ACTION MsgInfo('btn_27') ;
         CENTER ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "Text and image (centered) button." ;
         OOHGDRAW 

      @ 500,80 BUTTON btn_18 OBJ oBut18 ;
         CAPTION "This long caption does not fit" ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
         ACTION ChangeTextAlignment( oBut18 ) ;
         TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by Windows
         BACKCOLOR RED ;                      // Applies to the border only
         SOLID ;                              // Ignored by Windows
         WINDRAW

      @ 500,400 BUTTON btn_28 OBJ oBut28 ;
         CAPTION "This long caption does not fit" ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
         ACTION ChangeTextAlignment( oBut28 ) ;
         TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by OOHG because FITTXT is not present. See oBut29.
         BACKCOLOR RED ;                      // Applies to the whole button resulting into a colored flat rectangle
         SOLID ;                              // Omit this clause to mimic bnt_18
         OOHGDRAW

      @ 570,80 BUTTON btn_19 OBJ oBut19 ;
         CAPTION "This Caption is even Longer Than Before" ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
         ACTION ChangeTextAlignment( oBut19 ) ;
         TEXTMARGIN {10, 10, 10, 10} ;
         FITTXT ;                 // Ignored by Windows.
         WINDRAW

      @ 570,400 BUTTON btn_29 OBJ oBut29 ;
         CAPTION "This Caption is even Longer Than Before" ;
         WIDTH 140 ;
         HEIGHT 60 ;
         TOOLTIP "The caption is truncated to fit the button큦 width minus the text's margins." ;
         ACTION ChangeTextAlignment( oBut29 ) ;
         TEXTMARGIN {10, 10, 10, 10} ;
         FITTXT ;
         OOHGDRAW

      @ 650,80 LABEL lbl_1 ;
          VALUE "WINDRAW" ;         // This means painted by Windows.
          BOLD ;                    // It's the default behaviour when visual styles are not enabled.
          TRANSPARENT

      @ 650,400 LABEL lbl_2 ;
          VALUE "OOHGDRAW" ;        // This means painted by Windows.
          BOLD ;                    // It's the default behaviour when visual styles are enabled.
          TRANSPARENT

      @ 10, 285 BUTTON btn_31 ;
         PICTURE 'globe.ico' ;
         ACTION AutoMsgBox( 'globe.ico IMAGESIZE OOHGDRAW' ) ;
         TOOLTIP "Click me!" ;
         IMAGESIZE ;            // Defaults image alignment to CENTER
         NOFOCUSRECT ;
         OOHGDRAW

      @ 80, 285 BUTTON btn_32 ;
         PICTURE 'globe.ico' ;
         ACTION AutoMsgBox( 'globe.ico IMAGESIZE WINDRAW' ) ;
         TOOLTIP "Click me!" ;
         IMAGESIZE ;
         NOFOCUSRECT ;          // Ignored by Windows.
         WINDRAW

      @ 150, 285 BUTTON btn_33 ;
         PICTURE 'globe.ico' ;
         ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 WINDRAW' ) ;
         TOOLTIP "Click me!" ;
         WIDTH 48 ;
         HEIGHT 48 ;
         NOFOCUSRECT ;          // Ignored by Windows.
         WINDRAW

      @ 220, 285 BUTTON btn_34 ;
         PICTURE 'globe.ico' ;
         ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 OOHGDRAW' ) ;
         TOOLTIP "Click me!" ;
         WIDTH 48 ;
         HEIGHT 48 ;
         CENTER ;                           // This is needed because the default is LEFT
         IMAGEMARGIN {0, 0, 0, 0} ;         // This is needed because the default is {6,10,6,10}
         NOFOCUSRECT ;
         OOHGDRAW

      ON KEY ESCAPE ACTION Form_1.Release

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
#define BS_LEFT                       256
#define BS_RIGHT                      512
#define BS_CENTER                     768
#define BS_TOP                        1024
#define BS_BOTTOM                     2048
#define BS_VCENTER                    3072
*/

PROCEDURE ChangeTextAlignment( oBut )
   STATIC nTextAlignH := BS_LEFT
   STATIC nTextAlignV := BS_TOP

   nTextAlignH += 256
   IF nTextAlignH > 768
      nTextAlignH := 256
      nTextAlignV += 1024
      IF nTextAlignV > 3072
         nTextAlignV := 1024
      ENDIF
   ENDIF

  oBut:nTextAlign := nTextAlignH + nTextAlignV
  oBut:SizePos()
RETURN

/*
 * EOF
 */
