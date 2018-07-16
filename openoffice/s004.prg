/*
 * OpenOffice Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to copy and move worksheets of
 * an OpenOffice Calc workbook.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL i, aRows[ 15, 5 ], oForm, oGrid

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "Copy and Move OpenOffice Calc WorkSheets" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR i := 1 TO 15
          aRows[ i ] := { Str(HB_RandomInt( 99 ), 2), ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ), ;
                          HB_RandomInt( 10000 ) }
      NEXT i

      @ 20,20 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS {60, 80, 100, 120, 140} ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10

      @ 370,20 BUTTON btn_Export ;
         CAPTION 'Export to OpenOffice' ;
         WIDTH 140 ;
         ACTION MyProcess( oForm, oGrid )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION MyProcess( oForm, oGrid )

   LOCAL cFile, cBefore, oSerM, oDesk, oPropVals, oBook, oSheet1, oSheet2
   LOCAL oSheet3, oCell, uValue, nLin, nRow, nCol, bErrBlck2, x, bErrBlck1

   cFile := HB_DirBase() + "TEST.ODS"

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Creating ' + cFile + ' ...' )

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

      // remove all but 1 sheet
      DO WHILE oBook:Sheets:GetCount() > 1
         oSheet1 := oBook:Sheets:GetByIndex( oBook:Sheets:GetCount() - 1)
         oBook:Sheets:RemoveByName( oSheet1:Name )
      ENDDO

      // set first sheet as current
      oSheet1 := oBook:Sheets:GetByIndex(0)
      oBook:GetCurrentController:SetActiveSheet(oSheet1)

      // change sheet's name and default font name and size
      oSheet1:Name := "Sheet1"
      oSheet1:CharFontName := 'Arial'
      oSheet1:CharHeight := 10

      // put title
      oCell := oSheet1:GetCellByPosition( 0, 0 )
      oCell:SetString( 'Exported from OOHG !!!' )
      oCell:CharWeight := 150

      // put headers using bold style
      nLin := 4
      FOR nCol := 1 TO Len( oGrid:aHeaders )
         oCell := oSheet1:GetCellByPosition( nCol - 1, nLin - 1 )
         oCell:SetString( oGrid:aHeaders[ nCol ] )
         oCell:CharWeight := 150
      NEXT
      nLin += 2

      // put rows
      FOR nRow := 1 to oGrid:ItemCount
         FOR nCol := 1 to Len( oGrid:aHeaders )
            oCell := oSheet1:GetCellByPosition( nCol - 1, nLin - 1 )
            uValue := oGrid:Cell( nRow, nCol )
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
      oSheet1:GetColumns():SetPropertyValue( "OptimalWidth", .T. )

      // copy sheet before
      oBook:Sheets:CopyByName(oSheet1:Name, "Sheet2", 0)
      oSheet2 := oBook:Sheets:GetByName("Sheet2")
      oBook:GetCurrentController:SetActiveSheet(oSheet2)

      // copy sheet before and move to last position
      oBook:Sheets:CopyByName(oSheet1:Name, "Sheet3", 0)
      oBook:Sheets:MoveByName("Sheet3", 2)

      // Final sheet order: Sheet2, Sheet1, Sheet3

      bErrBlck2 := ErrorBlock( { | x | break( x ) } )

      BEGIN SEQUENCE
         // save
         oBook:StoreToURL( OO_ConvertToURL( cFile ), {} )
         oBook:Close( 1 )

         MsgInfo( cFile + ' was created.' )
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
   oCell   := NIL
   oSheet1 := NIL
   oSheet2 := NIL
   oSheet3 := NIL
   oBook   := Nil
   oDesk   := Nil
   oSerM   := Nil

   Form_1.StatusBar.Item( 1 ) := cBefore

RETURN NIL

/*
 * EOF
 */
