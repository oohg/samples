/*
 * XBrowse Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to simulate a multiselect xbrowse.
 * Note that ::Value always returns the last doubleclicked item.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"
REQUEST DBFCDX

FUNCTION Main()

   PUBLIC oForm, oXbrowse, nPos, aRecords := {}

   SET DATE BRITISH
   SET LANGUAGE TO SPANISH

   OpenTable()

   DEFINE WINDOW frm_1 OBJ oForm ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 ;
      HEIGHT 420 ;
      TITLE 'oohg - XBrowse with MultiSelect features' ;
      MAIN ;
      ON RELEASE CleanUp()

      @ 10, 10 XBROWSE xbr_1 OBJ oXbrowse ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Col.1', 'Col.2', 'Col.3' } ;
         WIDTHS { 50, 150, 150 } ;
         WORKAREA Data ;
         FIELDS { 'code', 'number', 'issued' } ;
         COLUMNCONTROLS { {"TEXTBOX", "NUMERIC", "999,999"}, {"TEXTBOX", "NUMERIC", "999,999"}, {"TEXTBOX", "DATE"} } ;
         ON DBLCLICK OnDblClick() ;
         UPDATECOLORS ;
         DYNAMICBACKCOLOR { {|| iif( AScan( aRecords, Data->number ) == 0, WHITE, ORANGE ) }, ;
                            {|| iif( AScan( aRecords, Data->number ) == 0, WHITE, ORANGE ) }, ;
                            {|| iif( AScan( aRecords, Data->number ) == 0, WHITE, ORANGE ) } } ;
         DISABLED

      @ 300, 10 LABEL lbl_Note ;
         WIDTH 240 ;
         HEIGHT 100 ;
         VALUE "Use DblClick to select lines." ;
         FONTCOLOR RED

      @ 300, 260 BUTTON btn_1 OBJ oButton ;
         CAPTION "Enable" ;
         ACTION ( oXbrowse:Enabled := ! oXbrowse:Enabled, oButton:Caption := iif( oXbrowse:Enabled, "Disable", "Enable" ) )

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION OnDblClick

   LOCAL nNumber := oXbrowse:Item( _OOHG_ThisItemRowIndex )[ 2 ]

   nPos := AScan( aRecords, nNumber )
   IF nPos == 0
      AAdd( aRecords, nNumber )
   ELSE
      _OOHG_DeleteArrayItem( aRecords, nPos )
   ENDIF
   oXbrowse:RefreshRow( _OOHG_ThisItemRowIndex )

   RETURN NIL

/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION OpenTable()

   LOCAL aStruc[ 3, 4 ]

   aStruc[ 1, DBS_NAME ] := "code"
   aStruc[ 1, DBS_TYPE ] := "Numeric"
   aStruc[ 1, DBS_LEN ]  := 6
   aStruc[ 1, DBS_DEC ]  := 0

   aStruc[ 2, DBS_NAME ] := "number"
   aStruc[ 2, DBS_TYPE ] := "Numeric"
   aStruc[ 2, DBS_LEN ]  := 6
   aStruc[ 2, DBS_DEC ]  := 0

   aStruc[ 3, DBS_NAME ] := "issued"
   aStruc[ 3, DBS_TYPE ] := "Date"
   aStruc[ 3, DBS_LEN ]  := 8
   aStruc[ 3, DBS_DEC ]  := 0

   dbCreate( "Data", aStruc, "DBFCDX" )
   USE Data VIA "DBFCDX"
   INDEX ON number TO Date

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE code   WITH hb_RandomInt( 1000 )
      REPLACE number WITH RecNo()
      REPLACE issued WITH ( CToD( "09/12/1967" ) + code )
   NEXT i

   GO TOP

RETURN NIL

/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Data.dbf
  ERASE Date.cdx

RETURN NIL

/*
 * EOF
 */
