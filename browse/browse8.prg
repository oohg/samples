/*
 * OOHG - Harbour Win32 GUI library Demo
 */

/*
 * Value property selects a record by its number (RecNo()).
 * Value property returns selected record number (recNo()).
 * Browse control does not change the active work area.
 * Browse control does not change the record pointer in any area (nor change
 * selection when it changes) when SET BROWSESYNC is OFF (the default).
 * You can programatically refresh it using refresh method.
 * Variables called <MemVar>.<WorkAreaName>.<FieldName> are created for
 * validation in browse editing window. You can use it in VALID array.
 * Using APPEND clause you can add records to table associated with WORKAREA
 * clause. The hotkey to add records is Alt+A.
 * Append clause can't be used with fields not belonging to browse work area.
 * DELETE clause allows to mark selected record for deletion pressing <Del> key.
 * Deletion only takes place if DELETEWHEN clause is omited or if the block
 * evaluates to .T. for the record. If the block evaluates to .F., deletion
 * does not take place and DELETEMSG message is displayed.
 * ON DELETE block is executed after de record is deleted but before is unlocked
 * or record pointer moved.
 * Enjoy !
 */

#include "oohg.ch"
#include "Dbstruct.ch"

Function Main
   LOCAL var

   REQUEST DBFCDX , DBFFPT

   var := 'Test'

   SET CENTURY ON
   SET DELETED ON

   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'ooHG Browse Demo' ;
      MAIN NOMAXIMIZE ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables()

      DEFINE MAIN MENU
         POPUP 'File'
            ITEM 'Set Browse Value'   ACTION Form_1.Browse_1.Value := Val ( InputBox ('Set Browse Value','') )
            ITEM 'Get Browse Value'   ACTION MsgInfo ( Str ( Form_1.Browse_1.Value ) )
            ITEM 'Refresh Browse'   ACTION Form_1.Browse_1.Refresh
            SEPARATOR
            ITEM 'Exit'      ACTION Form_1.Release
         END POPUP
         POPUP 'Help'
                                ITEM 'About'            ACTION MsgInfo (oohgversion()+" "+hb_compiler())
         END POPUP
      END MENU

      DEFINE STATUSBAR
         STATUSITEM ''
      END STATUSBAR


      @ 10,10 BROWSE Browse_1 ;
         WIDTH 610 ;
         HEIGHT 390 ;
         HEADERS { 'Code' , 'First Name' , 'Last Name', 'Birth Date', 'Married' , 'Biography' } ;
         HEADERIMAGES {'MINIGUI_EDIT_EDIT', 'MINIGUI_EDIT_DELETE', 'MINIGUI_EDIT_EDIT', 'MINIGUI_EDIT_CLOSE', 'MINIGUI_EDIT_EDIT', } ;
         IMAGESALIGN {HEADER_IMG_AT_RIGHT, HEADER_IMG_AT_LEFT, HEADER_IMG_AT_RIGHT, HEADER_IMG_AT_LEFT, HEADER_IMG_AT_RIGHT, } ;
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
         WORKAREA &var ;
         FIELDS { 'Test->Code' , 'Test->First' , 'Test->Last' , 'Test->Birth' , 'Test->Married' , 'Test->Bio' } ;
         TOOLTIP 'Browse Test' ;
         ON CHANGE ChangeTest() ;
         JUSTIFY { BROWSE_JTFY_RIGHT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER} ;
         DELETE ;
         DELETEWHEN {|| test->(recno()) % 2 == 0} ;
         DELETEMSG "Odd records can't be deleted !!!" ;
         ON DELETE {|| automsgbox("Record " + ltrim(str(test->(recno()))) + " deleted !!!")} ;
         LOCK ;
         EDIT INPLACE FULLMOVE ;
         APPEND

 /*
      DEFINE BROWSE Browse_1
         ROW 10
         COL 10
         WIDTH 610
         HEIGHT 390
         HEADERS { 'Code' , 'First Name' , 'Last Name', 'Birth Date', 'Married' , 'Biography' }
         HEADERIMAGES {'MINIGUI_EDIT_EDIT', 'MINIGUI_EDIT_DELETE', 'MINIGUI_EDIT_EDIT', 'MINIGUI_EDIT_CLOSE', 'MINIGUI_EDIT_EDIT'}
         IMAGESALIGN {HEADER_IMG_AT_RIGHT, HEADER_IMG_AT_LEFT, HEADER_IMG_AT_RIGHT, HEADER_IMG_AT_LEFT, HEADER_IMG_AT_RIGHT}
         WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 }
         WORKAREA &var
         FIELDS { 'Test->Code' , 'Test->First' , 'Test->Last' , 'Test->Birth' , 'Test->Married' , 'Test->Bio' }
         TOOLTIP 'Browse Test'
         ON CHANGE {|| ChangeTest()}
         JUSTIFY { BROWSE_JTFY_LEFT,BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER, BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER,BROWSE_JTFY_CENTER}
         ALLOWDELETE .T.
         DELETEWHEN {|| test->(recno()) % 2 == 0}
         DELETEMSG "Odd records can't be deleted !!!"
         ON DELETE {|| automsgbox("Record " + ltrim(str(test->(recno()))) + " deleted !!!")}
         LOCK .T.
         ALLOWAPPEND .T.
         ALLOWEDIT .T.
         FULLMOVE .T.
         INPLACEEDIT .T.
      END BROWSE
  */
   END WINDOW

   CENTER WINDOW Form_1

   Form_1.Browse_1.SetFocus

   ACTIVATE WINDOW Form_1

