/*
 * Image Sample n° 9
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to resize an image using an
 * IMAGE control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL nImg := 1

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      CLIENTAREA ;
      TITLE 'Resize an Image' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'File'
            ITEM 'Select Image' ;
               ACTION Form_1.Image_1.Picture := ;
                      Getfile ( { {'bmp Files','*.bmp'}, ;
                                  {'gif Files','*.gif'}, ;
                                  {'jpg Files','*.jpg, *.jpeg'}, ;
                                  {'ico Files','*.ico'}, ;
                                  {'tiff Files','*.tif, *.tiff'}, ;
                                  {'png Files','*.pif'} } , ;
                                'Select Image' )
            SEPARATOR
            ITEM 'Save Resized to Win Size as JPG 75%' ;
               ACTION ( oImage:Width := oForm:ClientWidth, ;
                        oImage:Height := oForm:ClientHeight, ;
                        oImage:SaveAs( "New_" + LTrim( Str( nImg ) ) + ".jpg", .F., "JPG", 75, 24 ), ;
                        AutoMsgBox( "New_" + LTrim( Str( nImg ) ) + ".jpg saved !!!" ), ;
                        nImg ++ )

            ITEM 'Save Resized to Win Size as JPG 100%' ;
               ACTION ( oImage:Width := oForm:ClientWidth, ;
                        oImage:Height := oForm:ClientHeight, ;
                        oImage:SaveAs( "New_" + LTrim( Str( nImg ) ) + ".jpg", .F., "JPG", 100, 24 ), ;
                        AutoMsgBox( "New_" + LTrim( Str( nImg ) ) + ".jpg saved !!!" ), ;
                        nImg ++ )
            SEPARATOR
            ITEM 'Save Resized to Win Half Size as JPG 75%' ;
               ACTION ( oImage:Width := oForm:ClientWidth / 2, ;
                        oImage:Height := oForm:ClientHeight / 2, ;
                        oImage:SaveAs( "New_" + LTrim( Str( nImg ) ) + ".jpg", .F., "JPG", 75, 24 ), ;
                        AutoMsgBox( "New_" + LTrim( Str( nImg ) ) + ".jpg saved !!!" ), ;
                        nImg ++ )

            ITEM 'Save Resized to Win Half Size as JPG 100%' ;
               ACTION ( oImage:Width := oForm:ClientWidth / 2, ;
                        oImage:Height := oForm:ClientHeight / 2, ;
                        oImage:SaveAs( "New_" + LTrim( Str( nImg ) ) + ".jpg", .F., "JPG", 100, 24 ), ;
                        AutoMsgBox( "New_" + LTrim( Str( nImg ) ) + ".jpg saved !!!" ), ;
                        nImg ++ )
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
