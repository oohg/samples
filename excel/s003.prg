/*
 * Excel Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create an Excel workbook from
 * an array, how to create a DBF from an Excel workbook,
 * and how to handle errors raised during operations.
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
      WIDTH 400 ;
      HEIGHT 280 ;
      TITLE "Copy an Excel Workbook to a Dbf" ;
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

   LOCAL cBefore, oExcel, oBook, oSheet, bErrBlck1, bErrBlck2, x
   LOCAL nLin, i, nCol, cExcel
   LOCAL aHeaders := { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' }
   LOCAL aData    := { { "AB1", 12, Date(), "Ref. 12", 128.10 }, ;
                       { "AB5", 34, Date(), "Ref. 34", 578.43 }, ;
                       { "XC3", 87, Date(), "Ref. 87", 879.60 }, ;
                       { "MN6", 65, Date(), "Ref. 65", 322.33 }, ;
                       { "OO9", 90, Date(), "Ref. 90", 765.77 } }

   cExcel := HB_DirBase() + 'TEST.XLS'

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Creating ' + cExcel + ' ...' )

   ERASE (cExcel)

   #ifndef __XHARBOUR__
      IF( oExcel := win_oleCreateObject( 'Excel.Application' ) ) == NIL
         MsgStop( 'Error: Excel not available. [' + win_oleErrorText() + ']' )
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
      oExcel:DisplayAlerts := .F.
      oExcel:SheetsInNewWorkbook := 1

      oBook := oExcel:WorkBooks:Add()

      oSheet := oBook:WorkSheets( 1 )
      oSheet:Select()

      oSheet:Cells:Font:Name := 'Arial'
      oSheet:Cells:Font:Size := 10

      oSheet:Cells( 1, 1 ):Value := Upper( 'Created from OOHG !!!' )
      oSheet:Cells( 1, 1 ):Font:Bold := .T.

      nLin := 4
      FOR nCol := 1 TO Len( aHeaders )
         oSheet:Cells( nLin, nCol ):Value := Upper( aHeaders[ nCol ] )
         oSheet:Cells( nLin, nCol ):Font:Bold := .T.
      NEXT
      nLin += 2

      FOR i := 1 to Len( aData )
         FOR nCol := 1 to Len( aHeaders )
            oSheet:Cells( nLin, nCol ):Value := aData[ i, nCol ]
         NEXT
         nLin ++
      NEXT

      FOR nCol := 1 TO Len( aHeaders )
         oSheet:Columns( nCol ):AutoFit()
      NEXT

      // save
      bErrBlck2 := ErrorBlock( { | x | break( x ) } )
      BEGIN SEQUENCE
         // http://msdn.microsoft.com/en-us/library/office/bb241279(v=office.12).aspx
         # define xlExcel7 39

         // if the file already exists and it's not open, it's overwritten without asking
         oSheet:SaveAs( cExcel, 39 )

         // close and remove the copy of EXCEL.EXE from memory
         oExcel:WorkBooks:Close()
         oExcel:Quit()

         IF MsgYesNo( cExcel + ' was created !!!' + HB_OsNewLine() + "Create Dbf?" )
            ConvertToDbf( oForm, cExcel )
         ENDIF
      RECOVER USING x
         // if oSheet:SaveAs() fails, show the error
         MsgStop( x:Description, "Excel Error" )

         // close and remove the copy of EXCEL.EXE from memory
         oExcel:WorkBooks:Close()
         oExcel:Quit()

         MsgStop( cExcel + ' was not created !!!' )
      END SEQUENCE

      ErrorBlock( bErrBlck2 )
   RECOVER USING x
      MsgStop( x:Description, "Excel Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   // This destroys any reference to the Sheet
   oSheet := NIL
   // This destroys any reference to the WorkBook
   oBook := NIL
   // This destroys any reference to Excel
   oExcel := NIL

   oForm:StatusBar:Item( 1, cBefore )

RETURN NIL

FUNCTION ConvertToDbf( oForm, cExcel )

   LOCAL cBefore, oExcel, oBook, oSheet, bErrBlck1, x
   LOCAL i, nRows, nCols, nLin, aFields, cDbf

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Opening ' + cExcel + ' ...' )

   cDbf := HB_DirBase() + "TEST.DBF"

   #ifndef __XHARBOUR__
      IF( oExcel := win_oleCreateObject( 'Excel.Application' ) ) == NIL
         MsgStop( 'Error: Excel not available. [' + win_oleErrorText() + ']' )
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
      oExcel:DisplayAlerts := .F.

      oBook := oExcel:WorkBooks:Open( cExcel, NIL, .T. )   // readonly

      oSheet := oBook:WorkSheets( 1 )

      nRows := oSheet:UsedRange:Rows:Count() - 5
      nCols := oSheet:UsedRange:Columns:Count()
      oForm:StatusBar:Item( 1, 'Processing ' + Ltrim( Str( nRows ) ) + ' rows with ' + Ltrim( Str( nCols ) ) + ' cols ...' )

      aFields := Array( nCols )
      aFields[ 1 ] := { Cstr(oSheet:Cells( 4, 1 ):value), "CHARACTER", 3, 0 }
      aFields[ 2 ] := { Cstr(oSheet:Cells( 4, 2 ):value), "NUMERIC", 2, 0 }
      aFields[ 3 ] := { Cstr(oSheet:Cells( 4, 3 ):value), "DATE", 8, 0 }
      aFields[ 4 ] := { Cstr(oSheet:Cells( 4, 4 ):value), "CHARACTER", 20, 0 }
      aFields[ 5 ] := { Cstr(oSheet:Cells( 4, 5 ):value), "NUMERIC", 6, 2 }

      ERASE (cDbf)

      DBCREATE( cDbf, aFields )

      oForm:StatusBar:Item( 1, cDbf + ' created ...' )

      USE (cDbf) ALIAS TEST

      nLin := 6
      FOR i := 1 TO nRows
         test->( dbappend() )

         REPLACE test->code      with Cstr( oSheet:Cells( nLin, 1 ):value )
         REPLACE test->number    with Val( Cstr(oSheet:Cells( nLin, 2 ):value ) )
         REPLACE test->date      with &( Cstr(oSheet:Cells(nLin, 3 ):value ) )
         REPLACE test->reference with Cstr( oSheet:Cells( nLin, 4 ):value )
         REPLACE test->amount    with Val( Cstr(oSheet:Cells( nLin, 5 ):value ) )

         nLin ++
      NEXT

      CLOSE DATABASES
      COMMIT

      oForm:StatusBar:Item( 1, cDbf + ', ' + Ltrim( Str( RecCount() ) ) + ' records appended ...' )
      MsgInfo( cDbf + ' was created' + HB_OsNewLine() + ' !!!' )
   RECOVER USING x
      MsgStop( x:Description, "Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   oExcel:WorkBooks:Close()
   oExcel:Quit()

   oSheet := NIL
   oBook  := NIL
   oExcel := NIL

   oForm:StatusBar:Item( 1, cBefore )

RETURN NIL

/*
 * EOF
 */
