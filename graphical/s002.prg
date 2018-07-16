/*
 * Graphical Commands Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to draw shapes in a form.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      TITLE "Draw shapes in a form" ;
      MAIN

      // LINE
      FOR i := 1 TO 5
         DRAW LINE IN WINDOW Win_1 ;
            AT 40 + (i * 6), 050 ;
            TO 40 + (i * 6), 200 ;
            PENCOLOR RED ;
            PENWIDTH i
      NEXT i

      // RECTANGLE
      DRAW RECTANGLE IN WINDOW Win_1 ;
         AT 100, 050 ;
         TO 150, 200 ;
         PENCOLOR YELLOW ;
         PENWIDTH 2 ;
         FILLCOLOR YELLOW

      // ROUNDRECTANGLE
      DRAW ROUNDRECTANGLE IN WINDOW Win_1 ;
         AT 180, 050 ;
         TO 230, 200 ;
         ROUNDWIDTH 15 ;
         ROUNDHEIGHT 15 ;
         PENCOLOR BLACK ;
         PENWIDTH 2 ;
         FILLCOLOR WHITE

      // ELLIPSE
      DRAW ELLIPSE IN WINDOW Win_1 ;
         AT 040, 300 ;
         TO 140, 400 ;
         PENCOLOR GREEN ;
         PENWIDTH 2 ;
         FILLCOLOR GREEN

      // ARC
      DRAW ARC IN WINDOW Win_1 ;
         AT 160, 300 ;
         TO 260, 400 ;
         FROM RADIAL 180, 350 ;
         TO RADIAL 200, 400 ;
         PENCOLOR BLUE ;
         PENWIDTH 5

      // PIE
      DRAW PIE IN WINDOW Win_1 ;
         AT 160, 500 ;
         TO 260, 600 ;
         FROM RADIAL 180, 550 ;
         TO RADIAL 200, 500 ;
         PENCOLOR FUCHSIA ;
         PENWIDTH 2 ;
         FILLCOLOR FUCHSIA

      // Polygon
      DRAW POLYGON IN WINDOW Win_1 ;
         POINTS { {400, 100}, ;
                  {350, 050}, ;
                  {300, 200}, ;
                  {350, 275}, ;
                  {400, 340}, ;
                  {500, 250}, ;
                  {400, 050} } ;
         PENCOLOR PINK ;
         PENWIDTH 2 ;
         FILLCOLOR PINK

      // POLYBEZIER
      DRAW POLYBEZIER IN WINDOW Win_1 ;
      POINTS {{400,400},{350,350},{300,500},{350,575},{400,640},{500,550},{400,350}} ;
      PENCOLOR ORANGE ;
      PENWIDTH 2

      ON KEY ESCAPE ACTION Win_1.Release()
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN NIL

/*
 * EOF
 */
