
#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW form_1 ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 400 ;
      HEIGHT 300 ;
      TITLE 'OOHG - Print from a Report File' ;
      MAIN

      @ 50,75 BUTTON btn_Printer ;
         CAPTION 'Print External Report (.rpt) to Printer' ;
         ACTION TestReport( .F. ) ;
         HEIGHT 40 ;
         WIDTH 250

      @ 120,75 BUTTON b_PDF ;
         CAPTION 'Print External Report (.rpt) to PDF' ;
         ACTION TestReport( .T. ) ;
         HEIGHT 40 ;
         WIDTH 250

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW form_1
   ACTIVATE WINDOW form_1

RETURN NIL

FUNCTION TestReport( lToPDF )

   USE mtiempo
   INDEX ON usuario TO lista
   GO TOP

   IF lToPDF
      _OOHG_PrintLibrary := "PDFPRINT"
   ENDIF

   wempresa := 'Sistemas C.V.C'
   DO REPORT FORM repdemo NAME ( GetCurrentFolder() + "\report" )

   CLOSE DATABASES
   ERASE lista.ntx

RETURN NIL

/*
 * EOF
 */
