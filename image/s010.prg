/*
 * Image Sample # 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an IMAGE control to
 * print an image loaded from a resource.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download oohg.jpg and s010.rc from:
 * https://github.com/oohg/samples/tree/master/image
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      TITLE 'Print an Image from RC file' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM ""
      END STATUSBAR

      @ 20,20 IMAGE Image_1 ;
         OBJ oImage ;
         IMAGESIZE ;
         PICTURE "OOHG" ON MOUSEHOVER oForm:StatusBar:Item( 1, TToS( Time() ) )

      @ 200, 010 BUTTON button_1 ;
         WIDTH 150 ;
         CAPTION "Print HBPRINTER" ;
         ACTION PrintImage( "HBPRINTER" )

      @ 200, 170 BUTTON button_2 ;
         WIDTH 150 ;
         CAPTION "Print MINIPRINT" ;
         ACTION PrintImage( "MINIPRINT" )

      @ 200, 330 BUTTON button_3 ;
         WIDTH 150 ;
         CAPTION "Print PDFPRINT" ;
         ACTION PrintImage( "PDFPRINT" )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL


PROCEDURE PrintImage( cTLibrary )

   LOCAL oPrint := TPrint( cTLibrary )

   oPrint:Init()

   oPrint:SelPrinter( .T., .T., .T. )
   IF oPrint:lPrError
      oPrint:Release()
      RETURN
   ENDIF

   oImage:SaveAs( "s010.jpg", .F., "JPG", 100, 24 )

   oPrint:BeginDoc( "Sample" )
   oPrint:BeginPage()
   oPrint:PrintImage( 21, 10, 30, 30, "s010.jpg", 100 )
   oPrint:EndPage()
   oPrint:EndDoc()

   oPrint:Release()

   ERASE s010.jpg

RETURN

/*
 * EOF
 */
