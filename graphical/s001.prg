/*
 * Graphical Commands Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a colorfull frame.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "i_windefs.ch"

PROCEDURE MAIN

   LOCAL oWin

   DEFINE WINDOW Form ;
      OBJ oWin ;
      WIDTH 640 ;
      HEIGHT 480 ;
      NOSIZE ;
      NOMAXIMIZE ;
      TITLE "How to draw a frame"

      ON KEY ESCAPE ACTION oWin:Release()

      DRAW ROUNDRECTANGLE IN WINDOW Form AT 40,40 ;
                   TO 400,500 ;
                   ROUNDWIDTH 8 ;
                   ROUNDHEIGHT 8 ;
                   PENCOLOR BLUE ;
                   PENWIDTH 5 ;
                   FILLCOLOR YELLOW

/*
 * When Form has no BackColor, use:
                   FILLCOLOR { GetRed( GetSysColor( COLOR_3DFACE ) ), ;
                               GetGreen( GetSysColor( COLOR_3DFACE ) ), ;
                               GetBlue( GetSysColor( COLOR_3DFACE ) ) }
 * so the frame's interior matches the color of the Form's background.
 *
 * When Form has BackColor, use the same color in FILLCOLOR clause
 * so the frame's interior matches the color of the Form's background.
 */

      @ 34,50 LABEL Title ;
         AUTOSIZE ;
         VALUE " My Frame " ;
         BACKCOLOR YELLOW
   END WINDOW

   oWin:Center()
   oWin:Activate()

RETURN

/*
 * EOF
 */
