/*
 * Form Sample n° 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to programatically scroll the
 * controls of an internal form.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main()

   DEFINE WINDOW frm_1 ;
      OBJ oForm ;
      TITLE "oohg - Scroll internal form" ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      BACKCOLOR TEAL

      DEFINE WINDOW int_1 ;
         OBJ oInt ;
         AT 10, 10 ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         INTERNAL ;
         VIRTUAL HEIGHT 1600 ;
         BACKCOLOR WHITE

         @ 20, 20 LABEL lbl_1 ;
             VALUE "This is a label" ;
             AUTOSIZE

         @ 20, 400 BUTTON btn_1 ;
            CAPTION "Scroll to row 800" ;
            WIDTH 120 ;
            ACTION oInt:Events_VScroll( MakeWParam( SB_THUMBPOSITION, 800 ) )

         @ 800, 20 LABEL lbl_2 ;
             VALUE "This is another label" ;
             AUTOSIZE

         @ 800, 400 BUTTON btn_2 ;
            CAPTION "Scroll to bottom" ;
            WIDTH 120 ;
            ACTION oInt:Events_VScroll( MakeWParam( SB_BOTTOM ) )

         @ 1500, 20 LABEL lbl_3 ;
             VALUE "And also is this" ;
             AUTOSIZE

         @ 1500, 400 BUTTON btn_3 ;
            CAPTION "Scroll to top" ;
            WIDTH 120 ;
            ACTION oInt:Events_VScroll( MakeWParam( SB_TOP ) )

      END WINDOW

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW frm_1
   ACTIVATE WINDOW frm_1

RETURN NIL

/*
 * EOF
 */
