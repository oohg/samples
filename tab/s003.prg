/*
 * Tab Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to dynamically add controls to
 * a Tab control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'oohg - Add controls to a TAB at runtime' ;
      MAIN

      DEFINE MAIN MENU
         MENUITEM "Add" ACTION AddCtrls()
      END MENU

      DEFINE TAB Tab_1 OBJ oTab ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1

         PAGE 'Page &1'
         END PAGE

         PAGE 'Page &2'
         END PAGE
      END TAB

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION AddCtrls

   @ 40,20 RADIOGROUP rdg_1 ;
      PARENT Form_1 ;
      OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
      WIDTH 80 ;
      SPACING 24 ;
      FONTCOLOR GREEN ;
      BACKCOLOR GetSysColor( COLOR_WINDOW )

   DEFINE CHECKBOX chk_1
      PARENT Form_1
      ROW 40
      COL 140
      WIDTH 160
      VALUE .F.
      CAPTION 'Left Align Red Caption'
      THREESTATE .T.
      LEFTALIGN .T.
      FONTCOLOR RED
      BACKCOLOR GetSysColor( COLOR_WINDOW )
   END CHECKBOX

   // METHOD AddControl( oCtrl, nPageNumber, nRow, nCol )
   oTab:AddControl( "rdg_1", 1, 40, 20 )
   oTab:AddControl( "chk_1", 2, 40, 140 )

   RETURN NIL

/*
 * EOF
 */
