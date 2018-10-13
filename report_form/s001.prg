/*
 * Report Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to print reports using commands
 * REPORT FROM and REPORTFORMWIN with standard FRM files.
 *
 * Based on the original work of Daniel Piperno
 * dpiperno /at/ montevideo.com.uy
 * adapted to TPRINT class by Ciro Vargas Clemow.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   PUBLIC _OOHG_PrintLibrary := "MINIPRINT"

   REQUEST DBFNTX, DBFDBT

   DEFINE WINDOW Form_Main OBJ oWind ;
      AT 0,0 ;
      WIDTH 300 ;
      HEIGHT 430 ;
      TITLE 'DO REPORT FORM and DO REPORT sample' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'Test '
            ITEM 'REPORT FORM test 1 (normal)'    ACTION PrintNormal()
            ITEM 'REPORT FORM test 2 (condensed)' ACTION PrintCondensed()
            ITEM 'DO REPORT test 1 (normal)'      ACTION PrintNormal1()
            ITEM 'DO REPORT test 2 (condensed)'   ACTION PrintCondensed1()
            ITEM 'EXIT'                           ACTION oWind:Release()
         END POPUP
      END MENU

      @ 20,20 RADIOGROUP radio_1 ;
         OPTIONS { "hbprinter", "miniprint", "dos", "txt", "excel", "calc", "rtf", "csv", "html", "html/calc", "html/excel", "pdf", "raw", "spreadsheet" } ;
         VALUE 2 ;
         AUTOSIZE ON ;
         CHANGE CambiaLib()

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   USE TEST
   INDEX ON GROUP + Str( CODE, 5 ) TO TEST

   CENTER WINDOW Form_Main
   ACTIVATE WINDOW Form_Main

   RETURN NIL


FUNCTION CambiaLib()

   nOpcion := oWind:radio_1:value

   DO CASE
   CASE nOpcion == 1
    _OOHG_PrintLibrary := "HBPRINTER"
   CASE nOpcion == 3
    _OOHG_PrintLibrary := "DOSPRINT"
   CASE nOpcion == 4
    _OOHG_PrintLibrary := "TXTPRINT"
   CASE nOpcion == 5
    _OOHG_PrintLibrary := "EXCELPRINT"
   CASE nOpcion == 6
    _OOHG_PrintLibrary := "CALCPRINT"
   CASE nOpcion == 7
    _OOHG_PrintLibrary := "RTFPRINT"
   CASE nOpcion == 8
    _OOHG_PrintLibrary := "CSVPRINT"
   CASE nOpcion == 9
    _OOHG_PrintLibrary := "HTMLPRINT"
   CASE nOpcion == 10
    _OOHG_PrintLibrary := "HTMLPRINTFROMCALC"
   CASE nOpcion == 11
    _OOHG_PrintLibrary := "HTMLPRINTFROMEXCEL"
   CASE nOpcion == 12
    _OOHG_PrintLibrary := "PDFPRINT"
   CASE nOpcion == 13
    _OOHG_PrintLibrary := "RAWPRINT"
   CASE nOpcion == 14
    _OOHG_PrintLibrary := "SPREADSHEETPRINT"
   OTHERWISE
    _OOHG_PrintLibrary := "MINIPRINT"
   ENDCASE

   RETURN NIL



FUNCTION PrintNormal()

   REPORTFORMWIN TEST1 HEADING "PRUEBA 1"

   RETURN NIL


FUNCTION PrintCondensed()

   REPORTFORMWIN TEST2 HEADING "PRUEBA 2"

   RETURN NIL


FUNCTION PrintNormal1()

   GO TOP

   DO REPORT ;
      TITLE 'PRUEBA1|REPORTE DE PRUEBA' ;
      HEADERS { ' ', ' ', ' ' }, { 'CODE', 'FIRST', 'LAST', "NOTES" } ;
      FIELDS { 'code', 'first', 'last', "memofield" } ;
      WIDTHS { 10, 30, 19, 20 } ;
      NFORMATS { NIL, NIL, NIL, "M" } ;
      TOTALS { .T., .F., .F., .F. } ;
      WORKAREA test ;
      LPP 55 ;
      CPL 80 ;
      LMARGIN 0 ;
      PAPERSIZE DMPAPER_LETTER ;
      PREVIEW ;
      SELECT ;
      GROUPED BY 'GROUP' ;
      HEADRGRP 'Group Field' ;
      IMAGE "oohg.bmp" AT 1, 12 TO 2, 16

/*
 * The "M" at NFORMATS means to process "memofield" as a MEMO so all
 * its content gets printed using more lines if needed.
 * Default is to process as a CHARACTER thus truncating its content
 * to  one line only.
 */

   RETURN NIL


FUNCTION PrintCondensed1()

   GO TOP

   DO REPORT FORM TEST4

   RETURN NIL

/*
 * EOF
 */

