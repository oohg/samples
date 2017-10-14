#Include "oohg.ch"
function main()

if msgyesno("Esta seguro","Pregunta")
   msgbox("positivo")
else
   msgbox("Negativo")
endif

if msgyesno("Esta seguro","Pregunta",.t.)
   msgbox("positivo")
else
   msgbox("Negativo")
endif


MsgInfo("Esta es una prueba","Informacion")

Automsgbox("Estos  son mensajes con formato automatico","Titulo")

d=date()
Automsgbox( d,"Fecha")

n=1500
automsginfo(n,"Numerico")

l=.T.

automsgstop(l,"Logico")

a:={ { 1,2,3 }, {3,2,1}, {5,6,7 }}

automsginfo (A, "Arreglo 2 dimensiones")


automsginfoext("Este es una prueba de varias lineas"+chr(13)+"esta es otra linea"+chr(13)+"le agregue temporizador opcional"+chr(13)+chr(13)+"estara disponible proxima version", "aporte de Lucho Miranda",4)

return nil


