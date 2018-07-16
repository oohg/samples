/*
 * Form Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to highlight a button when the
 * mouse hovers on it, using the control's and the form's
 * OnMouseMove event.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL oMainForm
   PRIVATE oButton_3, oLbl_1

   DEFINE WINDOW MainForm ;
      OBJ oMainForm ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 200 ;
      TITLE "ooHG Demo - OnMouseMove Control and Form Event" ;
      MAIN ;
      ON MOUSEMOVE {|| OnMouseMoveWindow()}

      @ 10, 10 BUTTON Button_3 ;
         OBJ oButton_3 ;
         WIDTH 150 ;
         HEIGHT 30 ;
         CAPTION "&Exit" ;
         ACTION oMainForm:Release() ;
         FONT "Tahoma" SIZE 9 ;
         ON MOUSEMOVE {|| OnMouseMoveButton()}

      @ 10, 200 LABEL lbl_1 ;
         OBJ oLbl_1 ;
         WIDTH 200 ;
         VALUE "" ;
         TRANSPARENT

      @ 70, 10 LABEL lbl_2 ;
         WIDTH 200 ;
         HEIGHT 100 ;
         VALUE "Move the mouse around the window and watch " + ;
               "what happens when you hover the button."

      ON KEY ESCAPE ACTION oMainForm:Release()
   END WINDOW

   CENTER WINDOW MainForm
   ACTIVATE WINDOW MainForm

RETURN Nil

FUNCTION OnMouseMoveWindow

   oLbl_1:Value := "Form - Row " + ;
                   LTRIM(STR(_OOHG_MouseRow)) + ;
                   " Col " + LTRIM(STR(_OOHG_MouseCol))
   oButton_3:FontSize := 9

RETURN Nil

FUNCTION OnMouseMoveButton

   oLbl_1:Value := ""
   oButton_3:FontSize := 18

RETURN Nil

/*
 * EOF
 */
