/*
 * Browse Sample n° 17
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how prevent the edition of a record.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Browse: prevent record edition' ;
      MAIN ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables()

      @ 10,10 BROWSE Browse_1 ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 20 ;
         EDIT INPLACE ;
         HEADERS { "Col1", "Col2"} ;
         WIDTHS { 100, 150 } ;
         WORKAREA Test ;
         FIELDS { "Code", "Name"} ;
         WHEN { {|| Test->Code % 3 == 0 }, {|| Test->Code % 3 == 0 } }

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL


FUNCTION OpenTables()

   LOCAL i

   DBCREATE( "Test", ;
             { {"Code", "N", 10, 0}, ;
               {"Name", "C", 25, 0} } )

   USE Test NEW
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code WITH i
      IF i % 3 == 0
         REPLACE Name WITH 'Edition allowed !!!'
      ELSE
         REPLACE Name WITH 'Edition not allowed.'
      ENDIF
   NEXT i

   GO TOP

RETURN NIL


FUNCTION CloseTables()

  CLOSE DATABASES

  ERASE Test.dbf

RETURN NIL

/*
 * EOF
 */
