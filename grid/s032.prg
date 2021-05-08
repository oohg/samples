/*
 * Grid Sample # 32
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a conditional
 * readonly column.
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
      TITLE 'Conditional Readonly Column' ;
      MAIN

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 84 ;
         HEADERS { 'LINE','CODE','NAME','VALUE' } ;
         READONLY { .F. , .F. , .F. , {|nItem, aItem| aItem[1] % 2 == 0 } } ;
         WIDTHS { 65, 115, 300,100 } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '9999' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '@E 99,999,999.99'} } ;
         ITEMS { {1, "COL 4 IS", "NOT READONLY", 1254.87}, {2, "COL 4 IS", "READONLY !!!", 2589.33} } ;
         APPEND ;
         DELETE ;
         EDIT INPLACE FULLMOVE

      oGrid:Cargo := 0

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
