#include <oohg.ch>
#include "SDC_Colores.ch"

Declare Window AbmClie 

*------------------------------------------------------------------------------*
* AbmClie() Administra el padrón de Socios/Clientes                            *
*------------------------------------------------------------------------------*
Procedure AbmClie
If IsWindowActive('AbmClie')
  Restore Window AbmClie ; AbmClie.SetFocus ; Return Nil
EndIf  
Private Ok:=.f., oBaseClie, oQuery
Private bColor  := { |Col, Row, Item| If ( Item[3]='  /  /    ', Nil , GrisClaro ) }
If oServer == Nil
  MsgStop('No hay conexion a MySql!!!','Acceso...') ; Return nil
EndIf
oQuery:=oServer:Query("Select c.NOMBRE, c.CODIGO, c.FECHAEGRE, c.CLIEID From CLIENTES c Order By c.NOMBRE")
If oQuery:NetErr()
	MsgExclamation('Error '+oQuery:Error()+chr(13)+'Actualizando Contenido...','Actualizaciones de Clientes...') ; Return
EndIf  
oBaseClie:=ooSQL():New(oQuery)
Load Window AbmClie ; Center Window AbmClie ; Activate Window AbmClie
Return Nil

*------------------------------------------------------------------------------*
* ArrancoAbmClie() Apago los controles al iniciar el Form.                            *
*------------------------------------------------------------------------------*
Static Function ArrancoAbmClie
AbmClie.Title:='Padrón de Clientes...'
AbmClie.Nuevo.Enabled:=.T. ; AbmClie.Editar.Enabled:=.T.; AbmClie.Grabar.Enabled:=.F.; AbmClie.Cancelar.Enabled:=.F.
AbmClie.Borrar.Enabled:=.T.; AbmClie.Buscar.Enabled:=.T.; AbmClie.Salir.Enabled:=.T.;AbmClie.Text_20.Enabled:=.f.
For nI:=1 to 8 ; SetProperty('AbmClie','Text_'+AllTrim(Str(nI)),'Enabled',.f.) ; Next
For nI:=2 to 8 ; SetProperty('AbmClie','Text_'+AllTrim(Str(nI)),'Value','') ; Next
AbmClie.Text_1.Value:=0 ; AbmClie.Text_9.Value:=CtoD('') ; AbmClie.Text_9.Enabled:=.f. 
AbmClie.Browse_1.Enabled:=.T. ; Navego() ; AbmClie.Browse_1.Refresh ; AbmClie.Browse_1.SetFocus
Return

*------------------------------------------------------------------------------*
* Habilito() Habilito controles para edición.                                  *
*------------------------------------------------------------------------------*
Static Function Habilito
AbmClie.Nuevo.Enabled:=.F.; AbmClie.Editar.Enabled:=.F.; AbmClie.Grabar.Enabled:=.T.; AbmClie.Cancelar.Enabled:=.T.
AbmClie.Borrar.Enabled:=.F.; AbmClie.Buscar.Enabled:=.F.; AbmClie.Salir.Enabled:=.F.
AbmClie.Browse_1.Enabled:=.F.
If Ok  //Es un Alta
  For nI:=1 to 8 ; SetProperty('AbmClie','Text_'+AllTrim(Str(nI)),'Enabled',.t.) ; Next
  AbmClie.Text_9.Enabled:=.t.; AbmClie.Text_1.SetFocus
Else   //Es una Modificación
  For nI:=2 to 8 ; SetProperty('AbmClie','Text_'+AllTrim(Str(nI)),'Enabled',.t.) ; Next
  AbmClie.Text_9.Enabled:=.t. ; AbmClie.Text_2.SetFocus
EndIf	
Return

*------------------------------------------------------------------------------*
* Cancelo() Es llamada por el Boton Cancelar del AbmClie.FMG                   *
*------------------------------------------------------------------------------*
Static Function Cancelo
Ok:=.F. ; ArrancoAbmClie()
Return

