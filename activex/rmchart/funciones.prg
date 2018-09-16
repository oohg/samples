#include <minigui.ch>
* Realizado por Gustavo Asborno

#define clrBack     {255,255,200}
#define clrNormal   {255,255,255}
*----------------------------------------------------------------------------*
Function PrimerDia(Arg1)
   Arg1:= IIf(Arg1 == Nil, Date(), Arg1)
   Return Arg1 - (Day(Arg1) - 1)
*----------------------------------------------------------------------------*
Function UltimoDia(Arg1)
Arg1:= IIf(Arg1 == Nil, Date(), Arg1)
Return (Arg1:= Arg1 + (45 - Day(Arg1))) - Day(Arg1)

*------------------------------------------------------------------------------*
/* Function ABRIRBASE(Arg1, Arg2, Arg3, Arg4, Arg5)
	Arg1 Nombre de la dbf a abrir
	Arg2 modo de Apertura .t.=shared / .f.=exclusiva
	Arg3 Tiempo de apertura ej 5 son 5 segundos
	Arg4 Muestra Mensaje .t.=Si / .f.=No  (por defecto es .t.)
	Arg5 Nombre del Alias (Por defecto es el mismo que la DBF)
	
	Si se puede abrir la base de datos la funcion devuelve .t.
*/
*-------------------------------------------------------- Versión:30-10-2008 --*
Function AbrirBase(Arg1, Arg2, Arg3, Arg4, Arg5)
DEFAULT Arg4 TO .t.
DEFAULT Arg5 TO Arg1
sigue:= Arg3 
Do While (sigue=0 .OR. Arg3 > 0)
   dbusearea(.T., "DBFCDX", Arg1, Arg5 ,Arg2,)  
   scroll(5, 1, 5, 78)
   SetPos(5, 1)
   If (!neterr())
      Return .T.
   ELSE
      InKey(.5)
      Arg3:= Arg3 - 1
      If (Arg3 == 0)
         If Arg4=.t.
            MSGSTOP('No se puede abrir '+ALLTRIM(Arg1),'Apertura de Tablas...')
         ENDIF   
         Return .F.
      EndIf
   ENDIF
EndDo

*----------------------------------------------------------------------------*
FUNCTION vercod
If univel>=nivope
  retu .t.
else
  retu .f.
endif
*----------------------------------------------------------------------------*
Function BloquearRegistro(area)
Local RetVal

  If &area->(RLock())
		RetVal := .t.
	Else
    MsgExclamation ('El Registro Esta Siendo Editado Por Otro Usuario'+CHR(13)+'Reintente Mas Tarde')
		RetVal := .f.
	EndIf

Return RetVal
*----------------------------------------------------------------------------*
Function ValiCUIT
PARA PAR
If len(par)=11
  *XPAR=LEFT(PAR,2)+SUBS(PAR,4,8)+RIGHT(PAR,1)
  *V_NUMERO=VAL(XPAR)
  V_NUMERO=VAL(PAR)
  SUMA=5*VAL(SUBS(STR(V_NUMERO,11),1,1))
  SUMA=SUMA+4*VAL(SUBS(STR(V_NUMERO,11),2,1))
  SUMA=SUMA+3*VAL(SUBS(STR(V_NUMERO,11),3,1))
  SUMA=SUMA+2*VAL(SUBS(STR(V_NUMERO,11),4,1))
  SUMA=SUMA+7*VAL(SUBS(STR(V_NUMERO,11),5,1))
  SUMA=SUMA+6*VAL(SUBS(STR(V_NUMERO,11),6,1))
  SUMA=SUMA+5*VAL(SUBS(STR(V_NUMERO,11),7,1))
  SUMA=SUMA+4*VAL(SUBS(STR(V_NUMERO,11),8,1))
  SUMA=SUMA+3*VAL(SUBS(STR(V_NUMERO,11),9,1))
  SUMA=SUMA+2*VAL(SUBS(STR(V_NUMERO,11),10,1))
  RESTO=MOD(SUMA,11)  
  DIGITO=11-RESTO
  IF DIGITO<>VAL(SUBS(STR(V_NUMERO,11),11,1)) .AND.;
    VAL(SUBS(STR(V_NUMERO,11),11,1))<>0
    MSGINFO("CUIT NO VALIDO")
    RETU .F.
  ENDI
Endif
RETU .T.
*----------------------------------------------------------------------------*
Function BloqueoRegistro(cArea)
	 Do While ! (cArea)->(RLock())
      If ! MSGRetryCancel("Registro en Uso en la Red ","Caja")
	       Return .F.
	    EndIf
	 EndDo
	 Return .T.
