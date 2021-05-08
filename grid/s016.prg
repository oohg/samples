/*
 * Grid Sample # 16
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to auto-number Grid lines on append.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL oForm, oGrid

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 320 ;
      TITLE 'Auto-number Grid lines on append' ;
      MAIN

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 84 ;
         HEADERS { 'LINE','CODE','NAME','VALUE' } ;
         READONLY { .T. , .F. , .F. , .F. } ;
         WIDTHS { 65, 115, 300,100 } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '9999' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '@E 99,999,999.99'} } ;
         ITEMS {} ;
         APPEND ;
         ON APPEND OnAppendItem( oGrid ) ;
         DELETE ;
         EDIT INPLACE

      oGrid:Cargo := 0

      @ oForm:ClientHeight - 44, oForm:ClientWidth - 120 BUTTON Button_1 ;
         CAPTION 'Append Item' ;
         WIDTH 100 ;
         HEIGHT 24 ;
         ACTION AddNewItem( oGrid )

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION OnAppendItem( oGrid )

   WITH OBJECT oGrid
      IF :Cell( :Value, 1 ) == 0
         :Cell( :Value, 1, ++ :Cargo )
      ENDIF
   END WITH

RETURN NIL

FUNCTION AddNewItem( oGrid )

   WITH OBJECT oGrid
      :SetFocus()
      :AppendItem()
   END WITH

RETURN NIL

/*
 * EOF
 */
