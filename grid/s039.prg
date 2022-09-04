/*
 * Grid Sample # 39
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to stay in a cell after its
 * edition has ended.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL oForm, oGrid

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 320 ;
      TITLE "TGridByCell: Edit and Stay" ;
      MAIN

      @ 20, 20 GRID 0 OBJ oGrid ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 84 ;
         HEADERS { 'LINE','CODE','NAME','VALUE' } ;
         ITEMS { { 1, "x1", "ItemX1", 50 }, ;
                 { 2, "x2", "ItemX2", 45 }, ;
                 { 3, "x3", "ItemX3", 30 }, ;
                 { 4, "x4", "ItemX4", 25 }, ;
                 { 5, "x5", "ItemX5", 10 } } ;
         WIDTHS { 65, 115, 300, 100 } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '9999' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '@E 99,999,999.99'} } ;
         APPEND ;
         DELETE ;
         EDIT INPLACE ;
         FULLMOVE ;
         NAVIGATEBYCELL ;
         VALUE { 1, 1 } ;
         STOPEDIT { .F., .F., .T., .F. }

      @ oForm:ClientHeight - 44, oForm:ClientWidth - 240 BUTTON 0 OBJ oButton ;
         CAPTION "Change 'stop edit' of column 3 to " + iif( oGrid:aStopEdit[ 3 ], ".F.", ".T." ) ;
         WIDTH 220 ;
         HEIGHT 24 ;
         ACTION ( oGrid:aStopEdit[ 3 ] := ! oGrid:aStopEdit[ 3 ], ;
                  oButton:Caption := "Change 'stop edit' of column 3 to " + iif( oGrid:aStopEdit[ 3 ], ".F.", ".T." ), ;
                  oGrid:SetFocus() )

      ON KEY ESCAPE ACTION oForm:Release()
      ON KEY F2 ACTION oGrid:EditCell()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

/*
 * EOF
 */
