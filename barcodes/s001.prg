/*
 * Barcodes Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to print barcodes
 * using TPrint class.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW oWnd ;
      AT 10,10 ;
      WIDTH 300 ;
      HEIGHT 200 ;
      TITLE 'Códigos de barras'

      @  20,80 BUTTON but_1 CAPTION "MINIPRINT" ACTION Test( "MINIPRINT" )
      @  60,80 BUTTON but_2 CAPTION "HBPRINTER" ACTION Test( "HBPRINTER" )
      @ 100,80 BUTTON but_3 CAPTION "PDFPRINT"  ACTION Test( "PDFPRINT" )
   END WINDOW

   CENTER WINDOW oWnd
   ACTIVATE WINDOW oWnd

RETURN NIL

FUNCTION Test( cSalida )

   LOCAL oPrint := TPrint( cSalida )

   WITH OBJECT oPrint
      :Init()
      :SelPrinter( .T., .T. )
      IF ! :lPrError
         :BeginDoc( "barras" )
            :SetPreviewSize( 1 )
            :BeginPage()
               :PrintData( 5, 15, "prueba de códigos de barras" )
               :PrintBarcode( 10, 15, "123456789012","EAN13" )
               :PrintBarcode( 15, 15, "codigo128cabcdefgh","CODE128C", {128, 128, 128}, .F. )
               :PrintBarcode( 15, 30, "https://github.com/oohg/samples", "QRCODE", NIL, NIL, 20, 20 )
            :EndPage()
         :EndDoc()
      ENDIF
      :Release()
   END

RETURN NIL

/*
 * EOF
 */
