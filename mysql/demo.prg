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

   oServer := TMySQLServer():New(cHostName, cUser, cPassWord,nPort)                       //Abro la conexión con MySQL

   If oServer:NetErr()                                                             //Verifica si ocurrió algún error en la Conexión
       MsgInfo("Error de Conexión con Servidor " +chr(13)+ oServer:Error(),'MySQL under OOHG')
       oServer:= Nil
       Return .f.
   EndIf

   If oServer == Nil                                                               //Verifica si se Conectó realmente
       MsgInfo("Conexión con MySQL NO fue Iniciada!!",'MySQL under OOHG')
       Return Nil
   EndIf

   MsgInfo( "CONECTADO" )

RETURN
