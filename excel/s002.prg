/*
 * Excel Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed bajo The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to open an Excel workbook in
 * read only mode.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE 'Open an Excel workbook in readonly mode' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG power !!!'
      END STATUSBAR

      @ 370,20 BUTTON btn_Abrir ;
         CAPTION 'Open Excel' ;
         WIDTH 140 ;
         ACTION Open()

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION Open

   LOCAL w_arch, oExcel, x, bErrBlck1

   IF Empty(w_arch := GetFile({ {'*.xls','*.xls'} }, 'Open Excel', 'C:\', .f., .f.))
      RETURN NIL
   ENDIF

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
      oExcel:WorkBooks:Open(w_arch, NIL, .T.)
      oExcel:Visible := .t.
   RECOVER USING x
      MsgStop( x:Description, "Excel Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

RETURN NIL

/*
 * EOF
 */
