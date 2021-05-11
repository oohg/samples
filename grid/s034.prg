/*
 * Grid Sample # 34
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to toggle the checkboxes of a Grid
 * control using the spacebar.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
   
FUNCTION Main
   
   LOCAL aItems := { { "Simpson", "Homer",  "555-5555", .T. }, ;
                     { "Mulder",  "Fox",    "324-6432", .T. }, ;
                     { "Smart",   "Max",    "432-5892", .F. }, ;
                     { "Grillo",  "Pepe",   "894-2332", .F. }, ;
                     { "Kirk",    "James",  "346-9873", .T. }, ;
                     { "Barriga", "Carlos", "394-9654", .T. } }

   PUBLIC oGrid
   
   DEFINE WINDOW Win_1 ;
      AT 0, 0 ;
      WIDTH 450 ;
      HEIGHT 500 ;
      TITLE "GRID Multiselect - Toggle checkboxes using the spacebar" ;
      MAIN
      
      @ 10, 10 GRID Grid_2 OBJ oGrid ;
      WIDTH 350 ;
      HEIGHT 330 ;
      HEADERS { "Last Name", "First Name", "Phone", "Id" } ;
      WIDTHS { 100, 90, 80, 40 } ;
      ITEMS aItems ;
      CHECKBOXES ;
      MULTISELECT ;
      ON CHECKCHANGE { |nItem| CheckSelected( nItem ) }

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END  WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1
   
RETURN

FUNCTION CheckSelected( nItem )

   LOCAL aItems, i
   STATIC lWorking := .F.

   IF ! lWorking
      lWorking := .T.

      IF oGrid:CheckItem( nItem )
         // An item was checked

         // See if nItem is selected
         aItems := oGrid:Value
         IF aScan( aItems, nItem ) > 0
            // Check all selected items
            aItems := oGrid:Value
            FOR i := 1 to Len( aItems )
               oGrid:CheckItem( aItems[ i ], .T. )
            NEXT i
         ENDIF
      ELSE
         // An item was unchecked

         // See if nItem is selected
         aItems := oGrid:Value
         IF aScan( aItems, nItem ) > 0
            // Uncheck all selected items
            aItems := oGrid:Value
            FOR i := 1 to Len( aItems )
               oGrid:CheckItem( aItems[ i ], .F. )
            NEXT i
         ENDIF
      ENDIF

      lWorking := .F.
   ENDIF

RETURN NIL

/*
 * EOF
 */
