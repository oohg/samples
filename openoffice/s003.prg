/*
 * OpenOffice Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create an OpenOffice workbook
 * from an array, how to create a DBF from an OpenOffice
 * workbook, and how to handle errors raised during operations.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main

   LOCAL oForm

   SET DATE BRITISH
   SET CENTURY ON

   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 280 ;
      TITLE "Copy an OpenOffice Workbook to a Dbf" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      @ 20,20 BUTTON btn_Execute ;
         CAPTION 'Execute' ;
         WIDTH 140 ;
         ACTION MyProcess( oForm )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION MyProcess( oForm )

   LOCAL cBefore, oSerM, oDesk, oBook, oPropVals, oSheet, bErrBlck2, x, bErrBlck1
   LOCAL nLin, nCol, cFile, oCell, nRow, uValue
   LOCAL aHeaders := { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' }
   LOCAL aData    := { { "AB1", 12, Date(), "Ref. 12", 128.10 }, ;
                       { "AB5", 34, Date(), "Ref. 34", 578.43 }, ;
                       { "XC3", 87, Date(), "Ref. 87", 879.60 }, ;
                       { "MN6", 65, Date(), "Ref. 65", 322.33 }, ;
                       { "OO9", 90, Date(), "Ref. 90", 765.77 } }

   cFile := HB_DirBase() + "TEST.ODS"

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Creating ' + cFile + ' ...' )

   ERASE (cFile)

   // open service manager
   #ifndef __XHARBOUR__
      IF( oSerM := win_oleCreateObject( 'com.sun.star.ServiceManager' ) ) == NIL
         MsgStop( 'Error: OpenOffice not available. [' + win_oleErrorText()+ ']' )
         RETURN NIL
      ENDIF
   #else
      oSerM := TOleAuto():New( 'com.sun.star.ServiceManager' )
      IF Ole2TxtError() != 'S_OK'
         MsgStop( 'Error: OpenOffice not available.' )
         RETURN NIL
      ENDIF
   #endif

   // catch any errors
   bErrBlck1 := ErrorBlock( { | x | break( x ) } )

   BEGIN SEQUENCE
      // open desktop service
      IF (oDesk := oSerM:CreateInstance("com.sun.star.frame.Desktop")) == NIL
         MsgStop( 'Error: OpenOffice Desktop not available.' )
         BREAK
      ENDIF

      // set properties for new book
      oPropVals := oSerM:Bridge_GetStruct("com.sun.star.beans.PropertyValue")
      oPropVals:Name := "Hidden"
      oPropVals:Value := .T.

      // open new book
      IF (oBook := oDesk:LoadComponentFromURL("private:factory/scalc", "_blank", 0, {oPropVals})) == NIL
         MsgStop( 'Error: OpenOffice Calc not available.' )
         BREAK
      ENDIF

      // set first sheet as current
      oSheet := oBook:Sheets:GetByIndex(0)
      oBook:getCurrentController:SetActiveSheet(oSheet)

      // change sheet's name and default font name and size
      oSheet:Name := "Data"
      oSheet:CharFontName := 'Arial'
      oSheet:CharHeight := 10

      // put title
      oCell := oSheet:GetCellByPosition( 0, 0 )
      oCell:SetString( 'Exported from OOHG !!!' )
      oCell:CharWeight := 150

      // put headers using bold style
      nLin := 4
      FOR nCol := 1 TO 5
         oCell := oSheet:GetCellByPosition( nCol - 1, nLin - 1 )
         oCell:SetString( aHeaders[ nCol ] )
         oCell:CharWeight := 150
      NEXT
      nLin += 2

      // put rows
      FOR nRow := 1 to 5
         FOR nCol := 1 to 5
            oCell := oSheet:GetCellByPosition( nCol - 1, nLin - 1 )
            uValue := aData[ nRow, nCol ]
            DO CASE
            CASE uValue == NIL
            CASE ValType( uValue ) == "C"
               IF Left( uValue, 1 ) == "'"
                  uValue := "'" + uValue
               ENDIF
               oCell:SetString( uValue )
            CASE ValType( uValue ) == "N"
               oCell:SetValue( uValue )
            CASE ValType( uValue ) == "L"
               oCell:SetValue( uValue )
               oCell:SetPropertyValue("NumberFormat", 99 )
            CASE ValType( uValue ) == "D"
               oCell:SetValue( uValue )
               oCell:SetPropertyValue( "NumberFormat", 36 )
            CASE ValType( uValue ) == "T"
               oCell:SetString( uValue )
            OTHERWISE
               oCell:SetFormula( uValue )
            ENDCASE
         NEXT
         nRow ++
         nLin ++
      NEXT

      // autofit columns
      oSheet:GetColumns():SetPropertyValue( "OptimalWidth", .T. )

      bErrBlck2 := ErrorBlock( { | x | break( x ) } )
      BEGIN SEQUENCE
         // save
         oBook:StoreToURL( OO_ConvertToURL( cFile ), {} )
         oBook:Close( 1 )

         IF MsgYesNo( cFile + ' was created.' + HB_OsNewLine() + "Create Dbf?" )
            ConvertToDbf( oForm, cFile )
         ENDIF
      RECOVER USING x
         // if oBook:StoreToURL() fails, show the error
         MsgStop( x:Description, "OpenOffice Error" )
         MsgStop( cFile + ' was not created !!!' )
      END SEQUENCE

      ErrorBlock( bErrBlck2 )
   RECOVER USING x
      MsgStop( x:Description, "OpenOffice Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   // cleanup
   oCell  := NIL
   oSheet := NIL
   oBook  := Nil
   oDesk  := Nil
   oSerM  := Nil

   Form_1.StatusBar.Item( 1 ) := cBefore

RETURN NIL

FUNCTION ConvertToDbf( oForm, cFile )

   LOCAL cBefore, oSerM, oDesk, oPropVal1, oPropVal2, oBook, oSheet, bErrBlck1, oCellCursor
   LOCAL i, nRows, nCols, nLin, aFields, cDbf

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Opening ' + cFile + ' ...' )

   cDbf := HB_DirBase() + "TEST.DBF"

   // open service manager
   #ifndef __XHARBOUR__
      IF( oSerM := win_oleCreateObject( 'com.sun.star.ServiceManager' ) ) == NIL
         MsgStop( 'Error: OpenOffice not available. [' + win_oleErrorText()+ ']' )
         RETURN NIL
      ENDIF
   #else
      oSerM := TOleAuto():New( 'com.sun.star.ServiceManager' )
      IF Ole2TxtError() != 'S_OK'
         MsgStop( 'Error: OpenOffice not available.' )
         RETURN NIL
      ENDIF
   #endif

   // catch any errors
   bErrBlck1 := ErrorBlock( { | x | break( x ) } )

   BEGIN SEQUENCE
      // open desktop service
      IF (oDesk := oSerM:CreateInstance("com.sun.star.frame.Desktop")) == NIL
         MsgStop( 'Error: OpenOffice Desktop not available.' )
         BREAK
      ENDIF

      // set properties for new book
      oPropVal1 := oSerM:Bridge_GetStruct("com.sun.star.beans.PropertyValue")
      oPropVal1:Name := "Hidden"
      oPropVal1:Value := .T.
      oPropVal2 := oSerM:Bridge_GetStruct("com.sun.star.beans.PropertyValue")
      oPropVal2:Name := "ReadOnly"
      oPropVal2:Value := .T.

      // open book
      IF (oBook := oDesk:LoadComponentFromURL(OO_ConvertToURL( cFile ), "_blank", 0, {oPropVal1, oPropVal2})) == NIL
         MsgStop( 'Error: OpenOffice Calc not available.' )
         BREAK
      ENDIF

      // set first sheet as current
      oSheet := oBook:Sheets:GetByIndex(0)
      oBook:getCurrentController:SetActiveSheet(oSheet)

      oCellCursor := oSheet:CreateCursor()

      /*
      oCellCursor:GotoStartOfUsedArea( .F. )
      nFirstRow := oCellCursor:GetRangeAddress():StartRow
      nFirstCol := oCellCursor:GetRangeAddress():StartColumn
      oCellCursor:GotoEndOfUsedArea( .T. )
      nLastRow := oCellCursor:GetRangeAddress():EndRow
      nLastCol := oCellCursor:GetRangeAddress():EndColumn
      */

      oCellCursor:GotoEndOfUsedArea( .T. )
      nRows = oCellCursor:GetRangeAddress:EndRow - 4
      nCols := oCellCursor:GetRangeAddress:EndColumn + 1

      oForm:StatusBar:Item( 1, 'Processing ' + Ltrim( Str( nRows ) ) + ' rows with ' + Ltrim( Str( nCols ) ) + ' cols ...' )

      aFields := Array( nCols )
      aFields[ 1 ] := { oSheet:GetCellByPosition( 0, 3 ):GetFormula, "CHARACTER", 3, 0 }
      aFields[ 2 ] := { oSheet:GetCellByPosition( 1, 3 ):GetFormula, "NUMERIC", 2, 0 }
      aFields[ 3 ] := { oSheet:GetCellByPosition( 2, 3 ):GetFormula, "DATE", 8, 0 }
      aFields[ 4 ] := { oSheet:GetCellByPosition( 3, 3 ):GetFormula, "CHARACTER", 20, 0 }
      aFields[ 5 ] := { oSheet:GetCellByPosition( 4, 3 ):GetFormula, "NUMERIC", 6, 2 }

      ERASE (cDbf)

      DBCREATE( cDbf, aFields )

      oForm:StatusBar:Item( 1, cDbf + ' created ...' )

      USE (cDbf) ALIAS TEST

      nLin := 6
      FOR i := 1 TO nRows
         test->( dbappend() )

         REPLACE test->code      with oSheet:GetCellByPosition( 0, nLin - 1 ):GetFormula
         REPLACE test->number    with oSheet:GetCellByPosition( 1, nLin - 1 ):Value
         REPLACE test->date      with ( oSheet:GetCellByPosition( 2, nLin - 1 ):GetValue  + d"1899/12/30" )
         REPLACE test->reference with oSheet:GetCellByPosition(3, nLin - 1 ):GetFormula
         REPLACE test->amount    with oSheet:GetCellByPosition( 4, nLin - 1 ):Value

         nLin ++
      NEXT

      CLOSE DATABASES
      COMMIT

      oForm:StatusBar:Item( 1, cDbf + ', ' + Ltrim( Str( RecCount() ) ) + ' records appended ...' )

      MsgInfo( cDbf + ' was created.' )
   RECOVER
      CLOSE DATABASES
      COMMIT

      MsgStop( 'OpenOffice error while reading.' )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   oSerM := NIL
   oDesk := NIL

   oForm:StatusBar:Item( 1, cBefore )

RETURN NIL

/*
 * EOF
 */