*----------------------------------------------------------------------------*
FUNCTION ControlCaja
SELECT "CAJA"
CAJA->(DBGOBOTTOM())
REY=RECNO()
IF REY=1
  CAJA->FECHA:=DATE()
ENDIF
*----------------------------------------------------------------------------*
FUNCTION CerraTabla
CLOSE DATA
RETURN
*----------------------------------------------------------------------------*
FUNCTION PasoSector(cSECTOR)
SELE AREAS
GO TOP
DO WHIL .NOT. EOF()
  IF SITIO=cSECTOR
    IF NIVEL=0
      RETU(.T.)
    ENDI
    IF nivope<=NIVEL
      RETU(.T.)
    ELSE
      RETU(.F.)
    ENDIF
  ENDIF
  SKIP
ENDD
RETU(.F.)

*---------------------------------------------------------------------------------*
* HabilitoUsu() LLamada por ControlPas() para Habilitar/Deshabilitar las opciones *
*               de Menu disponibles para el Usuario que Ingresa                   *   
*---------------------------------------------------------------------------------*
Function HabilitoUsu()
declare window sistema
TEXTO=''
BEGIN INI FILE "Sistema.Ini"
   GET TEXTO SECTION "General" ENTRY 'Usuario'
END INI

select permiso
go top
do whil .not. eof()
   IF ALLTRIM(USUARIO)=TEXTO
      if alltrim(el_item)=='Factu1'
         IF PERMISO
            SISTEMA.Factu1.ENABLED:=.T.
         ENDIF
      elseIF alltrim(el_item)== 'Factu2'
         IF PERMISO
            SISTEMA.Factu2.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu3'
         IF PERMISO
            SISTEMA.Factu3.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu4'
         IF PERMISO
            SISTEMA.Factu4.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu5'
         IF PERMISO
            SISTEMA.FACTU5.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja1'
         IF PERMISO
            SISTEMA.Caja1.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja2'
         IF PERMISO
            SISTEMA.Caja2.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja3'
         IF PERMISO
            SISTEMA.Caja3.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'pfactu1'
         IF PERMISO
            SISTEMA.pfactu1.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'dato1'
         IF PERMISO
            SISTEMA.dato1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato2'
         IF PERMISO
            SISTEMA.dato2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato3'
         IF PERMISO
            SISTEMA.dato3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato6'
         IF PERMISO
            SISTEMA.dato6.ENABLED:=.T.
         ENDIF	
      ELSEIF alltrim(el_item)== 'Stock1'
         IF PERMISO
            SISTEMA.Stock1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'Stock2'
         IF PERMISO
            SISTEMA.Stock2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'Stock3'
         IF PERMISO
            SISTEMA.Stock3.ENABLED:=.T.
         ENDIF	
      ELSEIF alltrim(el_item)== 'admi1'
         IF PERMISO
            SISTEMA.admi1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi2'
         IF PERMISO
            SISTEMA.admi2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi3'
         IF PERMISO
            SISTEMA.admi3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi5'
         IF PERMISO
            SISTEMA.admi5.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi6'
         IF PERMISO
            SISTEMA.admi6.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste1'
         IF PERMISO
            SISTEMA.siste1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste2'
         IF PERMISO
            SISTEMA.siste2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste3'
         IF PERMISO
            SISTEMA.siste3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste4'
         IF PERMISO
            SISTEMA.siste4.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste5'
         IF PERMISO
            SISTEMA.siste5.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste6'
         IF PERMISO
            SISTEMA.siste6.ENABLED:=.T.
         ENDIF
      ENDIF	
   ENDIF
   skip
enddo

