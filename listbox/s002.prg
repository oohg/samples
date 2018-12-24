/*
 * Listbox Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display images in a listbox.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download the images used in this sample from:
 * https://github.com/oohg/samples/tree/master/ListBox
 */

#include "oohg.ch"

FUNCTION Main

   SET AUTOADJUST ON

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 480 ;
      HEIGHT 680 ;
      TITLE 'Listbox with Images' ;
      MAIN

      /*
      Each item can be:
      a) a string.
      b) a two-item array with a string at position 1 and a reference to
         an image at position two. The image will be displayed left to the
         string all the time.
      c) a three-item array with a string at position 1 and two references
         to images at position 2 and 3. The images are displayed left to the
         string. The one at position 2 when the item has the focus and the
         other when it hasn't.

      Notes:
      - Items can be of mixed types: some a), some b) and some c) at the same time.
      - Images are numbered from zero.
      - TEXTHEIGHT sets the height of the items.
      - The height can't be changed after control's creations.
      - When TEXTHEIGHT is omited, a default value is computed from the control's font.
      - Images are not clipped unless FIT is added.
      - Images are painted vertically centered if there's enough room.
      - Images are clipped at the right and bottom sides.
      */

      @ 10,10 LISTBOX List_1 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 2 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} ;
         HEIGHT 200 ;
         WIDTH 200

      @ 10,250 LISTBOX List_2 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 2 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} ;
         HEIGHT 200 ;
         WIDTH 200

      @ 220,10 LISTBOX List_3 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 2 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} ;
         HEIGHT 200 ;
         WIDTH 200 ;
         TEXTHEIGHT 30

      @ 220,250 LISTBOX List_4 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 2 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} ;
         HEIGHT 200 ;
         WIDTH 200 ;
         TEXTHEIGHT 80

      @ 430,10 LISTBOX List_5 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 3 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} FIT ;
         HEIGHT 200 ;
         WIDTH 200 ;
         TEXTHEIGHT 30

      @ 430,250 LISTBOX List_6 ;
         ITEMS { {'Chat', 0}, {'Edit', 1}, {'Help', 2}, {'Move', 3}, {'Sound', 4} } ;
         VALUE 3 ;
         IMAGE {"chat.bmp", "edit.bmp", "help.bmp", "move.bmp", "sound.bmp"} FIT ;
         HEIGHT 200 ;
         WIDTH 200 ;
         TEXTHEIGHT 80

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
