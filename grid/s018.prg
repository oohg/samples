/*
 * Grid Sample n° 18
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the font of the headers.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
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
      HeaderSetFont( cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeout, lFontAngle, lFontwidth )
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
