/*
 * OLE Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on the original sample of Ciro Vargas C. (c) 2009
 * derived from Harbour's TestOle.prg
 *
 * This sample shows how to create and manipulate application
 * objects using OLE technology.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW main_form ;
      AT 114,218 ;
      WIDTH 334 ;
      HEIGHT 276 ;
      TITLE 'OLE TEST' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP "Test"
            MENUITEM 'Word Test' ACTION MSWORD()
            MENUITEM 'IE Test' ACTION IEXPLORER()
            MENUITEM 'OutLook Test' ACTION OUTLOOK()
            MENUITEM 'Excel Test' ACTION EXCEL()
            MENUITEM 'OpenOffice Calc' action Exm_OOCalc()
            MENUITEM 'OpenOffice Writer' Action Exm_OOWriter()
         END POPUP
      END MENU

   END WINDOW

   Main_form.Center
   Main_form.Activate

   RETURN NIL

STATIC PROCEDURE MSWord()

   LOCAL oWord, oText

#ifndef __XHARBOUR__
   IF ( oWord := win_oleCreateObject( "Word.Application" ) ) == NIL
      MsgStop( "Word is no available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   ENDIF
#else
   oWord := TOleAuto():New( "Word.Application" )
   IF Ole2TxtError() != "S_OK"
      MsgStop( "Word is no available.", "Error" )
      RETURN
   ENDIF
#EndIf

   oWord:Documents:Add()

   oText := oWord:Selection()

   oText:Text := "OLE from ooHG" + hb_osNewLine()
   oText:Font:Name := "Arial"
   oText:Font:Size := 48
   oText:Font:Bold := .T.

   oWord:Visible := .T.
   oWord:WindowState := 1 /* Maximize */

   RETURN

STATIC PROCEDURE IEXPLORER()

   LOCAL oIE

