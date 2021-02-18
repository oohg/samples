#include "oohg.ch"

PROCEDURE Main

  DEFINE WINDOW Win_1 ;
     TITLE 'Hello Wold!' ;
     MAIN

     @ 10, 10 BUTTON btn_1 ;
        CAPTION "About" ;
        ACTION MsgBox( "Built with" + hb_eol() + ;
                       OOHGVersion() + hb_eol() + ;
                       hb_Compiler() + hb_eol() + ;
                       Version() )

     @ 50, 10 BUTTON btn_2 ;
        CAPTION "Exit" ;
        ACTION ThisWindow:Release()
  END WINDOW

  CENTER WINDOW Win_1
  ACTIVATE WINDOW Win_1

  RETURN

/*
 * EOF
 */
