/*
 * RadioGroup Sample n° 3
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how use a RadioGroup control with
 * AUTOSIZE clause.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 588 ;
      HEIGHT 480 ;
      TITLE 'RadioGroup - Autosize' ;
      MAIN ;
      ON INIT ShowWidths()

      @ 10,20 LABEL lbl_1 VALUE "OOHGDRAW"

      @ 40,20 RADIOGROUP rdg_1 OBJ oRdg1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 24

      @ 140,20 LABEL lbl_2 OBJ oLbl2 ;
         VALUE "widths: " ;
         AUTOSIZE

      @ 10,300 LABEL lbl_3 VALUE "WINDRAW"

      @ 40,300 RADIOGROUP rdg_2 OBJ oRdg2 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 24 ;
         WINDRAW

      @ 140,300 LABEL lbl_4 OBJ oLbl4 ;
         VALUE "widths: " ;
         AUTOSIZE

      DRAW LINE IN WINDOW Form_1 AT 180,20 TO 180,( Form_1.ClientWidth - 20 ) ;
         PENCOLOR RED PENWIDTH 3

      @ 210,20 LABEL lbl_5 VALUE "OOHGDRAW"

      @ 240,20 RADIOGROUP rdg_3 OBJ oRdg3 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 24 ;
         LEFTALIGN

      @ 340,20 LABEL lbl_6 OBJ oLbl6 ;
         VALUE "widths: " ;
         AUTOSIZE

      @ 210,300 LABEL lbl_7 VALUE "WINDRAW"

      @ 240,300 RADIOGROUP rdg_4 OBJ oRdg4 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         AUTOSIZE ;
         SPACING 24 ;
         WINDRAW ;
         LEFTALIGN            // not supported by Windows

      @ 340,300 LABEL lbl_8 OBJ oLbl8 ;
         VALUE "widths: " ;
         AUTOSIZE

      @ 400,20 BUTTON btn_1 ;
         CAPTION "Change item" ;
         ACTION ChangeItem()

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
                  LTRIM( STR( oRdg1:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg1:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg1:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg1:aOptions[4]:Width ) )

   oLbl4:Value := "widths: " + ;
                  LTRIM( STR( oRdg2:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg2:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg2:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg2:aOptions[4]:Width ) )

   oLbl6:Value := "widths: " + ;
                  LTRIM( STR( oRdg3:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg3:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg3:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg3:aOptions[4]:Width ) )

   oLbl8:Value := "widths: " + ;
                  LTRIM( STR( oRdg4:aOptions[1]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg4:aOptions[2]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg4:aOptions[3]:Width ) ) + ;
                  " " + ;
                  LTRIM( STR( oRdg4:aOptions[4]:Width ) )

RETURN NIL

/*
 * EOF
 */
