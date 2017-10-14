#include <oohg.ch>

*------------------------------------------------------------------------------*
* ooSQL - Proyecto simple para ver el funcionamiento de la Clase ooSQL con el  *
*         control xBrowse mediante la LIB MySqlLib                             *
*                                                                              *
*  ABM de una consulta a MySql                                                 *
*                                                                              *
* Autor: Sergio D.Castellari (c) 10-2010 - Navarro, Argentina                  *
*        soportesdcgestion@yahoo.com.ar - www.sdcinformatica.com.ar            *
*                                                                              *
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
* Main() Inicio del Sistema!                                                   *
*------------------------------------------------------------------------------*
Function Main
REQUEST HB_LANG_ES
HB_LANGSELECT( "ES" )            //Esta linea con la de arriba declaran el idioma español

Set Century On
Set Epoch To 1960
Set Date To British
Set Multiple Off Warning
Set Navigation Extended
Set ToolTipBalloon On

_OOHG_NestedSameEvent( .T. )  //Esto permite multiples ejecuciones de Procedure o Function

Public oServer:=Nil
Public cNomSistema:="ooSQL - Clase para xBrowse..."
Public cDataBase:= "ooSQL"
Public cUsuario:=''
Public cUsuId:=''
	
Load Window Sistema
Private lMaxi:=.t.     //Maximizar Pantalla principal del Sistema
If !File('Parametros.Ini') ; CrearIniPar() ; EndIf
BEGIN INI FILE "Parametros.Ini"
  GET lMaxi SECTION "General" ENTRY 'Maximizar'
END INI
Center Window Sistema
If lMaxi ; Sistema.Maximize ; EndIf
Activate Window Sistema
Return

*------------------------------------------------------------------------------*
* Arranco() Utilizada por el InitInicio del Sistema!                           *
*------------------------------------------------------------------------------*
Static Function Arranco
Sistema.Label_1.Value:='SDC Soluciones Informáticas' ; Sistema.Label_1.Enabled:=.f.
ImagenSDC()
Sistema.Title:=Sistema.Title+' - '+cNomSistema                 
ConectoMySql()
Return

*------------------------------------------------------------------------------*
* ConectoMySql() Carga los datos de conexión de MySQL a partir de Sistema.Ini  *
*------------------------------------------------------------------------------*
Static Function ConectoMySql
Local aBaseDeDatosExistentes:= {}
Private cHostName:="", cUser:="", cPassWord:=""
If !File('Parametros.Ini') ; CrearIniPar() ; EndIf
BEGIN INI FILE "Parametros.Ini"
   GET cHostName      SECTION "Acceso"     ENTRY 'Host'
   GET cUser          SECTION "Acceso"     ENTRY 'Usuario'
   GET cPassWord      SECTION "Acceso"     ENTRY 'Pass'
END INI
If !Conexion(cHostName, cUser, cPassWord, cDataBase )
	MsgStop('No se pudo conectar con Mysql','Sistema ooSQL')
EndIf
Return

*------------------------------------------------------------------------------*
* Conexion() Realiza la conexión con el Servidor MySQL                         *
*------------------------------------------------------------------------------*
Static Function Conexion(cHostName, cUser, cPassWord, cDataBase )
Local lBnd:=.f.
Sistema.Statusbar.Item(1):="Conectando a "+cHostName
If oServer != Nil                                                               //Verifico si Ya esta conectado
	Sistema.StatusBar.Item(1):="Conectado a Base De Datos" ; Return .t.
EndIf
oServer:=TMySQLServer():New(cHostName, cUser, cPassWord )                       //Abro la conexión con MySQL
Sistema.statusBar.item(1):="Conectando a MySql"
If oServer:NetErr()                                                             //Verifica si ocurrió algún error en la Conexión 
  MsgInfo("Error de Conexión con Servidor " +chr(13)+ oServer:Error(),'Sistema ooSQL')
	oServer:=Nil ; Return .f.
EndIf 
cBaseDeDatos:=Lower(cDataBase)                                                  //Conectado con la Base de Datos
Sistema.Statusbar.Item(1):="Conectando a Base De datos"
If oServer == Nil                                                               //Verifica si se Conectó realmente                       
	MsgInfo("Conexión con MySQL NO fue Iniciada!!",'Sistema ooSQL') 
	Sistema.StatusBar.Item(1):="No Conectado" ; Return Nil 
EndIf
aBaseDeDatosExistentes:=oServer:ListDBs()                                       //Antes de Conectar Verifica si la Base de Datos ya existe
If oServer:NetErr()                                                             //Verifica si ocurrio algun error en Conexión 
  MsgInfo("Error de Conexión con Servidor / <TMySQLServer> " + oServer:Error(),'Sistema ooSQL' )
	Sistema.StatusBar.Item(1):="No Conectado a MySQL" ; oServer:=Nil ; Return .F.
