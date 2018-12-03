/*
 * Button Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to highlight a button using the control's
 * OnMouseMove event and the form's OnMouseMouse event.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      OBJ oMainForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "ooHG - OnMouseMove Control and Form Event" ;
      MAIN ;
      BACKCOLOR CYAN ;
      ON MOUSEMOVE {|| OnMouseMoveWindow()}

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         BUTTONS

         PAGE 'No TRANSPARENT'

            @ 50, 10 BUTTON Btn_11 ;
               OBJ oBtn11 ;
               WIDTH 150 ;
               HEIGHT 30 ;
               CAPTION "&Exit" ;
               ACTION oMainForm:Release() ;
               FONT "Tahoma" SIZE 9 ;
               ON MOUSEMOVE {|| OnMouseMoveButton()}

            @ 50, 200 LABEL Lbl_11 ;
               OBJ oLbl11 ;
               WIDTH 200 ;
               VALUE ""

            @ 110, 10 LABEL Lbl_12 ;
               WIDTH 200 ;
               HEIGHT 100 ;
               VALUE "Move the mouse around the window and watch " + ;
                     "what happens when you hover the button."

         END PAGE

         PAGE 'TRANSPARENT'

            @ 50, 10 BUTTON Btn_21 ;
               OBJ oBtn21 ;
               WIDTH 150 ;
               HEIGHT 30 ;
               CAPTION "&Exit" ;
               ACTION oMainForm:Release() ;
               FONT "Tahoma" SIZE 9 ;
               TRANSPARENT ;
               ON MOUSEMOVE {|| OnMouseMoveButton()}

            @ 50, 200 LABEL Lbl_21 ;
               OBJ oLbl21 ;
               WIDTH 200 ;
               VALUE "" ;
               TRANSPARENT

            @ 110, 10 LABEL Lbl_22 ;
               WIDTH 200 ;
               HEIGHT 100 ;
               TRANSPARENT ;
               VALUE "Move the mouse around the window and watch " + ;
                     "what happens when you hover the button."

         END PAGE

      END TAB

      ON KEY ESCAPE ACTION oMainForm:Release()
   END WINDOW

   CENTER WINDOW MainForm
   ACTIVATE WINDOW MainForm

RETURN Nil

FUNCTION OnMouseMoveWindow

   oLbl11:Value := "Form - Row " + ;
                   LTrim( Str( _OOHG_MouseRow ) ) + ;
                   " Col " + LTrim( Str(_OOHG_MouseCol ) )
   oBtn11:FontSize := 9

   oLbl21:Value := "Form - Row " + ;
                   LTrim( Str( _OOHG_MouseRow ) ) + ;
                   " Col " + LTrim( Str(_OOHG_MouseCol ) )
   oBtn21:FontSize := 9

RETURN Nil

FUNCTION OnMouseMoveButton

   oLbl11:Value := ""
   oBtn11:FontSize := 18

   oLbl21:Value := ""
   oBtn21:FontSize := 18

RETURN Nil

/*
 * EOF
 */
