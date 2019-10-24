/*
 * Browse Sample # 23
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an in-memory database
 * with a BROWSE control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

REQUEST HB_MEMIO
REQUEST DBFCDX

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE "OOHG - MemIO Demo" ;
      MAIN ;
      ON INIT OpenTable() ;
      ON RELEASE CloseTable()

      @ 10,10 BROWSE Browse_1 ;
         WIDTH 610   ;
         HEIGHT 390  ;
         HEADERS { 'Code' , 'Name' , 'Count' } ;
         WIDTHS { 100 , 100 , 100 } ;
         WORKAREA memarea ;
         FIELDS { 'code' , 'name' , 'count' } ;
         JUSTIFY { BROWSE_JTFY_RIGHT, BROWSE_JTFY_LEFT, BROWSE_JTFY_RIGHT } ;
         EDIT ;
         INPLACE

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL


FUNCTION OpenTable

   DBCREATE( "mem:test", ;
             { {"code", "C", 4, 0}, ;
               {"name", "C", 20, 0}, ;
               {"count", "N", 10, 0} }, ;
             "DBFCDX", ;
             .T., ;
             "memarea" )

   dbAppend()
   REPLACE code WITH 'ABCD', name WITH 'Simba', count WITH 150
   dbAppend()
   REPLACE code WITH 'WXYZ', name WITH 'Sarabi', count WITH 458
   dbAppend()
   REPLACE code WITH 'UYTT', name WITH 'Nala', count WITH 235
   dbAppend()
   REPLACE code WITH 'XXYY', name WITH 'Zazú', count WITH 455
   dbAppend()
   REPLACE code WITH 'YYLA', name WITH 'Rafiki', count WITH 218
   dbAppend()
   REPLACE code WITH 'LYTZ', name WITH 'Pumba', count WITH 855
   dbAppend()
   REPLACE code WITH 'LHRE', name WITH 'Mufasa', count WITH 684
   dbAppend()
   REPLACE code WITH 'POIU', name WITH 'Timón', count WITH 871

   INDEX ON count TAG count

   GO TOP

   RETURN NIL


FUNCTION CloseTable

   dbCloseArea()

   dbDrop( "mem:test" )

   RETURN NIL

/*
 * EOF
 */
