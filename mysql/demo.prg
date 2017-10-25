#include "oohg.ch"

PROCEDURE Main

   DEFINE WINDOW Main ;
         TITLE "MySQL demo"
      @ 10,10 BUTTON Btn CAPTION "Inicio" ACTION Conex()
   END WINDOW
   ACTIVATE WINDOW Main

   RETURN

PROCEDURE Conex()

   cHostName  = "localhost"
   cUser = "root"
   cPassWord = "root"
   nPort = 3306
   oServer := TMySQLServer():New(cHostName, cUser, cPassWord,nPort)                       //Abro la conexi�n con MySQL
   If oServer:NetErr()                                                             //Verifica si ocurri� alg�n error en la Conexi�n
      MsgInfo("Error de Conexi�n con Servidor " +chr(13)+ oServer:Error(),'MySQL under OOHG')
      oServer:= Nil

      Return .f.
   EndIf
   If oServer == Nil                                                               //Verifica si se Conect� realmente
      MsgInfo("Conexi�n con MySQL NO fue Iniciada!!",'MySQL under OOHG')

      Return Nil
   EndIf
   MsgInfo( "CONECTADO" )

   RETURN
