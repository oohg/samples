/*
 * Image Sample # 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to print an image using its handle.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download oohg.jpg and s013.rc from:
 * https://github.com/oohg/samples/tree/master/image
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      TITLE "ooHG - Print an Image using it's handle or from resources" ;
      MAIN

      @ 10, 020 LABEL 0 VALUE "From resources" SIZE 8

      @ 25, 020 IMAGE 0 OBJ oImage1 IMAGESIZE PICTURE "OOHG"

      @ 25, 220 IMAGE 0 OBJ oImage2 IMAGESIZE PICTURE "HARBOUR"

      @ 200, 020 BUTTON 0 CAPTION "MiniPrint" WIDTH 150 ;
         ACTION Print( "MINIPRINT" )

      @ 200, 200 BUTTON 0 CAPTION "HBPrinter" WIDTH 150 ;
         ACTION Print( "HBPRINTER" )

      @ 200, 380 CHECKBOX 0 OBJ oCheck CAPTION "Image Size"

      @ 250, 020 LABEL 0 VALUE "From file" SIZE 8

      @ 265, 020 IMAGE 0 OBJ oImage3 IMAGESIZE PICTURE "oohg.jpg"

      @ 265, 220 IMAGE 0 OBJ oImage4 IMAGESIZE PICTURE "demo.gif"

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

PROCEDURE Print( cTPrintLib )

   LOCAL oPrint := TPrint( cTPrintLib )

   oPrint:Init()

      oPrint:SelPrinter( .T., .T. )
      IF oPrint:lPrError
         oPrint:Release()
         RETURN
      ENDIF

      oPrint:BeginDoc()
         oPrint:BeginPage()

            oPrint:PrintData( 00, 00, "Image from resource", , , , RED )
                // PrintResource( nLin, nCol, nLinF, nColF, cResource, aResol, aSize, ...
            oPrint:PrintResource( 02,   00,   12,    10,    "OOHG",    NIL,    oCheck:Value )
            oPrint:PrintResource( 02,   20,   12,    40,    "HARBOUR", NIL,    oCheck:Value )

            oPrint:PrintData( 20, 00, "Image from file", , , , GREEN )
                // PrintImage( nLin, nCol, nLinF, nColF, cImage,     aResol, aSize,        aExt )
            oPrint:PrintImage( 22,   00,   32,    10,    "oohg.jpg", NIL,    oCheck:Value, NIL )
            oPrint:PrintImage( 22,   20,   32,    40,    "demo.gif", NIL,    oCheck:Value, NIL )

            oPrint:PrintData( 40, 00, "Image from bitmap", , , , BLUE )
                // PrintBitmap( nLin, nCol, nLinF, nColF, hBitmap,         aResol, aSize, ...
            oPrint:PrintBitmap( 42,   00,   52,    10,    oImage1:hBitmap, NIL,    oCheck:Value )
            oPrint:PrintBitmap( 42,   20,   52,    40,    oImage2:hBitmap, NIL,    oCheck:Value )

         oPrint:EndPage()
      oPrint:EndDoc()

   oPrint:Release()

   RETURN

/*
 * EOF
 */
