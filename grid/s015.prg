/*
 * Grid Sample # 15
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a Grid that behaves like
 * Excel when editing a cell. When you press a cursor key
 * while characters are being entered in a cell, the string
 * is stored and the cursor is moved to the corresponding
 * cell (EDITLIKEEXCEL clause). The same happens when the
 * mouse is clicked outside the edit window (NOMODALEDIT
 * clause). Instead of enabling this behaviour for the
 * whole grid, you can enable it control by control.
 * Also notice the different behaviour of method EditGrid
 * and method EditCell. To enter full edit mode press F2
 * (like in Excel).
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL aRows, oForm, oGrid

   SET DATE BRITISH
   SET CENTURY ON

	aRows := { {01, 'Simpson',   1234.56, ctod('01/01/2000')}, ;
	           {02, 'Mulder',    5897.55, ctod('02/02/2001')}, ;
	           {03, 'Smart',     6972.44, ctod('03/03/2002')}, ;
	           {04, 'Grillo',    4546.44, ctod('04/04/2003')}, ;
	           {05, 'Kirk',      1123.12, ctod('05/05/2004')}, ;
	           {06, 'Barriga',   9877.67, ctod('06/06/2005')}, ;
	           {07, 'Flanders',  5487.32, ctod('07/07/2006')}, ;
	           {08, 'Smith',     5467.65, ctod('08/08/2007')}, ;
	           {09, 'Pedemonti', 2344.65, ctod('09/09/2008')}, ;
	           {10, 'Gomez',     1097.79, ctod('10/10/2009')}, ;
	           {11, 'Fernandez', 7656.99, ctod('11/11/2010')}, ;
	           {12, 'Borges',    9873.44, ctod('12/12/2011')}, ;
	           {13, 'Alvarez',   9854.32, ctod('13/01/2012')}, ;
	           {14, 'Gonzalez',  8321.88, ctod('14/02/2013')}, ;
	           {15, 'Batistuta', 5465.87, ctod('15/03/2014')}, ;
	           {16, 'Vinazzi',   9833.55, ctod('16/04/2015')}, ;
	           {17, 'Pedemonti', 6697.09, ctod('17/05/2016')}, ;
	           {18, 'Samarbide', 1234.81, ctod('18/06/2017')}, ;
	           {19, 'Pradon',    3674.25, ctod('19/07/2018')}, ;
	           {20, 'Reyes',     2546.01, ctod('20/08/2019')} }

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 420 ;
      TITLE 'Grid behaves like Excel' ;
      MAIN

/*
   COLUMNCONTROLS format:
     {'TEXTBOX', cType, cPicture, cFunction, nOnFocusPos, lButtons, aImages, lLikeExcel, cEditKey, lNoModal}
     {'MEMO', cTitle, lCleanCRLF, nWidth, nHeight, lSize, lNoHScroll }
     {'DATEPICKER', lUpDown, lShowNone, lButtons, aImages, lNoModal}
     {'COMBOBOX', aItems, aValues, cRetValType, lButtons, aImages, lNoModal}
     {'COMBOBOXTEXT', aItems, lIncremental, lWinSize, lButtons, aImages, lNoModal}
     {'SPINNER', nRangeMin, nRangeMax, lButtons, aImages, lNoModal}
     {'CHECKBOX', cTrue, cFalse, lButtons, aImages, lNoModal}
     {'IMAGELIST', lButtons, aImages, lNoModal}
     {'IMAGEDATA', oData, lButtons, aImages, lNoModal}
     {'LCOMBOBOX', cTrue, cFalse, lButtons, aImages, lNoModal}
*/

      @ 20, 20 GRID Grid_1 OBJ oGrid ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 130 ;
         HEADERS {'Col.1', 'Col.2', 'Col.3', 'Col.4'} ;
         WIDTHS {80, 140, 140, 130} ;
         COLUMNCONTROLS { {'TEXTBOX', 'NUMERIC'}, ;
                          {'TEXTBOX', 'CHARACTER'}, ;
                          {'TEXTBOX', 'NUMERIC', '9,999.99'}, ;
                          {'TEXTBOX', 'DATE'} } ;
         ITEMS aRows ;
         APPEND ;
         DELETE ;
         EDIT INPLACE ;
         FULLMOVE ;
         NAVIGATEBYCELL ;
         EDITLIKEEXCEL ;
         NOMODALEDIT

      @ oForm:ClientHeight - 90, 20 LABEL Label_1 ;
         VALUE "See what happens when you are editing a cell and a " + ;
               "cursor key is pressed or when you click the mouse " + ;
               "outside the edit window. Edition can be started with " + ;
               "Enter, DblClick, F2 and the buttons.";
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT 30

      @ oForm:ClientHeight - 44, oForm:ClientWidth - 120 BUTTON Button_1 ;
         CAPTION "Edit One Cell" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         ACTION ( oGrid:SetFocus(), oGrid:EditCell() )

      @ oForm:ClientHeight - 44, oForm:ClientWidth - 230 BUTTON Button_2 ;
         CAPTION "Edit Grid" ;
         WIDTH 100 ;
         HEIGHT 24 ;
         ACTION ( oGrid:SetFocus(), oGrid:EditGrid() )

      ON KEY ESCAPE ACTION oForm:Release()
      ON KEY F2 ACTION oGrid:EditCell()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

/*
 * EOF
 */
