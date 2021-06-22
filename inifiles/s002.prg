/*
 * INI Files Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to read / write comments to
 * the first and last lines of an INI file.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   IF ! FILE( "file.ini" )
      hb_MemoWrit( "file.ini", ;
                   "#Last update at " + DToC( Date() ) + " " + Time() + CRLF + ;
                   CRLF + ;
                   "[Location]" + CRLF + ;
                   "Country=Uruguay" + CRLF + ;
                   "City=Montevideo" + CRLF + ;
                   "Address=Carlos Gardel s/n" + CRLF + ;
                   CRLF + ;
                   "[Paths]" + CRLF + ;
                   "Path1=C:\" + CRLF + ;
                   "Path2=C:\DESARROLLO\" + CRLF + ;
                   "Path3=C:\DESARROLLO\oohg\" + CRLF + ;
                   CRLF + ;
                   "#eof" + CRLF )
   ENDIF

   DEFINE WINDOW Form1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 620 ;
      HEIGHT 320 ;
      MAIN ;
      TITLE "How to handle INI files with OOHG" ;
      ON RELEASE iif( MsgYesNo( "Erase file.ini?" ), FErase( "file.ini" ), NIL )

      @ 015, 030 LABEL 0 VALUE 'Country' AUTOSIZE TRANSPARENT
      @ 010, 200 TEXTBOX txt_Country WIDTH 390 VALUE ''

      @ 045, 030 LABEL 0 VALUE 'City' AUTOSIZE TRANSPARENT
      @ 040, 200 TEXTBOX txt_City WIDTH 390 VALUE ''

      @ 075, 030 LABEL 0 VALUE 'Address' AUTOSIZE TRANSPARENT
      @ 070, 200 TEXTBOX txt_Address WIDTH 390 VALUE ''

      @ 105, 030 LABEL lbl_Path1 VALUE 'Path 1' AUTOSIZE TRANSPARENT
      @ 100, 200 TEXTBOX txt_Path1 WIDTH 390 VALUE ''

      @ 135, 030 LABEL lbl_Path2 VALUE 'Path 2' AUTOSIZE TRANSPARENT
      @ 130, 200 TEXTBOX txt_Path2 WIDTH 390 VALUE ''

      @ 165, 030 LABEL lbl_Path3 VALUE 'Path 3' AUTOSIZE TRANSPARENT
      @ 160, 200 TEXTBOX txt_Path3 WIDTH 390 VALUE ''

      @ 195, 030 LABEL lbl_BC VALUE 'Begin Comment' AUTOSIZE TRANSPARENT
      @ 190, 200 TEXTBOX txt_BC WIDTH 390 VALUE ''

      @ 225, 030 LABEL lbl_EC VALUE 'End Comment' AUTOSIZE TRANSPARENT
      @ 220, 200 TEXTBOX txt_EC WIDTH 390 VALUE ''

      @ 270, 030 BUTTON btn_Load CAPTION 'Load' WIDTH 90 HEIGHT 25 ACTION Load()
      @ 270, 265 BUTTON btn_Save CAPTION 'Save' WIDTH 90 HEIGHT 25 ACTION Save()
      @ 270, 500 BUTTON btn_Exit CAPTION 'Exit' WIDTH 90 HEIGHT 25 ACTION Form1.Release

      ON KEY ESCAPE ACTION Form1.Release
   END WINDOW

   CENTER WINDOW Form1
   ACTIVATE WINDOW Form1

   RETURN NIL

STATIC FUNCTION Load()

   BEGIN INI FILE "file.ini"
      GET BEGIN COMMENT TO Form1.txt_BC.Value
      GET Form1.txt_Country.Value SECTION "Location" ENTRY "Country" DEFAULT Form1.txt_Country.Value
      GET Form1.txt_City.Value    SECTION "Location" ENTRY "City"    DEFAULT Form1.txt_City.Value
      GET Form1.txt_Address.Value SECTION "Location" ENTRY "Address" DEFAULT Form1.txt_Address.Value
      GET Form1.txt_Path1.Value   SECTION "Paths"    ENTRY "Path1"   DEFAULT Form1.txt_Path1.Value
      GET Form1.txt_Path2.Value   SECTION "Paths"    ENTRY "Path2"   DEFAULT Form1.txt_Path2.Value
      GET Form1.txt_Path3.Value   SECTION "Paths"    ENTRY "Path3"   DEFAULT Form1.txt_Path3.Value
      GET END COMMENT TO Form1.txt_EC.Value
   END INI

   RETURN NIL

STATIC FUNCTION Save()

   BEGIN INI FILE "file.ini"
      IF Empty( Form1.txt_BC.Value )
         SET BEGIN COMMENT TO "#Last update at " + DToC( Date() ) + " " + Time()
      ELSE
         SET BEGIN COMMENT TO Form1.txt_BC.Value
      ENDIF
      SET SECTION "Location" ENTRY "Country" TO Form1.txt_Country.Value
      SET SECTION "Location" ENTRY "City"    TO Form1.txt_City.Value
      SET SECTION "Location" ENTRY "Address" TO Form1.txt_Address.Value
      SET SECTION "Paths"    ENTRY "Path1"   TO Form1.txt_Path1.Value
      SET SECTION "Paths"    ENTRY "Path2"   TO Form1.txt_Path2.Value
      SET SECTION "Paths"    ENTRY "Path3"   TO Form1.txt_Path3.Value
      IF Empty( Form1.txt_EC.Value )
         SET END COMMENT TO "#eof"
      ELSE
         SET END COMMENT TO Form1.txt_EC.Value
      ENDIF
   END INI

   RETURN NIL

/*
 * EOF
 */
