#include "oohg.ch"
*-------------------------
Function Main
*-------------------------
Private aRows [15] [5]

set date ansi
set century on
set navigation extended




bColor:=   {|| if(.T., RGB( 255,255,255 ), RGB(255,255,255) ) }


bcolor1:=   {|| if( this.cellvalue = 0 , { 255,0,0 }, {255,255,255}  )}



DEFINE WINDOW Form_1 ;
   AT 0,0 ;
   WIDTH 600 ;
   HEIGHT 550 ;
   TITLE 'Full-Move and Append Grid Modes Demo' ;
   MAIN

   for k:=1 to 15
       arows[k]:={ str(hb_randomint(99),2) ,hb_randomint(100),date()+hb_randomint(30),"Refer "+str(hb_randomint(10),2),hb_randomint(10000) }
   next k

   @ 10,10 button b1 obj ob1 caption "up" action {|| ogrid:setfocus(), ogrid:up() }
   @ 10,150 button b2 obj ob2 caption "down" action {|| ogrid:setfocus(),ogrid:down()}
   @ 10,280 checkbox c3 obj oc3 caption  "Full Move" ON change cambiax()
   @ 10,400 checkbox c4 obj oc4 caption  "Append Mode" ON change cambiay()



   @ 40,10 GRID Grid_1 obj ogrid ;
   WIDTH 520 ;
   HEIGHT 330 ;
   HEADERS {'CODIGO','NUMERO','FECHA','REFERENCIA','IMPORTE'} ;
   WIDTHS {60,80,100,120,140} ;
   ITEMS aRows ;
   COLUMNCONTROLS { {'TEXTBOX','CHARACTER',"99"} , {'TEXTBOX',"NUMERIC",'999999'} , {"TEXTBOX","DATE"} , { 'TEXTBOX' ,"CHARACTER"} , { 'TEXTBOX' , 'NUMERIC' , ' 999,999,999.99' } } ;
   FONT "COURIER NEW" SIZE 10 ;
   EDIT  INPLACE  ;
   ON EDITCELL  procesa()  ;



   @ 390,290 label l value "Total"

   @ 390,390 textbox nSuma numeric inputmask "999,999,999.99"

   form_1.nSuma.readonly:=.T.

   sumatoria()


   @ 415,5 label label_1 value "Ingrese 99 en la primera columna, 50 o 77 en la segunda para observar las posibilidades de movimiento." autosize
   @ 440,5 label label_2 value "Ingrese 43 en la primera columna y en la segunda aparecera 88 y pasara a la quinta." autosize
   @ 465,5 label label_5 value "Haga doble click en alguna celda y luego enter para editar y cambiar su valor."  autosize
   @ 490,5 label label_3 value "Revise el codigo fuente y verá lo fácil que es." autosize

   form_1.label_1.visible:=.F.
   form_1.label_2.visible:=.F.
   form_1.label_5.visible:=.F.
   form_1.label_3.visible:=.F.

END WINDOW

CENTER WINDOW Form_1

ACTIVATE WINDOW Form_1

Return

static function cambiax()
if oc3:value
   ogrid:fullmove:=.T.
   form_1.label_1.visible:=.t.
   form_1.label_2.visible:=.t.
   form_1.label_5.visible:=.t.
   form_1.label_3.visible:=.t.
else
   ogrid:fullmove:=.F.
   form_1.label_1.visible:=.F.
   form_1.label_2.visible:=.F.
   form_1.label_5.visible:=.F.
   form_1.label_3.visible:=.F.

endif
return nil

static function cambiay()
if oc4:value
   ogrid:append:=.T.
else
   ogrid:append:=.F.
endif
return nil


static procedure procesa()

if this.cellcolindex=1 .and. this.cellvalue="99"
   ogrid:right()
   ogrid:right()
endif

if this.cellcolindex=1 .and. this.cellvalue="43"
   ogrid:cell(this.cellrowindex , 2 , 88)
   ogrid:right()
   ogrid:right()
   ogrid:right()
endif
if this.cellcolindex=2 .and. this.cellvalue=50
   ogrid:down()
   ogrid:left()
endif
if this.cellcolindex=2 .and. this.cellvalue=77
   ogrid:up()
   ogrid:left()
   ogrid:right()
endif
if this.cellcolindex=5
   sumatoria()
endif
return nil

static function sumatoria()
local suma:=0
for i:=1 to ogrid:itemcount()
    suma:=suma+ogrid:cell(i,5)
next
form_1.nsuma.value:=suma
return nil

