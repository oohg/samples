/*
 * Textbox Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to handle password using a textbox.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 300 ;
      TITLE "OOHG - How to handle passwords" ;
      NOMAXIMIZE ;
      NOMINIMIZE ;
      NOSIZE ;
      MAIN ;
      ON INIT ShowChar()

      @ 10,10 TEXTBOX txt_1 OBJ oClave ;
         WIDTH 200 ;
         TOOLTIP "At least 10 chars, an uppercase letter, an lowercase letter, a number and a symbol." ;
         MAXLENGTH 15 ;
         BOLD ;
         VALUE '1234567890' ;
         PASSWORD ;
         ACTION ( oClave:PasswordChar := "", ShowChar(), ;
                  oTimer:Enabled := .T. ) ;
                TOOLTIP "Click to show the password for 2 seconds." ;
                IMAGE "eye.png" BUTTONWIDTH 16

      @ 80,10 LABEL lbl_2 OBJ oShow ;
         HEIGHT 25 ;
         AUTOSIZE

      @ 130,10 BUTTON btn_1 ;
         CAPTION "Show Password" ;
         ACTION ( oClave:PasswordChar := "", ShowChar() )

      @ 170,10 BUTTON btn_2 ;
         CAPTION "Set to #" ;
         ACTION ( oClave:PasswordChar := "#", ShowChar() )

      @ 210,10 BUTTON btn_3 ;
         CAPTION "Set to default" ;
         ACTION ( oClave:PasswordChar := " ", ShowChar() )

      DEFINE TIMER 0 OBJ oTimer ;
         INTERVAL 2000 DISABLED ;
         ACTION ( oClave:PasswordChar := " ", ShowChar() ) ;
         ONCE

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   Form_1.Center()
   Form_1.Activate()

   RETURN NIL


FUNCTION ShowChar

   cAux := AllTrim( AutoType( oClave:PasswordChar ) )
   oShow:Value := "Current Password Char = [" + iif( Len( cAux ) > 0, cAux, " not set " ) + "]"

   RETURN NIL

/*
 * EOF
 */

