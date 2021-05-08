/*
 * Grid Sample # 18
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the font of the grid's headers.
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
      TITLE 'Change Header Font' ;
      MAIN ;
      ON INIT ( oGrid:SetFocus(), oGrid:AppendItem() )

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 84 ;
         HEADERS { 'LINE','CODE','NAME','VALUE' } ;
         ITEMS {} ;
         WIDTHS { 65, 115, 300,100 } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'NUMERIC', '9999' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', '@E 99,999,999.99'} } ;
         APPEND ;
         DELETE ;
         EDIT INPLACE ;
         FULLMOVE ;
         NAVIGATEBYCELL

/*
      HeaderSetFont( cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeout, nFontAngle, nCharSet, nFontWidth, nOrientation, lAdvanced )
*/
      oGrid:HeaderSetFont( "VERDANA", 14, .T., .T. )

      @ oForm:ClientHeight - 44, oForm:ClientWidth - 120 BUTTON Button_1 ;
         CAPTION "Edit One Cell" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         ACTION ( oGrid:SetFocus(), oGrid:EditCell() )

      ON KEY ESCAPE ACTION oForm:Release()
      ON KEY F2 ACTION oGrid:EditCell()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

/*
 * EOF
 */
