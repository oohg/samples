/*
 * Graphical Commands Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to draw a transparent frame.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE MAIN

   LOCAL oWin

   DEFINE WINDOW Form ;
      OBJ oWin ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      NOSIZE ;
      NOMAXIMIZE ;
      TITLE "How to draw a transparent frame" ;
      BACKIMAGE "logo.jpg" STRETCH

      DRAW ROUNDRECTANGLE IN WINDOW Form AT 40,40 ;
                   TO 400,500 ;
                   ROUNDWIDTH 8 ;
                   ROUNDHEIGHT 8 ;
                   PENCOLOR BLUE ;
                   PENWIDTH 3 ;
                   TRANSPARENT

      ON KEY ESCAPE ACTION oWin:Release()
   END WINDOW

   oWin:Center()
   oWin:Activate()

   RETURN

/*
 * EOF
 */
