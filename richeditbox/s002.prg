/*
 * RichEditBox Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to limit the number of characters
 * in the lines of a Richeditbox control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW MAIN ;
     TITLE "Limit the length of RichEdit's lines" ;
     OBJ oMain

     @ 20, 20 RICHEDITBOX rch_Edit ;
       OBJ oRich ;
       WIDTH oMain:ClientWidth - 40 ;
       HEIGHT oMain:ClientHeight - 40 ;
       ON CHANGE CheckLineMax( 20 )

    ON KEY ESCAPE ACTION oMain:Release()
   END WINDOW

   oMain:Activate()

   RETURN NIL


FUNCTION CheckLineMax( nLenght )

   IF oRich:GetLineLength( oRich:GetCurrentLine() ) >= nLenght
     oRich:Value += Chr( 13 ) + Chr( 10 )
     oRich:CaretPos( Len( oRich:Value ) )
   ENDIF

   RETURN NIL

/*
 * EOF
 */
