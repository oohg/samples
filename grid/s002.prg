/*
 * Grid Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to create a Grid with navigation by cell
 * capabilities. By default, the navigation is restricted to the
 * selected row, but you can enable extended navigation by adding
 * the FULLMOVE clause at define time or by changing FULLMOVE
 * property at run time. This sample also demonstrate methods:
 * Left, Right, Up, Down, PageDown, PageUp, GoTop, GoBottom,
 * AddItem, AppendItem, EditCell, AddColumn, DeleteColumn,
 * ColumnHide and, ColumnShow. This kind of Grid is implemented
 * by TGridByCell subclass of TGrid class, so you can use almost
 * all the methods of the parent class. Beware that the Value of
 * TGridByCell class is a two items array {Row,Col} instead of
 * the number in TGrid class, so if you plan to convert any of
 * your old grids to this new class, you must take care of this
 * change. See document Colors of rows and columns in grid,
 * xbrowse and browse controls.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL k, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 500 ;
      TITLE 'Grid with Navigation By Cell' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR k := 1 TO 15
          aRows[ k ] := { Str(HB_RandomInt( 99 ), 2), ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ), ;
                          HB_RandomInt( 10000 ) }
      NEXT k

      @ 20, 20 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 60, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         EDIT ;
         WHEN { .T., { |nCol, aItem| aItem[ nCol ] > 50 }, .T., .T., .T. } ;
         READONLY { .F., .F., .F., .F., .T. } ;
         VALID { { |uValue| ! empty( uValue ) }, ;
                 { |uValue| uValue >= 0}, ;
                 { |uValue| uValue > date() }, ;
                 { |uValue| ! empty( uValue ) }, ;
                 NIL } ;
         NAVIGATEBYCELL ;
         SELECTEDCOLORS { BLACK, YELLOW, ;
                          YELLOW, BROWN, ;
                          BLUE, GREEN, ;
                          GREEN, PINK } ;
         FONTCOLOR PURPLE ;
         BACKCOLOR ORANGE ;
         DYNAMICFORECOLOR { WHITE, NIL, NIL, NIL, NIL } ;
         DYNAMICBACKCOLOR { BLACK, NIL, NIL, NIL, NIL } ;
         ON CHANGE { || Form_1.StatusBar.Item( 1 ) := ;
                        'Value changed to ' + Autotype( oGrid:Value ) } ;
         VALUE { 5, 4 } DISABLED

      DEFINE CONTEXT MENU CONTROL Grid_1
         MENUITEM 'Go to row 4 col 2' ;
            ACTION {|| oGrid:Value := { 4, 2 } }
         SEPARATOR
         MENUITEM 'Left' ;
            ACTION {|| oGrid:Left() }
         MENUITEM 'Right' ;
            ACTION {|| oGrid:setfocus(), oGrid:Right()}
         MENUITEM 'Up' ;
            ACTION {|| oGrid:setfocus(), oGrid:Up() }
         MENUITEM 'Down' ;
            ACTION {|| oGrid:setfocus(), oGrid:Down()}
         MENUITEM 'Page Up' ;
            ACTION {|| oGrid:setfocus(), oGrid:PageUp() }
         MENUITEM 'Page Down' ;
            ACTION {|| oGrid:setfocus(), oGrid:PageDown()}
         MENUITEM 'Top' ;
            ACTION {|| oGrid:setfocus(), oGrid:GoTop() }
         MENUITEM 'Bottom' ;
            ACTION {|| oGrid:setfocus(), oGrid:GoBottom() }
         SEPARATOR
         MENUITEM 'Add Item' ;
            ACTION {|| oGrid:AddItem( { '11', 123456, date(), ;
                                        'Added by AddItem', 123.99 } ) }
         MENUITEM 'Append Item' ;
            ACTION {|| oGrid:AppendItem() }
         MENUITEM 'Delete Item' ;
            ACTION {|| oGrid:DeleteItem( oGrid:Value[ 1 ] ) }
         SEPARATOR
         MENUITEM 'Edit row 2 col 3' ;
            ACTION {|| oGrid:EditCell( 2, 3 ) }
         SEPARATOR
         MENUITEM 'Add Column 3' NAME mnu_AddCol ;
            ACTION {|| oGrid:AddColumn( 3, "PERSON", 100, GRID_JTFY_CENTER, ;
                                        NIL, NIL, .T., NIL, { 'TEXTBOX', ;
                                        'CHARACTER' }, NIL, NIL, NIL, .T., ;
                                        NIL, NIL, .F. ), ;
                       Form_1.mnu_DelCol.Enabled := .T., ;
                       Form_1.mnu_AddCol.Enabled := .F. }
         MENUITEM 'Delete Column 3' NAME mnu_DelCol DISABLED ;
            ACTION {|| oGrid:DeleteColumn( 3, .T. ), ;
                       Form_1.mnu_AddCol.Enabled := .T., ;
                       Form_1.mnu_DelCol.Enabled := .F. }
         MENUITEM 'Hide Column 2' NAME mnu_Hide ;
            ACTION {|| oGrid:ColumnHide( 2 ), ;
                       Form_1.mnu_Show.Enabled := .T., ;
                       Form_1.mnu_Hide.Enabled := .F. }
         MENUITEM 'Show Column 2' NAME mnu_Show DISABLED ;
            ACTION {|| oGrid:ColumnShow( 2 ), ;
                       Form_1.mnu_Hide.Enabled := .T., ;
                       Form_1.mnu_Show.Enabled := .F. }
         MENUITEM 'Columns Better AutoFit' ;
            ACTION {|| oGrid:ColumnsBetterAutoFit() }
      END MENU

      @ 370, 20 CHECKBOX chk_Append ;
         CAPTION 'Append Mode' ;
         ON CHANGE oGrid:Append := ! oGrid:Append

      @ 410, 20 LABEL lbl_Try ;
         VALUE 'Try the Context Menu !!!' ;
         AUTOSIZE

      @ 370, 220 CHECKBOX chk_FullMode ;
         CAPTION 'FullMove' ;
         ON CHANGE oGrid:FullMove := ! oGrid:FullMove

      @ 410, 220 LABEL lbl_Enter ;
         VALUE 'Use Enter or DoubleClick to start edition.' ;
         AUTOSIZE

      @ 370, 420 CHECKBOX chk_EnDis ;
         CAPTION 'Enable' ;
         ON CHANGE ( oGrid:Enabled := ! oGrid:Enabled, Form_1.chk_EnDis.Caption := iif( oGrid:Enabled, "Disable", "Enable" ) )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