*------------------------------------------------------------------------------*
* Edito() Es llamada por el boton Modificar...                                 *
*       Recibe .t. cuando es un Alta                                           *
*              .f. cuando es una Modificación                                  *
*------------------------------------------------------------------------------*
Static Function Edito(Vengo)
Local oQuery, oRow, nNewCod:=0
Ok:=Vengo
If Ok   //Es un Alta
  AbmClie.Title:='Padrón de Clientes...(Nuevo)'
  oQuery:=oServer:Query("Select Max(CODIGO) From CLIENTES")
	If oQuery:NetErr()
		MsgStop('Error '+oQuery:Error()+Chr(13)+'Buscando siguiente Código sugerido...')
	Else
		oRow:=oQuery:GetRow(1) ; nNewCod:=oRow:FieldGet(1)+1
	EndIf
  AbmClie.Text_1.Value:=nNewCod
  For nI:=2 to 8 ; SetProperty('AbmClie','Text_'+AllTrim(Str(nI)),'Value','') ; Next ; AbmClie.Text_3.Value:='S'
  AbmClie.Text_9.Value:=CtoD('')
Else   
  AbmClie.Title:='Padrón de Clientes...(Modificación)'
EndIf
Habilito()
Return

*------------------------------------------------------------------------------*
* Grabo() Grabo los valores del Form en la Tabla, ya sea una Modificación o un *
*        Alta.                                                                 *
*------------------------------------------------------------------------------*
Static Function Grabo
Local cQuery, oQuery, oRow
If !Verificaciones()  //Realiza todas las comprobaciones ANTES de Grabar!
  Return
EndIf
Begin Sequence
	oQuery:=oServer:Query("START TRANSACTION")
	If oQuery:NetErr()												
		MsgStop(oQuery:Error(),'Inicio Transaction...') ; BREAK
	EndIf
	cCampo1:=Str(AbmClie.Text_1.Value) ; cCampo2:=CambioAcentoSQL(,AbmClie.Text_2.Value) ; cCampo3:=AbmClie.Text_3.Value
  cCampo4:=AbmClie.Text_4.Value ; cCampo5:=AbmClie.Text_5.Value ; cCampo6:=AbmClie.Text_6.Value ; cCampo7:=AbmClie.Text_7.Value
	cCampo8:=AbmClie.Text_8.Value ; cCampo9:=d2c(AbmClie.Text_9.Value)
	If Ok   //Es un Alta
		cQuery:="Insert Into CLIENTES (CODIGO,NOMBRE,TIPO,TELEFONO,DIRECCION,LOCALIDAD,DOCUMENTO,NROCUIT,FECHAINGRE) Value ('"+;
             cCampo1+"','"+cCampo2+"','"+cCampo3+"','"+cCampo4+"','"+cCampo5+"','"+cCampo6+"','"+cCampo7+"','"+cCampo8+"','"+cCampo9+"')"
	Else
		cQuery:="Update CLIENTES Set CODIGO='"+cCampo1+"',NOMBRE='"+cCampo2+"',TIPO='"+cCampo3+"',TELEFONO='"+cCampo4+"',DIRECCION='"+cCampo5+;
            "',LOCALIDAD='"+cCampo6+"',DOCUMENTO='"+cCampo7+"',NROCUIT='"+cCampo8+"',FECHAINGRE='"+cCampo9+"' Where CODIGO='"+cCampo1+"'"
	EndIf
	oQuery:=oServer:Query(cQuery)
	If oQuery:NetErr()										
		MsgStop(oQuery:Error(),'Error de Actualización...') ; BREAK
	EndIf
	oQuery:=oServer:Query("COMMIT")
	If oQuery:NetErr()												
		MsgStop(oQuery:Error(),'Error en Commit...') ; BREAK
	EndIf
	Ok:=.F.
  oQuery:=oServer:Query("Select c.NOMBRE, c.CODIGO, c.FECHAEGRE, c.CLIEID From CLIENTES c Order By c.NOMBRE")
  If oQuery:NetErr()
	  MsgExclamation('Error '+oQuery:Error()+chr(13)+'Actualizando Contenido...','Actualizaciones Tabla...') ; BREAK
  EndIf
  nRec:=oBaseClie:Recno()                //Obtengo el Recno() actual
  oBaseClie:oQuery:=oQuery               //Actualizo oBaseClie con el nuevo oQuery -Actualiza automaticamente el WorkArea del xBrowse-
  oQuery:Goto(nRec)                      //Posiciona el Recno() -provoca una actualizacion del xBrowse
  ArrancoAbmClie()
Recover 
	oQuery:=oServer:Query("ROLLBACK")
	If oQuery:NetErr()												
		MsgStop(oQuery:Error(),'Error en RoolBack...')
	EndIf
End
Return

*------------------------------------------------------------------------------*
* Borro() Habilito o NO un Cliente                                             *
*------------------------------------------------------------------------------*
Static Function Borro
Local cQuery,oQuery, cSQL, cTipo:='H'
If oBaseClie:FieldGet('CLIEID')=0    //Si no hay renglon del xBrowse seleccionado...
	Return
