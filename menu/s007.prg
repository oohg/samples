/*
 * Menu Sample n° 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change menu images.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the images and the .rc file from
 * https://github.com/oohg/samples/tree/master/menu
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE 'ooHG Demo - Menu Test' ;
      MAIN

      DEFINE MAIN MENU
         POPUP 'Demo'
            ITEM '2 Images' OBJ oPru1 CHECKED ;
               ACTION {|| MsgInfo('Image should change to ' + if(oPru1:checked, 'I_EXIT', 'I_CHECK')), oPru1:checked := ! oPru1:checked } ;
               IMAGE { 'I_EXIT', 'I_CHECK' }
            SEPARATOR
            ITEM 'Big image stretched' ;
               ACTION MsgInfo( 'Intl_No.ico from RC' ) ;
               IMAGE 'INTL_NO' STRETCH
            ITEM 'White is transparent' ;
               ACTION MsgInfo( 'Info1.ico from RC' ) ;
               IMAGE 'I_INFO1' STRETCH
            SEPARATOR
            ITEM 'Stretch on/off' obj oPru2 ;
               ACTION {|| MsgInfo( 'Stretch demo.' ), oPru2:stretch := ! oPru2:stretch } ;
               IMAGE 'Intl_No.ico'
            SEPARATOR
            ITEM 'Use button to change images' OBJ oPru3 ;
               ACTION {|| oPru3:checked := ! oPru3:checked } ;
               IMAGE { 'I_EXIT', 'I_CHECK' } STRETCH
         END POPUP

         POPUP 'More'
            ITEM 'Check.bmp from RC' ;
               ACTION MsgInfo( 'Check.bmp from RC' ) ;
               IMAGE 'B_CHECK'
            ITEM 'Albaran.bmp from RC' ;
               ACTION MsgInfo( 'Albaran.bmp from RC' ) ;
               IMAGE 'B_ALBAR' STRETCH
            ITEM 'Check.bmp from FILE' ;
               ACTION MsgInfo( 'Check.bmp from FILE' ) ;
               IMAGE 'Check.bmp'
            ITEM 'Albaran.bmp from FILE' ;
               ACTION MsgInfo( 'Albaran.bmp from FILE' ) ;
               IMAGE 'albaran.bmp' STRETCH
            SEPARATOR
            ITEM 'ooHg.jpg from RC' ACTION MsgInfo( 'ooHg.jpg from RC' ) IMAGE 'J_OOHG' STRETCH
            ITEM 'ooHg.gif from RC' ACTION MsgInfo( 'ooHg.gif from RC' ) IMAGE 'G_OOHG' STRETCH
            ITEM 'ooHg.jpg from FILE' ACTION MsgInfo( 'ooHg.jpg from FILE' ) IMAGE 'ooHg.jpg' STRETCH
            ITEM 'ooHg.gif from FILE' ACTION MsgInfo( 'ooHg.gif from FILE' ) IMAGE 'ooHg.gif' STRETCH
         END POPUP
      END MENU

      @ 80, 120 BUTTON But1 WIDTH 250 CAPTION "Change Images in Demo last submenu" ;
         ACTION {|| oPru3:Picture := iif( oPru3:Picture[ 1 ] == 'I_EXIT', { 'I_GLOBE', 'I_INFO2' }, { 'I_EXIT', 'I_CHECK' } ), MsgInfo( "Changed!" ) }

      ON KEY ESCAPE OF Form_1 ACTION Form_1.Release

   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
