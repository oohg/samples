/*
 * SplitBox Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a SplitBox with two
 * Toolbars in the same row.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

Function Main()

   DEFINE WINDOW MainForm ;
      OBJ MainForm ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 240 ;
      TITLE "ooHG Splitbox Demo" ;
      MAIN

      DEFINE SPLITBOX OBJ Split
         DEFINE TOOLBAR ToolBar_1 BUTTONSIZE 20,20 FLAT BOTTOM
            BUTTON btn_NewPage CAPTION "New Page" ACTION Action() AUTOSIZE
            BUTTON btn_Back    CAPTION "Back"     ACTION Action() AUTOSIZE
            BUTTON btn_Forward CAPTION "Forward"  ACTION Action() AUTOSIZE
            BUTTON btn_Reload  CAPTION "Reload"   ACTION Action() AUTOSIZE
            BUTTON btn_Stop    CAPTION "Stop"     ACTION Action() AUTOSIZE
            BUTTON btn_Home    CAPTION "Home"     ACTION Action() AUTOSIZE
            BUTTON btn_About   CAPTION "About"    ACTION Action() AUTOSIZE
         END TOOLBAR NOBREAK

         /*
          * If the NOBREAK clause is omited, the toolbars
          * are shown in different rows
          */

         DEFINE TOOLBAR ToolBar_2 BUTTONSIZE 20,20 FLAT BOTTOM
            BUTTON btn_Go CAPTION "Go" ACTION Action() AUTOSIZE
         END TOOLBAR
      END SPLITBOX

      ON KEY ESCAPE ACTION MainForm:Release()

   END WINDOW

   CENTER WINDOW MainForm
   ACTIVATE WINDOW MainForm

RETURN Nil

FUNCTION Action()

  MSGINFO('Action','Info')

RETURN Nil

/*
 * EOF
 */
