STATIC oServer, cHostName, cUser, cPassword, cDataBase, lLogin, BasedeDatos,;
    cServidor, cUsuario, cContrasena
*------------------------------------------------------------------------------------------------
#Include "MiniGui.CH"
#Define RCARRO Chr(13)+Chr(10)
*------------------------------------------------------------------------------------------------
Procedure Main
*-------------
Private Grid_1 := "", oTabla := "", estado:=.f., Ok:=.F.
oServer   := Nil
cHostName := "localhost"
cUser     := "root"
cPassWord := "root"
cDataBase := "Test"
lLogin    := .F.
SET NAVIGATION EXTENDED
Conexion()
My_Abre_una_Conexion_con_MySql()
My_Conecta_Base_De_Datos( cDataBase )
oTabla := MySqlQuery()

	DEFINE WINDOW Form_1 AT 0,0 ; 
		WIDTH 600 HEIGHT 430      ;
		TITLE "Prueba de MyGrid"  ;
		MAIN                      ; 
		ON INIT Arranque()        ; 
		ON RELEASE My_Cerrar_Conexion_con_Base_De_Datos() 

    ON KEY ESCAPE ACTION {|| Form_1.Release }
    
    DEFINE STATUSBAR
        STATUSITEM "Prueba de Grid con MySql"
    END STATUSBAR

    Grid_1:=MyGrid():New(80, 10, "Form_1", oTabla, 570, 220, {|| navego()})
    Grid_1:NewColumn("Nombre" , "nom" , 370 )
    Grid_1:NewColumn("Direccion" , "dom", 200 )
    Grid_1:NewColumn("" , "Local", 0 )
    Grid_1:VSpacing := 0
    Grid_1:ShowRecnoNumber := .T.
    Grid_1:ShowNavigate    := .T.
    Grid_1:VALUE:=1
    Grid_1:Show()

    DEFINE TEXTBOX Text_1
        ROW    10
        COL    80
        WIDTH  250
        HEIGHT 24
        FONTNAME "Arial"
        FONTSIZE 9
        UPPERCASE .T.
        VALUE ""
    END TEXTBOX

    DEFINE TEXTBOX Text_2
        ROW    40
        COL    80
        WIDTH  200
        HEIGHT 24
        FONTNAME "Arial"
        FONTSIZE 9
        VALUE ""
    END TEXTBOX

    DEFINE TEXTBOX Text_3
        ROW    40
        COL    380
        WIDTH  200
        HEIGHT 24
        FONTNAME "Arial"
        FONTSIZE 9
        VALUE ""
    END TEXTBOX
			
    DEFINE TEXTBOX Text_4
        ROW    300
        COL    110
        WIDTH  150
        HEIGHT 24
        FONTNAME "Arial"
        FONTSIZE 9
        ONENTER Buscar()
        UPPERCASE .T.
        VALUE ""
    END TEXTBOX
    
    DEFINE LABEL Label_1
        ROW    15
        COL    10
        WIDTH  60
        HEIGHT 15
        VALUE "Nombre"
        FONTNAME "Arial"
        FONTSIZE 9
    END LABEL

    DEFINE LABEL Label_2
        ROW    45
        COL    10
        WIDTH  60
        HEIGHT 15
        VALUE "Domicilio"
        FONTNAME "Arial"
        FONTSIZE 9
    END LABEL

    DEFINE LABEL Label_3
        ROW    45
        COL    310
        WIDTH  60
        HEIGHT 15
        VALUE "Localidad"
        FONTNAME "Arial"
        FONTSIZE 9
    END LABEL
    
    DEFINE LABEL Label_4
        ROW    305
        COL    10
        WIDTH  90
        HEIGHT 15
        VALUE "Buscar Nombre"
        FONTNAME "Arial"
        FONTSIZE 9
    END LABEL

    DEFINE BUTTON Button_1
        ROW    340
        COL    30
        WIDTH  100
        HEIGHT 28
        CAPTION "&Agregar"
        ACTION edito(.t.)
    END BUTTON

    DEFINE BUTTON Button_2
        ROW    340
        COL    140
        WIDTH  100
        HEIGHT 28
        CAPTION "&Modificar"
        ACTION edito(.f.)
    END BUTTON

    DEFINE BUTTON Button_3
        ROW    340
        COL    250
        WIDTH  100
        HEIGHT 28
        CAPTION "Grabar"
        ACTION Grabo()
    END BUTTON

    DEFINE BUTTON Button_4
        ROW    340
        COL    360
        WIDTH  100
        HEIGHT 28
        CAPTION "&Cancelar"
        ACTION arranque()
    END BUTTON

    DEFINE BUTTON Button_5
        ROW    340
        COL    470
        WIDTH  100
        HEIGHT 28
        CAPTION "&Salir"
        ACTION Form_1.RELEASE
    END BUTTON
