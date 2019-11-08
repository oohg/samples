#include "common.ch"
#define CRLF Hb_OSNewLine()

/* ayuda de SudipB sudipb001@gmail.com
*/

// XL Tokens
#define      XL_DIM        0
#define      XL_BOF        9
#define      XL_EOF        10
#define      XL_DOCUMENT   16
#define      XL_FORMAT     30
#define      XL_BUILTINFMTCOUNT  31     
#define      XL_COLWIDTH   36
#define      XL_FONT       49

// XL Cell Types
#define      XL_INTEGER    2
#define      XL_DOUBLE     3
#define      XL_STRING     4

// XL Cell Formats
#define      XL_INTFORMAT  129
#define      XL_DBLFORMAT  130
#define      XL_XDTFORMAT  131
#define      XL_DTEFORMAT  132
#define      XL_TMEFORMAT  133
#define      XL_HEADBOLD   64
#define      XL_HEADSHADE  248 
      

//----------------------------------------------------------------------------
FUNCTION GrabarXLS (nXls, nFila, aDatos)
//----------------------------------------------------------------------------
/* Funcion que graba una linea de datos en un archivo xls
Los datos vienen en un array

Voy a usar la funcion biffrec usada en el tsbrowse
*/
LOCAL i
Set(_SET_DATEFORMAT,'mm/dd/yy')

for i:= 1 to LEN(aDatos)
   xlsEscribir( nXls, nFila, i, aDatos[i] )      
next
Set(_SET_DATEFORMAT,'dd/mm/yy')
RETURN nil


/*
Funciones para escribir y guardar en un XLS. Compatible formato Biff 2.0
Ideas sacadas de la clase tsbrowse de la minigui extended
*/

//----------------------------------------------------------------------------
FUNCTION xlsAbrir(cFile, cTitle, nLine)
//----------------------------------------------------------------------------
LOCAL nHandle:= 0

DEFAULT nLine TO 0

If ( nHandle := FCreate( cFile, 0 ) ) < 0
   MsgStop( "ERROR: No se puede crear el archivo XLS: "+cfile, 23 )
else
   FWrite( nHandle, BiffRec( XL_BOF ) )
   
   // set CodePage
   FWrite( nHandle, BiffRec( 66, GetACP() ) )
   FWrite( nHandle, BiffRec( 12 ) )
   FWrite( nHandle, BiffRec( 13 ) )
   
   If ! Empty( cTitle )
      cTitle := StrTran( cTitle, CRLF, Chr( 10 ) )
      nAlign := If( Chr( 10 ) $ cTitle, 5, 1 )
      FWrite( nHandle, BiffRec( XL_STRING, cTitle, nLine, 0,, nAlign,, ) )
   EndIf
endif
RETURN nHandle


//----------------------------------------------------------------------------
FUNCTION xlsCerrar(nHandle)
//----------------------------------------------------------------------------
   FWrite( nHandle, BiffRec( XL_EOF ) )
   FClose( nHandle )
RETURN nil


//----------------------------------------------------------------------------
FUNCTION xlsEscribir (nHandle, nLine, nCol, uData)
//----------------------------------------------------------------------------
// fuente
// FWrite( nHandle, BiffRec( 49, aFont[ nCol ] ) )
LOCAL nAlign


DO CASE
   CASE ValType( uData ) == "N"
         nAlign:= 3

         //FWrite( nHandle, BiffRec( 31, 1 ) )    // OJO, no funciona
         //FWrite( nHandle, BiffRec( XL_FORMAT, "########0.00"  ) )

         FWrite( nHandle, BiffRec( XL_DOUBLE, uData, nLine - 1, nCol - 1, , nAlign , 14, ) )

   CASE ValType( uData ) == "D"
         uData := ExcelDate(uData)  // convierto al nro corresp a esa fecha
         nAlign:= 1

         //FWrite( nHandle, BiffRec( 31, 1 ) )   // OJO, no funciona
         //FWrite( nHandle, BiffRec( XL_FORMAT, "dd-mm-yyyy"  ) )

         FWrite( nHandle, BiffRec( XL_INTEGER, uData, nLine - 1, nCol - 1, , nAlign, 10 ,  ) )
  
   OTHERWISE
         uData := Trim( StrTran( HB_VALTOSTR( uData ), CRLF, Chr( 10 ) ) )
         //uData := Trim( StrTran( cValToChar( uData ), CRLF, Chr( 10 ) ) )
            
         nAlign:= If( Chr( 10 ) $ uData, 4, 1 )
         FWrite( nHandle, BiffRec( XL_STRING, uData, nLine - 1, nCol - 1, , nAlign, , ) )
