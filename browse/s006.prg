/*
 * Browse Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 * and on information shared by
 * Vicente Guerra <vic@guerra.com.mx>
 *
 * This sample shows how to place the last record on the last
 * row of the control and how to use Anchor property to keep
 * the control centered in the form's client area.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main

   LOCAL oForm, Browse_1, cMode

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 500 HEIGHT 380 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE 'Browse: Record Positioning and Anchor Property' ;
      MAIN;
      ON INIT OpenTables( Browse_1 ) ;
      ON RELEASE CleanUp()

      @ 10,10 BROWSE Browse_1 OBJ Browse_1 ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         EDIT INPLACE ;
         HEADERS { 'Code', ;
                   'First Name', ;
                   'Last Name', ;
                   'Birth Date', ;
                   'Married', ;
                   'Biography' } ;
         WIDTHS { 150, 150, 150, 150, 150, 150 } ;
         WORKAREA Test ;
         FIELDS { 'Test->Code', ;
                  'Test->First', ;
                  'Test->Last', ;
                  'Test->Birth', ;
                  'Test->Married', ;
                  'Test->Bio' } ;
         COLUMNCONTROLS { NIL, ;
                   NIL, ;
                   NIL, ;
                   NIL, ;
                   NIL, ;
                   {'MEMO', "Biography", , 600, 600, .T., .T. } } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER }

      cMode := ""
      Browse_1:Anchor := cMode

      /*
       * cMode is composed by the words TOP, LEFT, BOTTOM and RIGHT.
       * The default value is "TOPLEFT".
       * Indicates the side from which the control stays anchored.
       *
       * This means that when the window is resized the distance
       * between the control and the window's border does not change.
       *
       * Setting cMode := "RIGHT" forces the control to keep constant
       * it's distance with the right side.
       *
       * Setting cMode := "LEFTRIGHT" forces the control to keep
       * constant it's distance with the right and the left sides,
       * in fact changing it's size and staying centered in the window.
       *
       * If an orientation is not specified (no TOP nor BOTTOM, or no
       * LEFT nor RIGHT), the control stays unanchored and centered
       * between both sides. If none is specified, the control stays
       * unanchored and centered in the form's client area.
       */

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTables( oBrw )

   LOCAL i

   DBCREATE( "Test", ;
             { { "Code",    "Numeric",   10, 0 }, ;
               { "First",   "Character", 25, 0 }, ;
               { "Last",    "Character", 25, 0 }, ;
               { "Married", "Logical",    1, 0 }, ;
               { "Birth",   "Date",       8, 0 }, ;
               { "Bio",     "Memo",      10, 0 } }, ;
             "DBFCDX" )

   USE test VIA "DBFCDX"
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code    WITH i * 10000
      REPLACE First   WITH 'First Name '+ STR( i )
      REPLACE Last    WITH 'Last Name '+ STR( i )
      REPLACE Married WITH .t.
      REPLACE Birth   WITH DATE() + i - 10000
   NEXT i

   INDEX ON code TO code

   GO BOTTOM

   /*
    * Force the browse to show the last record in the last row.
    * By default the last record is shown in the middle row.
    *
    * The first parameter of this function indicates de record
    * to select. The second indicates the row where that record
    * must be shown.
    */

	oBrw:SetValue( RECNO(), oBrw:CountPerPage )

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Test.dbf
  ERASE Test.fpt
  ERASE Code.cdx

RETURN NIL

/*
 * EOF
 */