select permiso
go top
do whil .not. eof()
   IF ALLTRIM(USUARIO)=TEXTO
      if alltrim(el_item)=='Factu1'
         IF !PERMISO
            SISTEMA.Factu1.ENABLED:=.T.
         ENDIF
      elseIF alltrim(el_item)== 'Factu2'
         IF !PERMISO
            SISTEMA.Factu2.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu3'
         IF !PERMISO
            SISTEMA.Factu3.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu4'
         IF !PERMISO
            SISTEMA.Factu4.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Factu5'
         IF !PERMISO
            SISTEMA.FACTU5.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja1'
         IF !PERMISO
            SISTEMA.Caja1.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja2'
         IF !PERMISO
            SISTEMA.Caja2.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'Caja3'
         IF !PERMISO
            SISTEMA.Caja3.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'pfactu1'
         IF !PERMISO
            SISTEMA.pfactu1.ENABLED:=.T.
         endif
      ELSEIF alltrim(el_item)== 'dato1'
         IF !PERMISO
            SISTEMA.dato1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato2'
         IF !PERMISO
            SISTEMA.dato2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato3'
         IF !PERMISO
            SISTEMA.dato3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'dato6'
         IF !PERMISO
            SISTEMA.dato6.ENABLED:=.T.
         ENDIF	
      ELSEIF alltrim(el_item)== 'Stock1'
         IF !PERMISO
            SISTEMA.Stock1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'Stock2'
         IF !PERMISO
            SISTEMA.Stock2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'Stock3'
         IF !PERMISO
            SISTEMA.Stock3.ENABLED:=.T.
         ENDIF	
      ELSEIF alltrim(el_item)== 'admi1'
         IF !PERMISO
            SISTEMA.admi1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi2'
         IF !PERMISO
            SISTEMA.admi2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi3'
         IF !PERMISO
            SISTEMA.admi3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi5'
         IF !PERMISO
            SISTEMA.admi5.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'admi6'
         IF !PERMISO
            SISTEMA.admi6.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste1'
         IF !PERMISO
            SISTEMA.siste1.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste2'
         IF !PERMISO
            SISTEMA.siste2.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste3'
         IF !PERMISO
            SISTEMA.siste3.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste4'
         IF !PERMISO
            SISTEMA.siste4.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste5'
         IF !PERMISO
            SISTEMA.siste5.ENABLED:=.T.
         ENDIF
      ELSEIF alltrim(el_item)== 'siste6'
         IF !PERMISO
            SISTEMA.siste6.ENABLED:=.T.
         ENDIF
      ENDIF	
   ENDIF
   skip
enddo
Return

******************************************
Function Encrip
para pepe
pepe1=pepe
pala=''
enc=len(pepe1)
for a=1 to enc
  let=substr(pepe1,a,1)
  conv=asc(let)+100+a
  pala=pala+chr(conv)
next
pepe=pala
retu(pepe)
******************************************
Function Desencri
para pepe
pala=''
enc=len(alltrim(pepe))
for a=1 to enc
  let=substr(pepe,a,1)
  conv=asc(let)-100-a
  pala=pala+chr(conv)
next
pepe=pala
retu(pepe)
*****************************************
Function ConvExcel(traigo)
pala=''
for a=1 to len(traigo)
	letra=substr(traigo,a,1)
	if letra='.'
		letra=','
	endif
	pala=pala+letra
next
return(pala)
*----------------------------------------------------------------------------*
Function LimpioDoc
PARA PAR
CAD=''
FOR X=1 TO LEN(PAR)
	CAR=SUBSTR(PAR,X,1)
	IF ! CAR $ '1234567890ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'
		CAR=''
	ENDI
	CAD=CAD+CAR
NEXT
RETU CAD

*----------------------------*
/*
 FUNCTION FETOP()                       16/6/90           F009
  Objetivo: Valida que una fecha dada este comprendida entre
            otras dos limetes.-
  Parametros:
           1) Fecha a validar  <ExpD>
           2) Fecha "desde"    <ExpD>
           3) Fecha "hasta"    <ExpD>
  Retorna: Un valor logico
*/

FUNCTION FETOP
PARAMETERS val_fec, desde, hasta
PRIVATE ret_val

IF EMPTY(desde)
     desde = CTOD("01/01/30")
ENDIF

IF EMPTY(hasta)
     hasta = CTOD("31/12/29")
ENDIF

ret_val = .F.

IF val_fec >= desde .AND. val_fec <=  hasta 
   ret_val = .T.
ENDIF
RETURN(ret_val)



********************************************************************************
*** Encriptar: Función para Encriptar y Desencriptar String ********************
************* (Basada en una idea de Gustavo Asborno) **************************
*** Obligatorio:nTipo : 1=Encripta, 2=Desencripta ******************************
***             cTexto: Cadena de caracteres a tratar **************************
*** Optativo:   cPass : Password (Predetrminado, 'yotequieroverlejos!') ********
********************************************************************************
********************************************************************************
********************************************************* Versión:19-03-2007 ***
*** Coloque Limites al cálculo de nCar ****************** Versión:19-12-2008 ***
FUNCTION Encriptar (nTipo,cTexto,cPass)
Local cLetra,nI,cNuevo,nPass,nPos,nAsc, nCar
cPass :=IIF(Empty(cPass),'yotequieroverlejos!',AllTrim(cPass))
nPass :=LEN(cPass)
cNuevo:=''
nPos  :=0
nAsc  :=0
FOR nI=1 TO LEN(cTexto)
   nPos++
   IF nPos>nPass
      nPos:=0
   ENDIF
   nAsc:=ASC(SUBSTR(cPass,nPos,1))
   IF nTipo==1       //Encriptar
      nCar:=ASC(SUBSTR(cTexto,nI,1))+nAsc
      If nCar>255
         nCar:=nCar-255
      EndIf
      cNuevo:=cNuevo+CHR(nCar)
   ElseIF nTipo==2   //Desencriptar
      nCar:=ASC(SUBSTR(cTexto,nI,1))-nAsc
      If nCar<0
         nCar:=nCar+255
      Endif
      cNuevo:=cNuevo+CHR(nCar)
   ENDIF   