EndIf
If DtoC(oBaseClie:FieldGet('FECHAEGRE')) <> DtoC(CtoD('')) //Si el Cliente esta Deshabilitado...
  cTipo:='D' ; cSQL:="Update CLIENTES Set FECHAEGRE='0000-00-00' Where CLIEID='"+Str(oBaseClie:FieldGet('CLIEID'))+"'"
Else
  cSQL:="Update CLIENTES Set FECHAEGRE='"+DtoS(Date())+"' Where CLIEID='"+Str(oBaseClie:FieldGet('CLIEID'))+"'"
EndIf  	
PlayOk()
If cTipo='D'    
  If !MsgYesNo(AllTrim(oBaseClie:FieldGet('NOMBRE'))+' es un Cliente DESHABILITADO!, desea Habilitarlo ???','Habilitar Clientes...') ; Return ; EndIf
ElseIf cTipo='H'
  If !MsgYesNo(AllTrim(oBaseClie:FieldGet('NOMBRE'))+' es un Cliente HABILITADO!, desea DesHabilitarlo ???','Deshabilitar Clientes...') ; Return ; EndIf
EndIf      
Begin Sequence
  oQuery:=oServer:Query("START TRANSACTION")
  If oQuery:NetErr()												
	  MsgStop(oQuery:Error(),'Error de TRANSACTION') ; BREAK
  EndIf
  oQuery:=oServer:Query(cSQL)
 	If oQuery:NetErr()												
 	  Msgstop(oQuery:Error(),'Habilitar/deshabilitar Cliente...') ; BREAK
  EndIf
  oQuery:=oServer:Query("COMMIT")
  If oQuery:NetErr()												
	  Msgstop(oQuery:Error(),'Error en COMMIT') ; BREAK
  EndIf
  oQuery:Destroy()
  oQuery:=oServer:Query("Select c.NOMBRE, c.CODIGO, c.FECHAEGRE, c.CLIEID From CLIENTES c Order By c.NOMBRE")
  If oQuery:NetErr()
    PlayExclamation() ; MsgExclamation('Error'+chr(13)+oQuery:Error(),'Actualizando Clientes...') ; BREAK
  EndIf  
  oBaseClie:oQuery:=oQuery       //Actualizo oBaseClie con el nuevo oQuery -Actualiza automaticamente el WorkArea del xBrowse-
  oQuery:Gotop()                 //Posiciona el Recno() -provoca una actualizacion del xBrowse desde el 1er.registro-
  AbmClie.Browse_1.Refresh
  ArrancoAbmClie()
Recover 
  oQuery:=oServer:Query("ROLLBACK")
  If oQuery:NetErr()												
    Msgstop(oQuery:Error(),'Error en roolback') 
  EndIf
  oQuery:Destroy()
End	
Return

*------------------------------------------------------------------------------*
* Navego() Actualiza el contenido de los TextBox con la Tabla de MySQL         *
*------------------------------------------------------------------------------*
Static Function Navego
Local oQuery, oRow 
If oBaseClie:FieldGet('CLIEID')=0    //Si no hay renglon del xBrowse seleccionado...
	Return
EndIf
oQuery:=oServer:Query("Select * From CLIENTES Where CLIEID='"+Str(oBaseClie:FieldGet('CLIEID'))+"'")
If oQuery:NetErr()
	MsgStop('Error '+oQuery:Error()+Chr(13)+'Buscando Registro...') ;	AbmClie.Text_2.SetFocus ; Return
EndIf
AbmClie.Label_1.Value:=''
If oQuery:LastRec>0
	oRow:=oQuery:GetRow(1)
	AbmClie.Text_1.Value :=oRow:FieldGet('CODIGO')
  AbmClie.Text_2.Value :=oRow:FieldGet('NOMBRE')
  AbmClie.Text_3.Value :=oRow:FieldGet('TIPO')
	AbmClie.Text_4.Value :=oRow:FieldGet('TELEFONO')
  AbmClie.Text_5.Value :=oRow:FieldGet('DIRECCION')
  AbmClie.Text_6.Value :=oRow:FieldGet('LOCALIDAD')
  AbmClie.Text_7.Value :=oRow:FieldGet('DOCUMENTO')
  AbmClie.Text_8.Value :=oRow:FieldGet('NROCUIT')
  AbmClie.Text_9.Value :=CtoD(DtoC(oRow:FieldGet('FECHAINGRE')))
  If DtoC(oQuery:FieldGet('FECHAEGRE')) <> DtoC(CtoD(''))    //Muestro si el Cliente esta Deshabilitado!
    AbmClie.Label_1.Value:='[Deshabilitado]'
  EndIf
