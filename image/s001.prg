/*
 * Image Sample # 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to get the width and height of
 * an image using an IMAGE control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Image Control' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'File'
            ITEM 'Select Image' ACTION Form_1.Image_1.Picture := ;
                                       Getfile ( { {'jpg Files','*.jpg'}, ;
                                                   {'gif Files','*.gif'}, ;
                                                   {'ico Files','*.ico'} } , ;
                                                 'Select Image' )
            ITEM 'Clear' ACTION Form_1.Image_1.Picture := ''
         END POPUP
      END MENU

      @ 00,00 IMAGE Image_1 ;
         OBJ oImage ;
         IMAGESIZE ;
         ACTION AutoMsgBox( "Height: " + ;
                            AutoType( oImage:nHeight ) + ;
                            " Width: " + ;
                            AutoType( oImage:nWidth ) )

     ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
