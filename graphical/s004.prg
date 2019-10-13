/*
 * Graphical Commands Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to draw some shapes.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      TITLE "OOHG - Shapes Demo" ;
      MAIN ;
      ON INIT DrawShapes()

      ON KEY F9 ACTION oWin:Print()
   END WINDOW

   Form_1.Center
   Form_1.Activate

   RETURN NIL

FUNCTION DrawShapes

   MsgInfo( "Lines" )
   FOR i := 1 TO 5
      DRAW LINE IN WINDOW Form_1 AT 40+(i*6),50 TO 40+(i*6),200 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH i
   NEXT i
   MsgInfo( "Rectangle" )
   DRAW RECTANGLE IN WINDOW Form_1 AT 100,50 TO 150,200 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2 FILLCOLOR {Random(255),Random(255),Random(255)}
   MsgInfo( "RoundRectangle" )
   DRAW ROUNDRECTANGLE IN WINDOW Form_1 AT 180,50 TO 230,200 ROUNDWIDTH 15 ROUNDHEIGHT 15 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2 FILLCOLOR {Random(255),Random(255),Random(255)}
   MsgInfo( "Ellipse" )
   DRAW ELLIPSE IN WINDOW Form_1 AT 40,300 TO 140,600 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2 FILLCOLOR {Random(255),Random(255),Random(255)}
   MsgInfo( "Arc" )
   DRAW ARC IN WINDOW Form_1 AT 160,300 TO 260,400 FROM RADIAL 180,350 TO RADIAL 200,400 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 5
   MsgInfo( "Pie" )
   DRAW PIE IN WINDOW Form_1 AT 160,500 TO 260,600 FROM RADIAL 180,550 TO RADIAL 200,500 PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2 FILLCOLOR {Random(255),Random(255),Random(255)}
   MsgInfo( "Polygon" )
   DRAW POLYGON IN WINDOW Form_1 POINTS {{400,100},{350,50},{300,200},{350,275},{400,340},{500,250},{400,50}} PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2 FILLCOLOR {Random(255),Random(255),Random(255)}
   MsgInfo( "Polybezier" )
   DRAW POLYBEZIER IN WINDOW Form_1 POINTS {{400,400},{350,350},{300,500},{350,575},{400,640},{500,550},{400,350}} PENCOLOR {Random(255),Random(255),Random(255)} PENWIDTH 2

   RETURN NIL

/*
 * EOF
 */
