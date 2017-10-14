#include 'oohg.ch'
function main()
   define window oWnd at 10,10 width 300 height 200 title 'Codigos de barras'  ;

   @ 20,80 button but_1 caption "MINIPRINT" action test("MINIPRINT")
   @ 60,80 button but_2 caption "HBPRINTER" action test("HBPRINTER")
   @100,80 button but_3 caption "PDFPRINT" action test("PDFPRINT")


   end window
   center window oWnd
   activate window oWnd
return nil

function test(CSALIDA)
local oprint
set date ansi
set century on

oprint:=tprint(CSALIDA)   //// probar miniprint y hbprinter
oprint:init()
oprint:selprinter(.T. , .T.  )  /// select,preview,landscape,papersize
if oprint:lprerror
   oprint:release()
   return nil
endif
oprint:begindoc("barras")
oprint:setpreviewsize(1)  /// tamaño del preview  1 menor,2 mas grande ,3 mas...
oprint:beginpage()
        ///////                                       color, hori, ancho, alto
oprint:printdata(10,24,"prueba codigo de barra")
oprint:printbarcode(14,24,"123456789012","EAN13",  ,  ,   ,   )
oprint:printbarcode(26,24,"codigo128cabcdefgh","CODE128C", {128,128,128} , .f. ,   ,   )
oprint:endpage()
oprint:enddoc()

return nil


