/*
 * Browse Sample n° 16
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use DEFAULTVALUES clause to
 * set default values to each field of newly added records.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   PUBLIC oBrowse

   SET CENTURY ON
   SET DATE BRITISH
   SET DELETED ON
   SET BROWSESYNC ON

   OpenTables()

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 820 HEIGHT 480 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE 'Browse with DEFAULTVALUES clause' ;
      MAIN ;
      ON INIT oBrowse:SetFocus() ;
      ON RELEASE CleanUp()

      DEFINE STATUSBAR
        STATUSITEM "OOHG Power - Use Alt-A to append a new record and see what happens"
      END STATUSBAR

      @ oForm:ClientHeight + oForm:Statusbar:ClientHeightUsed - 40, 10 LABEL Label_1 ;
         VALUE "Total:"

      @ oForm:ClientHeight + oForm:Statusbar:ClientHeightUsed - 40, 70 TEXTBOX Text_1 ;
         OBJ oSuma WIDTH 100 NUMERIC READONLY

      @ 10, 10 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight + oForm:Statusbar:ClientHeightUsed - 60 ;
         HEADERS { 'Code', ;
                   'First Name', ;
                   'Last Name', ;
                   'Birth Date', ;
                   'Check', ;
                   'RecNo' } ;
         WIDTHS { 150, ;
                  150, ;
                  150, ;
                  150, ;
                  50, ;
                  80 } ;
         WORKAREA test ;
         FIELDS { 'Code', ;
                  'First', ;
                  'Last', ;
                  'Birth', ;
                  'check', ;
                  'recno()' } ;
         COLUMNCONTROLS { {'TEXTBOX', 'NUMERIC', '9999999999'}, ;
                          Nil, ;
                          Nil, ;
                          Nil, ;
                          {'IMAGELIST'}, ;
                          Nil } ;
         READONLY { .F., .F., .F., .F., .F., .T. } ;
         JUSTIFY { BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_LEFT, ;
                   BROWSE_JTFY_LEFT, ;
                   BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_LEFT, ;
                   BROWSE_JTFY_RIGHT } ;
         IMAGE { 'MINIGUI_EDIT_CANCEL', ;
                 'MINIGUI_EDIT_OK' } ;
         APPEND ;
         ENABLEALTA ;
         EDIT INPLACE ;
         ON EDITCELLEND ProcessEdit() ;
         ON APPEND ProcessAppend() ;
         ON EDITCELL Total() ;
         DEFAULTVALUES { 10, "Empty First", "Empty Last", date(), 1, Nil }

         /*
          * These values are placed into the edit row just before
          * the start of the edition. Note that the new record is
          * added after the end of the edition of the first column.
          */

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION ProcessEdit

   /*
    * ON EDITCELLEND is the first event fired after the end of the edition.
    * It's fired for each edited column.
    * You can access the cell info using this vars:
    * _OOHG_ThisItemRowIndex
    * _OOHG_ThisItemColIndex
    * _OOHG_ThisItemCellRow
    * _OOHG_ThisItemCellCol
    * _OOHG_ThisItemCellWidth
    * _OOHG_ThisItemCellHeight
    * _OOHG_ThisItemCellValue
    * Any change to this vars is ignored.
    */
    AutoMsgBox( "ProcessEdit" )

    IF oBrowse:lAppendMode
       /*
        * For the first editable column: the new record is not yet appended
        * and the record pointer is at the "phantom record".
        * At this point you can do almost whatever you want.
        * Beware not to unlock the data source if the control was defined
        * with LOCK clause.
        * Any change to a cell in the edited row will be discarded.
        * This values are not set into the edition row nor into the record:
        */
       oBrowse:Cell( _OOHG_ThisItemRowIndex, _OOHG_ThisItemColIndex, 99 )
       oBrowse:Cell( _OOHG_ThisItemRowIndex, 3, "xxxxxxxxx" )
    ELSE
       /*
        * For the other editable columns: the new record has been appended
        * and has become the current record. The edited value has not yet
        * been put into it.
        * At this point you can do almost whatever you want, even changing
        * the value of any field of the record.
        * Beware not to unlock the data source if the control was defined
        * with LOCK clause.
        * Beware that any change to the record pointer is not undone.
        * Any change to a cell in the edited row will be discarded.
        */
       IF _OOHG_ThisItemColIndex == 2
          // This value is not set into the edition row nor into the record
          oBrowse:Cell( _OOHG_ThisItemRowIndex, 3, "yyyyyyyyy" )
       ELSEIF _OOHG_ThisItemColIndex == 4
          // This works
          Test->Last := "NEW DATA"
       ENDIF
    ENDIF

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION ProcessAppend

   /*
    * After ON EDITCELLEND for the first editable column has ended, the new
    * record is appended and the just edited value and any other default
    * values are placed into it.
    *
    * After that, ON APPEND is fired.
    *
    * At this point you can place any value into the record.
    */
    AutoMsgBox( "ProcessAppend" )
    Test->Birth := ctod("01/01/1901")

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION Total
   LOCAL nRec, nSum

    AutoMsgBox( "Total" )
   /*
    * ON EDITCELL event is fired after the just edited value is
    * placed into the record. It's fired for each edited column.
    * You can access the cell info using this vars:
    * _OOHG_ThisItemRowIndex
    * _OOHG_ThisItemColIndex
    * _OOHG_ThisItemCellRow
    * _OOHG_ThisItemCellCol
    * _OOHG_ThisItemCellWidth
    * _OOHG_ThisItemCellHeight
    * _OOHG_ThisItemCellValue
    * Any change in this variables is ignored.
    */
   nRec := Test->(RecNo())
   nSum := 0
   Test->( DBEVAL( {|| nSum += Test->Code } ) )
   Test->( dbGoTo( nRec ) )
   oSuma:Value := nSum
RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION CleanUp

   dbCloseAll()
   ERASE test.dbf

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION OpenTables()

   DBCREATE( "Test", { { "Code",    "Numeric",   10, 0 }, ;
                       { "First",   "Character", 25, 0 }, ;
                       { "Last",    "Character", 25, 0 }, ;
                       { "Married", "Logical",    1, 0 }, ;
                       { "Birth",   "Date",       8, 0 }, ;
                       { "Check",   "Numeric",    1, 0 } } )

   USE test

   FOR i := 1 TO 5
      APPEND BLANK
      REPLACE Code    WITH HB_RandomInt(99) * 10000
      REPLACE First   WITH 'First Name '+ STR(i)
      REPLACE Last    WITH 'Last Name '+ STR(i)
      REPLACE Married WITH .t.
      REPLACE Birth   WITH Date() + i - 10000
      REPLACE Check   WITH i % 2
   NEXT i

   GO TOP

RETURN Nil

/*
 * EOF
 */
