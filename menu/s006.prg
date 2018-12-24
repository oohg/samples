/*
 * Menu Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to enable/disable a POPUP at runtime.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm_1 ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - enable/disable a POPUP at runtime' ;
      MAIN ;
      ON INIT oEnable:Enabled := .F.

      DEFINE MAIN MENU
         POPUP 'PopUpMenu' OBJ oPopUpMenu
            ITEM 'Exit' ;
               ACTION oForm_1:Release()
         END POPUP
      END MENU

      @ 20, 20 BUTTON btn_Enable ;
         OBJ oEnable ;
         CAPTION "Enable" ;
         ACTION ( oPopUpMenu:Enabled := .T., ;
                  oEnable:Enabled := .F., ;
                  oDisable:Enabled := .T. )

      @ 60, 20 BUTTON btn_Disable ;
         OBJ oDisable ;
         CAPTION "Disable" ;
         ACTION ( oPopUpMenu:Enabled := .F., ;
                  oEnable:Enabled := .T., ;
                  oDisable:Enabled := .F. )

      ON KEY ESCAPE ACTION oForm_1:Release()

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
