/*
 * Printing Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows different methods of TPrint class.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"
#include "miniprint.ch"

FUNCTION Main

   DEFINE WINDOW Form ;
      MAIN ;
      WIDTH 500 HEIGHT 200 ;
      TITLE "OOHG - Printing with TPrint"

      @ 20, 20 BUTTON btn_HBPRINTER ;
         CAPTION "HBPrinter" ;
         ACTION DoReports( "HBPRINTER" )

      @ 20, 140 BUTTON btn_MINIPRINT ;
         CAPTION "MiniPrint" ;
         ACTION DoReports( "MINIPRINT" )

      @ 20, 300 IMAGE img_Test OBJ oImg ;
         PICTURE "uruguay.ico" ;
         IMAGESIZE ;
         BORDER

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

   RETURN NIL

FUNCTION DoReports( cPrintLib )

   cFont   := "Courier New"
   nNumber := 10320
   cDate   := DToC( Date() )
   cCli    := "ANTONIO"
   cNIF    := "45271099S"
   cAdd    := "My Address"

   oPrint1 := TPrint( cPrintLib )
   oPrint1:Init()

   oPrint1:SetUnits( "MM" )
   oPrint1:SelPrinter( .F., .T. )

   IF oPrint1:lPrError
      oPrint1:Release()
      RETURN NIL
   ENDIF

   oPrint1:SetPreviewSize( 2 )
   oPrint1:BeginDoc()
      oPrint1:BeginPage()
         nLin := 55
         oPrint1:PrintRoundrectangle( nLin + 5, 06, nLin + 17, 60 )
         oPrint1:PrintData( nLin +  7, 08, "AAAAAAA :" ,                       cFont, 12)
         oPrint1:PrintData( nLin +  7, 31, Transform( nNumber, "99,999,999" ), cFont, 12, .T. )
         oPrint1:PrintData( nLin + 12, 08, "Date    :",                        cFont, 12 )
         oPrint1:PrintData( nLin + 12, 31, cDate,                              cFont, 12, .T. )
         oPrint1:PrintRoundrectangle( nLin - 2, 70, nLin+25,203)
         oPrint1:PrintData( nLin,      73, "Client   :", cFont, 12 )
         oPrint1:PrintData( nLin,      99, cCli,         cFont, 12, .T. )
         oPrint1:PrintData( nLin + 10, 73, "NIF      :", cFont, 12 )
         oPrint1:PrintData( nLin + 10, 99, cNIF,         cFont, 12, .T. )
         oPrint1:PrintData( nLin + 15, 73, "Address  :", cFont, 12 )
         oPrint1:PrintData( nLin + 15, 99, cAdd,         cFont, 12, .T.)

         // PrintImage( nLin, nCol, nLinF, nColF, cImage, aResol, aSize, aExt )
         // aSize == .T. means print at imagesize
         oPrint1:PrintImage( nLin + 30, 10, 0, 0, "uruguay.ico", NIL, .T., NIL )

         // PrintBitmap( nLin, nCol, nLinF, nColF, hBitmap, aResol, aSize, aExt )
         // aSize == .T. means print at imagesize
         oPrint1:PrintBitmap( nLin + 30, 60, 0, 0, oImg:hImage, NIL, .T., NIL )

         hBitmap := _OOHG_BitmapFromFile( NIL, "uruguay.ico", LR_CREATEDIBSECTION, .F., .F., ArrayRGB_TO_COLORREF( WHITE ) )
         oPrint1:PrintBitmap( nLin + 30, 110, 0, 0, hBitmap, NIL, .T., NIL )
         DeleteObject( hBitmap )

         // PrintResource( nLin, nCol, nLinF, nColF, cResource, aResol, aSize, aExt, lNoDIB, lNo3DC, lNoTra, lNoChk )
         // aSize == .T. means print at imagesize
         oPrint1:PrintResource( nLin + 30, 160, 0, 0, "uruguay.ico", NIL, .T., NIL, .F. )

      oPrint1:EndPage()
   oPrint1:EndDoc( .F., .T., .T. )   // Save, Wait, Size

   oPrint1:Release() 

   RETURN NIL

/*
 * EOF
 */
