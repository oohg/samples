**************************************************************************
*                                                                        *
*  ooHG OLE Demo                                                         *
*  (c) 2009 Ciro Vargas C.                                               *
*                                                                         *
*  Based upon 'TestOle.Prg' from harbour project                                              *
*                                                                         *
*                                                                        *
**************************************************************************

#include "minigui.ch"

#define WM_CLOSE        0x0010

*-------------------------
Function main()
*-------------------------

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
      MENUITEM  'Open Office Calc' action Exm_OOCalc()
      MENUITEM  'Open Office Writer' Action Exm_OOWriter()
   END POPUP

END MENU

END WINDOW

Main_form.center
Main_form.activate

Return NIL
    STATIC PROCEDURE MSWord()
   LOCAL oWord, oText

   IF ( oWord := win_oleCreateObject( "Word.Application" ) ) != NIL

      oWord:Documents:Add()

      oText := oWord:Selection()

      oText:Text := "OLE from ooHG" + hb_OSNewLine()
      oText:Font:Name := "Arial"
      oText:Font:Size := 48
      oText:Font:Bold := .T.

      oWord:Visible := .T.
      oWord:WindowState := 1 /* Maximize */
   ELSE
      msgstop( "Error. MS Word not available.", win_oleErrorText())
   ENDIF

   RETURN


STATIC PROCEDURE IEXPLORER()

LOCAL oIE

IF ( oIE := win_oleCreateObject( "InternetExplorer.Application" ) ) != NIL
   oIE:Visible := .T.
   oIE:Navigate( "https://oohg.github.io/" )
ELSE
   msgstop("Error. IExplorer not available.", win_oleErrorText())
ENDIF

/*
   oIE:Visible := .T.   // Show browser
   oIE:ToolBar := .F.   // Hide toolbar
   oIE:StatusBar := .F. // Hide statusbar
   oIE:MenuBar := .F.   // Hide menubar

   oIE:Navigate("http://www.sunat.gob.pe/cl-ti-itmrconsruc/captcha?accion=image")
   WHILE oIE:ReadyState != 4
         hb_idleSleep( 0 )
   ENDDO
*/
RETURN

oLe := NIL


RETURN

//--------------------------------------------------------------------

STATIC PROCEDURE OUTLOOK()

LOCAL oOL, oList

IF ( oOL := win_oleCreateObject( "Outlook.Application" ) ) != NIL
   oList := oOL:CreateItem( 7 /* olDistributionListItem */ )
   oList:DLName := "Distribution List"
   oList:Display( .F. )
ELSE
   msgbox( "Error. MS Outlook not available.", win_oleErrorText())
ENDIF



oLista := NIL
oOL := NIL


RETURN

//--------------------------------------------------------------------

STATIC PROCEDURE EXCEL()

LOCAL oExcel, oWorkBook, oWorkSheet, oAS
LOCAL nI, nCount

IF ( oExcel := win_oleCreateObject( "Excel.Application" ) ) != NIL

   oWorkBook := oExcel:WorkBooks:Add()

// Enumerator test
FOR EACH oWorkSheet IN oWorkBook:WorkSheets
    ? oWorkSheet:Name
NEXT

// oWorkBook:WorkSheets is a collection
nCount := oWorkBook:WorkSheets:Count()

// Elements of collection can be accessed using :Item() method
FOR nI := 1 TO nCount
    ? oWorkBook:WorkSheets:Item(nI):Name
NEXT

// OLE also allows to access collection elements by passing
// indices to :Worksheets property
FOR nI := 1 TO nCount
    ? oWorkBook:WorkSheets(nI):Name
NEXT

oAS := oExcel:ActiveSheet()

// Set font for all cells
oAS:Cells:Font:Name := "Arial"
oAS:Cells:Font:Size := 12

oAS:Cells( 1, 1 ):Value := "OLE from ooHG"
oAS:Cells( 1, 1 ):Font:Size := 16

// oAS:Cells( 1, 1 ) is object, but oAS:Cells( 1, 1 ):Value has value of the cell
? "Object valtype:", VALTYPE(oAS:Cells( 1, 1 )), "Value:", oAS:Cells( 1, 1 ):Value

oAS:Cells( 3, 1 ):Value := "String:"
oAS:Cells( 3, 2 ):Value := "Hello, World!"

oAS:Cells( 4, 1 ):Value := "Numeric:"
oAS:Cells( 4, 2 ):Value := 1234.56
oAS:Cells( 4, 3 ):Value := oAS:Cells( 4, 2 ):Value
oAS:Cells( 4, 4 ):Value := oAS:Cells( 4, 2 ):Value
oAS:Cells( 4, 3 ):Value *= 2
oAS:Cells( 4, 2 ):Value++

oAS:Cells( 5, 1 ):Value := "Logical:"
oAS:Cells( 5, 2 ):Value := .T.

oAS:Cells( 6, 1 ):Value := "Date:"
oAS:Cells( 6, 2 ):Value := DATE()

oAS:Cells( 7, 1 ):Value := "Timestamp:"
oAS:Cells( 7, 2 ):Value := HB_DATETIME()

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

oExcel:Quit()
ELSE
   msgstop( "Error: MS Excel not available. [" + win_oleErrorText()+ "]" )
ENDIF

RETURN

STATIC PROCEDURE Exm_OOCalc()
   LOCAL oServiceManager, oDesktop, oDoc, oSheet

   IF ( oServiceManager := win_oleCreateObject( "com.sun.star.ServiceManager" ) ) != NIL
      oDesktop := oServiceManager:createInstance( "com.sun.star.frame.Desktop" )
      oDoc := oDesktop:loadComponentFromURL( "private:factory/scalc", "_blank", 0, {} )

      oSheet := oDoc:getSheets:getByIndex(0)

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
   ELSE
      msgbox("Error. OpenOffice not available.", win_oleErrorText())
   ENDIF

   RETURN


STATIC PROCEDURE Exm_OOWriter()
   LOCAL oServiceManager, oDesktop, oDoc, oText, oCursor, oTable, oRow, oCell, oCellCursor, oRows

   IF ( oServiceManager := win_oleCreateObject( "com.sun.star.ServiceManager" ) ) != NIL
      oDesktop := oServiceManager:createInstance( "com.sun.star.frame.Desktop" )
      oDoc := oDesktop:loadComponentFromURL( "private:factory/swriter", "_blank", 0, {} )

      oText := oDoc:getText
      oCursor := oText:createTextCursor

      oText:insertString( oCursor, "OpenOffice Writer scripting from ooHG." + CHR(10), .F. )

      oText:insertString( oCursor, "This is the second line" + CHR(10), .F. )

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

      oTable:getCellByName( "A2" ):setValue(123.12)
      oTable:getCellByName( "B2" ):setValue(97.07)
      oTable:getCellByName( "C2" ):setValue(106.38)
      oTable:getCellByName( "D2" ):setFormula("sum <A2:C2>")

      oText:insertControlCharacter( oCursor, 0 , .F. )  // PARAGRAPH_BREAK

      oCursor:setPropertyValue( "CharColor", 255 )
      oText:insertString( oCursor, "Good bye!", .F. )
   ELSE
     msgbox( "Error. OpenOffice not available.", win_oleErrorText())
   ENDIF

   RETURN










