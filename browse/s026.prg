/*
 * Browse Sample # 26
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This example shows how to change the default behavior
 * of the edit keys used by the BROWSE control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

REQUEST DBFCDX

FUNCTION Main()

   SET DELETED ON
   SET DATE ANSI
   SET CENTURY ON
   SET EPOCH TO 1980
   SET NAVIGATION EXTENDED

   rddSetDefault( "DBFCDX" )

   AddData()

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      TITLE "Browse - Change editing keys' default behavior" ;
      WIDTH 800 ;
      HEIGHT 700 ;
      CLIENTAREA ;
      NOMAXIMIZE ;
      NOSIZE ;
      MAIN ;
      BACKCOLOR WHITE ;
      ON INIT Start()

      @ 25, 20 BROWSE browse_1 OBJ oBrw ;
         WIDTH 760 ;
         HEIGHT 600 ;
         HEADERS { 'Index', 'Name', 'Group', 'Price', 'Comment', 'EAN' } ;
         WIDTHS { 80, 240, 60, 80, 150, 120 } ;
         JUSTIFY { 0, 0, 0, 1, 0, 0 } ;
         WORKAREA 'DBSAMPLE' ;
         FIELDS { 'index1+"-"+index2', 'name', 'group1', 'price', 'comment', 'ean' } ;
         COLUMNCONTROLS { { 'TEXTBOX', 'C', 'X9999-9', .F., 0, .F., .F., .T., NIL, .F. }, ;
                          { 'TEXTBOX', 'C', Replicate( 'X', 30), .F., 0, .F., .F., .T., NIL, .F. }, ;
                          { 'TEXTBOX', 'C', 'XX', .F., 0 }, ;
                          { 'TEXTBOX', 'NUMERIC', '999 999.99', .F., -2, .F., .F., .T., NIL, .F. }, ;
                          { 'TEXTBOX', 'C', Replicate( 'X', 20), .F., 0 }, ;
                          { 'TEXTBOX' } } ;
         COLUMNWHEN { .F., .T., .T., .T., .T., .F. } ;
         EDIT ;
         NAVIGATEBYCELL ;
         KEYSLIKECLIPPER ;
         EDITLIKEEXCEL ;
         FULLMOVE ;
         NOMODALEDIT ;
         EDITKEYSFUN { |o| MyKeyHandler( o ) }

      @ 660, 150 LABEL lb1 OBJ oLabel ;
         WIDTH 500 HEIGHT 40 ;
         VALUE '' ;
         FONTCOLOR BLACK BACKCOLOR WHITE ;
         FONT "ARIAL" SIZE 10 ;
         CENTERALIGN VCENTERALIGN

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

   CLOSE DATABASES
   IF File( 'dbsample.dbf' )
      ERASE dbsample.dbf
   ENDIF
   IF File( 'dbsample.cdx' )
      ERASE dbsample.cdx
   ENDIF

   QUIT

   RETURN NIL

FUNCTION MyKeyHandler( oEditWindow )

   LOCAL oEW := oEditWindow
   LOCAL nCol := oBrw:Value[ 2 ]

   ON KEY UP OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 1 )
   ON KEY RIGHT OF ( oEW:oControl ) ACTION iif( oEW:oControl:CaretPos >= Len( Trim( oEW:oControl:Caption ) ), Eval( oEW:bOk, 2 ), oEW:oControl:CaretPos++ )
   IF oEW:oControl:Type == 'TEXTPICTURE' .AND. oEW:oControl:DataType == 'N'
      ON KEY LEFT OF ( oEW:oControl ) ACTION iif( oEW:oControl:CaretPos == 0 .OR. Empty( SubStr( oEW:oControl:Caption, 1, oEW:oControl:CaretPos + 1 ) ), Eval( oEW:bOk, 3 ), oEW:oControl:CaretPos-- )
   ELSE
      ON KEY LEFT OF ( oEW:oControl ) ACTION iif( oEW:oControl:CaretPos == 0, Eval( oEW:bOk, 3 ), oEW:oControl:CaretPos-- )
   ENDIF
   ON KEY TAB OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 2 )
   ON KEY SHIFT+TAB OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 3 )
   ON KEY DOWN OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 6 )
   ON KEY PRIOR OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 7 )
   ON KEY NEXT OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 8 )
   ON KEY CTRL+PRIOR OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 17 )
   ON KEY CTRL+NEXT OF ( oEW:oControl ) ACTION Eval( oEW:bOk, 18 )
   DO CASE
   CASE nCol == 2
      ON KEY F2 OF ( oEW:oControl ) ACTION { || Eval( oEW:bOK, -3 ), MyFunc_F2_col2() }
      oLabel:value := 'Press F2 to call MyFunc_F2_col2()'
   CASE nCol == 3
      ON KEY F2 OF ( oEW:oControl ) ACTION { || Eval( oEW:bOK, -3 ), MyFunc_F2_col3() }
      ON KEY F3 OF ( oEW:oControl ) ACTION { || Eval( oEW:bOK, -3 ), MyFunc_F3_col3() }
      oLabel:value := 'Press F2 to call MyFunc_F2_col3() or F3 to call MyFunc_F3_col3()'
   CASE nCol == 5
      ON KEY F2 OF ( oEW:oControl ) ACTION {|| Eval( oEW:bOK, -3 ), MyFunc_F2_col5() }
      oLabel:value := 'Press F2 to call MyFunc_F2_col5()'
   OTHERWISE
      oLabel:Value := 'Press ENTER to edit next cell or ESC to end edition'
   ENDCASE
   oEW:oWindow:OnRelease := { || oLabel:Value := "Press ENTER to edit current cell" }

   RETURN NIL

FUNCTION Start

   oBrw:Value := { dbsample->(RecNo()), 2 }
   oBrw:SetFocus()
   oBrw:Events_Enter()

   RETURN NIL

FUNCTION MyFunc_F2_col2

   MsgInfo( 'This is MyFunc_F2_col2()' )

   RETURN NIL

FUNCTION MyFunc_F2_col3

   MsgInfo( 'This is MyFunc_F2_col3()' )

   RETURN NIL

FUNCTION MyFunc_F3_col3

   MsgInfo( 'This is MyFunc_F3_col3()' )

   RETURN NIL

FUNCTION MyFunc_F2_col5

   MsgInfo( 'My function on F2 for column 5' )

   RETURN NIL

FUNCTION Insert( idx1, idx2, nm, g1, g2, cm, en )

   APPEND BLANK
   REPLACE index1 WITH idx1, index2 WITH idx2, name WITH nm, group1 WITH g1, price WITH g2, comment WITH cm, ean WITH en

   RETURN NIL

FUNCTION AddData

   IF File( 'dbsample.dbf' )
     DELETE FILE dbsample.dbf
   ENDIF

   dbCreate( 'dbsample', { { 'Index1', 'C', 5, 0 }, ;
                           { 'Index2', 'C', 1, 0 }, ;
                           { 'Name', 'C', 30, 0 }, ;
                           { 'Group1', 'C', 2, 0 }, ;
                           { 'Price', 'N', 9, 2 }, ;
                           { 'Comment', 'C', 20, 0 }, ;
                           { 'Ean', 'C', 13, 0 } } )
   USE dbsample
   INDEX ON ( index1 + index2 ) TAG sample01 TO dbsample

   Insert( 'A0014', '2', 'LG 43UK6400', '4K', 125.15, '', '5900446011323' )
   Insert( 'A0003', '1', 'Samsung UE55NU70', '55', 321.30, '', '5904215129660' )
   Insert( 'A0001', '2', 'Samsung UE50NU', '50', 280.10, '???', '5904215129677' )
   Insert( 'A0013', '5', 'Samsung UE55NU60', '55', 490.90, '', '5905256010061' )
   Insert( 'A0012', '5', 'Sony KD55X', '55', 310, '', '5905256010139' )
   Insert( 'A0012', '2', 'Manta 19LHN', '19', 100, '', '5905256010207' )
   Insert( 'A0012', '3', 'Manta LED220Q7', '22', 140, '*', '5905256010252' )
   Insert( 'A0013', '1', 'Lin 24LHDD', '24', 190, '', '5905256020015' )
   Insert( 'A0012', '1', 'Hitachi 24HB4C05', '24', 105, '', '5905256020022' )
   Insert( 'A0011', '2', 'Lin 32LHD1510', '32', 220, '?', '5905256020053' )
   Insert( 'A0011', '1', 'Sharp LC-24CHF4012E', '24', 195, '', '5905256020060' )
   Insert( 'A0011', '3', 'Thomson 22FB3113', '22', 111, '', '5905256020138' )
   Insert( 'A0013', '2', 'Philips 24PFT4022/12N', '24', 142, '?', '5900017355009' )
   Insert( 'A0001', '3', 'Hyundai HLP24T370', '24', 111, '', '5905256030014' )
   Insert( 'A0013', '3', 'Toshiba 32W1733DG', '32', 105, '', '5905256030045' )
   Insert( 'A0010', '4', 'Philips 24PHH4000/88', '24', 220, '', '5905256060011' )
   Insert( 'A0010', '3', 'Sharp LC-24CHG6002E', '24', 199, '', '5905256060035' )
   Insert( 'A0010', '2', 'Hitachi 32HB4T01', '24', 142, '', '5905256060042' )
   Insert( 'A0010', '1', 'Blauberg LFS4005', '40', 111, '', '5905256080040' )
   Insert( 'A0020', '2', 'LG 32LK500B', '32', 155, '', '5905256080064' )
   Insert( 'A0020', '1', 'Lin 43LFHD1800', '43', 112, '', '5905256130035' )
   Insert( 'A0020', '3', 'Samsung UE32J5000', '32', 132, '', '5905256140027' )
   Insert( 'A0013', '4', 'Philips 24PFS5231/12', '24', 109, '', '5905256160032' )
   Insert( 'A0021', '2', 'LG 43UJ6307', '43', 290, '', '5905256280013 ' )
   Insert( 'A0031', '0', 'TCL EP43640', '43', 290, '', '5905256300014 ' )
   Insert( 'A0032', '0', 'TCL EP50640', '50', 300, '', '5905256300115 ' )
   Insert( 'A0033', '0', 'TCL EP55640', '55', 350, '', '5905256300211 ' )
   Insert( 'A0034', '0', 'TCL EP65640', '65', 400, '', '5905256300319 ' )
   Insert( 'A0031', '1', 'TCL EP43660', '43', 310, '', '5905256300514 ' )
   Insert( 'A0032', '1', 'TCL EP50660', '50', 330, '', '5905256300615 ' )
   Insert( 'A0033', '1', 'TCL EP55660', '55', 345, '', '5905256300711 ' )
   Insert( 'A0034', '1', 'TCL EP65660', '65', 400, '', '5905256300819 ' )
   Insert( 'A0031', '2', 'TCL EP43680', '43', 320, '', '5905256300910 ' )
   Insert( 'A0032', '2', 'TCL EP50680', '50', 325, '', '5905256301012 ' )
   Insert( 'A0033', '2', 'TCL EP55680', '55', 333, '', '5905256301113 ' )
   Insert( 'A0034', '2', 'TCL EP65680', '65', 450, '', '5905256301214 ' )

   GO TOP

   RETURN NIL

/*
 * EOF
 */
