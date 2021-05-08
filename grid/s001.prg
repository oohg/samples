/*
 * Grid Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample from OOHG distribution build by
 * Ciro Vargas C. <cvc@oohg.org>
 *
 * This sample shows how to create an Excel worksheet
 * without user's interaction.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL i, aRows[ 150, 5 ]

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "Export Grid's Data to an Excel Workbook" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR i := 1 TO 150
          aRows[ i ] := { Str( hb_RandomInt( 99 ), 2 ), ;
                          hb_RandomInt( 100 ), ;
                          Date() + Random( hb_RandomInt() ), ;
                          'Refer ' + Str( hb_RandomInt( 10 ), 2 ), ;
                          hb_RandomInt( 10000 ) }
      NEXT i

      block := { |nCol| AutoMsgBox( nCol ) }

      @ 20,20 GRID Grid_1 OBJ oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS { 60, 80, 100, 120, 140 } ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10 ;
         ON HEADDBLCLICK { block, block, block, block, block } ;
         DISABLED

      @ 370,20 BUTTON btn_Export ;
         CAPTION 'Export to Excel' ;
         WIDTH 140 ;
         ACTION ToExcel( oGrid )

      @ 370,170 BUTTON btn_Toggle OBJ oButton ;
         CAPTION 'Enable' ;
         WIDTH 140 ;
         ACTION ( oGrid:Enabled := ! oGrid:Enabled, oButton:Caption := iif( oGrid:Enabled, "Disable", "Enable" ) )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ToExcel( oGrid )

   LOCAL cBefore, oExcel, oSheet, nLin, nRow, nCol

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

   oExcel:WorkBooks:Add()
   oSheet := oExcel:ActiveSheet()
   oSheet:Cells:Font:Name := 'Arial'
   oSheet:Cells:Font:Size := 10

   oSheet:Cells( 1, 1 ):Value := Upper( 'Exported from OOHG !!!' )
   oSheet:Cells( 1, 1 ):Font:Bold := .T.

   nLin := 4
   FOR nCol := 1 TO Len( oGrid:aHeaders )
      oSheet:Cells( nLin, nCol ):Value := Upper( oGrid:aHeaders[ nCol ] )
      oSheet:Cells( nLin, nCol ):Font:Bold := .T.
   NEXT
   nLin += 2

   FOR nRow := 1 to oGrid:ItemCount
      FOR nCol := 1 to Len( oGrid:aHeaders )
         oSheet:Cells( nLin, nCol ):Value := oGrid:Cell( nRow, nCol )
      NEXT
      nLin ++
   NEXT

   FOR nCol := 1 TO Len( oGrid:aHeaders )
      oSheet:Columns( nCol ):AutoFit()
   NEXT

   oSheet:SaveAs( HB_DirBase() + 'TEST.XLS' )
   oExcel:WorkBooks:Close()
   oExcel:Quit()

   oSheet := NIL
   oExcel := NIL

   MsgInfo( HB_DirBase() + 'TEST.XLS was created' + HB_OsNewLine() + ;
            'and EXCEL.EXE was unloaded from memory.' )

   Form_1.StatusBar.Item( 1 ) := cBefore

RETURN NIL

/*
 * EOF
 */
