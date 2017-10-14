/*
* MiniGUI ODBC Demo
* Based upon code from:
*        ODBCDEMO - ODBC Access Class Demonstration
*        Felipe G. Coury <fcoury@flexsys-ci.com>
* oohg Version:
*        Ciro Vargas Clemow
*
* For help about hbodbc class use, download harbour contributions package
* from www.harbour-project.org and look at ODBC folder.
*
*/

#include "oohg.ch"
#include "sql.ch"

*-------------------------
Function Main
*-------------------------

DEFINE WINDOW Win_1 ;
   AT 0,0 ;
   WIDTH 400 ;
   HEIGHT 400 ;
   TITLE 'OOHG ODBC Demo ADS DBF/CDX ' ;
   MAIN  on init conectar() ;
   on release cerrar()
   
   DEFINE MAIN MENU
      DEFINE POPUP 'File'
      MENUITEM 'Listado' ACTION list()
      menuitem 'Busqueda POR APELLIDO' Action Bus()
      menuitem 'Busqueda POR telefono' Action Bus1()
      menuitem 'Agregar' Action Addrec()
      menuitem 'Borrar' Action Borrarec()
      menuitem  'INDEX' action indexa()
      menuitem 'borra index' action borrai()
      menuitem  "version " action automsgbox(miniguiversion())
   END POPUP
END MENU

END WINDOW
ACTIVATE WINDOW Win_1
Return



*-------------------------
PROCEDURE INDEXA()
*-------------------------
WITH OBJECT dsFunctions
///      :SetSQL( "CREATE INDEX pornom ON ABI (NOMBRE)" )
////      :setsql( "ALTER TABLE ABI ADD INDEX pornumero (numero)")

///      if .not. :Open()
///          msgbox("error")
///      endif

:SetSQL( "CREATE INDEX pornUM ON ABI (NUMERO)" )
////         :setsql( "ALTER TABLE ABI ADD INDEX pornumero (numero)")

if .not. :Open()
msgbox("error")
ELSE
MSGBOX("INDEXADO")
endif


:Close()

END

return


*-------------------------
procedure borrai()
*-------------------------
WITH OBJECT dsFunctions 
//      :SetSQL( "DROP INDEX pornom ON ABI" )
///         :setsql( "ALTER TABLE ABI ADD INDEX pornumero (numero)")

//      if .not. :Open()
//          msgbox("error")
//      endif

:SetSQL( "DROP INDEX pornUM ON ABI" )

if .not. :Open()
msgbox("error")
endif


:Close()

END
return



*-------------------------
procedure conectar()
*-------------------------
Public cConStr   := ;
"Driver={Advantage StreamlineSQL ODBC};SourceType=DBF;SourceDB=c:\analisis\iden;"

Public  dsFunctions := TODBC():New( cConStr ) // cConStr )

if SQL_ERROR = -1
msgbox("si conecto")
else
msgbox("no conecto")
return
endif

dsfunctions:lcachers:=.F.

return


*-------------------------
procedure cerrar()
*-------------------------
dsFunctions:Destroy()
return


*-------------------------
PROCEDURE list()
*-------------------------
local i

WITH OBJECT dsFunctions


:SetSQL( "SELECT * FROM ABI order by NOMBRE " )

:Open()
      

creg:=""
contador:=0
DO WHILE (:FETCH( SQL_FETCH_NEXT ,1)= SQL_SUCCESS)
creg:=creg+ :Fieldbyname("nombre"):value+ :fieldbyname("NUMERO"):value+ chr(13)+chr(10)
contador++
IF CONTADOR>=25
   if .not. msgyesno(creg,"Continua ?")
      exit
   ELSE
      CREG:=""
      CONTADOR:=0
   endif
ENDIF

ENDDO
:Close()

END
RETURN( NIL )



*-------------------------
PROCEDURE Bus()
*-------------------------
local csearch:=upper(inputbox("Busca APELLIDO","Pregunta"))

WITH OBJECT dsFunctions

a:=seconds()

:SetSQL( "SELECT top 50 * FROM ABI WHERE Nombre LIKE "+"'"+csearch+"%'" )

if .not. :Open()
msgbox("error")
endif

creg:=""
sw:=0
cn:=0
while (:FETCH( SQL_FETCH_NEXT ,1)= SQL_SUCCESS)
      creg:=creg+:FieldByName( "NOMBRE" ):Value+" "+(:FieldByName( "Numero" ):Value )+chr(13)+chr(10)
      sw:=1
      cn++
/////
enddo
if sw=1

automsginfo(creg)

else
msgbox("registro no encontrado")
endif

:Close()


END
RETURN  NIL


*-------------------------
PROCEDURE Bus1()
*-------------------------
local csearch:=inputbox("Busca TELEFONO","Pregunta")

WITH OBJECT dsFunctions 

a:=seconds()

:lcachers:=.T.
:SetSQL( "SELECT * FROM abi WHERE NUMERO = "+CSEARCH )

if .not. :Open()
msgbox("error")
endif
CREG:=""
SW:=0
while .not. :eof()
creg:=creg+:FieldByName( "NOMBRE" ):Value+" "+(:FieldByName( "Numero" ):Value )+chr(13)+chr(10)
:skip()
sw:=1
enddo
if sw=1
automsginfo(creg)
///         automsgbox(b-a)
else
msgbox("registro no encontrado")
endif

:lcachers:=.F.

:Close()

END
RETURN  NIL


*-------------------------
PROCEDURE addrec()
*-------------------------
local csearch:=upper(inputbox("Nombre :","Pregunta"))
local csearch1:=upper(inputbox("Numero :","Pregunta"))

if empty(csearch) .or. empty(csearch1)
   msginfo("no se puede a¤adir datos en blanco")
   return nil
endif

WITH OBJECT dsFunctions 

cinserta:="(" + csearch1 +",'" + csearch + "',' "+ "',' ',' ',' "+ "')"
automsgbox(cinserta)
:SetSQL( "INSERT INTO ABI VALUES " + cinserta )
if (:Open())
   msgbox("registro agregado")
else
   msgbox("fallo agrega registro")
endif

:Close()

END

RETURN  NIL



*-------------------------
PROCEDURE borrarec()
*-------------------------
local csearch:=ALLTRIM(upper(inputbox("Numero :","Pregunta")))
WITH OBJECT dsFunctions 

:SetSQL( "SELECT * FROM ABI WHERE NUMERO = "+csearch )
:Open()
   if .not. :eof()
       if  msgyesno("Esta seguro de borrar: "+csearch)
           :close()
           :SetSQL( "DELETE FROM ABI WHERE NUMERO = "+csearch )
           IF (:Open())
               msgbox("registro borrado")
           ELSE
               MSGBOX("NO SE PUDO BORRAR")
           ENDIF
       endif
   else
     msgbox("registro no encontrado")
   endif

:close()
END

RETURN nil
