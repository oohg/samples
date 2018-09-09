#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW frm_Main ;
      AT 0, 0 ;
      MAIN ;
      TITLE "MsgInfoExt Sample"

      @ 30, 30 BUTTON btn_Try ;
         CAPTION "Show Msg" ;
         ACTION ShowMsg()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW frm_Main
   ACTIVATE WINDOW frm_Main

RETURN NIL

FUNCTION ShowMsg

   MsgInfoExt( ( "MsgInfoExt Sample" + CRLF + ;
                 "This is line 2"    + CRLF + ;
                 "This message has a 10 seconds timeout" ), ;
               "This is the title", ;
               10, ;
               YELLOW )

RETURN NIL
