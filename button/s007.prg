/*
 * Button Sample n� 7
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
 * You can download the images from
 * https://github.com/oohg/samples/tree/master/button
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 760 ;
      MAIN ;
      TITLE "ooHG - Button Demo" ;
      BACKCOLOR YELLOW

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 700 ;
         VALUE 1 ;
         BUTTONS

         PAGE 'No TRANSPARENT'

            @ 30,80 BUTTON btn_1_11 ;
               OBJ oBtn_1_11 ;
               CAPTION "&Click Me" ;
               PICTURE "hbprint_print" ;
               ACTION if( oBtn_1_11:ImageMargin()[2] == 0, oBtn_1_11:ImageMargin( {0, 10, 0, 0} ), oBtn_1_11:ImageMargin( {0, 0, 0, 0} ) ) ;
               IMAGEALIGN LEFT ;
               TEXTALIGNH CENTER ;
               TEXTALIGNV VCENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               FONTCOLOR RED ;                                  // Ignored by Windows.
               TOOLTIP "Click to change image's margins." ;
               IMAGEMARGIN {0, 0, 0, 0} ;                       // Win 10 adds a 3px left margin.
               WINDRAW

            @ 30,400 BUTTON btn_1_21 ;
               OBJ oBtn_1_21 ;
               CAPTION "&Click Me" ;
               PICTURE "hbprint_print" ;
               ACTION if( oBtn_1_21:ImageMargin()[2] == 0, oBtn_1_21:ImageMargin( {0, 10, 0, 0} ), oBtn_1_21:ImageMargin( {0, 0, 0, 0} ) ) ;
               IMAGEALIGN LEFT ;
               TEXTALIGNH CENTER ;
               TEXTALIGNV VCENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               FONTCOLOR RED ;
               TOOLTIP "Click to change image's margins." ;
               IMAGEMARGIN {0, 0, 0, 0} ;
               OOHGDRAW

            @ 100,80 BUTTON btn_1_12 ;
               CAPTION "On the right" ;
               PICTURE "hbprint_save" ;
               ACTION MsgInfo( 'btn_1_12' ) ;
               IMAGEALIGN RIGHT ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the right) button." ;
               WINDRAW

            @ 100,400 BUTTON btn_1_22 ;
               CAPTION "On the right" ;
               PICTURE "hbprint_save" ;
               ACTION MsgInfo( 'btn_1_22' ) ;
               IMAGEALIGN RIGHT ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the right) button." ;
               OOHGDRAW

            @ 170,80 BUTTON btn_1_13 ;
               CAPTION "On the top" ;
               PICTURE "hbprint_print" ;
               ACTION MsgInfo( 'btn_1_13' ) ;
               TOP ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the top) button." ;
               WINDRAW

            @ 170,400 BUTTON btn_1_23 ;
               CAPTION "On the top" ;
               PICTURE "hbprint_print" ;
               ACTION MsgInfo( 'btn_1_23' ) ;
               TOP ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the top) button." ;
               OOHGDRAW

            @ 240,80 BUTTON btn_1_14 ;
               OBJ oBtn_1_14 ;
               CAPTION "On the bottom" ;
               PICTURE "hbprint_save" ;
               ACTION AutoMsgBox( oBtn_1_14:aImageMargin ) ;
               BOTTOM ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the bottom) button." ;
               NOFOCUSRECT ;
               WINDRAW

            @ 240,400 BUTTON btn_1_24 ;
               OBJ oBtn_1_24 ;
               CAPTION "On the bottom" ;
               PICTURE "hbprint_save" ;
               ACTION AutoMsgBox( oBtn_1_24:aImageMargin ) ;
               BOTTOM ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the bottom) button." ;
               NOFOCUSRECT ;
               OOHGDRAW

            @ 310,80 BUTTON btn_1_15 ;
               OBJ oBtn_1_15 ;
               CAPTION "Really Long &Multiline Text Only Button" ;
               MULTILINE ;
               ACTION ChangeTextAlignment( oBtn_1_15 ) ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Multiline text only button." ;
               WINDRAW

            @ 310,400 BUTTON btn_1_25 ;
               OBJ oBtn_1_25 ;
               CAPTION "Really Long &Multiline Text Only Button" ;
               MULTILINE ;
               ACTION ChangeTextAlignment( oBtn_1_25 ) ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Multiline text only button." ;
               OOHGDRAW

            @ 380,80 BUTTON btn_1_16 ;
               PICTURE "Button6.bmp" ;
               ACTION MsgInfo('btn_1_16') ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Image (centered) only button, OOHGDRAW." ;
               WINDRAW

            @ 380,400 BUTTON btn_1_26 ;
               PICTURE "Button6.bmp" ;
               ACTION MsgInfo('btn_1_26') ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Image (centered) only button, OOHGDRAW." ;
               OOHGDRAW

            @ 450,80 BUTTON btn_1_17 ;
               CAPTION "Texto y             &Bitmap" ;
               PICTURE  "hbprint_save" ;
               ACTION MsgInfo('btn_1_17') ;
               CENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (centered) button." ;
               WINDRAW

            @ 450,400 BUTTON btn_1_27 ;
               CAPTION "Texto y             &Bitmap" ;
               PICTURE  "hbprint_save" ;
               ACTION MsgInfo('btn_1_27') ;
               CENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (centered) button." ;
               OOHGDRAW

            @ 520,80 BUTTON btn_1_18 ;
               OBJ oBtn_1_18 ;
               CAPTION "This long caption does not fit" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_1_18 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by Windows.
               BACKCOLOR RED ;                      // Applies to the border only.
               SOLID ;                              // Ignored by Windows.
               WINDRAW

            @ 520,400 BUTTON btn_1_28 ;
               OBJ oBtn_1_28 ;
               CAPTION "This long caption does not fit" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_1_28 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by OOHG because FITTXT is not present. See oBtn_1_29.
               BACKCOLOR RED ;                      // Applies to the whole button resulting into a colored flat rectangle.
               SOLID ;                              // Omit this clause to mimic bnt_1_18.
               OOHGDRAW

            @ 590,80 BUTTON btn_1_19 ;
               OBJ oBtn_1_19 ;
               CAPTION "This Caption is even Longer Than Before" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_1_19 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;
               FITTXT ;                 // Ignored by Windows.
               WINDRAW

            @ 590,400 BUTTON btn_1_29 ;
               OBJ oBtn_1_29 ;
               CAPTION "This Caption is even Longer Than Before" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width minus the text's margins." ;
               ACTION ChangeTextAlignment( oBtn_1_29 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;
               FITTXT ;
               OOHGDRAW

            @ 670,80 LABEL lbl_1_1 ;
                VALUE "WINDRAW" ;         // This means painted by Windows.
                BOLD                      // It's the default behaviour when visual styles are not enabled.

            @ 670,400 LABEL lbl_1_2 ;
                VALUE "OOHGDRAW" ;        // This means painted by Windows.
                BOLD                      // It's the default behaviour when visual styles are enabled.

            @ 30, 285 BUTTON btn_1_31 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico IMAGESIZE OOHGDRAW' ) ;
               TOOLTIP "Click me!" ;
               IMAGESIZE ;            // Image alignment defaults to CENTER.
               NOFOCUSRECT ;
               OOHGDRAW

            @ 100, 285 BUTTON btn_1_32 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico IMAGESIZE WINDRAW' ) ;
               TOOLTIP "Click me!" ;
               IMAGESIZE ;
               NOFOCUSRECT ;          // Ignored by Windows.
               WINDRAW

            @ 170, 285 BUTTON btn_1_33 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 WINDRAW' ) ;
               TOOLTIP "Click me!" ;
               WIDTH 48 ;
               HEIGHT 48 ;
               NOFOCUSRECT ;          // Ignored by Windows.
               WINDRAW

            @ 240, 285 BUTTON btn_1_34 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 OOHGDRAW' ) ;
               TOOLTIP "Click me!" ;
               WIDTH 48 ;
               HEIGHT 48 ;
               CENTER ;                           // This is needed because the default is LEFT.
               IMAGEMARGIN {0, 0, 0, 0} ;         // This is needed because the default is {6,10,6,10}.
               NOFOCUSRECT ;
               OOHGDRAW

         END PAGE

         PAGE 'TRANSPARENT'

            @ 30,80 BUTTON btn_2_11 ;
               OBJ oBtn_2_11 ;
               CAPTION "&Click Me" ;
               PICTURE "hbprint_print" ;
               ACTION if( oBtn_2_11:ImageMargin()[2] == 0, oBtn_2_11:ImageMargin( {0, 10, 0, 0} ), oBtn_2_11:ImageMargin( {0, 0, 0, 0} ) ) ;
               IMAGEALIGN LEFT ;
               TEXTALIGNH CENTER ;
               TEXTALIGNV VCENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               FONTCOLOR RED ;                                  // Ignored by Windows.
               TOOLTIP "Click to change image's margins." ;
               IMAGEMARGIN {0, 0, 0, 0} ;                       // Win 10 adds a 3px left margin.
               TRANSPARENT ;
               WINDRAW

            @ 30,400 BUTTON btn_2_21 ;
               OBJ oBtn_2_21 ;
               CAPTION "&Click Me" ;
               PICTURE "hbprint_print" ;
               ACTION if( oBtn_2_21:ImageMargin()[2] == 0, oBtn_2_21:ImageMargin( {0, 10, 0, 0} ), oBtn_2_21:ImageMargin( {0, 0, 0, 0} ) ) ;
               IMAGEALIGN LEFT ;
               TEXTALIGNH CENTER ;
               TEXTALIGNV VCENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               FONTCOLOR RED ;
               TOOLTIP "Click to change image's margins." ;
               IMAGEMARGIN {0, 0, 0, 0} ;
               TRANSPARENT ;
               OOHGDRAW

            @ 100,80 BUTTON btn_2_12 ;
               CAPTION "On the right" ;
               PICTURE "hbprint_save" ;
               ACTION MsgInfo( 'btn_2_12' ) ;
               IMAGEALIGN RIGHT ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the right) button." ;
               TRANSPARENT ;
               WINDRAW

            @ 100,400 BUTTON btn_2_22 ;
               CAPTION "On the right" ;
               PICTURE "hbprint_save" ;
               ACTION MsgInfo( 'btn_2_22' ) ;
               IMAGEALIGN RIGHT ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the right) button." ;
               TRANSPARENT ;
               OOHGDRAW

            @ 170,80 BUTTON btn_2_13 ;
               CAPTION "On the top" ;
               PICTURE "hbprint_print" ;
               ACTION MsgInfo( 'btn_2_13' ) ;
               TOP ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the top) button." ;
               TRANSPARENT ;
               WINDRAW

            @ 170,400 BUTTON btn_2_23 ;
               CAPTION "On the top" ;
               PICTURE "hbprint_print" ;
               ACTION MsgInfo( 'btn_2_23' ) ;
               TOP ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the top) button." ;
               TRANSPARENT ;
               OOHGDRAW

            @ 240,80 BUTTON btn_2_14 ;
               OBJ oBtn_2_14 ;
               CAPTION "On the bottom" ;
               PICTURE "hbprint_save" ;
               ACTION AutoMsgBox( oBtn_2_14:aImageMargin ) ;
               BOTTOM ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the bottom) button." ;
               NOFOCUSRECT ;
               TRANSPARENT ;
               WINDRAW

            @ 240,400 BUTTON btn_2_24 ;
               OBJ oBtn_2_24 ;
               CAPTION "On the bottom" ;
               PICTURE "hbprint_save" ;
               ACTION AutoMsgBox( oBtn_2_24:aImageMargin ) ;
               BOTTOM ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (on the bottom) button." ;
               NOFOCUSRECT ;
               TRANSPARENT ;
               OOHGDRAW

            @ 310,80 BUTTON btn_2_15 ;
               OBJ oBtn_2_15 ;
               CAPTION "Really Long &Multiline Text Only Button" ;
               MULTILINE ;
               ACTION ChangeTextAlignment( oBtn_2_15 ) ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Multiline text only button." ;
               TRANSPARENT ;
               WINDRAW

            @ 310,400 BUTTON btn_2_25 ;
               OBJ oBtn_2_25 ;
               CAPTION "Really Long &Multiline Text Only Button" ;
               MULTILINE ;
               ACTION ChangeTextAlignment( oBtn_2_25 ) ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Multiline text only button." ;
               TRANSPARENT ;
               OOHGDRAW

            @ 380,80 BUTTON btn_2_16 ;
               PICTURE "Button6.bmp" ;
               ACTION MsgInfo('btn_2_16') ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Image (centered) only button, OOHGDRAW." ;
               TRANSPARENT ;
               WINDRAW

            @ 380,400 BUTTON btn_2_26 ;
               PICTURE "Button6.bmp" ;
               ACTION MsgInfo('btn_2_26') ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Image (centered) only button, OOHGDRAW." ;
               TRANSPARENT ;
               OOHGDRAW

            @ 450,80 BUTTON btn_2_17 ;
               CAPTION "Texto y             &Bitmap" ;
               PICTURE  "hbprint_save" ;
               ACTION MsgInfo('btn_2_17') ;
               CENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (centered) button." ;
               TRANSPARENT ;
               WINDRAW

            @ 450,400 BUTTON btn_2_27 ;
               CAPTION "Texto y             &Bitmap" ;
               PICTURE  "hbprint_save" ;
               ACTION MsgInfo('btn_2_27') ;
               CENTER ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "Text and image (centered) button." ;
               TRANSPARENT ;
               OOHGDRAW

            @ 520,80 BUTTON btn_2_18 ;
               OBJ oBtn_2_18 ;
               CAPTION "This long caption does not fit" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_2_18 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by Windows.
               BACKCOLOR RED ;                      // Applies to the border only.
               SOLID ;                              // Ignored by Windows.
               TRANSPARENT ;
               WINDRAW

            @ 520,400 BUTTON btn_2_28 ;
               OBJ oBtn_2_28 ;
               CAPTION "This long caption does not fit" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_2_28 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;        // Ignored by OOHG because FITTXT is not present. See oBtn_2_29.
               BACKCOLOR RED ;                      // Applies to the whole button resulting into a colored flat rectangle.
               SOLID ;                              // Omit this clause to mimic bnt_2_18.
               TRANSPARENT ;
               OOHGDRAW

            @ 590,80 BUTTON btn_2_19 ;
               OBJ oBtn_2_19 ;
               CAPTION "This Caption is even Longer Than Before" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width. The text's margins are ignored." ;
               ACTION ChangeTextAlignment( oBtn_2_19 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;
               FITTXT ;                 // Ignored by Windows.
               TRANSPARENT ;
               WINDRAW

            @ 590,400 BUTTON btn_2_29 ;
               OBJ oBtn_2_29 ;
               CAPTION "This Caption is even Longer Than Before" ;
               WIDTH 140 ;
               HEIGHT 60 ;
               TOOLTIP "The caption is truncated to fit the button큦 width minus the text's margins." ;
               ACTION ChangeTextAlignment( oBtn_2_29 ) ;
               TEXTMARGIN {10, 10, 10, 10} ;
               FITTXT ;
               TRANSPARENT ;
               OOHGDRAW

            @ 670,80 LABEL lbl_2_1 ;
               VALUE "WINDRAW" ;         // This means painted by Windows.
               BOLD ;                    // It's the default behaviour when visual styles are not enabled.
               TRANSPARENT

            @ 670,400 LABEL lbl_2_2 ;
               VALUE "OOHGDRAW" ;        // This means painted by Windows.
               BOLD ;                    // It's the default behaviour when visual styles are not enabled.
               TRANSPARENT

            @ 30, 285 BUTTON btn_2_31 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico IMAGESIZE OOHGDRAW' ) ;
               TOOLTIP "Click me!" ;
               IMAGESIZE ;            // Defaults image alignment to CENTER.
               NOFOCUSRECT ;
               TRANSPARENT ;
               OOHGDRAW

            @ 100, 285 BUTTON btn_2_32 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico IMAGESIZE WINDRAW' ) ;
               TOOLTIP "Click me!" ;
               IMAGESIZE ;
               NOFOCUSRECT ;          // Ignored by Windows.
               TRANSPARENT ;
               WINDRAW

            @ 170, 285 BUTTON btn_2_33 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 WINDRAW' ) ;
               TOOLTIP "Click me!" ;
               WIDTH 48 ;
               HEIGHT 48 ;
               NOFOCUSRECT ;          // Ignored by Windows.
               TRANSPARENT ;
               WINDRAW

            @ 240, 285 BUTTON btn_2_34 ;
               PICTURE 'globe.ico' ;
               ACTION AutoMsgBox( 'globe.ico WIDTH 48 HEIGHT 48 OOHGDRAW' ) ;
               TOOLTIP "Click me!" ;
               WIDTH 48 ;
               HEIGHT 48 ;
               CENTER ;                           // This is needed because the default is LEFT.
               IMAGEMARGIN {0, 0, 0, 0} ;         // This is needed because the default is {6,10,6,10}.
               NOFOCUSRECT ;
               TRANSPARENT ;
               OOHGDRAW

         END PAGE

      END TAB

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
