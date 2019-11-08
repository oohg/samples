#include <oohg.ch>
#include "SDC_Colores.ch"

#include "hbclass.ch"
*------------------------------------------------------------------------------*
* ooSQL() Clase creada por Vicente Guerra para administrar Consultas a MySQL() *
*        a traves del xBrowse, a pedido de Sergio Castellari                   *
*----------------------------------------------------------------- 20-02-2010 -*
CLASS ooSql
  *Methods always used by XBrowse
  METHOD Skipper
  METHOD GoTop              INLINE ::oQuery:GoTop()
  METHOD GoBottom           INLINE ::oQuery:GoBottom()

  *Methods used by XBrowse if you'll have a scrollbar
  METHOD RecNo              INLINE ::oQuery:RecNo()
  METHOD RecCount           INLINE ::oQuery:LastRec()
  METHOD GoTo( n )          BLOCK { | Self, n | ::oQuery:Goto( n ) }
  METHOD OrdKeyNo           INLINE ::oQuery:RecNo()
  METHOD OrdKeyCount        INLINE ::oQuery:LastRec()     //::oQuery:RecCount()
  METHOD OrdKeyGoTo( n )    BLOCK { | Self, n | ::oQuery:Goto( n ) }

  *Methods used by XBrowse if you'll allow edition
  DATA cAlias__             INIT nil
  METHOD Eof                INLINE ::oQuery:Eof()

  *Used by "own" class (not used by XBrowse itself)
  DATA oQuery
  METHOD New( oQuery )      BLOCK { | Self, oQuery | ::oQuery := oQuery , Self }
  METHOD Refresh            INLINE ::oQuery:Refresh()
  METHOD FieldGet( nPos )   BLOCK { | Self, nPos | ::oQuery:FieldGet( nPos ) }
  METHOD FieldPut( p, u )   BLOCK { | Self, p, u | ::oQuery:FieldPut( p, u ) }
  METHOD Use( oQuery )      BLOCK { | Self, oQuery | ::oQuery := oQuery , Self }
  METHOD Skip( n )          BLOCK { | Self, n | ::oQuery:Skip( n ) }
  METHOD Bof                INLINE ::oQuery:Bof()
  METHOD Field( n )         BLOCK { | Self, n | ::oQuery:FieldName( n ) }
  METHOD FieldName( n )     BLOCK { | Self, n | ::oQuery:FieldName( n ) }
  METHOD FieldPos( c )      BLOCK { | Self, c | ::oQuery:FieldPos( c ) }
  METHOD GetRow( n )        BLOCK { | Self, n | ::oQuery:GetRow( n ) }
  METHOD FieldBlock

  ERROR HANDLER FieldAssign
ENDCLASS

*------------------------------------------------------------------------------*
* Metodo Skipper() Avanza o Retrocede un registro                              * 
*----------------------------------------------------------------- 20-02-2010 -*
METHOD Skipper( nSkip ) CLASS ooSql
LOCAL nCount:=0
nSkip := INT( nSkip )
IF nSkip > 0
  DO WHILE nSkip > 0
    ::Skip( 1 )
    IF ::Eof
      ::Skip( -1 )
      EXIT
    ENDIF
    nCount++
    nSkip--
  ENDDO
ELSE
  DO WHILE nSkip < 0
    ::Skip( -1 )
    IF ::Bof
      EXIT
    ENDIF
    nCount--
    nSkip++
  ENDDO
ENDIF
RETURN nCount

*------------------------------------------------------------------------------*
* Metodo FieldBlock() Procesa un bloque de código.                             * 
*----------------------------------------------------------------- 20-02-2010 -*
METHOD FieldBlock( nPos ) CLASS ooSql
RETURN { | _x_ | IF( PCOUNT() > 0 , ::oQuery:FieldPut( nPos, _x_ ) , ::oQuery:FieldGet( nPos ) ) }

*------------------------------------------------------------------------------*
* Metodo FieldAssign() ???                                                     * 
*----------------------------------------------------------------- 01-03-2010 -*
METHOD FieldAssign( xValue ) CLASS ooSql
LOCAL nPos, cMessage, uRet, lError
  cMessage := ALLTRIM( UPPER( __GetMessage() ) )
  lError := .T.
  IF PCOUNT() == 0
    nPos := ::oQuery:FieldPos( cMessage )
    IF nPos > 0
      uRet := ::oQuery:FieldGet( nPos )
      lError := .F.
    ENDIF
  ELSEIF PCOUNT() == 1
    nPos := ::oQuery:FieldPos( SUBSTR( cMessage, 2 ) )
    IF nPos > 0
      uRet := ::oQuery:FieldPut( nPos, xValue )
      lError := .F.
    ENDIF
  ENDIF
  IF lError
    uRet := NIL
    ::MsgNotFound( cMessage )
  ENDIF
RETURN uRet

*------------------------------------------------------------------------------*
* CambioBarritaSQL() Permite cambiar las barras '\' por '/' para poder ser     *
*                    grabadas en MySql y al reves para leerlas.                *
*          Recibe: nTipo = 0  ---> Invierte \ por /  -por defecto-             * 
*                        = 1  ---> Invierte / por \                            *
*                 cTexto = String a convertir                                  *
*----------------------------------------------------------------- 11-03-2010 -*
Function CambioBarritaSQL(nTipo,cTexto)
Default nTipo TO 0
If nTipo==0         //Convierto  '\' por '/'
  Return StrTran(cTexto,'\','/')
ElseIf nTipo==1     //Convierto  '/' por '\'
  Return StrTran(cTexto,'/','\')
EndIf

*------------------------------------------------------------------------------*
* CambioAcentoSQL()  Permite cambiar las barras ' por ´     para poder ser     *
*                    grabadas en MySql y al reves para leerlas.                *
*          Recibe: nTipo = 0  ---> Invierte ' por ´  -por defecto-             * 
*                        = 1  ---> Invierte ´ por '                            *
*                 cTexto = String a convertir                                  *
*----------------------------------------------------------------- 19-03-2010 -*
Function CambioAcentoSQL(nTipo,cTexto)
Default nTipo TO 0
If nTipo==0
  Return StrTran(cTexto,"'",'´')
ElseIf nTipo==1
  Return StrTran(cTexto,'´',"'")
EndIf

*------------------------------------------------------------------------------*
* d2c() Convierte campos de tipo Fecha en cDate (texto) para almacenar en la   *
*       base de datos MySQL. Si es vacía, almacena 0000-00-00.                 *
*------------------------------------------------------------------------------*
Function d2c( _date )
Local cRet:='0000-00-00'
If !Empty(_date)
  cRet:=Str(Year(_date),4)+"-"+StrZero(Month(_date),2)+"-"+StrZero(Day(_date),2)
EndIf
Return cRet

*------------------------------------------------------------------------------*
* URLInternet() Llama al Internet Explorer con una URL                         *
*       Recibe: cURL ---> Sitio web                                            *
*------------------------------------------------------------------------------*
Function URLInternet(cURL)
ShellExecute( 0, "open", "rundll32.exe", "url.dll,FileProtocolHandler " + cUrl, , 1 ) 
Return

*------------------------------------------------------------------------------*
* VeoAyuda() Llamo a la Ayuda del Sistema                                      *
*       Recibe: cArchivo ---> Archivo a ejecutarse                             *
*------------------------------------------------------------------------------*
Function VeoAyuda(cArchivo)
Execute File cArchivo
Return
