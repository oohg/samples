/*
 * Browse Sample # 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to browse an Access database using ADORDD.
 *
 * Note that you must use use Build.bat in order to compile.
 */

#include "oohg.ch"
#include "adordd.ch"
#require "rddado"

FUNCTION Main

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   SET( _SET_DATEFORMAT, "yyyy-mm-dd" )

   DBCREATE( "test2.mdb;table1", ;
             { { "FIRST", "C", 10, 0 }, ;
             { "LAST",    "C", 10, 0 }, ;
             { "AGE",     "N",  8, 0 }, ;
             { "MYDATE",  "D",  8, 0 } }, ;
             "ADORDD" )

   USE test2.mdb VIA "ADORDD" TABLE "table1"

   APPEND BLANK
   test2->First   := "Homer"
   test2->Last    := "Simpson"
   test2->Age     := 45
   test2->MyDate  := Date()

   APPEND BLANK
   test2->First   := "Lara"
   test2->Last    := "Croft"
   test2->Age     := 32
   test2->MyDate  := Date() + 2

   GO TOP

   DEFINE WINDOW Form_1 OBJ oForm ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Access Database via ADORDD' ;
      MAIN ;
      ON RELEASE CleanUp()

      DEFINE STATUSBAR
        STATUSITEM "OOHG Power !!!"
      END STATUSBAR

      @ 20, 20 XBROWSE xBrowse_1 ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 40 ;
         VALUE 1

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

PROCEDURE CleanUp

   IF ! MsgYesNo( "Save mdb file?" )
      CLOSE DATABASES
      ERASE test2.mdb
   ENDIF

RETURN

/*
 * EOF
 */