END WINDOW
estado:=.t.	
CENTER    WINDOW Form_1
ACTIVATE  WINDOW Form_1
Return nil
*------------------------------------------------------------------------------
Function arranque
Form_1.Text_1.VALUE:= Grid_1:acampo[1]
Form_1.Text_2.VALUE:= Grid_1:acampo[2]
Form_1.Text_3.VALUE:= Grid_1:acampo[3]
Form_1.Text_1.readonly:=.t.
Form_1.Text_2.readonly:=.t.
Form_1.Text_3.readonly:=.t.
Form_1.Text_4.readonly:=.f.
Form_1.Button_1.enabled:=.t.
Form_1.Button_2.enabled:=.t.
Form_1.Button_3.enabled:=.f.
Form_1.Button_4.enabled:=.f.
Form_1.Button_5.enabled:=.t.
return
*------------------------------------------------------------------------------
*-Ejecuto el Query
*------------------------------------------------------------------------------
Function MySqlQuery
*------------------
*-Monto un Query con Select
LOCAL oQuery := oServer:Query( "Select * From Test01 order by nom" )

*-Verifico si ocurrio un Error
If oQuery:NetErr()
    Msgstop("Error en el Grid (Select): " + oQuery:Error())
    RELEASE WINDOW ALL
    Quit
Endif

*-Destuyo el Query
//oQuery:Destroy()
Return oQuery


*------------------------------------------------------------------------------
*-Operaciones de Creacion, Apertura de Base de Datos y Tablas
*------------------------------------------------------------------------------
Function Conexion
*----------------
   *---------------------------------------------------------------------------------------
    My_Abre_una_conexion_con_MySql()
    *---------------------------------------------------------------------------------------
    My_Crea_una_Base_De_Datos( "Test" )
    *---------------------------------------------------------------------------------------
    My_Conecta_Base_De_Datos( "Test" )
    *---------------------------------------------------------------------------------------
    My_Crea_Tabla( "Test01" )
    *---------------------------------------------------------------------------------------
    My_Agrega_Registros( "Test01" )
    *---------------------------------------------------------------------------------------
    My_Cerrar_Conexion_con_Base_De_Datos()
    *---------------------------------------------------------------------------------------
Return Nil

*------------------------------------------------------------------------------
*-Abre una conexión
*------------------------------------------------------------------------------
Function  My_Abre_una_conexion_con_MySql
*---------------------------------------
    *-Verifica si no esta ya conectado
    If oServer != Nil
        Return Nil
    Endif

    *-Abre una conexion con MySql
    oServer := TMySQLServer():New(cHostName, cUser, cPassWord )

    *-Verifica si ocurrio un error de conexion
    If oServer:NetErr()
       msgstop("Error de Conexion con Servidor / <TMySQLServer> " + oServer:Error(),"" )
       Release Window ALL
       Quit
    Endif

    *** Obs: a Variável oServer será sempre a referência em todo o sistema para qualquer tipo de operação
Return Nil

*------------------------------------------------------------------------------
*-Crea una Base de Datos
*------------------------------------------------------------------------------
Function  My_Crea_una_Base_De_Datos( cBaseDeDatos )
*-------------------------------------------------
    Local i := 0,;
          BasesDeDatosExistentes := {}
    cBaseDeDatos := Lower(cBaseDeDatos)

    *-Verifico si hay una conexion con MySql
    If oServer == Nil
        MsgInfo("No hay una conexion iniciada con MySql!!!")
        Return Nil
    EndIf

    *-Antes de crear una base de datos, verifico su existencia
    BasesDeDatosExistentes  := oServer:ListDBs()

    *-Verifico si ocurrio algun error
    If oServer:NetErr()
        msgstop("Erro verificando Lista de base de Datos / <TMySQLServer> " + oServer:Error(),"" )
        Release Window ALL
        Quit
    Endif

    *-Busco en el Array BasesDeDatosExistentes
    If AScan( BasesDeDatosExistentes, Lower( cBaseDeDatos ) ) != 0
        //MsgINFO( "Base de Datos "+cBaseDeDatos+" Ya Existe!!")
        Return Nil
    EndIf

    *-Crea una Base de Datos
    oServer:CreateDatabase( cBaseDeDatos )

    *-Verifica si ocurrio algun error
    If oServer:NetErr()
        msgstop("Erro al crear la Base de Datos: "+cBaseDeDatos+" / <TMySQLServer> " + oServer:Error(),"" )
        Release Window ALL
        Quit
    Endif

    ////MsgInfo("Base de Datos << "+cBaseDeDatos+" >> Creada!!!" )
Return Nil

