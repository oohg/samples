/*
 * RichEditBox Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to limit the number of characters
 * in the lines of a Richeditbox control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
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

RETURN Nil


FUNCTION CheckLineMax( nLenght )

   IF oRich:GetLineLength( oRich:GetCurrentLine() ) >= nLenght
     oRich:Value += CHR(13) + CHR(10)
     oRich:CaretPos( Len( oRich:Value ) )
   ENDIF

RETURN Nil

/*
 * EOF
 */
