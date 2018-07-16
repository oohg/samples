/*
 * Browse Sample n° 7
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change dynamically the workarea
 * and other data of a browse.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm, oBrw, myDbf := "Test1"

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Browse: dynamically change properties' ;
      MAIN ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables()

      @ 13, 10 LABEL Lbl_1 ;
         WIDTH 60 ;
         HEIGHT 24 ;
         VALUE "Use dbf:"

      @ 10, 70 RADIOGROUP Rdg_1 OBJ oDbf ;
         OPTIONS { "Test1", "Test2", "Test3" } ;
         WIDTH 80 ;
         HORIZONTAL ;
         VALUE 1 ;
         ON CHANGE ChangeDbf( oDbf, oBrw, oForm )

      @ 40,10 BROWSE Browse_1 OBJ oBrw ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 60 ;
         SYNCHRONIZED ;
         HEADERS { "Article Code", "Article Name"} ;
         WIDTHS { 100, 150 } ;
         WORKAREA (myDbf) ;
         FIELDS { "Code1", "Name1"} ;
         JUSTIFY { BROWSE_JTFY_RIGHT, BROWSE_JTFY_LEFT } ;
         UPDATEALL ;
         DYNAMICBLOCKS

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL


FUNCTION OpenTables()

   LOCAL i

   DBCREATE( "Test3", ;
             { {"Code3", "N", 10, 0}, ;
               {"Name3", "C", 25, 0}, ;
               {"Data3", "D",  8, 0} } )

   USE Test3 NEW
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code3 WITH i * 2 + 1
      REPLACE Name3 WITH 'Client '+ STR( i )
      REPLACE Data3 WITH DATE()
   NEXT i

   GO TOP

   DBCREATE( "Test2", ;
             { {"Code2", "N", 10, 0}, ;
               {"Name2", "C", 25, 0} } )

   USE Test2 NEW
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code2 WITH i * 2
      REPLACE Name2 WITH 'Supplier '+ STR( i )
   NEXT i

   GO TOP

   DBCREATE( "Test1", ;
             { {"Code1", "N", 10, 0}, ;
               {"Name1", "C", 25, 0} } )

   USE Test1 NEW
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code1 WITH i
      REPLACE Name1 WITH 'Article '+ STR( i )
   NEXT i

   GO TOP

RETURN NIL


FUNCTION CloseTables()

  CLOSE DATABASES

  IF MsgYesNo( "Erase tables ?", "" )
     ERASE Test1.dbf
     ERASE Test2.dbf
     ERASE Test3.dbf
  ENDIF

RETURN NIL


FUNCTION ChangeDbf( oDbf, oBrw, oForm )

   LOCAL aDbfData := ;
         { { "Test1", ;
           { "Article Code", "Article Name"}, ;
           { "Code1", "Name1" }, ;
           { 100, 150 }, ;
           { BROWSE_JTFY_RIGHT, BROWSE_JTFY_LEFT } }, ;
           { "Test2", ;
           { "Supplier Code", "Supplier Name" }, ;
           { "Code2", "Name2" }, ;
           { 120, 170 }, ;
           { BROWSE_JTFY_CENTER, BROWSE_JTFY_RIGHT } }, ;
           { "Test3", ;
           { "Client Code", "Client Name", "Last Contact" }, ;
           { "Code3", "Name3", "Data3" }, ;
           { 120, 170, 90 }, ;
           { BROWSE_JTFY_CENTER, BROWSE_JTFY_RIGHT, BROWSE_JTFY_CENTER } } }

   Do While oBrw:ColumnCount() < LEN( aDbfData[ oDbf:Value ] [ 3 ] )
      // The second parameter must not be NIL
      oBrw:AddColumn( NIL, "" )
   EndDo
   Do While oBrw:ColumnCount() > LEN( aDbfData[ oDbf:Value ] [ 3 ] )
      oBrw:DeleteColumn()
   EndDo

   oBrw:WorkArea := aDbfData[ oDbf:Value ] [ 1 ]
   oBrw:aHeaders := aDbfData[ oDbf:Value ] [ 2 ]
   oBrw:aFields  := aDbfData[ oDbf:Value ] [ 3 ]
   oBrw:aWidths  := aDbfData[ oDbf:Value ] [ 4 ]
   oBrw:aJust    := aDbfData[ oDbf:Value ] [ 5 ]

   oBrw:Value := 1
   oBrw:Refresh()

RETURN NIL

/*
 * EOF
 */
