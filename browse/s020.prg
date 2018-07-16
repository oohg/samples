/*
 * Browse Sample n° 20
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set the current cell using
 * different methods.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main

   LOCAL oForm, oBrowse, cArea := "test"

   REQUEST DBFCDX, DBFFPT

   SET CENTURY ON
   SET DELETED ON
   SET BROWSESYNC ON

   OpenTables()

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      CLIENTAREA ;
      WIDTH 500 HEIGHT 380 ;
      MINWIDTH 500 MINHEIGHT 380 ;
      TITLE 'ooHG Browse Demo' ;
      MAIN NOMAXIMIZE ;
      ON RELEASE CleanUp() ;
      ON SIZE ( oBrowse:Width  := oForm:ClientWidth - 40, ;
                oBrowse:Height := oForm:ClientHeight - 40 )

      @ 20,20 BROWSE Browse_1 OBJ oBrowse ;
         WIDTH oForm:ClientWidth - 40 ;
         HEIGHT oForm:ClientHeight - 40 ;
         HEADERS { 'Code', ;
                   'First Name', ;
                   'Last Name', ;
                   'Birth Date', ;
                   'Married', ;
                   'Biography' } ;
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
         WORKAREA (cArea) ;
         FIELDS { 'Code', ;
                  'First', ;
                  'Last', ;
                  'Birth', ;
                  'Married', ;
                  'Bio' } ;
         COLUMNCONTROLS { {'TEXTBOX', "N", "9999999999", NIL, NIL, .F., .F., .T., NIL, .F.}, ;
                          NIL, ;
                          NIL, ;
                          {'DATEPICKER'}, ;
                          {'CHECKBOX'}, ;
                          NIL } ;
         FONT "Courier New" SIZE 10 ;
         JUSTIFY { BROWSE_JTFY_RIGHT, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER, ;
                   BROWSE_JTFY_CENTER} ;
         EDIT ;
         NAVIGATEBYCELL ;
         KEYSLIKECLIPPER ;
         EDITLIKEEXCEL ;
         NOMODALEDIT ;
         FULLMOVE ;
         CHANGEBEFOREEDIT ;
         FIXEDBLOCKS ;
         FIXEDCONTROLS

      DEFINE CONTEXT MENU CONTROL Browse_1
         MENUITEM 'Value' ;
            ACTION {|| AutoMsgBox( oBrowse:Value ) }
         SEPARATOR
         MENUITEM 'Go to row 4 col 2' ;
            ACTION {|| oBrowse:Value := { 4, 2 } }
         SEPARATOR
         MENUITEM 'Left' ;
            ACTION {|| oBrowse:Left() }
         MENUITEM 'Right' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:Right()}
         MENUITEM 'Up' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:Up() }
         MENUITEM 'Down' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:Down()}
         MENUITEM 'Page Up' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:PageUp() }
         MENUITEM 'Page Down' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:PageDown()}
         MENUITEM 'Top' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:GoTop() }
         MENUITEM 'Bottom' ;
            ACTION {|| oBrowse:setfocus(), oBrowse:GoBottom() }
         SEPARATOR
         MENUITEM 'Edit row 2 col 3' ;
            ACTION {|| oBrowse:EditCell( 2, 3 ) }
         MENUITEM 'EditAllCells' ;
            ACTION {|| oBrowse:EditAllCells( 3, 1 ) }
         MENUITEM 'EditGrid' ;
            ACTION {|| oBrowse:EditGrid( 8, 1 ) }
      END MENU

      ON KEY F1     ACTION AutoMsgBox( oBrowse:Value )
      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

//----------------------------------------------------------------------------
FUNCTION OpenTables()

   LOCAL aDbf[6][4]

   aDbf[1][ DBS_NAME ] := "Code"
   aDbf[1][ DBS_TYPE ] := "Numeric"
   aDbf[1][ DBS_LEN ]  := 10
   aDbf[1][ DBS_DEC ]  := 0

   aDbf[2][ DBS_NAME ] := "First"
   aDbf[2][ DBS_TYPE ] := "Character"
   aDbf[2][ DBS_LEN ]  := 25
   aDbf[2][ DBS_DEC ]  := 0

   aDbf[3][ DBS_NAME ] := "Last"
   aDbf[3][ DBS_TYPE ] := "Character"
   aDbf[3][ DBS_LEN ]  := 25
   aDbf[3][ DBS_DEC ]  := 0

   aDbf[4][ DBS_NAME ] := "Married"
   aDbf[4][ DBS_TYPE ] := "Logical"
   aDbf[4][ DBS_LEN ]  := 1
   aDbf[4][ DBS_DEC ]  := 0

   aDbf[5][ DBS_NAME ] := "Birth"
   aDbf[5][ DBS_TYPE ] := "Date"
   aDbf[5][ DBS_LEN ]  := 8
   aDbf[5][ DBS_DEC ]  := 0

   aDbf[6][ DBS_NAME ] := "Bio"
   aDbf[6][ DBS_TYPE ] := "Memo"
   aDbf[6][ DBS_LEN ]  := 10
   aDbf[6][ DBS_DEC ]  := 0

   dbCreate("Test", aDbf, "DBFCDX")

   USE test VIA "DBFCDX"
   ZAP

   FOR i:= 1 TO 100
      APPEND BLANK
      REPLACE code    WITH i * 10000
      REPLACE First   WITH 'First Name '+ Str(i)
      REPLACE Last    WITH 'Last Name '+ Str(i)
      REPLACE Married WITH .t.
      REPLACE birth   WITH Date() + i - 10000
   NEXT i

   INDEX ON code TO code

   GO TOP

RETURN NIL

//----------------------------------------------------------------------------
FUNCTION MyFunction

   AutoMsgBox( This.CellColIndex )

RETURN Nil

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Test.dbf
  ERASE Test.fpt
  ERASE Code.cdx

RETURN NIL

/*
 * EOF
 */
