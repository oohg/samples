/*
 * Combobox Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to load items and images using
 * data from a database (ITEMSOURCE, ITEMIMAGENUMBER and
 * IMAGESOURCE clauses), and how to change the images
 * after control creation.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 *
 * You can download all the images from
 * https://github.com/fyurisich/OOHG_Samples/tree/master/English/Samples/ComboBox
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main()

   LOCAL oCmb_1

   CreateDatabase()

   DEFINE WINDOW Form1 ;
      AT 0,0 ;
      WIDTH 428 ;
      HEIGHT 300 ;
      TITLE "ooHG - COMBOBOX with Images" ;
      MAIN

      @ 20,20 COMBOBOX cmb_1 ;
         OBJ oCmb_1 ;
         HEIGHT 200 ;
         WIDTH 185 ;
         ITEMSOURCE "test->item" ;
         ITEMIMAGENUMBER {|| test->(RECNO()) - 1} ;
         IMAGESOURCE {|| test->image} ;
         FIT ;
         TEXTHEIGHT 40 ;
         VALUE 1

      @ 20,300 BUTTON btn_1 ;
         CAPTION "Change Images" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         ACTION {|| oCmb_1:ImageSource := {|| test->image2}, ;
                    oCmb_1:Refresh() }

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form1
   ACTIVATE WINDOW Form1

   CLOSE DATABASES
   ERASE Test.dbf

RETURN NIL

FUNCTION CreateDatabase()

   LOCAL aDbf[3][4]

   aDbf[1][ DBS_NAME ] := "Item"
   aDbf[1][ DBS_TYPE ] := "Character"
   aDbf[1][ DBS_LEN ]  := 20
   aDbf[1][ DBS_DEC ]  := 0

   aDbf[2][ DBS_NAME ] := "Image"
   aDbf[2][ DBS_TYPE ] := "Character"
   aDbf[2][ DBS_LEN ]  := 12
   aDbf[2][ DBS_DEC ]  := 0

   aDbf[3][ DBS_NAME ] := "Image2"
   aDbf[3][ DBS_TYPE ] := "Character"
   aDbf[3][ DBS_LEN ]  := 12
   aDbf[3][ DBS_DEC ]  := 0

   REQUEST DBFCDX

   DBCREATE("Test", aDbf, "DBFCDX")

   USE test Via "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE Item   WITH "Item 1"
   REPLACE Image  WITH "globe.png"
   REPLACE Image2 WITH "albaran.png"

   APPEND BLANK
   REPLACE Item   WITH "Item 2"
   REPLACE Image  WITH "albaran.png"
   REPLACE Image2 WITH "info.png"

   APPEND BLANK
   REPLACE Item   WITH "Item 3"
   REPLACE Image  WITH "info.png"
   REPLACE Image2 WITH "globe.png"

RETURN NIL

/*
 * EOF
 */
