/*
 * Message Boxes Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how display message boxes with
 * different modes. See "Messagebox function" in MSDN.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

  SetMsgDefaultMode( MB_APPLMODAL )
  SetMsgDefaultMessage( "Default message." )
  SetMsgDefaultTitle( "Default Title" )

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 HEIGHT 280 ;
      TITLE 'ooHg - MessageBox modes' ;
      MAIN

      @ 10, 10 BUTTON btn_1 ;
         CAPTION "Use defaults Mode, Message and Title" ;
         WIDTH 500 ;
         HEIGHT 28 ;
         ACTION MsgInfo()

      @ 50, 10 BUTTON btn_2 ;
         CAPTION "Use defaults Message and Title, Mode = MB_SYSTEMMODAL" ;
         WIDTH 500 ;
         HEIGHT 28 ;
         ACTION MsgStop( Nil, Nil, MB_SYSTEMMODAL )

      @ 90, 10 BUTTON btn_3 ;
         CAPTION "Use default Mode and defined Message and Title" ;
         WIDTH 500 ;
         HEIGHT 28 ;
         ACTION MsgExclamation( "There's no icon in the title bar !!!", ;
                                "MB_APPLMODAL" )

      @ 130, 10 BUTTON btn_4 ;
         CAPTION "Use defined Mode, Message and Title" ;
         WIDTH 500 ;
         HEIGHT 28 ;
         ACTION MsgBox( "This box has a system icon.", ;
                        "MB_SYSTEMMODAL", MB_SYSTEMMODAL )

      @ 180, 10 LABEL lbl_1 ;
         VALUE "Click the buttons to see message boxes with diferent modes." ;
         WIDTH 500

      ON KEY ESCAPE ACTION Form_1.Release

   END WINDOW

   Form_1.Center

   Form_1.Activate

RETURN Nil

/*
 * EOF
 */
