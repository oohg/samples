/*
 * Dialog Sample # 1
 * Author: Unknown, freshen up by
 * Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to reverse the default order in
 * which forms are released (first the parent later the
 * its children).
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 400 ;
      HEIGHT 400 ;
      TITLE 'OOHG - Common Dialogs Demo' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP 'File'
            MENUITEM 'Test 1' ACTION Test1()
            MENUITEM 'Test 2' ACTION Test2()
         END POPUP
      END MENU

   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN NIL


PROCEDURE Test1()

   // GetFile( aFilter, cTitle, cIniFolder, lMultiselect, lNochangedir, cDefaultFileName, lHidereadonly )

   MsgInfo( Getfile( { {'All Files', '*.*'} }, 'Open File', 'c:\', .F. , .T. ), "File" )

RETURN


PROCEDURE Test2()

   LOCAL x, i, c := ""

   x := Getfile( { {'All Files', '*.*'} }, 'Open Files', 'c:\', .T., .T. )

   FOR i := 1 TO Len( x )
      c += ( x[i] + CRLF )
   NEXT x

   MsgInfo( c, "Files" )

RETURN

/*
 * EOF
 */
