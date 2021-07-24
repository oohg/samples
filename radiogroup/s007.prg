/*
 * RadioGroup Sample # 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how display a multiline RadioGroup
 * and the methods GroupWidth and GroupHeight.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   nLimitH   := 0
   lSpacingH := .T.
   lShiftH   := .T.
   lManualH  := .T.
   lLimitV   := .T.
   lSpacingV := .T.
   lShiftV   := .T.

   SET AUTOADJUST ON

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 740 ;
      HEIGHT 480 ;
      TITLE 'OOHG - RadioGroup: MultiLine & Methods GroupWidth and GroupHeight' ;
      MAIN ;
      ON INIT Show() ;
      ON SIZE Show()

      @ 20,20 RADIOGROUP rdg_1 OBJ oRdg1 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 80 ;
         SPACING 25

      @ 150,20 LABEL 0 OBJ oLbl1 AUTOSIZE VALUE ""

      @ 20,220 RADIOGROUP rdg_2 OBJ oRdg2 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 60 ;
         SPACING 70 ;
         HORIZONTAL

      @ 150,220 LABEL 0 OBJ oLbl2 AUTOSIZE VALUE ""

      @ 200,20 RADIOGROUP rdg_3 OBJ oRdg3 ;
         OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
         WIDTH 60 ;
         SPACING 70 ;
         HORIZONTAL
      oRdg3:aOptions[ 3 ]:Row := oRdg3:aOptions[ 1 ]:Row + 25
      oRdg3:aOptions[ 3 ]:Col := oRdg3:aOptions[ 1 ]:Col
      oRdg3:aOptions[ 4 ]:Row := oRdg3:aOptions[ 2 ]:Row + 25
      oRdg3:aOptions[ 4 ]:Col := oRdg3:aOptions[ 2 ]:Col

      @ 300,20 LABEL 0 OBJ oLbl3 WIDTH 200 HEIGHT 100 VALUE ""

      @ 250,230 BUTTON 0 CAPTION "Limit = 3" ;
         ACTION ( nLimitH := iif( nLimitH # 3, 3, 2 ), ;
                  oRdg3:Limit := nLimitH, ;
                  This.Caption := "Limit = " + iif( nLimitH # 3, "3", "2" ), ;
                  lManualH := .F., ;
                  Show() )

      @ 300,230 BUTTON 0 CAPTION "Spacing +" ;
         ACTION ( oRdg3:Spacing := iif( lSpacingH, oRdg3:Spacing * 1.15, oRdg3:Spacing / 1.15 ), ;
                  lSpacingH := ! lSpacingH, ;
                  This.Caption := "Spacing " + iif( lSpacingH, "+", "-" ), ;
                  lManualH := .F., ;
                  Show() )

      @ 350,230 BUTTON 0 CAPTION "Shift +" ;
         ACTION ( oRdg3:Shift := iif( lShiftH, oRdg3:Shift * 1.2, oRdg3:Shift / 1.2 ), ;
                  lShiftH := ! lShiftH, ;
                  This.Caption := "Shift " + iif( lShiftH, "+", "-" ), ;
                  lManualH := .F., ;
                  Show() )

      @ 200,350 RADIOGROUP rdg_4 OBJ oRdg4 ;
         OPTIONS { 'One', 'Two', 'Four' } ;
         WIDTH 60 ;
         SPACING 70 ;
         HORIZONTAL ;
         HEIGHT 25 ;
         SHIFT 20 ;
         LIMIT 3

      oRdg4:InsertItem( 3, "Three" )

      @ 300,350 LABEL 0 OBJ oLbl4 WIDTH 200 HEIGHT 100 VALUE ""

      @ 200,600 BUTTON 0 CAPTION "Limit = 2" ;
         ACTION ( oRdg4:Limit := iif( lLimitV, 2, 3 ), ;
                  lLimitV := ! lLimitV, ;
                  This.Caption := "Limit = " + iif( lLimitV, "2", "3" ), ;
                  Show() )

      @ 250,600 BUTTON 0 CAPTION "Spacing +" ;
         ACTION ( oRdg4:Spacing := iif( lSpacingV, oRdg4:Spacing * 1.15, oRdg4:Spacing / 1.15 ), ;
                  lSpacingV := ! lSpacingV, ;
                  This.Caption := "Spacing " + iif( lSpacingV, "+", "-" ), ;
                  Show() )

      @ 300,600 BUTTON 0 CAPTION "Shift +" ;
         ACTION ( oRdg4:Shift := iif( lShiftV, oRdg4:Shift * 1.2, oRdg4:Shift / 1.2 ), ;
                  lShiftV := ! lShiftV, ;
                  This.Caption := "Shift " + iif( lShiftV, "+", "-" ), ;
                  Show() )

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

   RETURN NIL


FUNCTION Show

   oLbl1:Value := "Width = " + LTrim( Str( Round( oRdg1:GroupWidth, 1 ) ) )  + ;
                  " Height = " + LTrim( Str( Round( oRdg1:GroupHeight, 1 ) ) )

   oLbl2:Value := "Width = " + LTrim( Str( Round( oRdg2:GroupWidth, 1 ) ) ) + ;
                  " Height = " + LTrim( Str( Round( oRdg2:GroupHeight, 1 ) ) )

   oLbl3:Value := "Width = " + LTrim( Str( Round( oRdg3:GroupWidth, 1 ) ) ) + ;
                  " Height = " + LTrim( Str( Round( oRdg3:GroupHeight, 1 ) ) ) + CRLF + ;
                  "HORIZONTAL" + CRLF + ;
                  iif( nLimitH == 0, "NO LIMIT", "LIMIT " + LTrim( Str( nLimitH ) ) ) + CRLF + ;
                  iif( lManualH, "MANUALLY", "AUTOMATICALLY" ) + " PLACED"

   oLbl4:Value := "Width = " + LTrim( Str( Round( oRdg4:GroupWidth, 1 ) ) ) + ;
                  " Height = " + LTrim( Str( Round( oRdg4:GroupHeight, 1 ) ) ) + CRLF + ;
                  "VERTICAL" + CRLF + ;
                  "LIMIT " + iif( lLimitV, "3", "2" ) + CRLF + ;
                  "AUTOMATICALLY PLACED"

   RETURN NIL

/*
 * EOF
 */
