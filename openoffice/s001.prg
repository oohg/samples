/*
 * OpenOffice Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create an OpenOffice workbook,
 * using data from a Grid, without user's interaction.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL i, aRows[ 15, 5 ], oGrid

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "Export Grid's Data to an OpenOffice Workbook" ;
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

      @ 20,20 GRID Grid_1 obj oGrid ;
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
         ACTION ToOpenOffice( oGrid )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ToOpenOffice( oGrid )

   LOCAL cBefore, oSerM, oDesk, oPropVals, oBook, oSheet, oCell, uValue, nLin, nRow, nCol, bErrBlck2, x, bErrBlck1

   cBefore := Form_1.StatusBar.Item( 1 )
   Form_1.StatusBar.Item( 1 ) := 'Creating TEST.ODS in base folder ...'

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
      FOR nCol := 1 TO Len( oGrid:aHeaders )
         oCell := oSheet:GetCellByPosition( nCol - 1, nLin - 1 )
         oCell:SetString( oGrid:aHeaders[ nCol ] )
         oCell:CharWeight := 150
      NEXT
      nLin += 2

      // put rows
      FOR nRow := 1 to oGrid:ItemCount
         FOR nCol := 1 to Len( oGrid:aHeaders )
            oCell := oSheet:GetCellByPosition( nCol - 1, nLin - 1 )
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
      oSheet:GetColumns():SetPropertyValue( "OptimalWidth", .T. )

      bErrBlck2 := ErrorBlock( { | x | break( x ) } )
      BEGIN SEQUENCE
         // save
         oBook:StoreToURL( OO_ConvertToURL( HB_DirBase() + 'TEST.ODS' ), {} )
         oBook:Close( 1 )

         MsgInfo( HB_DirBase() + 'TEST.ODS was created.' )
      RECOVER USING x
         // if oBook:StoreToURL() fails, show the error
         MsgStop( x:Description, "OpenOffice Error" )
         MsgStop( HB_DirBase() + 'TEST.ODS was not created !!!' )
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

/*
 * EOF
 */
