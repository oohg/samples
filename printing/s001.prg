/*
 * Printing Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to enumerate the available paper
 * sizes in a printer driver.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 300 ;
      TITLE 'Available Paper Sizes in a Printer' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM "Click the button and select a printer."
      END STATUSBAR

      @ 20, 20 BUTTON But_1 ;
         CAPTION "Show Data" ;
         ACTION ShowData()

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ShowData()
   LOCAL oPrint

   oPrint := TPrint( "HBPRINTER" )
   oPrint:Init()
   oPrint:SelPrinter()
   IF ! oPrint:LPrError
      AutoMsgBox( oPrint:oHBPrn:PaperNames, "Available Paper Sizes" )
   ENDIF

   oPrint:Release()

RETURN NIL

/*
 * EOF
 */