#ifndef __XHARBOUR__
   IF ( oIE := win_oleCreateObject( "InternetExplorer.Application" ) ) == NIL
      MsgStop( "IExplorer is not available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   ENDIF
#else
   oIE := TOleAuto():New( "InternetExplorer.Application" )
   IF Ole2TxtError() != "S_OK"
      MsgStop( "IExplorer is not available.", "Error" )
      RETURN
   ENDIF
#EndIf

   oIE:Visible := .T.
   oIE:Navigate( "https://oohg.github.io/" )

   RETURN

STATIC PROCEDURE OUTLOOK()

   LOCAL oOL, oList

#ifndef __XHARBOUR__
   IF ( oOL := win_oleCreateObject( "Outlook.Application" ) ) == NIL
      MsgStop( "Outlook is not available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   ENDIF
#else
   oOL := TOleAuto():New( "Outlook.Application" )
   IF Ole2TxtError() != "S_OK"
      MsgStop( "Outlook is not available.", "Error" )
      RETURN
   ENDIF
#EndIf

   oList := oOL:CreateItem( 7 /* olDistributionListItem */ )
   oList:DLName := "Distribution List"
   oList:Display( .F. )

   RETURN

STATIC PROCEDURE EXCEL()

   LOCAL oExcel, oWorkBook, oWorkSheet, oAS, nI, nCount

#ifndef __XHARBOUR__
   IF ( oExcel := win_oleCreateObject( "Excel.Application" ) ) == Nil
      MsgStop( "Excel is not available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   ENDIF
#else
   oExcel := TOleAuto():New( "Excel.Application" )
   IF Ole2TxtError() != "S_OK"
      MsgStop( "Excel is not available.", "Error" )
      RETURN
   ENDIF
#EndIf

   oWorkBook := oExcel:WorkBooks:Add()

   // Enumerator test
   FOR EACH oWorkSheet IN oWorkBook:WorkSheets
    ? oWorkSheet:Name
   NEXT

   // oWorkBook:WorkSheets is a collection
   nCount := oWorkBook:WorkSheets:Count()

   // Elements of collection can be accessed using :Item() method
   FOR nI := 1 TO nCount
    ? oWorkBook:WorkSheets:Item( nI ):Name
   NEXT

   // OLE also allows to access collection elements by passing
   // indices to :Worksheets property
   FOR nI := 1 TO nCount
    ? oWorkBook:WorkSheets( nI ):Name
   NEXT

   oAS := oExcel:ActiveSheet()

   // Set font for all cells
   oAS:Cells:Font:Name := "Arial"
   oAS:Cells:Font:Size := 12

   oAS:Cells( 1, 1 ):Value := "OLE from ooHG"
   oAS:Cells( 1, 1 ):Font:Size := 16

   // oAS:Cells( 1, 1 ) is object, but oAS:Cells( 1, 1 ):Value has value of the cell
   // AutoMsgBox( { "Object valtype:", ValType( oAS:Cells( 1, 1 ) ), "Value:", oAS:Cells( 1, 1 ):Value } )

   oAS:Cells( 3, 1 ):Value := "String:"
   oAS:Cells( 3, 2 ):Value := "Hello, World!"

   oAS:Cells( 4, 1 ):Value := "Numeric:"
   oAS:Cells( 4, 2 ):Value := 1234.56
   oAS:Cells( 4, 3 ):Value := oAS:Cells( 4, 2 ):Value
   oAS:Cells( 4, 4 ):Value := oAS:Cells( 4, 2 ):Value
   oAS:Cells( 4, 3 ):Value *= 2
   oAS:Cells( 4, 2 ):Value ++

   oAS:Cells( 5, 1 ):Value := "Logical:"
   oAS:Cells( 5, 2 ):Value := .T.

   oAS:Cells( 6, 1 ):Value := "Date:"
   oAS:Cells( 6, 2 ):Value := DATE()

   oAS:Cells( 7, 1 ):Value := "Timestamp:"
   oAS:Cells( 7, 2 ):Value := hb_DateTime()

   // Some formatting
   oAS:Columns( 1 ):Font:Bold := .T.
   oAS:Columns( 2 ):HorizontalAlignment := -4152  // xlRight

   oAS:Columns( 1 ):AutoFit()
   oAS:Columns( 2 ):AutoFit()
   oAS:Columns( 3 ):AutoFit()
   oAS:Columns( 4 ):AutoFit()

   oAS:Cells( 3, 2 ):Font:ColorIndex := 3  // red

   oAS:Range( "A1:B1" ):HorizontalAlignment := 7
   oAS:Range( "A3:A7" ):Select()

   oExcel:Visible := .T.

   // To remove Excel from memory
   // oExcel:Quit()

   RETURN

STATIC PROCEDURE Exm_OOCalc()

   LOCAL oServiceManager, oDesktop, oDoc, oSheet

   // open service manager
#ifndef __XHARBOUR__
   If ( oServiceManager := win_oleCreateObject( "com.sun.star.ServiceManager" ) ) == NIL
      MsgStop( "OpenOffice is not available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   EndIf
#else
   oServiceManager := TOleAuto():New( "com.sun.star.ServiceManager" )
   If Ole2TxtError() != "S_OK"
      MsgStop( "OpenOffice is not available.", "Error" )
      RETURN
   EndIf
#endIf

   // open desktop service
   IF ( oDesktop := oServiceManager:CreateInstance( "com.sun.star.frame.Desktop" ) ) == NIL
      MsgStop( "OpenOffice is not available.", "Error" )
      RETURN
   ENDIF

   /*
   // set properties for new book
   oPropVals := oServiceManager:Bridge_GetStruct( "com.sun.star.beans.PropertyValue" )
   oPropVals:Name := "Hidden"
   oPropVals:Value := .T.

   // open new book
   IF ( oDoc := oDesktop:LoadComponentFromURL( "private:factory/scalc", "_blank", 0, {oPropVals} ) ) == Nil
      MsgStop( "OpenOffice is not available.", "Error" )
      oDesktop := NIL
      RETURN
   ENDIF
   */

   IF ( oDoc := oDesktop:LoadComponentFromURL( "private:factory/scalc", "_blank", 0, {} ) ) == NIL
      MsgStop( "OpenOffice is not available.", "Error" )
      oDesktop := NIL
      RETURN
   ENDIF

   oSheet := oDoc:Sheets:getByIndex( 0 )

   oSheet:getCellRangeByName( "A1" ):setString( "OLE from Harbour" )

   oSheet:getCellRangeByName( "A3" ):setString( "String:" )
   oSheet:getCellRangeByName( "B3" ):setString( "Hello, World!" )

   oSheet:getCellRangeByName( "A4" ):setString( "Numeric:" )
   oSheet:getCellRangeByName( "B4" ):setValue( 1234.56 )

   oSheet:getCellRangeByName( "A5" ):setString( "Logical:" )
   oSheet:getCellRangeByName( "B5" ):setValue( .T. )
   oSheet:getCellRangeByName( "B5" ):setPropertyValue( "NumberFormat", 99 ) // BOOLEAN

   oSheet:getCellRangeByName( "A6" ):setString( "Date:" )
   oSheet:getCellRangeByName( "B6" ):setValue( DATE() )
   oSheet:getCellRangeByName( "B6" ):setPropertyValue( "NumberFormat", 36 ) // YYYY-MM-DD

   oSheet:getCellRangeByName( "A7" ):setString( "Timestamp:" )
   oSheet:getCellRangeByName( "B7" ):setstring( HB_DATETIME() )

   oSheet:getCellRangeByName( "A3" ):setPropertyValue( "IsCellBackgroundTransparent", .F. )
   oSheet:getCellRangeByName( "A3" ):setPropertyValue( "CellBackColor", 255 ) // blue
   oSheet:getCellRangeByName( "B3" ):setPropertyValue( "CharColor", 255 * 256 * 256 ) // red

   /*
   // To show the document if it was created with "Hidden" property set to .T.
   oSheet:IsVisible := .T.
   oBook:GetCurrentController():GetFrame():GetContainerWindow():SetVisible( .T. )
   oBook:GetCurrentController():GetFrame():GetContainerWindow():ToFront()
   */

   RETURN

STATIC PROCEDURE Exm_OOWriter()

   LOCAL oServiceManager, oDesktop, oDoc, oText, oCursor, oTable, oRow, oCell, oRows

   // open service manager
#ifndef __XHARBOUR__
   If ( oServiceManager := win_oleCreateObject( "com.sun.star.ServiceManager" ) ) == NIL
      MsgStop( "OpenOffice is not available [" + win_oleErrorText() + "]", "Error" )
      RETURN
   EndIf
#else
   oServiceManager := TOleAuto():New( "com.sun.star.ServiceManager" )
   If Ole2TxtError() != "S_OK"
      MsgStop( "OpenOffice is not available.", "Error" )
      RETURN
   EndIf
#endIf

   // open desktop service
   IF ( oDesktop := oServiceManager:CreateInstance( "com.sun.star.frame.Desktop" ) ) == NIL
      MsgStop( "OpenOffice is not available.", "Error" )
      RETURN
   ENDIF

   oDoc := oDesktop:loadComponentFromURL( "private:factory/swriter", "_blank", 0, {} )

   oText := oDoc:getText
   oCursor := oText:createTextCursor

   oText:insertString( oCursor, "OpenOffice Writer scripting from ooHG." + Chr( 10 ), .F. )

   oText:insertString( oCursor, "This is the second line" + Chr( 10 ), .F. )

   oTable := oDoc:createInstance( "com.sun.star.text.TextTable" )
   oTable:initialize( 2, 4 )

   oText:insertTextContent( oCursor, oTable, .F. )

   oTable:setPropertyValue( "BackTransparent", .F. )
   oTable:setPropertyValue( "BackColor", ( 255 * 256 + 255 ) * 256 + 192 )

   oRows := oTable:getRows
   oRow := oRows:getByIndex( 0 )
   oRow:setPropertyValue( "BackTransparent", .F. )
   oRow:setPropertyValue( "BackColor", ( 192 * 256 + 192 ) * 256 + 128 )

   oCell := oTable:getCellByName( "A1" )
   oCell:insertString( oCell:createTextCursor, "Jan", .F.)
   oCell := oTable:getCellByName( "B1" )
   oCell:insertString( oCell:createTextCursor, "Feb", .F.)
   oCell := oTable:getCellByName( "C1" )
   oCell:insertString( oCell:createTextCursor, "Mar", .F.)

   // I guess we can set text without cursor creation
   oTable:getCellByName( "D1" ):setString("SUM")

   oTable:getCellByName( "A2" ):setValue( 123.12 )
   oTable:getCellByName( "B2" ):setValue( 97.07 )
   oTable:getCellByName( "C2" ):setValue( 106.38 )
   oTable:getCellByName( "D2" ):setFormula( "sum <A2:C2>" )

   oText:insertControlCharacter( oCursor, 0 , .F. )  // PARAGRAPH_BREAK

   oCursor:setPropertyValue( "CharColor", 255 )
   oText:insertString( oCursor, "Good bye!", .F. )

   RETURN

/*
 * EOF
 */
