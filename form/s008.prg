/*
 * Form Sample n° 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Adapted from "Transparency Sample By Grigory Filatov"
 * included in HMG Extended package.
 *
 * This sample shows how to use transparency in a form.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 250 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "ooHG - Window with transparency" ;
      BACKCOLOR YELLOW ;
      ON INIT ( oForm:Slider_1:Enabled := .f., ;
                MakeOpaque(), ;
                oForm:TextBox_1:Enabled := .f., ;
                oForm:Button_1:Enabled := .t., ;
                oForm:Button_2:Enabled := .f. )
              
      ON KEY ESCAPE ACTION oForm:Release()
      ON KEY F1 ACTION ( oForm:Slider_1:Enabled := .f., ;
                         MakeOpaque( oForm ), ;
                         oForm:BackColor := YELLOW, ;
                         oForm:TextBox_1:Enabled := .f., ;
                         oForm:Button_1:Enabled := .t., ;
                         oForm:Button_2:Enabled := .f., ;
                         oBut3:Transparent := .F. )

      @ 10, 200 LABEL lbl_aviso ;
         VALUE "Click Here or F1 to Restore Opacity" ;
         WIDTH 180 ;
         HEIGHT 37 ;
         BORDER ;
         BACKCOLOR GREEN ;
         FONTCOLOR BLUE ;
         CENTER ;
         ON CLICK ( oForm:Slider_1:Enabled := .f., ;
                     MakeOpaque( oForm ), ;
                     oForm:TextBox_1:Enabled := .f., ;
                     oForm:Button_1:Enabled := .t., ;
                     oForm:Button_2:Enabled := .f. )

      @ 10, 10 BUTTON Button_1 ;
         OBJ oBut1 ;
         CAPTION 'Set Transparency ON' ;
         WIDTH   140 ;
         ACTION ( oForm:Slider_1:Enabled := .t., ;
                  oForm:TextBox_1:Enabled := .t., ;
                  oForm:Button_1:Enabled := .f., ;
                  oForm:Button_2:Enabled := .t., ;
                  oForm:Slider_1:Value := 180 )
      oBut1:Transparent := .T.

      @ 40, 10 BUTTON Button_2 ;
         OBJ oBut2 ;
         CAPTION 'Set Transparency OFF' ;
         WIDTH   140 ;
         ACTION ( oForm:Slider_1:Enabled := .f., ;
                  MakeOpaque( oForm ), ;
                  oForm:TextBox_1:Enabled := .f., ;
                  oForm:Button_1:Enabled := .t., ;
                  oForm:Button_2:Enabled := .f. )
      oBut2:Transparent := .T.

      @ 50, 200 BUTTON Button_3 ;
         OBJ oBut3 ;
         CAPTION "Invisible Background" ;
         WIDTH   140 ;
         ACTION {|| oBut1:SetBackgroundInvisible( oForm:BackColorCode ), ;
                    oBut2:SetBackgroundInvisible( oForm:BackColorCode ), ;
                    oBut3:SetBackgroundInvisible( oForm:BackColorCode ), ;
                    oForm:SetBackgroundInvisible( oForm:BackColorCode ) }

      @ 110, 10 LABEL lbl_Below ;
         VALUE "THIS IS A LONG TEXT TO SHOW AT THE VERY BACKGROUND" ;
         WIDTH 380 ;
         HEIGHT 24 ;
         CENTER

      DEFINE SLIDER Slider_1
         ROW 140
         COL 10
         VALUE 255
         WIDTH 310
         HEIGHT 50
         RANGEMIN 0
         RANGEMAX 255
         ON CHANGE Slider_Change( oForm )
      END SLIDER

      @ 190, 10 LABEL lbl_transparent ;
         VALUE "TRANSPARENT" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         TRANSPARENT ;
         BORDER

      @ 190, 220 LABEL lbl_opaque ;
         VALUE "OPAQUE" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         RIGHTALIGN ;
         BORDER

      @ 140, 330 TEXTBOX TextBox_1 ;
         VALUE 255 ;
         INPUTMASK "999" ;
         WIDTH 50 ;
         HEIGHT 24 ;
         DISABLED

      @ 170, 330 BUTTON Button_4 ;
         OBJ oBut4 ;
         CAPTION "set" ;
         HEIGHT 20 ;
         WIDTH  50 ;
         ACTION TextBox_Change( oForm )

   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

FUNCTION TextBox_Change (oWin)

  WITH OBJECT oWin
    :Slider_1:Value := :TextBox_1:Value

     IF .not. :SetTransparency( :Slider_1:Value )
        MsgStop( "Transparency is not supported by OS !!!", "Error" )
     ENDIF
  END WITH

RETURN NIL

FUNCTION Slider_Change (oWin)

  WITH OBJECT oWin
     :TextBox_1:Value := :Slider_1:Value

     IF .not. :SetTransparency( :Slider_1:Value )
        MsgStop( "Transparency is not supported by OS !!!", "Error" )
     ENDIF
  END WITH

RETURN NIL

FUNCTION MakeOpaque

   oForm:Slider_1:Value := 255
   oForm:Slider_1:Enabled := .F.
   oForm:TextBox_1:Value := 255
   oForm:TextBox_1:Enabled := .F.
   oForm:Button_1:Enabled := .T.
   oForm:Button_2:Enabled := .F.
   oBut1:RemoveTransparency()
   oBut2:RemoveTransparency()
   oBut3:RemoveTransparency()
   oForm:RemoveTransparency()

RETURN NIL

/*
 * EOF
 */
