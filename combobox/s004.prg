/*
 * Combobox Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use methods GetDropDownWidth,
 * SetDropDownWidth, AutosizeDropDown and Autosize to size
 * a combobox control during runtime
 *
 * Methods shown here:
 *
 * GetDropDownWidth()
 *    Gets the minimum allowable width, in pixels, of the list box.
 *
 *  SetDropDownWidth( nWidth )
 *    Sets the minimum allowable width, in pixels, of the list box.
 *    If succesfull returns nWidth else returns default width.
 *
 *  Autosize( lValue )
 *     If lValue is .T. the combo will be resized (width and height)
 *     every time an item is selected so the whole text is visible.
 *
 *  AutosizeDropDown( lResizeBox, nMinWidth, nMaxWidth )
 *    Sets minimun and maximun width of the list and display boxes.
 *
 *    Computes the space needed to show the longest item in the
 *    dropdown list. If the computed value is less than the minimum,
 *    use the minimum as the new width. If the computed value is
 *    greater than the maximum, use the maximum. If lResizeBox is .T.
 *    resizes the combobox. If it's .F. resizes the dropdown list.
 *
 *    The dropdown list's width is, ALWAYS, at least equal to the
 *    combobox width.
 *
 *    Parameters:
 *       lResizeBox = .T. to resize dropdown list and combobox
 *                    .F. to resize dropdown list only (default action)
 *       nMinWidth  = minimum width
 *                    If omited or less than 0
 *                       If lResizeBox == .T.
 *                          defaults to 0
 *                       else
 *                          defaults to combobox width
 *       nMaxWidth  = maximum width
 *                    If omited defaults to longest item's width
 *                    If less than minimun defaults to longest item's
 *                    width or minimun, whichever is bigger.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

  LOCAL oFrm1, oCmb1, oTxt1, oTxt2, oTxt3, oTxt4, oCmb3

   DEFINE WINDOW Form_1 ;
      OBJ oFrm1 ;
      AT 0,0 ;
      WIDTH 440 ;
      HEIGHT 380 ;
      MINWIDTH 440 ;
      MINHEIGHT 380 ;
      TITLE 'ooHG - ComboBox Demo' ;
      MAIN ;
      ON INIT AdjustSize( oFrm1 ) ;
      ON SIZE AdjustSize( oFrm1 )

   @ 10,10 LABEL lbl_1 ;
      VALUE "1. Clic combo arrow to see the list." ;
      WIDTH 200

   @ 40,10 COMBOBOX cmb_1 ;
      OBJ oCmb1 ;
      WIDTH 30 ;
      ITEMS { 'Item A', 'Item B', 'Item C - a very big one' } ;
      VALUE 1 ;
      ON CHANGE AutoMsgBox( oCmb1:Value )

   @ 40, 310 BUTTON 0 ;
      WIDTH 100 ;
      HEIGHT 24 ;
      CAPTION "Select None" ;
      ACTION oCmb1:Value := NIL   // This clears the selection, you can use 0 instead of NIL

   @ 80, 10 BUTTON btn_1 ;
      WIDTH 150 ;
      HEIGHT 24 ;
      CAPTION "GetDropDownWidth" ;
      ACTION AutoMsgBox( oCmb1:GetDropDownWidth() )

   @ 80,170 LABEL lbl_2 ;
      VALUE "2. Current list width." ;
      WIDTH 200

   @ 110, 10 BUTTON btn_2 ;
      WIDTH 150 ;
      HEIGHT 24 ;
      CAPTION "SetDropDownWidth = 300" ;
      ACTION AutoMsgBox( oCmb1:SetDropDownWidth( 300 ) )

   @ 110,170 LABEL lbl_3 ;
      VALUE "3. Clic button then clic combo arrow." ;
      WIDTH 200

   @ 140, 10 BUTTON btn_3 ;
      WIDTH 150 ;
      HEIGHT 24 ;
      CAPTION "SetDropDownWidth = 3" ;
      ACTION AutoMsgBox( oCmb1:SetDropDownWidth( 3 ) )

   @ 140,170 LABEL lbl_4 ;
      VALUE "4. Clic button then clic combo arrow." ;
      WIDTH 200

   @ 170, 170 LABEL lbl_5 ;
      VALUE "Min." ;
      AUTOSIZE

   @ 170, 220 LABEL lbl_6 ;
      VALUE "Max." ;
      AUTOSIZE

   @ 190, 10 BUTTON btn_4 ;
      WIDTH 150 ;
      HEIGHT 24 ;
      CAPTION "AutosizeDropDown List" ;
      ACTION oCmb1:AutosizeDropDown( .F., oTxt1:Value, oTxt2:Value )

   @ 190, 170 TEXTBOX txt_1 ;
      OBJ oTxt1 ;
      WIDTH 40 ;
      HEIGHT 24 ;
      NUMERIC ;
      INPUTMASK "999"

   @ 190, 220 TEXTBOX txt_2 ;
      OBJ oTxt2 ;
      WIDTH 40 ;
      HEIGHT 24 ;
      NUMERIC ;
      INPUTMASK "999"

   @ 190,270 LABEL lbl_7 ;
      VALUE "5. Input different values, clic and see what happens." ;
      WIDTH 150 ;
      HEIGHT 36

   @ 220, 10 BUTTON btn_5 ;
      WIDTH 150 ;
      HEIGHT 24 ;
      CAPTION "AutosizeDropDown Both" ;
      ACTION oCmb1:AutosizeDropDown( .T., oTxt3:Value, oTxt4:Value )

   @ 220, 170 TEXTBOX txt_3 ;
      OBJ oTxt3 ;
      WIDTH 40 ;
      HEIGHT 24 ;
      NUMERIC ;
      INPUTMASK "999"

   @ 220, 220 TEXTBOX txt_4 ;
      OBJ oTxt4 ;
      WIDTH 40 ;
      HEIGHT 24 ;
      NUMERIC ;
      INPUTMASK "999"

   @ 220,270 LABEL lbl_8 ;
      VALUE "6. Input different values, clic and see what happens." ;
      WIDTH 150 ;
      HEIGHT 36

   @ 260,10 LABEL lbl_9 ;
      VALUE "7. Resize the window horizontally to see what happens." ;
      WIDTH 180 ;
      HEIGHT 36

   @ 260,200 COMBOBOX cmb_2 ;
      WIDTH 30 ;
      ITEMS { 'Item One', ;
              'Item Two, Two', ;
              'Item Three, Three, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, Three, Three' } ;
      VALUE 1

   @ 300,10 LABEL lbl_10 ;
      VALUE "8. Select an item and see what happens." ;
      WIDTH 180 ;
      HEIGHT 36

   @ 300,200 COMBOBOX cmb_3 ;
      OBJ oCmb3 ;
      WIDTH 30 ;
      ITEMS { 'First item', ;
              'B', ;
              'Third and final item' } ;
      VALUE 2 ;
      AUTOSIZE

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION AdjustSize( oWin )

   WITH OBJECT oWin
      :cmb_2:AutoSizeDropDown( .T., 30, :ClientWidth - :lbl_9:Col - :lbl_9:Width - 20 )
   END WITH

RETURN NIL

/*
 * EOF
 */
