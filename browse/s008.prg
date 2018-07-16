/*
 * Browse Sample n° 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to handle unknown fields.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm, ;
         oBrw, ;
         myDbf := "Test1", ;
         myFields := { "Code1", "Name1"}

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Browse: handle unknown fields' ;
      MAIN ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables()

      @ 10,10 BROWSE Browse_1 OBJ oBrw ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         SYNCHRONIZED ;
         EDIT INPLACE ;
         HEADERS { "Col1", "Col2"} ;
         WIDTHS { 100, 150 } ;
         WORKAREA (myDbf) ;
         FIELDS myFields ;
         VALID { {|| &( "memvar" + myDbf + myFields[1] ) > 0 }, {|| ! empty( &( "memvar" + myDbf + myFields[2]) ) } }

    /* When the valid is executed, the class creates a variable called
     * MemVarBaseField, where Base is the alias of the workarea and the Field
     * is the name of the just edited field. f.e.: MemVarTest1Code1
     */

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL


FUNCTION OpenTables()

   LOCAL i

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

  IF MsgYesNo( "Erase table ?", "" )
     ERASE Test1.dbf
  ENDIF

RETURN NIL

/*
 * EOF
 */
