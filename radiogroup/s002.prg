/*
 * RadioGroup Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample is a test case for OOHGDRAW, WINDRAW, BACKGROUND,
 * BACKCOLOR and TRANSPARENT clauses of a RadioGroup control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 *
 * You can download fondo.bmp from:
 * https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/RadioGroup
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm1, nBack := 1

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 900 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE 'RadioGroup - Test Case' ;
      MAIN ;
      BACKCOLOR PINK

      @ 10, 10 LABEL lbl_111 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 25, 10 LABEL lbl_112 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 40, 10 LABEL lbl_113 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"
      @ 55, 10 LABEL lbl_114 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 80, 10 FRAME frm_11 WIDTH 100 HEIGHT 110

      @ 90, 20 RADIOGROUP rdg_11 ;
         OBJ oR11 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKGROUND oForm1 ;
         BACKCOLOR RED ;
         TRANSPARENT
      oR11:aOptions[ 1 ]:FontColor := GREEN
      oR11:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 120 LABEL lbl_121 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 25, 120 LABEL lbl_122 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 40, 120 LABEL lbl_123 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"

      @ 80, 120 FRAME frm_12 WIDTH 100 HEIGHT 110

      @ 90, 130 RADIOGROUP rdg_12 ;
         OBJ oR12 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKGROUND oForm1 ;
         BACKCOLOR RED ;
         LEFTJUSTIFY
      oR12:aOptions[ 1 ]:FontColor := GREEN
      oR12:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 230 LABEL lbl_131 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 25, 230 LABEL lbl_132 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 55, 230 LABEL lbl_134 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 80, 230 FRAME frm_13 WIDTH 100 HEIGHT 110

      @ 90, 240 RADIOGROUP rdg_13 ;
         OBJ oR13 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKGROUND oForm1 ;
         TRANSPARENT
      oR13:aOptions[ 1 ]:FontColor := GREEN
      oR13:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 340 LABEL lbl_141 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 40, 340 LABEL lbl_143 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"
      @ 55, 340 LABEL lbl_144 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 80, 340 FRAME frm_14 WIDTH 100 HEIGHT 110

      @ 90, 350 RADIOGROUP rdg_14 ;
         OBJ oR14 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKCOLOR RED ;
         TRANSPARENT
      oR14:aOptions[ 1 ]:FontColor := GREEN
      oR14:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 450 LABEL lbl_151 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 55, 450 LABEL lbl_154 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 80, 450 FRAME frm_15 WIDTH 100 HEIGHT 110

      @ 90, 460 RADIOGROUP rdg_15 ;
         OBJ oR15 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         TRANSPARENT
      oR15:aOptions[ 1 ]:FontColor := GREEN
      oR15:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 560 LABEL lbl_161 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 25, 560 LABEL lbl_162 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"

      @ 80, 560 FRAME frm_16 WIDTH 100 HEIGHT 110

      @ 90, 570 RADIOGROUP rdg_16 ;
         OBJ oR16 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKGROUND oForm1
      oR16:aOptions[ 1 ]:FontColor := GREEN
      oR16:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 670 LABEL lbl_171 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"
      @ 40, 670 LABEL lbl_173 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"

      @ 80, 670 FRAME frm_17 WIDTH 100 HEIGHT 110

      @ 90, 680 RADIOGROUP rdg_17 ;
         OBJ oR17 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW ;
         BACKCOLOR RED
      oR17:aOptions[ 1 ]:FontColor := GREEN
      oR17:aOptions[ 2 ]:BackColor := BLUE

      @ 10, 780 LABEL lbl_181 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "OOHGDRAW"

      @ 80, 780 FRAME frm_18 WIDTH 100 HEIGHT 110

      @ 90, 790 RADIOGROUP rdg_18 ;
         OBJ oR18 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         OOHGDRAW              // BACKCOLOR is set to form's BACKCOLOR
      oR18:aOptions[ 1 ]:FontColor := GREEN
      oR18:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 10 LABEL lbl_211 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 225, 10 LABEL lbl_212 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 240, 10 LABEL lbl_213 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"
      @ 255, 10 LABEL lbl_214 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 280, 10 FRAME frm_21 WIDTH 100 HEIGHT 110

      @ 290, 20 RADIOGROUP rdg_21 ;
         OBJ oR21 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKGROUND oForm1 ;
         BACKCOLOR RED ;
         TRANSPARENT ;
         WINDRAW
      oR21:aOptions[ 1 ]:FontColor := GREEN
      oR21:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 120 LABEL lbl_221 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 225, 120 LABEL lbl_222 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 240, 120 LABEL lbl_223 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"

      @ 280, 120 FRAME frm_22 WIDTH 100 HEIGHT 110

      @ 290, 130 RADIOGROUP rdg_22 ;
         OBJ oR22 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKGROUND oForm1 ;
         BACKCOLOR RED ;
         WINDRAW
      oR22:aOptions[ 1 ]:FontColor := GREEN
      oR22:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 230 LABEL lbl_231 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 225, 230 LABEL lbl_232 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"
      @ 255, 230 LABEL lbl_234 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 280, 230 FRAME frm_23 WIDTH 100 HEIGHT 110

      @ 290, 240 RADIOGROUP rdg_23 ;
         OBJ oR23 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKGROUND oForm1 ;
         TRANSPARENT ;
         WINDRAW
      oR23:aOptions[ 1 ]:FontColor := GREEN
      oR23:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 340 LABEL lbl_241 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 240, 340 LABEL lbl_243 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"
      @ 255, 340 LABEL lbl_244 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 280, 340 FRAME frm_24 WIDTH 100 HEIGHT 110

      @ 290, 350 RADIOGROUP rdg_24 ;
         OBJ oR24 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKCOLOR RED ;
         TRANSPARENT ;
         WINDRAW
      oR24:aOptions[ 1 ]:FontColor := GREEN
      oR24:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 450 LABEL lbl_251 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 255, 450 LABEL lbl_254 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "TRANSPARENT"

      @ 280, 450 FRAME frm_25 WIDTH 100 HEIGHT 110

      @ 290, 460 RADIOGROUP rdg_25 ;
         OBJ oR25 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         TRANSPARENT ;
         WINDRAW ;
         LEFTALIGN
      oR25:aOptions[ 1 ]:FontColor := GREEN
      oR25:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 560 LABEL lbl_261 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 225, 560 LABEL lbl_262 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKGROUND"

      @ 280, 560 FRAME frm_26 WIDTH 100 HEIGHT 110

      @ 290, 570 RADIOGROUP rdg_26 ;
         OBJ oR26 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKGROUND oForm1 ;
         WINDRAW
      oR26:aOptions[ 1 ]:FontColor := GREEN
      oR26:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 670 LABEL lbl_271 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 240, 670 LABEL lbl_273 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "BACKCOLOR"

      @ 280, 670 FRAME frm_27 WIDTH 100 HEIGHT 110

      @ 290, 680 RADIOGROUP rdg_27 ;
         OBJ oR27 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         BACKCOLOR RED ;
         WINDRAW
      oR27:aOptions[ 1 ]:FontColor := GREEN
      oR27:aOptions[ 2 ]:BackColor := BLUE

      @ 210, 780 LABEL lbl_281 WIDTH 100 HEIGHT 15 TRANSPARENT VALUE "WINDRAW"
      @ 280, 780 FRAME frm_28 WIDTH 100 HEIGHT 110

      @ 290, 790 RADIOGROUP rdg_28 ;
         OBJ oR28 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 24 ;
         WINDRAW              // BACKCOLOR is set to form's BACKCOLOR
      oR28:aOptions[ 1 ]:FontColor := GREEN
      oR28:aOptions[ 2 ]:BackColor := BLUE

      @ 410, 10 LABEL lbl_Notes WIDTH 500 HEIGHT 200 TRANSPARENT ;
         VALUE "BACKGROUND tries to force OOHGDRAW, on failure the control will be painted black." + hb_OsNewLine() + ;
               "TRANSPARENT and BACKCOLOR are ignored when BACKGROUND is present." + hb_OsNewLine() + ;
               "BACKCOLOR is ignored when TRANSPARENT is present." + hb_OsNewLine() + ;
               "TRANSPARENT paints de control's background using a NULL BRUSH." + hb_OsNewLine() + ;
               "OOHGDRAW paints using Visual Style functions if a Windows Theme is enabled, if not uses Windows' default routine." + hb_OsNewLine() + ;
               "WINDRAW paints using Windows' default routine." + hb_OsNewLine() + ;
               "If neither OOHGDRAW nor WINDRAW are present then OOHGDRAW is assumed if app is OOHGDRAW or WINDRAW otherwise." + hb_OsNewLine() + ;
               "BACKGROUND paint the control's background using a brush derived from another control's client area."

      @ 500, 700 BUTTON btn_Change OBJ oBut CAPTION "Use BackImage" WIDTH 170 ;
         ACTION { || Eval( If( nBack == 1, ;
                               { || oForm1:BackColor := NIL, oForm1:BackImage := "fondo.bmp", oBut:Caption := "No BackColor nor BackImage", nBack := 2 }, ;
                               If( nBack == 2, ;
                                   { || oForm1:BackColor := NIL, oForm1:BackImage := NIL, oBut:Caption := "Use BackColor", nBack := 3 }, ;
                                   { || oForm1:BackColor := PINK, oForm1:BackImage := NIL, oBut:Caption := "Use BackImage", nBack := 1 } ) ) ) }

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

/*
 * EOF
 */