*------------------------------------------------------------------------------
*-Conecta con una Base de Datos
*------------------------------------------------------------------------------
Function My_Conecta_Base_de_Datos( cBaseDeDatos )
*-----------------------------------------------
    Local i := 0,;
          aBaseDeDatosExistentes      := {}
    cBaseDeDatos := Lower(cBaseDeDatos)

    *-Verifica si hay una conexion con MySql
    If oServer == Nil
        MsgInfo("No hay una conexion iniciada con MySql!!")
        Return Nil
    EndIf

    *-Antes de conectar con la Base de Datos, Verifico su Existencia
    aBaseDeDatosExistentes := oServer:ListDBs()

    *-Verifica si ocurrio un error
    If oServer:NetErr()
        msgstop("Error al verificar Lista de base de Datos / <TMySQLServer> " + oServer:Error(),"" )
        Release Window ALL
        Quit
    Endif

    *-Verifica si en el Array aBaseDeDatosExistentes existe la Base de Datos
    If AScan( aBaseDeDatosExistentes, Lower( cBaseDeDatos ) ) == 0
        //MsgINFO( "Base de Datos:"+cBaseDeDatos+" No Existe!!")
        Return Nil
    EndIf

    *-Conecta con la Base de Datos
    oServer:SelectDB( cBaseDeDatos )

    *-Verifica si ocurrio un error
    If oServer:NetErr()
        msgstop("Error Conectando a Base de Datos: "+cBaseDeDatos+" / <TMySQLServer> " + oServer:Error(),"" )
        Release Window ALL
        Quit
    Endif

    ///MsgInfo("Base de Datos << "+cBaseDeDatos+" >> Abierta!!" )
Return Nil

*------------------------------------------------------------------------------
*-Crea una Tabla
*------------------------------------------------------------------------------
Function My_Crea_Tabla( cTabla )
*-------------------------------
    Local i := 0,;
          aTablasExistentes := {},;
          aStruc := {},;
          cQuery := "",;
          oQuery

    /* Usei esta sintaxe porque não consegui criar Tabla com TMySQLServer
       usando a variável Codigo com AutoIncremento */
    *-Estructura de la Base de Datos
    cQuery  := "CREATE TABLE "+;
               cTabla+;
               " ( Cod INTEGER NOT NULL AUTO_INCREMENT ,"+;
               "Nom      VarChar(25) ,"+;
               "Dom      VarChar(25) ,"+;
               "Local    VarChar(25) ,"+;
               "Cp       VarChar(25) ,"+;
               "Te       VarChar(25) ,"+;
               "PRIMARY KEY (Cod) ) "

    *-Verifica si hay una conexion con MySql
    If oServer == Nil
        MsgInfo("No hay una conexion iniciada con MySql!!")
        Return Nil
    EndIf

    /*  Antes de criar Verifica se a Tabla  já existe */
    *-Antes de crear la Tabla, Verifico si ya Existe
    aTablasExistentes  := oServer:ListTables()

     *-Verifico si ocurrio un Error
     If oServer:NetErr()
         msgstop("Error al Verificar la Lista de Tablas / <TMySQLServer> " + oServer:Error(),"" )
         Release Window ALL
         Quit
     Endif

     *-Verifico si en el Array aTablasExistentes existe la Tabla
     If AScan( aTablasExistentes, Lower( cTabla ) ) != 0
         //MsgINFO( "Tabla: "+cTabla+" Ya Existe!!")
         Return Nil
     EndIf

     *-Crea la Tabla
     oQuery := oServer:Query( cQuery )

     *-Verifico si ocurrio un Error
     If oServer:NetErr()
         msgstop("Error al Crear la Tabla: "+cTabla+" / <TMySQLServer> " + oServer:Error(),"" )
         Release Window ALL
         Quit
     Endif

    *-Destruyo el Query
    oQuery:Destroy()
Return Nil

