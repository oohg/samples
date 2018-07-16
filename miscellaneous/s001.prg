/*
 * Miscellaneous Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to remove the visual style from a
 * form or control at runtime.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION MAIN

   DEFINE WINDOW Win_1 ;
      OBJ oWin1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Remove Visual Style" ;
      MAIN

      DEFINE SPLITBOX
         DEFINE TOOLBAR tbr_1 OBJ oTool1 BUTTONSIZE 70,20 BORDER
            BUTTON But11 CAPTION "&Exit" ACTION oWin:Release()
            BUTTON But12 CAPTION "&One" DROPDOWN
            BUTTON But13 CAPTION "&Two" WHOLEDROPDOWN
         END TOOLBAR
         DEFINE TOOLBAR tbr_2 OBJ oTool2 BUTTONSIZE 70,20 BORDER FLAT
            BUTTON But21 CAPTION "&Exit" ACTION oWin:Release()
            BUTTON But22 CAPTION "&One" DROPDOWN
            BUTTON But23 CAPTION "&Two" WHOLEDROPDOWN
         END TOOLBAR
      END SPLITBOX

      @ 140, 10 BUTTON btn_1 OBJ oBut1 ;
      WIDTH 200 ;
      CAPTION "Remove Theme" ;
      ACTION { oTool1:DisableVisualStyle(), ;
               oTool2:DisableVisualStyle(), ;
               oBut1:DisableVisualStyle(), ;
               oWin1:DisableVisualStyle(), ;
               oWin1:Redraw() }
   END WINDOW

   oWin1:Center()
   oWin1:Activate()

RETURN NIL

/*
 * EOF
 */