NEXT
RETURN (cNuevo)


*------------------------------------------------------------------------------*
* Basurita()  Sirve para agregar TEXTO basura a un dato que será encriptado.   *
*       Recibe: nCar = Cantidad de caracteres basura.                          *
*       Retorna: Texto basura con 'nCar' carateres!                            * 
*------------------------------------------------------------------------------*
Function Basurita (nCar)
Local cBasura:=''
For I=1 to nCar
   cBasura:=cBasura+Chr(Int(HB_RANDOM(24)+65))
Next
Return (cBasura)

*------------------------------------------------------------------------------*
* MsgTemp() Visualiza en pantalla un mensaje temporal.                         *
*       Recibe: cMensaje = Texto a Visualizar -obligatorio-                    *
*               nTiempo  = segundos a visualizarlo -optativo- default 3 segs.  *
*               cColor   = Color de la Fuentes                                 *
*               nTamanio = Tamaño de la Fuente                                 *
*               nWidth   = Ancho de la Ventana                                 *
*               nHeight  = Alto de la Ventana                                  *
*---------------------------------------------------------------- 10-03-2007 --*
*---------------------------------------------------------------- 21-11-2008 --*
Function MsgTemp (cMensaje,nTiempo,cColor,nTamanio,nWidth,nHeight)
DEFAULT nTiempo  TO 3
DEFAULT cColor   TO BLACK
DEFAULT nTamanio TO 9    
DEFAULT nWidth   TO 650
DEFAULT nHeight  TO 100

DEFINE WINDOW frmMensajes AT 0,0 WIDTH nWidth HEIGHT nHeight TITLE 'Mensajes del Sistema...' MODAL NOSYSMENU
   DEFINE LABEL lblMensajes
      ROW 20
      COL 10
      WIDTH nWidth-10
      HEIGHT nHeight-10
      VALUE AllTrim(cMensaje)
      FONTSIZE nTamanio
      FONTCOLOR cColor
      FONTBOLD .t.
      CENTERALIGN .t.
   END LABEL   
END WINDOW
CENTER   WINDOW frmMensajes
ACTIVATE WINDOW frmMensajes NOWAIT
DO WHILE nTiempo>=0
   DO EVENTS     
   Inkey(.5)
   nTiempo:=nTiempo-.5
ENDDO   
frmMensajes.RELEASE
Return .t.


*------------------------------------------------------------------------------*
* MesToNombre() Sirve para devolver el 'Nombre' de un mes apartir de su numero *
*       Recibe: cMes = Numero de mes en formato 'nn' caracterer, pe: 01 = Ene  *
*               nTipo= 1 = Devuelve el nombre en 3 letras (por defecto)        *
*                      2 = Devuelve el nombre completo                         *
*       Retorna: Texto con el nombre del mes en 3 letras o completo            * 
*---------------------------------------------------------------- 28-12-2008 --*
Function MesToNombre (cMes,nTipo)
DEFAULT nTipo TO 1
If cMes='01'
   Return IIF(nTipo=1,'Ene','Enero')
ElseIf cMes='02'
   Return IIF(nTipo=1,'Feb','Febrero')
ElseIf cMes='03'
   Return IIF(nTipo=1,'Mar','Marzo')
ElseIf cMes='04'
   Return IIF(nTipo=1,'Abr','Abril')
ElseIf cMes='05'
   Return IIF(nTipo=1,'May','Mayo')
ElseIf cMes='06'
   Return IIF(nTipo=1,'Jun','Junio')
ElseIf cMes='07'
   Return IIF(nTipo=1,'Jul','Julio')
ElseIf cMes='08'
   Return IIF(nTipo=1,'Ago','Agosto')
ElseIf cMes='09'
   Return IIF(nTipo=1,'Sep','Septiembre')
ElseIf cMes='10'
   Return IIF(nTipo=1,'Oct','Octubre')
ElseIf cMes='11'
   Return IIF(nTipo=1,'Nov','Noviembre')
ElseIf cMes='12'
   Return IIF(nTipo=1,'Dic','Diciembre')
Else
   MsgBox('Error! en MesToNombre(). Mes no identificado!','Funciones del Sistema.')
   Return ''
EndIf
   
