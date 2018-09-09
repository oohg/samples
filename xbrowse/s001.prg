/*
 * XBrowse Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use the methods related to
 * the XBrowse's headers.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main()

   PUBLIC oForm, oXBr

   REQUEST DBFCDX

   SET DATE BRITISH
   SET LANGUAGE TO SPANISH

   OpenTable()

   DEFINE WINDOW frm_1 OBJ oForm ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 ;
      HEIGHT 420 ;
      TITLE 'oohg - XBrowse Headers' ;
      MAIN ;
      ON RELEASE CleanUp()

      @ 10, 10 XBROWSE xbr_1 OBJ oXBr ;
         WIDTH 400 ;
         HEIGHT 180 ;
         HEADERS { 'Col.1', 'Col.2', 'Col.3' } ;
         WIDTHS { 50, 150, 150 } ;
         WORKAREA Data ;
         FIELDS { 'code', 'number', 'issued' } ;
         BEFORECOLMOVE { |nCol| BeforeColMove( nCol ) } ;
         AFTERCOLMOVE { |nCol, nPos| AfterColMove( nCol, nPos ) } ;
         BEFORECOLSIZE { |nCol| BeforeColSize( nCol ) } ;
         AFTERCOLSIZE { |nCol, nSize| AfterColSize( nCol, nSize ) } ;
         BEFOREAUTOFIT { |nCol| BeforeAutoFit( nCol ) }

      @ 220, 10 BUTTON btn_GetOrder OBJ oBtn1 ;
         WIDTH 190 ;
         CAPTION "Show columns order" ;
         ACTION oLbl:Value := "Columns order: " + ;
                              AutoType( oXBr:ColumnOrder )

      @ 220, 220 BUTTON btn_SetOrder OBJ oBtn2 ;
         WIDTH 190 ;
         CAPTION "Change columns order" ;
         ACTION ( oXBr:ColumnOrder := { 3, 1, 2 }, ;
                  oLbl:Value := "Columns order: " + ;
                                AutoType( oXBr:ColumnOrder ) )

      @ 260, 10 LABEL lbl_Order OBJ oLbl ;
         WIDTH 400 ;
         VALUE ""

      @ 300, 10 LABEL lbl_Note ;
         WIDTH 400 ;
         HEIGHT 100 ;
         VALUE "Move or change the size of a header, or doubleclic " + ;
               "on a divider. Is not allowed to move column 1, nor " + ;
               "changing it's size (by dragging or by autofit). " + ;
               "The minimun size of columns 2 and 3 must be 50." ;
         FONTCOLOR RED

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenTable()

   LOCAL aDbf1[ 3 ][ 4 ]

   aDbf1[ 1 ][ DBS_NAME ] := "code"
   aDbf1[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 1 ][ DBS_LEN ]  := 10
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "number"
   aDbf1[ 2 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 2 ][ DBS_LEN ]  := 6
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   aDbf1[ 3 ][ DBS_NAME ] := "issued"
   aDbf1[ 3 ][ DBS_TYPE ] := "Date"
   aDbf1[ 3 ][ DBS_LEN ]  := 8
   aDbf1[ 3 ][ DBS_DEC ]  := 0

   dbCreate( "Data", aDbf1, "DBFCDX" )

   SELECT 0
   USE Data VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 9334
   REPLACE issued WITH CTOD( "09/12/1967" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 8765
   REPLACE issued WITH CTOD( "14/03/1961" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 565
   REPLACE issued WITH CTOD( "27/08/1968" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 5433
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 54322
   REPLACE issued WITH CTOD( "31/10/1969" )
   APPEND BLANK
   REPLACE code   WITH 355
   REPLACE number WITH 76865
   REPLACE issued WITH CTOD( "19/09/1966" )
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )
   APPEND BLANK
   REPLACE code   WITH 7
   REPLACE number WITH 5654
   REPLACE issued WITH CTOD( "07/04/1965" )
   APPEND BLANK
   REPLACE code   WITH 123
   REPLACE number WITH 7687
   REPLACE issued WITH CTOD( "22/06/1962" )
   APPEND BLANK
   REPLACE code   WITH 76
   REPLACE number WITH 53377
   REPLACE issued WITH CTOD( "05/02/1963" )

   GO TOP

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  ERASE Data.dbf

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION BeforeColMove( nCol )

   IF nCol == 1
      AutoMsgBox( "Column 1 can't be moved !!!" )
      RETURN .F.
   ENDIF

RETURN .T.

//--------------------------------------------------------------------------//
FUNCTION AfterColMove( nCol, nPosicion )

   AutoMsgBox( "Column " + LTrim( Str( nCol ) ) + ;
               " will be moved to position " + LTrim( Str( nPosicion ) ) )

   oLbl:Value := "Click the button to see the columns order."

RETURN .T.

//--------------------------------------------------------------------------//
FUNCTION BeforeColSize( nCol )

   IF nCol == 1
     // It's not allowed to change the width of column 1
     RETURN .F.
   ENDIF

RETURN .T.

//--------------------------------------------------------------------------//
FUNCTION AfterColSize( nCol, nSize )

   IF nSize < 50
      // Minimun column width is 50.
      RETURN 50
   ENDIF

RETURN nSize

//--------------------------------------------------------------------------//
FUNCTION BeforeAutoFit( nCol )

   IF nCol == 1
     // Autofit of column 1 is not allowed.
     RETURN .F.
   ENDIF

RETURN .T.

/*
 * EOF
 */
