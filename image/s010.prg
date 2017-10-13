/*
 * Image Sample n° 10
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an IMAGE control to
 * print an image loaded from a resource.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 *
 * You can download oohg.jpg and s010.rc from:
 * https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/Image
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

      @ 20,20 IMAGE Image_1 ;
         OBJ oImage ;
         IMAGESIZE ;
         PICTURE "OOHG"

      @ 200, 100 BUTTON button_1 ;
         WIDTH 150 ;
         CAPTION "Print HBPRINTER" ;
         ACTION PrintImage( "HBPRINTER" )

      @ 200, 260 BUTTON button_2 ;
         WIDTH 150 ;
         CAPTION "Print MINIPRINT" ;
         ACTION PrintImage( "MINIPRINT" )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL


PROCEDURE PrintImage( cTLibrary )

   LOCAL oPrint := TPrint( cTLibrary )

   oPrint:Init()

   oPrint:SelPrinter( .T., .T., .t. )
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