Return Nil

Function OpenTables()

   CreateTable()

   Use Test Via "DBFCDX"
   Go Top

   Form_1.Browse_1.Value := RecNo()

Return Nil

Function CloseTables()
   Use
   ERASE TEST.DBF
   ERASE TEST.FPT
   ERASE CODE.CDX
Return Nil

Function ChangeTest()

   Form_1.StatusBar.Item(1) := 'RecNo() ' + Alltrim ( Str ( RecNo ( ) ) )

Return Nil

Function CreateTable
   LOCAL aDbf[6][4], i

        aDbf[1][ DBS_NAME ] := "Code"
        aDbf[1][ DBS_TYPE ] := "Numeric"
        aDbf[1][ DBS_LEN ]  := 10
        aDbf[1][ DBS_DEC ]  := 0
        //
        aDbf[2][ DBS_NAME ] := "First"
        aDbf[2][ DBS_TYPE ] := "Character"
        aDbf[2][ DBS_LEN ]  := 25
        aDbf[2][ DBS_DEC ]  := 0
        //
        aDbf[3][ DBS_NAME ] := "Last"
        aDbf[3][ DBS_TYPE ] := "Character"
        aDbf[3][ DBS_LEN ]  := 25
        aDbf[3][ DBS_DEC ]  := 0
        //
        aDbf[4][ DBS_NAME ] := "Married"
        aDbf[4][ DBS_TYPE ] := "Logical"
        aDbf[4][ DBS_LEN ]  := 1
        aDbf[4][ DBS_DEC ]  := 0
        //
        aDbf[5][ DBS_NAME ] := "Birth"
        aDbf[5][ DBS_TYPE ] := "Date"
        aDbf[5][ DBS_LEN ]  := 8
        aDbf[5][ DBS_DEC ]  := 0
        //
        aDbf[6][ DBS_NAME ] := "Bio"
        aDbf[6][ DBS_TYPE ] := "Memo"
        aDbf[6][ DBS_LEN ]  := 10
        aDbf[6][ DBS_DEC ]  := 0
        //

        DBCREATE("Test", aDbf, "DBFCDX")

   Use test Via "DBFCDX"
   zap

   For i:= 1 To 10
      append blank
      Replace code with i
      Replace First With 'First Name '+ Str(i)
      Replace Last With 'Last Name '+ Str(i)
      Replace Married With .t.
      replace birth with date()+i-10000
   Next i

   Index on test->code to code

   Use

Return Nil
