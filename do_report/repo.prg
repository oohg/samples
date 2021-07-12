
#include 'oohg.ch'
#include "i_init.ch"

FUNCTION Main()

   SET LANGUAGE TO SPANISH

   DEFINE WINDOW form_1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 400 ;
      HEIGHT 300 ;
      TITLE 'OOHG - Print from a Report File' ;
      MAIN

      @ 30,75 BUTTON btn_Printer ;
         CAPTION 'Print External Report (.rpt) to Printer' ;
         ACTION TestReport( 1 ) ;
         HEIGHT 40 ;
         WIDTH 250

      @ 90,75 BUTTON btn_HBPrinter ;
         CAPTION 'Print External Report (.rpt) to HBPrinter' ;
         ACTION TestReport( 2 ) ;
         HEIGHT 40 ;
         WIDTH 250

      @ 150,75 BUTTON btn_PDF ;
         CAPTION 'Print External Report (.rpt) to PDF' ;
         ACTION TestReport( 3 ) ;
         HEIGHT 40 ;
         WIDTH 250

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW form_1
   ACTIVATE WINDOW form_1

RETURN NIL

FUNCTION TestReport( nTo )

   USE mtiempo SHARED
   IF ! File( "lista.ntx" )
      INDEX ON usuario TO lista
   ELSE
      SET INDEX TO lista
   ENDIF
   GO TOP

   DO CASE
   CASE nTo == 1
      _OOHG_PrintLibrary := "MINIPRINT"
   CASE nTo == 2
      _OOHG_PrintLibrary := "HBPRINTER"
   OTHERWISE
      _OOHG_PrintLibrary := "PDFPRINT"
   ENDCASE

   wempresa := 'Sistemas C.V.C.'
   DO REPORT FORM repdemo NAME ( GetCurrentFolder() + "\report" )

   CLOSE DATABASES

RETURN NIL

/*
 * EOF
 */
