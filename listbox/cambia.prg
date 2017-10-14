#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 400 ;
      HEIGHT 400 ;
      TITLE 'Listbox' ;
      MAIN

      @ 03, 03 BUTTON but_1 ;
         CAPTION "Change Image" ;
         ACTION ChangeImg()

      @ 43, 03 LISTBOX LB_1 OBJ oLB_1 ;
         ITEMS { { 'Exit', 0, 1 }, { 'Two', 0, 1 } } ;
         IMAGE { "Exit.bmp", "Exit2.bmp", "Info.bmp" } ;
         FONT "VERDANA" ;
         SIZE 10 ;
         TEXTHEIGHT 75 ;
         HEIGHT oForm:Height - 90 ;
         WIDTH oForm:Width - 22 ;
         BOLD

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN


PROCEDURE ChangeImg

   STATIC nIndex := 0

   IF nIndex == 0
      nIndex := 2
      oLB_1:Item( 1, { "Help", 2, 1 } )

      /*
      Alternative:

      oLB_1:DeleteItem( 1 )
      oLB_1:InsertItem( 1, { "Help", 2, 1 } )
      */
   ELSE
      nIndex := 0
      oLB_1:Item( 1, { "Exit", 0, 1 } )

      /*
      Alternative:

      oLB_1:DeleteItem( 1 )
      oLB_1:InsertItem( 1, { "Exit", 0, 1 } )
      */
   ENDIF

RETURN

/*
 * EOF
 */
