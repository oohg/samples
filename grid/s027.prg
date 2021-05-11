/*
 * Grid Sample # 27
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the row's backcolor
 * when its checkbox is toggled.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
   
#define bColor { |nCol,nItem,aItem| iif( _OOHG_ThisControl:CheckItem( nItem ), RED, iif( nItem % 2 == 0, WHITE, AQUA ) ) }

FUNCTION Main
   
   LOCAL aItems := { { "Simpson", "Homer",  "555-5555", .T. }, ;
                     { "Mulder",  "Fox",    "324-6432", .T. }, ;
                     { "Smart",   "Max",    "432-5892", .F. }, ;
                     { "Grillo",  "Pepe",   "894-2332", .F. }, ;
                     { "Kirk",    "James",  "346-9873", .T. }, ;
                     { "Barriga", "Carlos", "394-9654", .T. } }

   PUBLIC oGrid
   
   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 450 ;
      HEIGHT 500 ;
      TITLE "GRID - Row Backcolor and Checkboxes" ;
      MAIN
      
      @ 10,10 GRID Grid_2 OBJ oGrid ;
      WIDTH 350 ;
      HEIGHT 330 ;
      HEADERS { "Last Name", "First Name", "Phone", "Id" } ;
      WIDTHS { 100, 90, 80, 40 } ;
      ITEMS aItems ;
      VALUE 1 ;
      CHECKBOXES ;
      DYNAMICBACKCOLOR { bColor, bColor, bColor, bColor } ;
      ON CHECKCHANGE { |nItem| oGrid:SetItemColor( nItem, ;
                                                   NIL, ;
                                                   iif( oGrid:CheckItem( nItem ), ;
                                                        {RED, RED, RED, RED}, ;
                                                        iif( nItem % 2 == 0, ;
                                                             {WHITE, WHITE, WHITE, WHITE}, ;
                                                             {AQUA, AQUA, AQUA, AQUA} ) ) ) }
      
      ON KEY ESCAPE ACTION ThisWindow.Release()
   END  WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1
   
RETURN

/*
 * EOF
 */
