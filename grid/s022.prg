/*
 * Grid Sample # 22
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to use the automatic search by column
 * content feature in Grid with NAVIGATEBYCELL clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL aRows[ 20, 3 ]

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 500 ;
      HEIGHT 420 ;
      TITLE 'Automatic Search By Column Content in Grid Navigated by Cell' ;
      MAIN

      aRows[ 01 ] := {'Simpson',   'Homer',     '555-5555'}
      aRows[ 02 ] := {'Mulder',    'Fox',       '324-6432'}
      aRows[ 03 ] := {'Smart',     'Max',       '432-5892'}
      aRows[ 04 ] := {'Grillo',    'Pepe',      '894-2332'}
      aRows[ 05 ] := {'Kirk',      'James',     '346-9873'}
      aRows[ 06 ] := {'Barriga',   'Carlos',    '394-9654'}
      aRows[ 07 ] := {'Flanders',  'Ned',       '435-3211'}
      aRows[ 08 ] := {'Smith',     'John',      '123-1234'}
      aRows[ 09 ] := {'Pedemonti', 'Flavio',    '000-0000'}
      aRows[ 10 ] := {'Gomez',     'Juan',      '583-4832'}
      aRows[ 11 ] := {'Fernandez', 'Raul',      '321-4332'}
      aRows[ 12 ] := {'Borges',    'Javier',    '326-9430'}
      aRows[ 13 ] := {'Alvarez',   'Alberto',   '543-7898'}
      aRows[ 14 ] := {'Gonzalez',  'Ambo',      '437-8473'}
      aRows[ 15 ] := {'Batistuta', 'Gol',       '485-2843'}
      aRows[ 16 ] := {'Vinazzi',   'Amigo',     '394-5983'}
      aRows[ 17 ] := {'Pedemonti', 'Flavio',    '534-7984'}
      aRows[ 18 ] := {'Samarbide', 'Armando',   '854-7873'}
      aRows[ 19 ] := {'Pradon',    'Alejandra', '???-????'}
      aRows[ 20 ] := {'Reyes',     'Monica',    '432-5836'}


      @ 10, 10 GRID Grid_2 OBJ ogrid ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT 230 ;
         HEADERS {'Last Name', 'First Name', 'Phone'} ;
         WIDTHS {130, 130, 130} ;
         ITEMS aRows ;
         VALUE { 1, 1 } ;
         NAVIGATEBYCELL

      @ 270, 10 LABEL Lbl_1 OBJ oLbl1 ;
         AUTOSIZE ;
         VALUE "Search by Col " + ;
               LTRIM( STR( oGrid:SearchCol ) ) + ;
               " - Wrap " + ;
               IF( oGrid:SearchWrap, "ON", "OFF" )

      @ 300, 10 BUTTON But_1 ;
         CAPTION "Search by Col 1" ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchCol := 1, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      @ 300, 150 BUTTON But_2 ;
         CAPTION "Search by Col 2" ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchCol := 2, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      @ 300, 290 BUTTON But_3 OBJ oBut3 ;
         CAPTION "Wrap " + IF( oGrid:SearchWrap, "OFF", "ON" ) ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchWrap := ! oGrid:SearchWrap, ;
                      oBut3:Caption := "Wrap " + ;
                                       IF( oGrid:SearchWrap, "OFF", "ON" ), ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      @ 340, 10 BUTTON But_4 ;
         CAPTION "Use Grid Default" ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchCol := 0, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      @ 340, 150 BUTTON But_5 ;
         CAPTION "Disable Search" ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchCol := oGrid:ColumnCount + 1, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      @ 340, 290 BUTTON But_6 ;
         CAPTION "Search Current" ;
         WIDTH 120 ;
         ACTION {|| ( oGrid:SearchCol := -1, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oGrid:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oGrid:SearchWrap, "ON", "OFF" ), ;
                      oGrid:SetFocus() ) }

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
