

function main() 
local hLib := hb_LibLoad( "dlluno.dll" ) 
local sym

SetMode(25,80)
Scroll()

  //Estas son las formas de llamar a las funciones contenidas.
  //1)
  ? &("Prueba")( "hola desde la dll" ) 
  
  //2)
  sym := &("@PRUEBA()")
  ? sym:exec("hola desde la dll prueba 2")
  inkey(0)
  
  //Eliminamos la referencia.
  HB_SYMBOL_UNUSED(hLib)
  
return nil 




