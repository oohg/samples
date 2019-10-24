/*
 * Browse Sample # 24
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to enable and disable
 * a BROWSE control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

REQUEST DBFCDX, DBFFPT

FUNCTION Main()

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   OpenTables()

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      TITLE 'OOHG - Browse Demo' ;
      WIDTH 640 ;
      HEIGHT 480 ;
      NOMAXIMIZE ;
      MAIN ;
      ON RELEASE CloseTables()

      DEFINE MAIN MENU
         POPUP 'File'
            ITEM 'Set Browse Value' ACTION Form_1.Browse_1.Value := Val( InputBox( 'Set Browse Value', '' ) )
            ITEM 'Get Browse Value' ACTION MsgInfo( Str( Form_1.Browse_1.Value ) )
            ITEM 'Refresh Browse'   ACTION Form_1.Browse_1.Refresh
            SEPARATOR
            ITEM 'Exit'             ACTION Form_1.Release
         END POPUP
         POPUP 'Help'
            ITEM 'About'            ACTION MsgInfo( oohgVersion() + " " + hb_compiler() )
         END POPUP
      END MENU

      DEFINE STATUSBAR
         STATUSITEM ''
      END STATUSBAR

      @ 10, 10 BUTTON 0 OBJ oBut CAPTION "Enable" ;
         ACTION ( oBrw:Enabled := ! oBrw:Enabled, oBut:Caption := iif( oBrw:Enabled, "Disable", "Enable" ) )

      @ 10, 120 BUTTON 0 CAPTION "Status" ;
         ACTION AutoMsgBox( { "Browse enabled", oBrw:Enabled, "Scrollbar enabled", IsWindowEnabled( oBrw:VScroll:hWnd ) } )

      @ 40, 10 BROWSE Browse_1 OBJ oBrw ;
         WIDTH 610 ;
         HEIGHT 360 ;
         HEADERS { 'Code', 'First Name', 'Last Name', 'Birth Date', 'Married', 'Biography' } ;
         WIDTHS { 150, 150, 150, 150, 150, 150 } ;
         WORKAREA Test ;
         FIELDS { 'Code', 'First', 'Last', 'Birth', 'Married', 'Bio' } ;
         TOOLTIP 'Browse Test' ;
         ON CHANGE ChangeTest() ;
         JUSTIFY { BROWSE_JTFY_LEFT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER } ;
         DELETE ;
         LOCK ;
         VALUE RecNo() ;
         EDIT INPLACE ;
         DISABLED

         ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   RETURN NIL

FUNCTION ChangeTest()

   Form_1.StatusBar.Item( 1 ) := 'RecNo() ' + AllTrim( Str( RecNo() ) )

   RETURN NIL

FUNCTION OpenTables()

   LOCAL aDbf[6, 4]

   aDbf[1, DBS_NAME ] := "Code"
   aDbf[1, DBS_TYPE ] := "Numeric"
   aDbf[1, DBS_LEN ]  := 10
   aDbf[1, DBS_DEC ]  := 0

   aDbf[2, DBS_NAME ] := "First"
   aDbf[2, DBS_TYPE ] := "Character"
   aDbf[2, DBS_LEN ]  := 25
   aDbf[2, DBS_DEC ]  := 0

   aDbf[3, DBS_NAME ] := "Last"
   aDbf[3, DBS_TYPE ] := "Character"
   aDbf[3, DBS_LEN ]  := 25
   aDbf[3, DBS_DEC ]  := 0

   aDbf[4, DBS_NAME ] := "Married"
   aDbf[4, DBS_TYPE ] := "Logical"
   aDbf[4, DBS_LEN ]  := 1
   aDbf[4, DBS_DEC ]  := 0

   aDbf[5, DBS_NAME ] := "Birth"
   aDbf[5, DBS_TYPE ] := "Date"
   aDbf[5, DBS_LEN ]  := 8
   aDbf[5, DBS_DEC ]  := 0

   aDbf[6, DBS_NAME ] := "Bio"
   aDbf[6, DBS_TYPE ] := "Memo"
   aDbf[6, DBS_LEN ]  := 10
   aDbf[6, DBS_DEC ]  := 0

   dbCreate("Test", aDbf, "DBFCDX")

   USE Test VIA "DBFCDX"

   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code    WITH i
      REPLACE First   WITH 'First Name '+ Str( i )
      REPLACE Last    WITH 'Last Name '+ Str( i )
      REPLACE Married WITH .T.
      REPLACE Birth   WITH Date() + i- 10000
   NEXT i

   INDEX ON Code TO Code

   GO TOP

   RETURN NIL

FUNCTION CloseTables()

   USE
   ERASE Test.dbf
   ERASE Test.fpt
   ERASE Code.cdx

   RETURN NIL

/*
 * EOF
 */
