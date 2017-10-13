/*
 * Browse Sample n° 15
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set default values for newly
 * added records and how to show computed, read only cells
 * while the row's edition is ongoing.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main

   LOCAL oForm, oBrowse

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 500 HEIGHT 380 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE "Browse: new record's default values" ;
      MAIN;
      ON INIT OpenTables( oBrowse ) ;
      ON RELEASE CleanUp()

      @ 05,10 LABEL Label_1 OBJ oLbl ;
         VALUE "Use Alt-A to add a record and see what happens" ;
         AUTOSIZE

      @ 30,10 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 40 ;
         ONHEADCLICK { { || ordSetFocus( "recno" ), oBrowse:Refresh() }, ;
                       { || ordSetFocus( "code" ), oBrowse:Refresh() }, ;
                       NIL, ;
                       NIL, ;
                       NIL, ;
                       NIL, ;
                       NIL } ;
         EDIT INPLACE ;
         APPEND ;
         DELETE ;
         HEADERS { 'RecNo', ;
                   'Code', ;
                   'First Name', ;
                   'Last Name', ;
                   'Birth Date', ;
                   'Married', ;
                   'Biography' } ;
         WIDTHS { 60, 150, 150, 150, 150, 150, 150 } ;
         WORKAREA Test ;
         FIELDS { { || Test->(RECNO()) }, ;
                  'Test->Code', ;
                  'Test->First', ;
                  'Test->Last', ;
                  'Test->Birth', ;
                  'Test->Married', ;
                  'Test->Bio' } ;
         COLUMNCONTROLS { NIL, ;
                          {'COMBOBOX',{'1','2','3'},{1,2,3},"NUMERIC"}, ;
                          NIL, ;
                          NIL, ;
                          NIL, ;
                          NIL, ;
                          {'MEMO', "Biography", , 600, 600, .T., .T. } } ;
         READONLY { { || FillRecNo( oBrowse ) }, ;
                    .F., ;
                    .F., ;
                    .F., ;
                    .F., ;
                    .F., ;
                    .F. } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER }

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION FillRecNo( oBrw )

   // Set the underlying grid's cell with the not yet added record number
   // This works because the DBF is at EOF while Alt-A is being processed.
   oBrw:Cell( oBrw:ItemCount, 1, Test->(RECNO()) )

   // Force the immediate repaint of the edition row.
   oBrw:RefreshRow( oBrw:ItemCount )

   // Do not edit cell
RETURN .T.

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
      REPLACE Code    WITH ( i % 3 ) + 1
      REPLACE First   WITH 'First Name '+ STR( i )
      REPLACE Last    WITH 'Last Name '+ STR( i )
      REPLACE Married WITH .t.
      REPLACE Birth   WITH DATE() + i - 10000
   NEXT i

   INDEX ON code TAG code TO code
   INDEX ON RECNO() TAG recno TO code

   GO BOTTOM
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
