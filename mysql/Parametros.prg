#include <oohg.ch>
#include "SDC_Colores.ch"

* Realizado por Sergio Castellari

Declare Window Parametros

*------------------------------------------------------------------------------*
* Parametros()      Carga Parametros.FMG y sirve para admininstrar parámetros  *
*                  del Sistema.                                                *
*------------------------------------------------------------------------------*
Function Parametros
If IsWindowActive('Parametros')
  Restore Window Parametros ; Parametros.SetFocus ; Return Nil
EndIf  
Private lMaxi:=.t.             //Maximizar Pantalla principal del Sistema
Private cHost:='127.0.0.1'     //Host de MySql local
Private cUser:='root'          //Nombre de Usuario
Private cPass:='root'          //Password de acceso
If !File('Parametros.Ini') ; CrearIniPar() ; EndIf
Load Window Parametros ; Center Window Parametros
CargarIniPar()
Activate Window Parametros
Return Nil

*------------------------------------------------------------------------------*
* CrearIniPar() Genera un archivo INI para Configuración de Parámetros.        *
*------------------------------------------------------------------------------*
Function CrearIniPar
set console off
set printer on
set printer to Parametros.Ini
?? '[General]'
? 'Maximizar = T'

? '[Acceso]'
? 'Host  = 127.0.0.1'
? 'Usuario = root'
? 'Pass = root'

set console on
set printer off
set printer to 
Return

*------------------------------------------------------------------------------*
* CargarIniPar() Carga los valores desde Parametros.INI                        *
*------------------------------------------------------------------------------*
Function CargarIniPar
BEGIN INI FILE "Parametros.Ini"
   GET lMaxi          SECTION "General"    ENTRY 'Maximizar'
   GET cHost          SECTION "Acceso"     ENTRY 'Host'
   GET cUser          SECTION "Acceso"     ENTRY 'Usuario'
   GET cPass          SECTION "Acceso"     ENTRY 'Pass'
END INI
Parametros.Check_2.Value    :=lMaxi
Parametros.Text_1.Value     :=cUser
Parametros.Text_2.Value     :=cPass
Parametros.Text_3.Value     :=cHost
Parametros.Button_1.SetFocus
Return Nil

*------------------------------------------------------------------------------*
* GrabarIniPar() Graba los valores desde Parametros.FMG                        *
*------------------------------------------------------------------------------*
Function GrabarIniPar
BEGIN INI FILE "Parametros.Ini"
   SET SECTION "General"    ENTRY "Maximizar"     TO Parametros.Check_2.Value
   SET SECTION "Acceso"     ENTRY "Usuario"       TO Parametros.Text_1.Value
   SET SECTION "Acceso"     ENTRY "Pass"          TO Parametros.Text_2.Value
   SET SECTION "Acceso"     ENTRY "Host"          TO Parametros.Text_3.Value
END INI
Parametros.Release
Return Nil
