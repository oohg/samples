/*
 * Excel Sample n° 4
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to create an Excel workbook using
 * data from a Grid control, without user's interaction.
 * It also shows how to copy and move worksheets.
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
      TITLE "Create Excel Workbook" ;
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
         CAPTION 'Export to Excel' ;
         WIDTH 140 ;
         ACTION ToExcel( oGrid )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ToExcel( oGrid )

   LOCAL cBefore, oExcel, oSheet1, oSheet2, oSheet3, nLin, nRow, nCol, bErrBlck1, x, bErrBlck2

   cBefore := Form_1.StatusBar.Item( 1 )
   Form_1.StatusBar.Item( 1 ) := 'Creating TEST.XLS in base folder ...'

   #ifndef __XHARBOUR__
      IF( oExcel := win_oleCreateObject( 'Excel.Application' ) ) == NIL
         MsgStop( 'Error: Excel not available. [' + win_oleErrorText()+ ']' )
         RETURN NIL
      ENDIF
   #else
      oExcel := TOleAuto():New( 'Excel.Application' )
      IF Ole2TxtError() != 'S_OK'
         MsgStop( 'Error: Excel not available.' )
         RETURN NIL
      ENDIF
   #endif

   // catch any errors
   bErrBlck1 := ErrorBlock( { | x | break( x ) } )

   BEGIN SEQUENCE
      oExcel:Visible := .F.
      oExcel:DisplayAlerts :=.F.

      // open new book
      oExcel:WorkBooks:Add()

      // set first sheet as current
      oSheet1 := oExcel:ActiveSheet()

      // change sheet's name and default font name and size
      oSheet1:Name := "Sheet1"

      // fill in some data and format it
      oSheet1:Cells:Font:Name := 'Arial'
      oSheet1:Cells:Font:Size := 10

      oSheet1:Cells( 1, 1 ):Value := Upper( 'Exported from OOHG !!!' )
      oSheet1:Cells( 1, 1 ):Font:Bold := .T.

      nLin := 4
      FOR nCol := 1 TO Len( oGrid:aHeaders )
         oSheet1:Cells( nLin, nCol ):Value := Upper( oGrid:aHeaders[ nCol ] )
         oSheet1:Cells( nLin, nCol ):Font:Bold := .T.
      NEXT
      nLin += 2

      FOR nRow := 1 to oGrid:ItemCount
         FOR nCol := 1 to Len( oGrid:aHeaders )
            oSheet1:Cells( nLin, nCol ):Value := oGrid:Cell( nRow, nCol )
         NEXT
         nLin ++
      NEXT

      FOR nCol := 1 TO Len( oGrid:aHeaders )
         oSheet1:Columns( nCol ):AutoFit()
      NEXT

      // Copy sheet before

      oSheet1:Copy( oSheet1 )
      oSheet2 := oExcel:ActiveSheet()
      oSheet2:Name := "Sheet2"

      // Copy sheet after

      oSheet1:Copy( oSheet1 )
      oSheet3 := oExcel:ActiveSheet()
      oSheet3:Name := "Sheet3"
      oSheet1:Move( oSheet3 )

      // Final sheet order: Sheet2, Sheet1, Sheet3

      // Save

      // save
      bErrBlck2 := ErrorBlock( { | x | break( x ) } )
      BEGIN SEQUENCE
         // if the file already exists and it's not open, it's overwritten without asking
         oSheet1:SaveAs( HB_DirBase() + 'TEST.XLS' )

         // close and remove the copy of EXCEL.EXE from memory
         oExcel:WorkBooks:Close()
         oExcel:Quit()

         MsgInfo( HB_DirBase() + 'TEST.XLS was created !!!' )
      RECOVER USING x
         // if oSheet1:SaveAs() fails, show the error
         MsgStop( x:Description, "Excel Error" )

         // close and remove the copy of EXCEL.EXE from memory
         oExcel:WorkBooks:Close()
         oExcel:Quit()

         MsgStop( HB_DirBase() + 'TEST.XLS was not created !!!' )
      END SEQUENCE

      ErrorBlock( bErrBlck2 )
   RECOVER USING x
      MsgStop( x:Description, "Excel Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   oSheet1 := NIL
   oExcel := NIL

   Form_1.StatusBar.Item( 1 ) := cBefore

RETURN NIL

/*
 * EOF
 */
