/*
 * Toolbar Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how place a ToolBar inside a form that
 * has virtual dimensions.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION MAIN

   DEFINE WINDOW Win ;
      OBJ oWin ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Toolbar in a window with virtual dimensions" ;
      MAIN

      DEFINE TOOLBAR Tool OBJ oTool BUTTONSIZE 70,20 FLAT BORDER
         BUTTON But1 CAPTION "&Exit" ACTION oWin:Release()
      END TOOLBAR

      DEFINE WINDOW Int ;
         OBJ oInt ;
         AT oTool:Height, 0 ;
         WIDTH oWin:ClientWidth ;
         HEIGHT oWin:ClientHeight - oTool:Height ;
         INTERNAL ;
         VIRTUAL HEIGHT 1000 ;
         VIRTUAL WIDTH 1000

         @ 100,20 TEXTBOX Text1 ;
            WIDTH 100 ;
            HEIGHT 25

         @ 300,20 TEXTBOX Text2 ;
            WIDTH 100 ;
            HEIGHT 25

         @ 500,20 TEXTBOX Text3 ;
            WIDTH 100 ;
            HEIGHT 25

         @ 700,20 TEXTBOX Text4 ;
            WIDTH 100 ;
            HEIGHT 25

         @ 900,20 TEXTBOX Text5 ;
            WIDTH 100 ;
            HEIGHT 25
      END WINDOW
   END WINDOW

   // This reduces flicker
   oInt:VScrollBar:nLineSkip := 50

   oWin:Center()
   oWin:Activate()

RETURN NIL

/*
 * EOF
 */
