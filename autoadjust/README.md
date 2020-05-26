# AutoAdjust

* Se ajusta posicion, ancho y font 
https://github.com/oohg/samples/blob/master/autoadjust/Auto1.prg
* Se ajusta las posiciones , pero no el ancho ni el font 
https://github.com/oohg/samples/blob/master/autoadjust/AUTO2.PRG
* se ajusta posicion, ancho pero no font
https://github.com/oohg/samples/blob/master/autoadjust/AUTO3.PRG
* se ajusta posición, ancho y font, pero al boton 'Salir' solo se le ajusta posición.
https://github.com/oohg/samples/blob/master/autoadjust/auto4.prg
* se ajusta posicion, ancho y font, pero en el progessbar se desactiva autoajuste
https://github.com/oohg/samples/blob/master/autoadjust/auto5.prg

-----------------------------------------------------------------

SET AUTOADJUST ON    ////  Prende el autoajuste global posicion, ancho y font
SET AUTOADJUST OFF   ////  Apaga el autoajuste global

SET ADJUSTWIDTH ON   ////  Prende el ajuste global de ancho
SET ADJUSTWIDTH OFF  ////  Apaga del ajuste global de ancho
                     ////  Depende del primero  

SET ADJUSTFONT ON    ////  Prende el ajuste global de font
SET ADJUSTFONT OFF   ////  Apaga el autoajuste global de font
                     ////  Depende del primero.

------------------------------------------------------------------


 Para cada control se puede activar o desactivar el autoajuste
 si esta prendido el global.

con        oControl:ladjust := .T.
 o         oControl:ladjust := .F.

-----------------------------------------------------------------

 Para cada Control se puede activar o desactivar el ajuste de ancho
 se esta prendido el global

con        oControl:lfixwidth := .T.
 o         oControl:lfixwidth := .F.

-----------------------------------------------------------------

 Para cada control se puede activar o desactivar el ajuste de font
 si esta prendido el ajuste global

con        oControl:lfixfont  := .T.
 o         oControl:lfixfont  := .F.



