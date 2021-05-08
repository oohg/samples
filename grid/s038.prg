/*
 * Grid Sample # 38
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use a fullmove grid.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   PRIVATE aRows [15] [5]

   SET DATE ANSI
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   bColor := { || iif( .T., RGB( 255, 255, 255 ), RGB( 255, 255, 255 ) ) }
   bcolor1:= { || iif( This.CellValue == 0, RED, WHITE ) }

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 550 ;
      TITLE 'Full-Move and Append Grid Modes Demo' ;
      MAIN

      FOR k := 1 TO 15
         aRows[ k ] := { Str( hb_RandomInt( 99 ), 2 ), ;
                         hb_RandomInt( 100 ), ;
                         Date() + hb_RandomInt( 30 ), ;
                         "Refer " + Str( hb_RandomInt( 10 ), 2 ), ;
                         hb_RandomInt( 10000 ) }
      NEXT k

      @ 10, 010 BUTTON b1 OBJ ob1 ;
         CAPTION "up" ACTION { || oGrid:SetFocus(), oGrid:Up() }

      @ 10, 150 BUTTON b2 OBJ ob2 ;
         CAPTION "down" ACTION { || oGrid:SetFocus(), oGrid:Down() }

      @ 10, 280 CHECKBOX c3 OBJ oc3 ;
         CAPTION "Full Move" ON CHANGE CambiaX()

      @ 10, 400 CHECKBOX c4 OBJ oc4 ;
         CAPTION "Append Mode" ON CHANGE CambiaY()

      @ 40,10 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODIGO', 'NUMERO', 'FECHA', 'REFERENCIA', 'IMPORTE' } ;
         WIDTHS {60, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', "99" }, ;
                          { 'TEXTBOX', "NUMERIC", '999999' }, ;
                          { "TEXTBOX", "DATE" }, ;
                          { 'TEXTBOX', "CHARACTER" }, ;
                          { 'TEXTBOX', 'NUMERIC', '999,999,999.99' } } ;
         FONT "COURIER NEW" SIZE 10 ;
         EDIT INPLACE ;
         ON EDITCELL Procesa()

      @ 390, 290 LABEL l VALUE "Total"

      @ 390, 390 TEXTBOX nSuma NUMERIC INPUTMASK "999,999,999.99"

      Form_1.nSuma.ReadOnly := .T.

      Sumatoria()

      @ 415, 5 LABEL label_1 AUTOSIZE ;
         VALUE "Ingrese 99 en la primera columna, 50 o 77 en la segunda para observar las posibilidades de movimiento."

      @ 440, 5 LABEL label_2 AUTOSIZE ;
         VALUE "Ingrese 43 en la primera columna y en la segunda aparecera 88 y pasara a la quinta."

      @ 465, 5 LABEL label_5 AUTOSIZE ;
         VALUE "Haga doble click en alguna celda y luego enter para editar y cambiar su valor."

      @ 490, 5 LABEL label_3 AUTOSIZE ;
         VALUE "Revise el codigo fuente y verá lo fácil que es."

      Form_1.label_1.Visible := .F.
      Form_1.label_2.Visible := .F.
      Form_1.label_5.Visible := .F.
      Form_1.label_3.Visible := .F.

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

STATIC FUNCTION CambiaX()

   IF oc3:Value
      oGrid:FullMove := .T.
      Form_1.label_1.Visible := .T.
      Form_1.label_2.Visible := .T.
      Form_1.label_5.Visible := .T.
      Form_1.label_3.Visible := .T.
   ELSE
      oGrid:FullMove := .F.
      Form_1.label_1.Visible := .F.
      Form_1.label_2.Visible := .F.
      Form_1.label_5.Visible := .F.
      Form_1.label_3.Visible := .F.
   ENDIF

   RETURN NIL

STATIC FUNCTION CambiaY()

   IF oc4:Value
      oGrid:Append := .T.
   ELSE
      oGrid:Append := .F.
   ENDIF

   RETURN NIL

STATIC PROCEDURE Procesa()

   IF This.CellColIndex == 1 .AND. This.CellValue == "99"
      oGrid:Right()
      oGrid:Right()
   ENDIF

   IF This.CellColIndex == 1 .AND. This.CellValue == "43"
      oGrid:Cell( This.CellRowIndex, 2, 88 )
      oGrid:Right()
      oGrid:Right()
      oGrid:Right()
   ENDIF
   IF This.CellColIndex == 2 .AND. This.CellValue == 50
      oGrid:Down()
      oGrid:Left()
   ENDIF
   IF This.CellColIndex == 2 .AND. This.CellValue == 77
      oGrid:Up()
      oGrid:Left()
      oGrid:Right()
   ENDIF
   IF This.CellColIndex == 5
      Sumatoria()
   ENDIF

   RETURN NIL

STATIC PROCEDURE Sumatoria()
   LOCAL suma := 0
   FOR i := 1 TO oGrid:ItemCount()
      suma += oGrid:Cell( i, 5 )
   NEXT
   Form_1.nsuma.Value := suma

   RETURN NIL

/*
 * EOF
 */