EndIf
Return

*------------------------------------------------------------------------------*
* Buscar() Es activado al presionar el Boton Buscar.                           *
*------------------------------------------------------------------------------*
Static Function Buscar 
AbmClie.Text_20.Value:='' ; AbmClie.Text_20.Enabled:=.t. ; AbmClie.Text_20.SetFocus
Return

*------------------------------------------------------------------------------*
* Buscando() Procesa la búsqueda...                                            *
*------------------------------------------------------------------------------*
Static Function Buscando
Local nAncho:=Len(AllTrim(AbmClie.Text_20.value)), lBnd:=.f., nRec:=0
If Empty(AbmClie.Text_20.Value)
	Return
EndIf
nRec:=oBaseClie:Recno()
oBaseClie:GoTop()
Do While !oBaseClie:Eof()
  If SubStr(oBaseClie:FieldGet('NOMBRE'),1,nAncho) == AbmClie.Text_20.Value
    lBnd:=.t. ; Exit
  EndIf
  oBaseClie:Skip()
EndDo
If !lBnd
  PlayExclamation() ; oQuery:Goto(nRec)
EndIf  
Navego()
AbmClie.Browse_1.Refresh
Return
 
*------------------------------------------------------------------------------*
* Salir() Se procesa en el OnEnter de la Búsqueda.                             *
*------------------------------------------------------------------------------*
Static Function Salir
AbmClie.Text_20.Value:='' ; AbmClie.Text_20.Enabled:=.f. ; AbmClie.Browse_1.SetFocus
Return

*------------------------------------------------------------------------------*
* Verificaciones() Realiza TODAS las comprobaciones necesarias antes de Grabar *
*------------------------------------------------------------------------------*
Static Function Verificaciones
Local cTit:='Padrón de Clientes...', cError:='] es Obligatorio!!', oQuery, oRow, cDes, cNewCod
If Empty(AbmClie.Text_1.Value)
  MsgExclamation('El campo [' + AllTrim(AbmClie.Label_01.Value) + cError,cTit) ; AbmClie.Text_1.SetFocus ; Return .f.
EndIf
If Ok   //Es un Alta  
	oQuery:=oServer:Query("Select * from CLIENTES where CODIGO='"+Str(AbmClie.Text_1.Value)+"'")
	If oQuery:NetErr()
		MsgStop('Error '+oQuery:Error()+Chr(13)+'Intentelo nuevamente...') ; AbmClie.Text_1.SetFocus ; Return .f.
	EndIf
	If oQuery:LastRec()>0
		oRow:=oQuery:GetRow(1) ; cDes:=oRow:FieldGet('NOMBRE')
		oQuery:=oServer:Query("Select Max(CODIGO) From CLIENTES")
		If oQuery:NetErr()
  		MsgStop('Error '+oQuery:Error()+Chr(13)+'Buscando siguiente Código...'+Chr(13)+'Intentelo nuevamente...') ; AbmClie.Text_1.SetFocus ; Return .f.
		Else
			oRow:=oQuery:GetRow(1) ; cNewCod:=AllTrim(Str(oRow:FieldGet('CODIGO')+1))
		EndIf
    MsgExclamation('Este Código YA fue asignado a: '+cDes+Chr(13)+'Próximo Código sugerido: '+cNewCod,'Agregar Cliente...') ; AbmClie.Text_1.SetFocus ; Return .f.
	EndIf
EndIf
If Empty(AbmClie.Text_2.Value)
  MsgExclamation('El campo [' + AllTrim(AbmClie.Label_02.Value) + cError,cTit) ; AbmClie.Text_2.SetFocus ; Return .f.
EndIf   
If Empty(AbmClie.Text_3.Value) .or. (AbmClie.Text_3.Value<>'S' .and. AbmClie.Text_3.Value<>'C') 
  MsgExclamation('El campo [' + AllTrim(AbmClie.Label_3.Value)+cError+chr(13)+"Valores válidos 'S' = Socios, 'C' = Clientes",cTit) ; AbmClie.Text_3.SetFocus ; Return .f.
EndIf
Return .t.
