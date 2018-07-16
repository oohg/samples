/*
 * Picture Sample # 1
 *
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to get the width and height of
 * an image using an IMAGE control, and how to rotate
 * the loaded image.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL nDegrees := 0

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Picture Control' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'File'
            ITEM 'Select Image' ACTION oPict:Picture := ;
                                       Getfile ( { {'jpg Files','*.jpg'}, ;
                                                   {'gif Files','*.gif'}, ;
                                                   {'ico Files','*.ico'} } , ;
                                                 'Select Image' )
            ITEM 'Clear' ACTION oPict:Picture := ''
            ITEM 'Rotate' ACTION ( nDegrees := if( nDegrees < 270, ;
                                                   nDegrees + 90, 0 ), ;
                                   oPict:Rotate( nDegrees ) )
         END POPUP
      END MENU

      @ 00,00 PICTURE pct_Image ;
         OBJ oPict ;
         IMAGESIZE ;
         ACTION AutoMsgBox( "Height: " + ;
                            AutoType( oPict:nHeight ) + ;
                            " Width: " + ;
                            AutoType( oPict:nWidth ) )

     ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