EndIf 
If AScan( aBaseDeDatosExistentes, Lower( cBaseDeDatos ) ) == 0                  //Verifica si en el Array aBaseDeDadosExistentes tiene la Base de Datos
  MsgInfo("Base de Datos "+cBaseDeDatos+" No Existe!!",'Sistema ooSQL')
  If MsgYesNo('Desea Crear la Base MySQL [ooSQL] ???','Atención!!!. Crear Base...')
    If !CreoBase()
      oServer:=Nil ; Return .f.
    Else
      lBnd:=.t.   //Como la Base No existia...la creo...y luego debo crear la Tabla Clientes...    
    EndIf  
  Else
	  oServer:=Nil ; Return .F.
	EndIf
EndIf 
oServer:SelectDB( cBaseDeDatos )
If oServer:NetErr()                                                             //Verifica si ocurrio algun error en Conexión 
  MsgInfo("Error de Conexión con Servidor / <TMySQLServer> " + oServer:Error(),'Sistema ooSQL' )
	oServer:=Nil ; Return .F.
Else
  If lBnd == .t.
    If !CreoTabla()
      oServer:=Nil ; Return .f.
    EndIf
  EndIf
Endif 
Sistema.StatusBar.Item(1):='Conectado como: '+oServer:cUser + "@" + cHostName
Return .T.

*------------------------------------------------------------------------------*
* ImagenSDC() Controla la visualización del logo de SDC Soluciones!            *
*------------------------------------------------------------------------------*
Static Function ImagenSDC 
Local nAlto,nAncho,nAjusAl,nAjusAn,nAltura, nAnchura
nAlto  :=110             //Altura de la Imagen
nAncho :=172             //Anchura de la Imagen
nAjusAl:=90
nAjusAn:=30
IF Sistema.Height-nAlto-nAjusAl<nAlto
  Sistema.Image_1.Visible:=.f.
  Return nil
Else 
  Sistema.Image_1.Visible:=.t.
  nAltura:=Sistema.Height-nAlto-nAjusAl
Endif  
IF Sistema.Width-nAncho-nAjusAn<nAncho
  Sistema.Image_1.Visible:=.f.
  Return nil
Else
  Sistema.Image_1.Visible:=.t.
  nAnchura:=Sistema.Width-nAncho-nAjusAn
EndIf
Modify Control Image_1 of Sistema  ROW nAltura
Modify Control Image_1 of Sistema  COL nAnchura
Modify Control Label_1 of Sistema  ROW Sistema.Height-220
Modify Control Label_1 of Sistema  COL 20
Return nil

*------------------------------------------------------------------------------*
* SalidaSistema() Salida...                                                    *
*------------------------------------------------------------------------------*
Function SalidaSistema
Return

*------------------------------------------------------------------------------*
* CreoBase() Creo la Base de Datos ooSQL                                       *
*------------------------------------------------------------------------------*
Function CreoBase
Local oQuery
oQuery:=oServer:Query("CREATE DATABASE ooSQL")
If oQuery:NetErr()
  MsgExclamation('Error'+chr(13)+oQuery:Error(),'Creando Base...') ; Return .f.
EndIf
Return .t.  

*------------------------------------------------------------------------------*
* CreoTabla() Creo la Tabla Clientes                                           *
*------------------------------------------------------------------------------*
Function CreoTabla
Local oQuery, oQuery1, cQuery
oQuery:=oServer:Query("Drop Table If Exists CLIENTES")
If oQuery:NetErr()
  MsgExclamation('Error'+chr(13)+oQuery:Error(),'Creando Tabla...') ; Return .f.
EndIf
cQuery:="Create Table CLIENTES ("+;
         "CODIGO     Mediumint(5) default 0,"+;
         "TIPO       Char(1)      default 'S',"+;
         "NOMBRE     Char(30)     default '',"+;
         "TELEFONO   Char(15)     default '',"+;
         "DIRECCION  Char(30)     default '',"+;
         "DOCUMENTO  Char(10)     default '',"+;
         "LOCALIDAD  Char(20)     default '',"+;
         "NROCUIT    Char(13)     default '',"+;
         "FECHAINGRE Date         null,"+;
         "FECHAEGRE  Date         null,"+;
         "CLIEID Int(10) unsigned Not Null auto_increment, Primary Key (CLIEID)) ENGINE=InnoDB Default Charset=latin1"
oQuery1:=oServer:Query(cQuery)
If oQuery1:NetErr()
  MsgExclamation('Error'+chr(13)+oQuery1:Error(),'Creando Tabla...') ; Return .f.
EndIf
Return .t.