ENDCASE

RETURN nil



//----------------------------------------------------------------------------
FUNCTION ExcelDate( dDate )
//----------------------------------------------------------------------------
RETURN dDate - ctod('12/31/1899') + 1


/// FUNCIONES USADAS EN EL TSBROWSE DE la minigui extended para exportar a excel
* ============================================================================
* FUNCTION BiffRec() Version 9.0 Nov/01/2009
* Excel BIFF record wrappers (Biff2)
* ============================================================================
/* 
nAlign: 
0 General
1 Left
2 Centred
3 Right
4 Filled
5 Justified (BIFF4-BIFF8)
6 Centred across selection (BIFF4-BIFF8)
7 Distributed (BIFF8, available in Excel 10.0 (Excel XP) and later only)
*/
Function BiffRec( nOpCode, uData, nRow, nCol, lBorder, nAlign, nPic, nFont )
   Local cHead, cBody, aAttr[ 3 ]
   
   DEFAULT lBorder TO .f.
   DEFAULT nAlign TO 1
   DEFAULT nPic to 0
   DEFAULT nFont TO 0
           
   aAttr[ 1 ] := Chr( 64 )
   aAttr[ 2 ] := Chr( ( ( 2 ** 6 ) * nFont ) + nPic )
   aAttr[ 3 ] := Chr( If( lBorder, 120, 0 ) + nAlign )
   
   Do Case  // in order of apearence
      Case nOpCode == 9 // BOF record
         cHead := I2Bin( 9 ) + ; // opCode
                  I2Bin( 4 )     // body length
         cBody := I2Bin( 2 ) + ; // excel version
                  I2Bin( 16 )    // file type (10h = worksheet)
      Case nOpCode == 12 // 0Ch CALCCOUNT record
         cHead := I2Bin( 12 ) + ; // opCode
                  I2Bin( 2 )      // body length
         cBody := I2Bin( uData )  // iteration count
      Case nOpCode == 13 // 0Dh CALCMODE record
         cHead := I2Bin( 13 ) + ; // opCode
                  I2Bin( 2 )      // body length
         cBody := I2Bin( uData )  // calculation mode
      Case nOpCode == 66 // 42h CODEPAGE record
         cHead := I2Bin( 66 ) + ; // opCode
                  I2Bin( 2 )      // body length
         cBody := I2Bin( uData )  // codepage identifier
      Case nOpCode == 49 // 31h FONT record
         cHead := I2Bin( 49 ) + ; // opCode
                  I2Bin( 5 + Len( uData[ 1 ] ) ) // body length
         cBody := I2Bin( uData[ 2 ] * 20 ) + ;   // font height in 1/20ths of a point
                  I2Bin( nOr( If( uData[ 3 ], 1, 0 ), ; // lBold    //JP nOr
                            If( uData[ 4 ], 2, 0 ), ;   // lItalic
                            If( uData[ 5 ], 4, 0 ), ;   // lUnderline
                            If( uData[ 6 ], 8, 0 ) ) ) + ;  // lStrikeout
                  Chr( Len( uData[ 1 ] ) ) + ;          // length of cFaceName
                  uData[ 1 ]                            // cFaceName
      Case nOpCode == 20 // 14h HEADER record
         cHead := I2Bin( 20 ) + ; // opCode
                  I2Bin( 1 + Len( uData ) ) // body length
         cBody := Chr( Len( uData ) ) + ;
                  uData
      Case nOpCode == 21 // 15h FOOTER record
         cHead := I2Bin( 21 ) + ; // opCode
                  I2Bin( 1 + Len( uData ) ) // body length
         cBody := Chr( Len( uData ) ) + ;
                  uData
      Case nOpCode == 36 // 24h COLWIDTH record
         //Default nCol := nRow
         DEFAULT nCol TO nRow
         cHead := I2Bin( 36 ) + ;       // opCode
                  I2Bin( 4 )            // body length
         cBody := Chr( nRow ) + ;       // first column
                  Chr( nCol ) + ;       // last column
                  I2BIN( uData * 256 )  // column width in 1/256ths of a character
      Case nOpCode == 31 // 1Fh FORMATCOUNT record
         cHead := I2Bin( 31 ) + ; // opCode
                  I2Bin( 2 )      // body length
         cBody := I2BIN( uData )  // number of standard format records in file
      Case nOpCode == 30 // 1Eh FORMAT record
         cHead := I2Bin( 30 ) + ; // opCode
                  I2Bin( 1 + Len( uData ) ) // body length
         cBody := Chr( Len( uData ) ) + ;   // length of format string
                  uData                     // format string
      Case nOpCode == 4 // 04h LABEL record
         uData := SubStr( uData, 1, Min( 255, Len( uData ) ) )
         cHead := I2Bin( 4 ) + ; // opCode
                  I2Bin( 8 + Len( uData ) ) // body length
         cBody := I2Bin( nRow ) + ; // row number 0 based
                  I2Bin( nCol ) + ; // col number 0 based
                  aAttr[ 1 ]    + ;
                  aAttr[ 2 ]    + ;
                  aAttr[ 3 ]    + ;
                  Chr( Len( uData ) ) + ;
                  uData
      Case nOpCode == 2 // 02h INTEGER record
         cHead := I2Bin( 2 ) + ; // opCode
                  I2Bin( 9 )     // body length
         cBody := I2Bin( nRow ) + ;
                  I2Bin( nCol ) + ;
                  aAttr[ 1 ]    + ;
                  aAttr[ 2 ]    + ;
                  aAttr[ 3 ]    + ;
                  I2Bin( Int( uData ) )
      Case nOpCode == 3 // NUMBER record
         cHead := I2Bin( 3 ) + ; // opCode
                  I2Bin( 15 )    // body length
         cBody := I2Bin( nRow ) + ;
                  I2Bin( nCol ) + ;
                  aAttr[ 1 ]    + ;
                  aAttr[ 2 ]    + ;
                  aAttr[ 3 ]    + ;
                  FTOC( uData )             //D2Bin( uData )
      Case nOpCode == 10 // 0Ah EOF record
         cHead := I2Bin( 10 ) + ; // opcode
                  I2Bin( 0 )      // body length
         cBody := ""
   End Case
