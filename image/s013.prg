/*
 * Image Sample # 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to print an image using it's handle.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download oohg.jpg and s013.rc from:
 * https://github.com/oohg/samples/tree/master/Image
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      TITLE "Print an Image using it's handle" ;
      MAIN

      @ 20,20 IMAGE Image_1 ;
         OBJ oImage ;
         IMAGESIZE ;
         PICTURE "OOHG"

      @ 200, 100 BUTTON button_1 ;
         WIDTH 150 ;
         CAPTION "Print HBPRINTER" ;
         ACTION PrintImage( "HBPRINTER" )

/*
      @ 200, 260 BUTTON button_2 ;
         WIDTH 150 ;
         CAPTION "Print MINIPRINT" ;
         ACTION PrintImage( "MINIPRINT" )
*/
      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL


PROCEDURE PrintImage( cTLibrary )

   LOCAL oPrint := TPrint( cTLibrary )

   oPrint:Init()

   oPrint:SelPrinter( .T., .T. )
   IF oPrint:lPrError
      oPrint:Release()
      RETURN
   ENDIF

   oPrint:BeginDoc( "Sample" )
   oPrint:BeginPage()
   oPrint:PrintData( 20, 10, "Image from handle" )
   oPrint:PrintBitmap( 21, 10, 30, 30, oImage:hBitmap )
   oPrint:EndPage()
   oPrint:EndDoc()

   oPrint:Release()

RETURN

/*
 * EOF
 */
