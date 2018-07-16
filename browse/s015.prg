/*
 * Browse Sample n° 15
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set default values for newly
 * added records and how to show computed, read only cells
 * while the row's edition is ongoing. It also shows how
 * to use _OOHG_InitTGridControlDatas to alter the default
 * behaviour of TGridControlTextBox editcontrols.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main

   LOCAL oForm, oBrowse

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   /*
    * This changes the default behaviour of TGridControlTextBox
    * editcontrols from -2 to -3
    */
   _OOHG_InitTGridControlDatas := { |oCtrl| oCtrl:nOnFocusPos := -3 }

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
         FIELDS { { || Test->(RecNo()) }, ;
                  'Test->Code', ;
                  'Test->First', ;
                  'Test->Last', ;
                  'Test->Birth', ;
                  'Test->Married', ;
                  'Test->Bio' } ;
         COLUMNCONTROLS { NIL, ;
                          {'COMBOBOX', {'1','2','3'}, {1,2,3}, "NUMERIC"}, ;
                          {'TEXTBOX',  'CHARACTER', Replicate("X", 25), , -2}, ;
                          {'TEXTBOX',  'CHARACTER', Replicate("X", 25)}, ;                 // default to -2
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

   dbCreate( "Test", ;
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
      REPLACE First   WITH PadR( 'First Name '+ STR( i ), 25 )
      REPLACE Last    WITH 'Last Name '+ STR( i )
      REPLACE Married WITH .t.
      REPLACE Birth   WITH DATE() + i - 10000
   NEXT i

   INDEX ON code TAG code TO code
   INDEX ON RecNo() TAG recno TO code

   GO BOTTOM
	oBrw:SetValue( RecNo(), oBrw:CountPerPage )

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
