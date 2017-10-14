/*
 * Ejemplo Menu n° 4
 * Autor: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenciado bajo The Code Project Open License (CPOL) 1.02
 * Vea <http://www.codeproject.com/info/cpol10.aspx>
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Abrir Menu" ;
      MAIN ;
      ON INIT INSERTAR_ALT_F()

      DEFINE MAIN MENU OF Win_1
         POPUP "&File"
            ITEM "Uno" ACTION MsgInfo( "Opción Uno del Menú" )
            ITEM "Dos" ACTION MsgInfo( "Opción Dos del Menú" )
            SEPARATOR
            ITEM "Salir" ACTION Win_1.Release
         END POPUP
      END MENU

      /*
      El truco consiste en definir una tecla aceleradora para
      el menú, utilizando un & delante de la correspondiente
      letra (en este caso F), y simulando que el usuario ha
      oprimido Alt+F con la funciín INSERTAR_ALT_F().
      */

      @ 100, 10 LABEL Lbl_1 ;
         VALUE "Al inicio del programa el menú debe estar abierto." ;
         AUTOSIZE

      ON KEY ESCAPE ACTION Win_1.Release
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN NIL

#pragma BEGINDUMP

#include "hbapi.h"
#include <windows.h>

#ifndef VK_F
   #define VK_F 70
#endif

HB_FUNC( INSERTAR_ALT_F )
{
   keybd_event(VK_MENU, 0, 0, 0 ) ;
   keybd_event(VK_F, 0, 0, 0 ) ;
   keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0 );
}

#pragma ENDDUMP

/*
 * EOF
 */
