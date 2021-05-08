/*
 * Grid Sample # 26
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set the colors of the selected row
 * depending on the control's value.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL k, oGrid, aRows[ 30, 2 ]
   PRIVATE bColor1 := { || if (  This.CellRowIndex/2 == Int(This.CellRowIndex/2), RED,   GREEN  )}
   PRIVATE bColor2 := { || if (  This.CellRowIndex/2 == Int(This.CellRowIndex/2), WHITE, YELLOW )}
   PRIVATE bColor3 := { || if (  oGrid:Value/2       == Int(oGrid:Value/2),       WHITE, YELLOW )}
   PRIVATE bColor4 := { || if (  oGrid:Value/2       == Int(oGrid:Value/2),       RED,   GREEN  )}
   PRIVATE bColor5 := { || if (  oGrid:Value/2       == Int(oGrid:Value/2),       WHITE, YELLOW )}
   PRIVATE bColor6 := { || if (  oGrid:Value/2       == Int(oGrid:Value/2),       GRAY,  GRAY   )}

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE "SelectedColor Clause" ;
      MAIN ;
      ON INIT oGrid:Value := 3

      FOR k := 1 TO 30
          aRows[ k ] := { Str(HB_RandomInt( 99 ), 2, 0), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ) }
      NEXT k

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'REFERENCE' } ;
         WIDTHS { 60, 140 } ;
         ITEMS aRows ;
         FONT 'COURIER NEW' SIZE 10 ;
         DYNAMICFORECOLOR { bColor1, bColor1 } ;
         DYNAMICBACKCOLOR { bColor2, bColor2 } ;
         ON CHANGE oGrid:SetSelectedColors( { bColor3, bColor4, bColor5, bColor6 }, .T. )

/*
SELECTEDCOLOR clause uses an array with 4 items to paint the selected item (the item pointed by the control's value):

item 1: text's color when control has focus, defaults to COLOR_HIGHLIGHTTEXT.
item 2: text's background color when control has focus, defaults to COLOR_HIGHLIGHT.
item 3: text's color when control doesn't has focus, defaults to COLOR_WINDOWTEXT.
item 4: text's background when control doesn't has focus, defaults to COLOR_3DFACE.
*/

      @ 360, 10 BUTTON Button_1 ;
         CAPTION "Click" ACTION Nil

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
