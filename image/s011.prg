/*
 * Image Sample # 11
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use method SAVE of an IMAGE
 * control to save its content to a file.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ oWin ;
      AT 200,200 ;
      WIDTH 640 ;
      HEIGHT ( 480 + GETMENUBARHEIGHT() + GETHSCROLLBARHEIGHT() ) ;
      CLIENTAREA ;
      TITLE 'Image Control' ;
      MAIN

      DEFINE MAIN MENU OBJ oMenu
         POPUP 'File'
            ITEM 'Select Image' ACTION Form_1.Image_1.Picture := ;
                                       Getfile ( { {'jpg Files','*.jpg'}, ;
                                                   {'gif Files','*.gif'}, ;
                                                   {'ico Files','*.ico'} } , ;
                                                 'Select Image' )
            ITEM 'Clear' ACTION Form_1.Image_1.Picture := ''
            ITEM "Hide" ACTION oImage:Hide
            ITEM "Show" ACTION oImage:Show
            SEPARATOR
            ITEM "Save BMP Current Size"  ACTION ( ferase("img1.bmp"), oIMage:Save( "img1.bmp", "BMP" ) )
            ITEM "Save BMP Current Size"  ACTION ( ferase("img2.bmp"), oIMage:Save( "img2.bmp", "BMP", 0 ) )
            ITEM "Save BMP 50%"           ACTION ( ferase("img3.bmp"), oIMage:Save( "img3.bmp", "BMP", 0.5 ) )
            ITEM "Save BMP 200%"          ACTION ( ferase("img4.bmp"), oIMage:Save( "img4.bmp", "BMP", 2 ) )
            ITEM "Save BMP {W 120, H 60}" ACTION ( ferase("img5.bmp"), oIMage:Save( "img5.bmp", "BMP", {120, 60} ) )
            SEPARATOR
            ITEM "Save JPG Current Size Quality 100" ACTION ( ferase("img1.jpg"), oIMage:Save( "img1.jpg", "JPG" ) )
            ITEM "Save JPG Current Size Quality 90"  ACTION ( ferase("img2.jpg"), oIMage:Save( "img2.jpg", "JPG", 0, 90 ) )
            ITEM "Save JPG 50% 80"                   ACTION ( ferase("img3.jpg"), oIMage:Save( "img3.jpg", "JPG", 0.5, 80 ) )
            ITEM "Save JPG 200% 85"                  ACTION ( ferase("img4.jpg"), oIMage:Save( "img4.jpg", "JPG", 2, 85 ) )
            ITEM "Save JPG {W 120, H 60} 100"        ACTION ( ferase("img5.jpg"), oIMage:Save( "img5.jpg", "JPG", {120, 60}, 100 ) )
            SEPARATOR
            ITEM "Save GIF Current Size"  ACTION ( ferase("img1.gif"), oIMage:Save( "img1.gif", "GIF" ) )
            ITEM "Save GIF Current Size"  ACTION ( ferase("img2.gif"), oIMage:Save( "img2.gif", "GIF", 0 ) )
            ITEM "Save GIF 50%"           ACTION ( ferase("img3.gif"), oIMage:Save( "img3.gif", "GIF", 0.5 ) )
            ITEM "Save GIF 200%"          ACTION ( ferase("img4.gif"), oIMage:Save( "img4.gif", "GIF", 2 ) )
            ITEM "Save GIF {W 120, H 60}" ACTION ( ferase("img5.gif"), oIMage:Save( "img5.gif", "GIF", {120, 60} ) )
            SEPARATOR
            ITEM "Save PNG Current Size"  ACTION ( ferase("img1.png"), oIMage:Save( "img1.png", "PNG" ) )
            ITEM "Save PNG Current Size"  ACTION ( ferase("img2.png"), oIMage:Save( "img2.png", "PNG", 0 ) )
            ITEM "Save PNG 50%"           ACTION ( ferase("img3.png"), oIMage:Save( "img3.png", "PNG", 0.5 ) )
            ITEM "Save PNG 200%"          ACTION ( ferase("img4.png"), oIMage:Save( "img4.png", "PNG", 2 ) )
            ITEM "Save PNG {W 120, H 60}" ACTION ( ferase("img5.png"), oIMage:Save( "img5.png", "PNG", {120, 60} ) )
            SEPARATOR
            ITEM "Save TIF Current Size Quality 1 32bpp"    ACTION ( ferase("img1.tif"), oIMage:Save( "img1.tif", "TIF" ) )
            ITEM "Save TIF Current Size Quality 0.9 24 bpp" ACTION ( ferase("img2.tif"), oIMage:Save( "img2.tif", "TIF", 0, 0.9, 24 ) )
            ITEM "Save TIF 50% Quality 0.8 8bpp"            ACTION ( ferase("img3.tif"), oIMage:Save( "img3.tif", "TIF", 0.5, 0.8, 8 ) )
            ITEM "Save TIF 200% Quality 0.85 4bpp"          ACTION ( ferase("img4.tif"), oIMage:Save( "img4.tif", "TIF", 2, 0.85, 4 ) )
            ITEM "Save TIF {W 120, H 60} Quality 1 1bpp"    ACTION ( ferase("img5.tif"), oIMage:Save( "img5.tif", "TIF", {120, 60}, 1, 1 ) )
         END POPUP
      END MENU

      DEFINE TAB tab_1 OBJ oTab AT 10, 10 WIDTH 620 HEIGHT 460
         DEFINE PAGE "Save"

            @ 60,40 IMAGE Image_1 ;
               OBJ oImage ;
               IMAGESIZE ;
               ACTION AutoMsgBox( "Height: " + ;
                                  AutoType( oImage:nHeight ) + ;
                                  " Width: " + ;
                                  AutoType( oImage:nWidth ) )
         END PAGE
      END TAB

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
