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
 * https://github.com/oohg/samples/tree/master/Image
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

      @ 20, 20 IMAGE 0 ;
         OBJ oImage ;
         IMAGESIZE ;
         PICTURE "oohg.jpg"

      @ 20, 220 IMAGE 0 ;
         IMAGESIZE ;
         PICTURE "HARBOUR"

      @ 200, 20 BUTTON 0 ;
         WIDTH 150 ;
         CAPTION "Print" ;
         ACTION Print( "HBPRINTER" )

      @ 250, 20 CHECKBOX 0 ;
         OBJ oCheck ;
         CAPTION "Image Size"

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
   oPrint:PrintData( 5, 10, "Image from handle" )
   oPrint:PrintBitmap( 6, 10, 16, 30, oImage:hBitmap, , , , , oCheck:Value )
   oPrint:PrintData( 20, 10, "Image from resource" )
   oPrint:PrintResource( 21, 10, 31, 70, "HARBOUR", , , , , , , , , oCheck:Value )
   oPrint:EndPage()
   oPrint:EndDoc()

   oPrint:Release()

   RETURN

/*
 * EOF
 */
