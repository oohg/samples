/*
 * Ejemplo Browse n° 7
 * Autor: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenciado bajo The Code Project Open License (CPOL) 1.02
 * Vea <http://www.codeproject.com/info/cpol10.aspx>
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oForm, oBrw, myDbf := "Test1"

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'Browse: cambiar propiedades en forma dinámica' ;
      MAIN ;
      ON INIT AbrirTablas() ;
      ON RELEASE CerrarTablas()

      @ 13, 10 LABEL Lbl_1 ;
         WIDTH 60 ;
         HEIGHT 24 ;
         VALUE "Usar dbf:"

      @ 10, 70 RADIOGROUP Rdg_1 OBJ oDbf ;
         OPTIONS { "Test1", "Test2", "Test3" } ;
         WIDTH 80 ;
         HORIZONTAL ;
         VALUE 1 ;
         ON CHANGE ChangeDbf( oDbf, oBrw, oForm )

      @ 40,10 BROWSE Browse_1 OBJ oBrw ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT oForm:ClientHeight - 60 ;
         SYNCHRONIZED ;
         HEADERS { "Código del Artículo", "Nombre del Artículo"} ;
         WIDTHS { 100, 150 } ;
         WORKAREA (myDbf) ;
         FIELDS { "Code1", "Name1"} ;
         JUSTIFY { BROWSE_JTFY_RIGHT, BROWSE_JTFY_LEFT } ;
         UPDATEALL ;
         DYNAMICBLOCKS

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

RETURN NIL


FUNCTION AbrirTablas()

   LOCAL i

   DBCREATE( "Test1", ;
             { {"Code1", "N", 10, 0}, ;
               {"Name1", "C", 25, 0} } )

   USE Test1 NEW 
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code1 WITH i
      REPLACE Name1 WITH 'Artículo '+ STR( i )
   NEXT i

   GO TOP

   DBCREATE( "Test2", ;
             { {"Code2", "N", 10, 0}, ;
               {"Name2", "C", 25, 0} } )

   USE Test2 NEW 
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code2 WITH i * 2
      REPLACE Name2 WITH 'Proveedor '+ STR( i )
   NEXT i

   GO TOP

   DBCREATE( "Test3", ;
             { {"Code3", "N", 10, 0}, ;
               {"Name3", "C", 25, 0}, ;
               {"Data3", "D",  8, 0} } )

   USE Test3 NEW 
   ZAP

   FOR i := 1 TO 100
      APPEND BLANK
      REPLACE Code3 WITH i * 2 + 1
      REPLACE Name3 WITH 'Cliente '+ STR( i )
      REPLACE Data3 WITH DATE()
   NEXT i

   GO TOP

RETURN NIL


FUNCTION CerrarTablas()

  CLOSE DATABASES

  IF MsgYesNo( "¿ Borrar las tablas ?", "" )
     ERASE Test1.dbf
     ERASE Test2.dbf
     ERASE Test3.dbf
  ENDIF

RETURN NIL


FUNCTION ChangeDbf( oDbf, oBrw, oForm )

   LOCAL aDbfData := ;
         { { "Test1", ;
           { "Código del Artículo", "Nombre del Artículo"}, ;
           { "Code1", "Name1" }, ;
           { 100, 150 }, ;
           { BROWSE_JTFY_RIGHT, ;
             BROWSE_JTFY_LEFT } }, ;
         { "Test2", ;
           { "Código del Proveedor", "Nombre del Proveedor" }, ;
           { "Code2", "Name2" }, ;
           { 120, 170 }, ;
           { BROWSE_JTFY_CENTER, BROWSE_JTFY_RIGHT } }, ;
         { "Test3", ;
           { "Código del Cliente", "Nombre del Cliente", "Último Contacto" }, ;
           { "Code3", "Name3", "Data3" }, ;
           { 120, 170, 90 }, ;
           { BROWSE_JTFY_CENTER, BROWSE_JTFY_RIGHT, BROWSE_JTFY_CENTER } } }

   Do While oBrw:ColumnCount() < LEN( aDbfData[ oDbf:Value ] [ 3 ] )
      // El segundo parámetro no debe ser NIL
      oBrw:AddColumn( NIL, "" )             
   EndDo
   Do While oBrw:ColumnCount() > LEN( aDbfData[ oDbf:Value ] [ 3 ] )
      oBrw:DeleteColumn()
   EndDo

   oBrw:WorkArea := aDbfData[ oDbf:Value ] [ 1 ]
   oBrw:aHeaders := aDbfData[ oDbf:Value ] [ 2 ]
   oBrw:aFields  := aDbfData[ oDbf:Value ] [ 3 ]
   oBrw:aWidths  := aDbfData[ oDbf:Value ] [ 4 ]
   oBrw:aJust    := aDbfData[ oDbf:Value ] [ 5 ]

   oBrw:Value := 1
   oBrw:Refresh()

RETURN NIL

/*
 * EOF
 */
