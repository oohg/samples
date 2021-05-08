/*
 * Grid Sample # 14
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set a Grid that can be edited
 * without a keyboard.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL aRows

   SET DATE BRITISH
   SET CENTURY ON

	aRows := { {01, 'Simpson',   1234.56, ctod('01/01/2000'), ctod('01/01/2000')}, ;
	           {02, 'Mulder',    5897.55, ctod('02/02/2001'), ctod('02/02/2001')}, ;
	           {03, 'Smart',     6972.44, ctod('03/03/2002'), ctod('03/03/2002')}, ;
	           {04, 'Grillo',    4546.44, ctod('04/04/2003'), ctod('04/04/2003')}, ;
	           {05, 'Kirk',      1123.12, ctod('05/05/2004'), ctod('05/05/2004')}, ;
	           {06, 'Barriga',   9877.67, ctod('06/06/2005'), ctod('06/06/2005')}, ;
	           {07, 'Flanders',  5487.32, ctod('07/07/2006'), ctod('07/07/2006')}, ;
	           {08, 'Smith',     5467.65, ctod('08/08/2007'), ctod('08/08/2007')}, ;
	           {09, 'Pedemonti', 2344.65, ctod('09/09/2008'), ctod('09/09/2008')}, ;
	           {10, 'Gomez',     1097.79, ctod('10/10/2009'), ctod('10/10/2009')}, ;
	           {11, 'Fernandez', 7656.99, ctod('11/11/2010'), ctod('11/11/2010')}, ;
	           {12, 'Borges',    9873.44, ctod('12/12/2011'), ctod('12/12/2011')}, ;
	           {13, 'Alvarez',   9854.32, ctod('13/01/2012'), ctod('13/01/2012')}, ;
	           {14, 'Gonzalez',  8321.88, ctod('14/02/2013'), ctod('14/02/2013')}, ;
	           {15, 'Batistuta', 5465.87, ctod('15/03/2014'), ctod('15/03/2014')}, ;
	           {16, 'Vinazzi',   9833.55, ctod('16/04/2015'), ctod('16/04/2015')}, ;
	           {17, 'Pedemonti', 6697.09, ctod('17/05/2016'), ctod('17/05/2016')}, ;
	           {18, 'Samarbide', 1234.81, ctod('18/06/2017'), ctod('18/06/2017')}, ;
	           {19, 'Pradon',    3674.25, ctod('19/07/2018'), ctod('19/07/2018')}, ;
	           {20, 'Reyes',     2546.01, ctod('20/08/2019'), ctod('20/08/2019')} }

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 648 ;
      HEIGHT 408 ;
      TITLE 'Grid without keyboard' ;
      MAIN

/*
   COLUMNCONTROLS format:
     {'TEXTBOX', cType, cPicture, cFunction, nOnFocusPos, lButtons, aImages, lLikeExcel}
     {'MEMO', cTitle, lCleanCRLF, nWidth, nHeight, lSize, lNoHScroll }
     {'DATEPICKER', lUpDown, lShowNone, lButtons, aImages}
     {'COMBOBOX', aItems, aValues, cRetValType, lButtons, aImages}
     {'COMBOBOXTEXT', aItems, lIncremental, lWinSize, lButtons, aImages}
     {'SPINNER', nRangeMin, nRangeMax, lButtons, aImages}
     {'CHECKBOX', cTrue, cFalse, lButtons, aImages}
     {'IMAGELIST', lButtons, aImages}
     {'IMAGEDATA', oData, lButtons, aImages}
     {'LCOMBOBOX', cTrue, cFalse, lButtons, aImages}
*/

      @ 10,10 GRID Grid_1 ;
         WIDTH 620 ;
         HEIGHT 300 ;
         HEADERS {'Col.1', 'Col.2', 'Col.3', 'Col.4', 'Col.5'} ;
         WIDTHS {80, 140, 140, 130, 110} ;
         COLUMNCONTROLS { {'TEXTBOX', 'NUMERIC', , , , .T.}, ;
                          {'TEXTBOX', 'CHARACTER', , , -3, .T.}, ;
                          {'TEXTBOX', 'NUMERIC', '9,999.99', , , .T.}, ;
                          {'DATEPICKER', , , .T.}, ;
                          {'TEXTBOX', 'DATE', , , , .T.} } ;
         ITEMS aRows ;
         EDIT INPLACE

      @ 320,10 LABEL Label_1 ;
         VALUE "See what happens when you edit a cell." ;
         AUTOSIZE

     ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
