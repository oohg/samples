/*
* Form Sample n� 4
* Author: Fernando Yurisich <fernando.yurisich@gmail.com>
* Licensed under The Code Project Open License (CPOL) 1.02
* See <http://www.codeproject.com/info/cpol10.aspx>
*
* This sample shows how to anchor on form to another,
* using ON SIZE event.
*
* Visit us at https://github.com/fyurisich/OOHG_Samples or at
* http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
*/
#include "oohg.ch"

FUNCTION Main

   PUBLIC oMain, oChild
   DEFINE WINDOW frm_Main OBJ oMain ;
         TITLE "Main" ;
         AT 0, 0 ;
         MAIN ;
         ON INIT DefineChild() ;
         ON SIZE MoveChild()
      @ 20, 20 LABEL lbl_1 ;
         AUTOSIZE ;
         VALUE "Drag me around !!!"
   END WINDOW
   CENTER WINDOW frm_Main
   ACTIVATE WINDOW frm_Main

   RETURN NIL

FUNCTION DefineChild

   DEFINE WINDOW frm_Child OBJ oChild ;
         TITLE "Child" ;
         AT oMain:Row + 40, oMain:Col + 40 ;
         CHILD ;
         ON SIZE AdjustToMain()
      @ 20, 20 LABEL lbl_1 ;
         AUTOSIZE ;
         VALUE "Drag me around !!!"
   END WINDOW
   ACTIVATE WINDOW frm_Child NOWAIT

   RETURN NIL

FUNCTION MoveChild

   oChild:Row := oMain:Row + 40
   oChild:Col := oMain:Col + 40

   RETURN NIL

FUNCTION AdjustToMain

   IF oChild:Row # oMain:Row + 40
      oChild:Row := oMain:Row + 40
   ENDIF
   IF oChild:Col # oMain:Col + 40
      oChild:Col := oMain:Col + 40
   ENDIF

   RETURN NIL
/*
* EOF
*/