*------------------------------------------------------------------------------
*-Abrego Datos a la Tabla
*------------------------------------------------------------------------------
Function My_Agrega_Registros( cTabla )
*------------------------------------
    LOCAL I := 0
    LOCAL XNOM := "", XDOM := "", XLOCAL := "", XTE := "", xcp := ""
    Local oQuery, cQuery := ""
		* Verifico si ya hay datos cargados
		cquery:="select * From test01"
    oQuery := oServer:Query( cQuery )
    If oServer:NetErr()
      msgstop("Error al Verificar la Tabla "+chr(13)+oServer:Error(),"" )
       Quit
     Endif
		 If oQuery:LastRec()= 0				    
		
	    If ! MsgYesNo( "Agrega Datos aleatorios a la Tabla ??", "Se Agregarán !un millón de registros!!")
  	      Return Nil
    	EndIf
	    MSGBOX("Inicio Operación de agregado de registros")
  	  FOR I := 1 TO 10000
    	    XNOM   := "NOMBRE "+ALLTRIM(str(i))
      	  XDOM   := "Domicilio"+str(i)
        	XLOCAL := "Localidad"+str(i)
	        XTE    := "Teléfono"+str(i)
  	      XCP    := "Código Postal"+str(i)
    	    *-Creo el Query */
      	  cQuery := "INSERT INTO "+;
                 cTabla +" (Nom,Dom,Local,Cp,Te)"+;
                 " VALUES ('"+xNom +"','"+xDom +"','"+xLocal +"','"+xcp+"','"+xTe +"' )"
        *-Ejecuto el Query
        oQuery := oServer:Query(  cQuery )

        *-Verifico si ocurrio un error
        If oServer:NetErr()
            MsgInfo("Error Ejecutando la Consulta <<<  "+cQuery+" / <TMySQLServer> " + RCARRO + oServer:Error(),"" )
            *-EXIT
        Endif

        oQuery:Destroy()
    	NEXT
    	MsgInfo( StrZero( I-1 , 6 )+"  Registros ngresados a la Tabla "+cTabla+" !!")
    ENDIF	
Return Nil
*------------------------------------------------------------------------------
*-Cierro la Conexion
*------------------------------------------------------------------------------
Function My_Cerrar_Conexion_con_Base_De_Datos
*--------------------------------------------
    if oServer != Nil
       oServer:Destroy()
       oServer := Nil
    EndIf
Return Nil
*--------------------------*
function navego
if estado
	Form_1.text_1.value:=Grid_1:acampo[1]
	Form_1.text_2.value:=Grid_1:acampo[2]
	Form_1.text_3.value:=Grid_1:acampo[3]
endif	
return
*--------------------------*
function Buscar()
grid_1:MySeek(1,Form_1.text_4.value,oTabla)
Form_1.text_4.setfocus
RETURN
*--------------------------*
function edito(traigo)
Ok:=traigo
if ok
	Form_1.text_1.value:=""
	Form_1.text_2.value:=""
	Form_1.text_3.value:=""
endif
Form_1.Text_1.readonly:=.f.
Form_1.Text_2.readonly:=.f.
Form_1.Text_3.readonly:=.f.
Form_1.Text_4.readonly:=.t.
Form_1.Button_1.enabled:=.f.
Form_1.Button_2.enabled:=.f.
Form_1.Button_3.enabled:=.t.
Form_1.Button_4.enabled:=.t.
Form_1.Button_5.enabled:=.f.
Form_1.Text_1.setfocus
return
*--------------------------*
function Grabo()
Local oRow :={},oQuery:= "",cQuery:= ""

BEGIN SEQUENCE
	cQuery := "START TRANSACTION"
	oQuery	:= oServer:Query( cQuery )
	If oQuery:NetErr()												
		Msgstop(oQuery:Error(),'Error de TRANSACTION')
		BREAK
	EndIf
	Nomb=Form_1.text_1.value
	dire=Form_1.text_2.value
	loca=Form_1.text_3.value
	if Ok
		cQuery := "INSERT INTO Test01 (nom,dom,local) VALUES ( '"+nomb+"','"+dire+"','"+loca+"')"
	else
		clave:=grid_1:aCampo[1]
		cQuery := "UPDATE Test01 SET  nom='"+nomb+"',dom='"+dire+"',local='"+;
			loca+"' WHERE nom='"+clave+"'" 
	endif

	oQuery	:= oServer:Query( cQuery )
	If oQuery:NetErr()												
		Msgstop('Error en Grabacion'+chr(13)+oQuery:Error(),'Rangofecha 1')
	EndIf
	
  cQuery := "COMMIT"
	oQuery	:= oServer:Query( cQuery)
	If oQuery:NetErr()												
		Msgstop(oQuery:Error(),'Error en COMMIT')
		BREAK
	EndIf
	
  RECOVER 
	cQuery := "ROLLBACK"
	oQuery	:= oServer:Query( cQuery )
	If oQuery:NetErr()												
			Msgstop(oQuery:Error(),'Error en roolback')
			return
	EndIf
end

/*AL trabajar Directamente sobre un select hay que generar uno para refrescar */
	otabla:=''
	oTabla := MySqlQuery()
	GRID_1:WorkArea := oTabla
if Ok
	/* Si es un registro nuevo hacemos un seek*/
		
	grid_1:mySeek(1,Form_1.text_1.value,otabla)
	Form_1.text_1.setfocus
	
else
	/* Si es una modicficacion hacemos un refresh*/
	Grid_1:Refresh(oTabla)
endif
oQuery:Destroy()
arranque()
return

