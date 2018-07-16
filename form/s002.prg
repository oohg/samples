/*
 * Form Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the tab order of the
 * controls in a form.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 588 ;
      HEIGHT 480 ;
      TITLE 'Change Tab Order' ;
      MAIN

      DEFINE STATUSBAR OBJ oStat
      END STATUSBAR

/*
   Tab indexes are 1-based.
   New controls are place at the tail of the tab order.
   When a control is released, the tab index of the subsequent
   controls in the tab order is decremented by 1 to avoid gaps.

   Every control has it's own tab index, including invisible ones
   and controls with "notabstop" property.

   Note that the tab index of the first used defined control is not 1.
   This is because OOHG creates a few controls before the first one
   defined by the user.

   Tab indexes are automatically renumbered every time a control's
   tab index is changed, so they remain 1-based and without gaps.
*/

      @  10,  10 TEXTBOX txt_01 OBJ oTxt01 WIDTH 100 NUMERIC
      oTxt01:Value := oTxt01:TabIndex
      @  40,  10 TEXTBOX txt_02 OBJ oTxt02 WIDTH 100 NUMERIC
      oTxt02:Value := oTxt02:TabIndex
      @  70,  10 TEXTBOX txt_03 OBJ oTxt03 WIDTH 100 NUMERIC
      oTxt03:Value := oTxt03:TabIndex
      @ 100,  10 TEXTBOX txt_04 OBJ oTxt04 WIDTH 100 NUMERIC
      oTxt04:Value := oTxt04:TabIndex
      @ 130,  10 TEXTBOX txt_05 OBJ oTxt05 WIDTH 100 NUMERIC
      oTxt05:Value := oTxt05:TabIndex
      @ 160,  10 TEXTBOX txt_06 OBJ oTxt06 WIDTH 100 NUMERIC
      oTxt06:Value := oTxt06:TabIndex
      @ 190,  10 TEXTBOX txt_07 OBJ oTxt07 WIDTH 100 NUMERIC
      oTxt07:Value := oTxt07:TabIndex
      @ 220,  10 TEXTBOX txt_08 OBJ oTxt08 WIDTH 100 NUMERIC
      oTxt08:Value := oTxt08:TabIndex
      @ 250,  10 TEXTBOX txt_09 OBJ oTxt09 WIDTH 100 NUMERIC
      oTxt09:Value := oTxt09:TabIndex
      @ 280,  10 TEXTBOX txt_10 OBJ oTxt10 WIDTH 100 NUMERIC
      oTxt10:Value := oTxt10:TabIndex

      @  10, 130 TEXTBOX txt_11 OBJ oTxt11 WIDTH 100 NUMERIC
      oTxt11:Value := oTxt11:TabIndex
      @  40, 130 TEXTBOX txt_12 OBJ oTxt12 WIDTH 100 NUMERIC
      oTxt12:Value := oTxt12:TabIndex
      @  70, 130 TEXTBOX txt_13 OBJ oTxt13 WIDTH 100 NUMERIC
      oTxt13:Value := oTxt13:TabIndex
      @ 100, 130 TEXTBOX txt_14 OBJ oTxt14 WIDTH 100 NUMERIC
      oTxt14:Value := oTxt14:TabIndex
      @ 130, 130 TEXTBOX txt_15 OBJ oTxt15 WIDTH 100 NUMERIC
      oTxt15:Value := oTxt15:TabIndex
      @ 160, 130 TEXTBOX txt_16 OBJ oTxt16 WIDTH 100 NUMERIC
      oTxt16:Value := oTxt16:TabIndex
      @ 190, 130 TEXTBOX txt_17 OBJ oTxt17 WIDTH 100 NUMERIC
      oTxt17:Value := oTxt17:TabIndex
      @ 220, 130 TEXTBOX txt_18 OBJ oTxt18 WIDTH 100 NUMERIC
      oTxt18:Value := oTxt18:TabIndex
      @ 250, 130 TEXTBOX txt_19 OBJ oTxt19 WIDTH 100 NUMERIC
      oTxt19:Value := oTxt19:TabIndex
      @ 280, 130 TEXTBOX txt_20 OBJ oTxt20 WIDTH 100 NUMERIC
      oTxt20:Value := oTxt20:TabIndex

      @  10, 250 LABEL lbl_01 OBJ oLbl01 ;
         WIDTH 300 HEIGHT 300 ;
         VALUE "Tab order is: first column from top to bottom, " + ;
               "then second column from top to bottom." ;
         FONTCOLOR RED

      @ 320, 130 BUTTON btn_01 ;
         OBJ oBut01 CAPTION "Change" ACTION Change()

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

FUNCTION Change
   LOCAL i, j
   STATIC lFlip := .T.

/*
 * The order used to change the tab index is relevant.
 *
 * Suppose you have five controls in the following tab order:
 *    o1, o2, o3, o4 and o5.
 *
 * If you do o4:TabIndex := 2, the tab order is changed to:
 *    o1, o4, o2, o3 and o5.
 * If you do o2:TabIndex := 4, the tab order is changed to:
 *    o1, o3, o4, o2 and o5.
 *
 * If you want the order to be: o5, o4, o3, o2, o1
 * This sequence does not work:
 *    o1:TabIndex := 5
 *    o2:TabIndex := 4
 *    o4:TabIndex := 2
 *    o5:TabIndex := 1
 * because
 *    sentence 1 changes order to: o2, o3, o4, o5, o1
 *    sentence 2 changes order to: o3, o4, o5, o2, o1
 *    sentence 3 changes order to: o3, o4, o5, o2, o1
 *    sentence 4 changes order to: o5, o3, o4, o2, o1
 * But this sequence works ok:
 *    o1:TabIndex := 5
 *    o5:TabIndex := 1
 *    o2:TabIndex := 4
 *    o4:TabIndex := 2
 * because
 *    sentence 1 changes order to: o2, o3, o4, o5, o1
 *    sentence 2 changes order to: o5, o2, o3, o4, o1
 *    sentence 3 changes order to: o5, o3, o4, o2, o1
 *    sentence 4 changes order to: o5, o4, o3, o2, o1
 */

   If lFlip
      oLbl01:Value := "Tab order is: first row from left to " + ;
                      "right then second row from left to right " + ;
                      "and so on until last row."

      j := oTxt01:TabIndex
      For i := 1 to 10
         &( "oTxt" + strzero(i,      2, 0) ):TabIndex := j
         &( "oTxt" + strzero(i + 10, 2, 0) ):TabIndex := j + 1
         j += 2
      Next i
   Else
      oLbl01:Value := "Tab order is: first column from top to " + ;
                      "bottom, then second column from top to bottom."

      j := oTxt01:TabIndex
      For i := 1 to 20
         &( "oTxt" + strzero(i, 2, 0) ):TabIndex := j + i - 1
      Next i
   EndIf

   For i := 1 to 20
      With Object &( "oTxt" + strzero(i, 2, 0) )
         :Value := :TabIndex
      End Width
   Next i

   lFlip := ! lFlip

   oTxt01:SetFocus()

RETURN NIL

/*
 * EOF
 */
