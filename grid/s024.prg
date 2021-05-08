/*
 * Grid Sample # 24
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to start the edition in the third
 * column of a new line of a Grid, using ON EDITCELL, WHEN
 * and ON ABORTEDIT clauses.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aRows[5, 5], k
   PUBLIC lEdit := .T.

   SET DATE ANSI
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 600 ;
      HEIGHT 550 ;
      TITLE 'Edit new row from column 3' ;
      MAIN

      FOR k := 1 TO 5
          aRows[k] := { Str( HB_RandomInt(99), 2 ), ;
                        HB_RandomInt(100), ;
                        HB_RandomInt(100), ;
                        "Refer " + Str( HB_RandomInt(10), 2 ), ;
                        HB_RandomInt(10000) }
      NEXT k

      @ 40,10 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS {'CODE', 'NUMBER', 'ITEM', 'REFERENCE', 'AMOUNT'} ;
         WIDTHS {60, 80, 100, 120, 140} ;
         ITEMS aRows ;
         COLUMNCONTROLS { {'TEXTBOX', 'CHARACTER', "99"}, ;
                          {'TEXTBOX', "NUMERIC", '999999'}, ;
                          {'TEXTBOX', "NUMERIC", '999999'}, ;
                          {'TEXTBOX', "CHARACTER"}, ;
                          {'TEXTBOX', 'NUMERIC', '999,999,999.99'} } ;
         FONT "COURIER NEW" SIZE 10 ;
         VALUE 5 ;
         APPEND ;
         EDIT INPLACE ;
         FULLMOVE ;
         WHEN { {|| lEdit }, {|| lEdit }, .T., .T., .T. } ;
         ON EDITCELL CellEdited( oGrid ) ;
         ON ABORTEDIT lEdit := .T.

      @ 400, 10 LABEL Label_1 ;
         WIDTH 520 ;
         HEIGHT 100 ;
         VALUE "When column 2 value is < 50, edition continues in the " + ;
               "same line. When value is >= 50, edition continues in " + ;
               "the column 3 of next line (if the row is the last one, " + ;
               "a new one is added)."

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION CellEdited( oGrid )
   LOCAL i

   IF This.CellColIndex == 2 .AND. _OOHG_ThisItemCellValue >= 50
      /*
         Grid is tricked to think it just edited the last column.
         If the current row is the last, when this function ends,
         a new row will be added. If not, edition continues in
         the next line.
      */
      FOR i := 1 TO ( oGrid:ColumnCount - This.CellColIndex )
         oGrid:Right()
      NEXT i

      // Disables edition of columns 1 and 2
      lEdit := .F.
   ELSE
      lEdit := .T.
   ENDIF

RETURN NIL

/*
 * EOF
 */
