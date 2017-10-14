///Mail Sample using Matteo Bacan socket function
///Based on Paola's Bruccoleri Mail Function
///Bruno Luciani
///bruno.luciani@gmail.com


#include "oohg.ch"

procedure main


load window mailing
mailing.smtp.value:="mail.servidor.com"



center window mailing
activate window mailing

return



function enviomail
sendmail(mailing.send.value,mailing.rname.value,mailing.smtp.value)
return



return







//-----------------------------------------------------------------------------*
function sendmail(email,nombre,cServer)
//-----------------------------------------------------------------------------*
local oSock, cRet
///local cServer := "mail.tuservidor.com"   / puedes poner la IP tambien


oSock := TSmtp():New()

Mailing.statusbar.value:= "Conectando a " +cServer

if oSock:Connect( cServer )
Mailing.statusbar.value:= "Conectado...."


if !Empty(alltrim(email))

Mailing.confirmacion_lbl.Value:= ""

oSock:ClearData()
oSock:SetFrom( "Mail Sample", "<oohg@oohg.org>" )
oSock:SetSubject( Mailing.asunto_txb.Value )
oSock:AddTo( alltrim(nombre),"<"+alltrim(email)+">" )
oSock:SetData( Mailing.texto_edt.value, .t. )
if !oSock:Send( .T. )
Mailing.confirmacion_lbl.Value:= "Error: "+oSock:getLastError()
else
Mailing.confirmacion_lbl.Value:= 'Envio correcto'
endif
endif

Mailing.statusbar.Value:= "Cerrando la conexion"
if oSock:Close()
Mailing.statusbar.Value:= "Cerrada la conexion"
Mailing.release
else
Mailing.statusbar.Value:= "Error al cerrar la conexion"
endif
else
Mailing.statusbar.Value:= "Fallo conexion " + oSock:getLastError()
endif

RETURN

#define NO_SAMPLE
#include "TSmtpClient.prg"
