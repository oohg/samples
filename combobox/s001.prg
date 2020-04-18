/*
 * Combobox Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to load items and images using
 * data from a database (ITEMSOURCE, ITEMIMAGENUMBER and
 * IMAGESOURCE clauses), how to change the images after
 * control's creation and how to get the value of a given
 * item.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download all the images from
 * https://github.com/oohg/samples/tree/master/combobox
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main()

   LOCAL oCmb_1

   CreateDatabase()

   DEFINE WINDOW Form1 ;
      AT 0, 0 ;
      WIDTH 428 ;
      HEIGHT 300 ;
      TITLE "ooHG - COMBOBOX with Images" ;
      MAIN ;
      ON RELEASE CloseTables()

      @ 20,20 COMBOBOX cmb_1 ;
         OBJ oCmb_1 ;
         HEIGHT 200 ;
         WIDTH 185 ;
         ITEMSOURCE "s001->item" ;
         ITEMIMAGENUMBER { || s001->( RecNo() ) - 1 } ;
         IMAGESOURCE { || s001->image} ;
         FIT ;
         VALUE 1 ;
         TEXTHEIGHT 40     // Use EDITHEIGHT 40 to set the edit part only and/or OPTIONSHEIGHT 40 to set the list part only

      @ 20,300 BUTTON btn_1 ;
         CAPTION "Change Images" ;
         WIDTH 100 ;
         HEIGHT 28 ;
         ACTION {|| oCmb_1:ImageSource := { || s001->image2 }, ;
                    oCmb_1:Refresh() }

      @ 70,260 BUTTON btn_2 ;
         CAPTION "Get Item 2 position" ;
         WIDTH 140 ;
         HEIGHT 28 ;
         ACTION AutoMsgBox( oCmb_1:ItemValue( PadR( "Item 2", Len( s001->item ) ) ) )        // Exact match

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW Form1
   ACTIVATE WINDOW Form1

RETURN NIL

FUNCTION CreateDatabase()

   LOCAL aDbf[3,4]

   aDbf[1, DBS_NAME ] := "Item"
   aDbf[1, DBS_TYPE ] := "Character"
   aDbf[1, DBS_LEN ]  := 20
   aDbf[1, DBS_DEC ]  := 0

   aDbf[2, DBS_NAME ] := "Image"
   aDbf[2, DBS_TYPE ] := "Character"
   aDbf[2, DBS_LEN ]  := 12
   aDbf[2, DBS_DEC ]  := 0

   aDbf[3, DBS_NAME ] := "Image2"
   aDbf[3, DBS_TYPE ] := "Character"
   aDbf[3, DBS_LEN ]  := 12
   aDbf[3, DBS_DEC ]  := 0

   REQUEST DBFCDX

   dbCreate("s001", aDbf, "DBFCDX")

   USE s001 Via "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE Item   WITH "Item 21"
   REPLACE Image  WITH "globe.bmp"
   REPLACE Image2 WITH "albaran.bmp"

   APPEND BLANK
   REPLACE Item   WITH "Item 2"
   REPLACE Image  WITH "albaran.bmp"
   REPLACE Image2 WITH "info.bmp"

   APPEND BLANK
   REPLACE Item   WITH "Item 3"
   REPLACE Image  WITH "info.bmp"
   REPLACE Image2 WITH "globe.bmp"

RETURN NIL

FUNCTION CloseTables()

   CLOSE DATABASES
   ERASE ( "s001" + IndexExt() )
   ERASE s001.dbf

RETURN NIL

/*
 * EOF
 */
