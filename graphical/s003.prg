/*
 * Graphical Commands Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to draw a graph and later
 * print it to PDF.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   _OOHG_PrintLibrary := "PDFPRINT"

   DEFINE WINDOW Graph OBJ oWinGraph ;
      AT 0, 0 ;
      WIDTH 560 ;
      HEIGHT 560 ;
      CLIENTAREA ;
      NOMAXIMIZE ;
      BACKCOLOR { 179, 217, 255 } ;
      MAIN ;
      TITLE 'OOHG - Draw a graph and print it (use CTRL+P to print)'

      DRAW GRAPH ;
         IN WINDOW Graph ;
         AT 10, 10 ;
         TO 550, 550 ;
         TITLE "Monthly Data" ;
         TYPE BARS ;
         SERIES { {10}, {20}, {30}, {40}, {50}, {60}, {70}, {80}, {90}, {100}, {110}, {120} } ;
         YVALUES { "2019" } ;
         DEPTH 15 ;
         BARWIDTH 15 ;
         HVALUES 15 ;
         SERIENAMES {"Jan:", "Feb:", "Mar:", "Apr:", "May:", "Jun:", "Jul:", "Aug:", "Sep:", "Oct:", "Nov:", "Dec:"} ;
         COLORS { RED, BLUE, OLIVE, GREEN, ORANGE, PURPLE, FUCHSIA, PINK, MAROON, GRAY, SILVER, TEAL } ;
         3DVIEW ;
         SHOWGRID ;
         SHOWXVALUES ;
         SHOWYVALUES ;
         SHOWLEGENDS ;
         NOBORDER

      ON KEY CONTROL+P ACTION oWinGraph:Print( 1, 1, 40, 80, .F., "JPG", 100 )
      ON KEY ESCAPE ACTION Graph.Release
   END WINDOW

   CENTER WINDOW Graph
   ACTIVATE WINDOW Graph

   RETURN NIL

/*
 * EOF
 */
