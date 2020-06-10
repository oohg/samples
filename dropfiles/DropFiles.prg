
#include "oohg.ch"

PROCEDURE MAIN

   DEFINE WINDOW Main OBJ oWin ;
      WIDTH 320 ;
      HEIGHT 320 ;
      CLIENTAREA ;
      TITLE "Drop files here"

      @ 10,10 EDITBOX edt_Files OBJ oEdit ;
         WIDTH 300 ;
         HEIGHT 300

      oEdit:AcceptFiles := .T.
      oEdit:OnDropFiles := { |f| AddFiles( f, oWin ) }

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   ACTIVATE WINDOW Main

RETURN

PROCEDURE AddFiles( aFiles, oWin )

   AEval( aFiles, { |c| oEdit:Value += c + Chr( 13 ) + Chr( 10 ) } )

RETURN

/*
 * EOF
 */