Return cHead + cBody



* ============================================================================
Function cValToChar(xValue)
* ============================================================================
   LOCAL cType := ValType( xValue )
   LOCAL cValue := "", nDecimals
   if cType == 'N'
        if xValue == int(xValue)
           nDecimals := 0
        else
           nDecimals := Set( _SET_DECIMALS)
        endif
   endif
   DO CASE
      CASE cType $  "CM";  cValue := xValue
      CASE cType == "N" ;  cValue := LTrim( Str( xValue, 20, nDecimals ) )
      CASE cType == "D" ;  cValue := DToC( xValue )
      CASE cType == "L" ;  cValue := IIf( xValue, "T", "F" )
      CASE cType == "A" ;  cValue := AToC( xValue )
      CASE cType $  "UE";  cValue := ""
      CASE cType == "B" ;  cValue := "{|| ... }"
      CASE cType == "O" ;  cValue := "{" + xValue:className + "}"
   ENDCASE
RETURN cValue


#pragma BEGINDUMP

#include "oohg.h"

HB_FUNC( GETACP )
{
   hb_retni( ( int ) GetACP() );
}

HB_FUNC( NOR )
{
   int   p = hb_pcount();
   int   n, ret = 0;

   for( n = 1; n <= p; n++ )
   {
      ret = ret | hb_parni( n );
   }

   hb_retni( ret );
}

#pragma ENDDUMP
