/*
 * RadioGroup Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how use a RadioGroup control with
 * AUTOSIZE clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   PUBLIC lDefault := .T., aFonts := { _OOHG_DefaultFontName, "Courier New" }

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 588 ;
      HEIGHT 480 ;
      TITLE 'RadioGroup - Autosize' ;
      MAIN ;
      ON INIT ShowWidths() ;
      BACKIMAGE "fondo.bmp" STRETCH

      @ 10,20 LABEL lbl_1 VALUE "OOHGDRAW" TRANSPARENT

      @ 40,20 RADIOGROUP rdg_1 OBJ oRdg1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 25 ;
         TRANSPARENT ;
         OOHGDRAW ;
         BACKGROUND oForm

      @ 140,20 LABEL lbl_2 OBJ oLbl2 ;
         VALUE "widths: " ;
         AUTOSIZE ;
         TRANSPARENT

      @ 10,300 LABEL lbl_3 VALUE "WINDRAW" TRANSPARENT

      @ 40,300 RADIOGROUP rdg_2 OBJ oRdg2 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 25 ;
         WINDRAW ;
         BACKGROUND oForm

      @ 140,300 LABEL lbl_4 OBJ oLbl4 ;
         VALUE "widths: " ;
         AUTOSIZE ;
         TRANSPARENT

      DRAW LINE IN WINDOW Form_1 AT 180,20 TO 180,( Form_1.ClientWidth - 20 ) ;
         PENCOLOR RED PENWIDTH 3

      @ 210,20 LABEL lbl_5 VALUE "OOHGDRAW - LEFTALIGN" AUTOSIZE TRANSPARENT

      // To get all the button at the same column
      // use WIDTH instead of AUTOSIZE clause.

      @ 240,20 RADIOGROUP rdg_3 OBJ oRdg3 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 25 ;
         LEFTALIGN ;
         OOHGDRAW ;
         BACKGROUND oForm

      @ 340,20 LABEL lbl_6 OBJ oLbl6 ;
         VALUE "widths: " ;
         AUTOSIZE ;
         TRANSPARENT

      @ 210,300 LABEL lbl_7 VALUE "WINDRAW - LEFTALIGN" AUTOSIZE TRANSPARENT

      @ 240,300 RADIOGROUP rdg_4 OBJ oRdg4 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         WIDTH 80 ;
         SPACING 25 ;
         WINDRAW ;
         LEFTALIGN ;
         BACKGROUND oForm

      @ 340,300 LABEL lbl_8 OBJ oLbl8 ;
         VALUE "widths: " ;
         AUTOSIZE ;
         TRANSPARENT

      @ 400,20 BUTTON btn_1 ;
         CAPTION "Change item" ;
         ACTION ChangeItem()

      @ 400,120 BUTTON btn_2 ;
         CAPTION "Change font" ;
         ACTION ChangeFont()

      DEFINE TIMER tmr_1 INTERVAL 1000 ACTION ShowWidths()

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ChangeItem()
   STATIC lLong := .F.

   lLong := ! lLong

   IF lLong
      oRdg1:Caption( 1, "Item 1's new caption is really long" )
      oRdg2:Caption( 1, "Item 1's new caption is really long" )
      oRdg3:Caption( 1, "Item 1's new caption is really long" )
      oRdg4:Caption( 1, "Item 1's new caption is really long" )
   ELSE
      oRdg1:Caption( 1, "One" )
      oRdg2:Caption( 1, "One" )
      oRdg3:Caption( 1, "One" )
      oRdg4:Caption( 1, "One" )
   ENDIF

   ShowWidths()

RETURN NIL

FUNCTION ShowWidths()

   oLbl2:Value := "widths: " + ;
                  LTrim( Str( oRdg1:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg1:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg1:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg1:aOptions[4]:Width ) )

   oLbl4:Value := "widths: " + ;
                  LTrim( Str( oRdg2:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg2:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg2:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg2:aOptions[4]:Width ) )

   oLbl6:Value := "widths: " + ;
                  LTrim( Str( oRdg3:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg3:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg3:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg3:aOptions[4]:Width ) )

   oLbl8:Value := "widths: " + ;
                  LTrim( Str( oRdg4:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg4:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg4:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTrim( Str( oRdg4:aOptions[4]:Width ) )

RETURN NIL

FUNCTION ChangeFont

   IF lDefault
      oRdg3:FontName := ;
      oRdg4:FontName := aFonts[2]
   ELSE
      oRdg3:FontName := ;
      oRdg4:FontName := aFonts[1]
   ENDIF
   lDefault := ! lDefault

RETURN NIL

/*
 * EOF
 */
