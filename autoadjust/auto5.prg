#include "oohg.ch"

Function Main()

SET INTERACTIVECLOSE OFF

msginfo("Test de autoajuste, se ajusta posicion, ancho y font, pero en el progessbar se desactiva autoajuste")

SET AUTOADJUST ON


DEFINE window catalog obj owin ;
AT 45,74 ;
WIDTH 753 ;
HEIGHT 560 ;
TITLE 'Catalogo de productos' ;
ICON 'catalog' ;
MAIN ;
FONT 'MS Sans Serif' ;
SIZE 10 ;

DEFINE STATUSBAR
STATUSITEM "" ;
WIDTH   80 ;
&&& comment
KEYBOARD
DATE  ;
WIDTH   80 ;
&&& comment
CLOCK  ;
WIDTH   80 ;
&&& comment
END STATUSBAR

*****@ 11,14 TAB tab_1

DEFINE TAB tab_1 ;
AT   11 ,   14  ;
WIDTH  719 ;
HEIGHT 403 ;
VALUE 0 ;
FONT 'MS Sans Serif' ;
SIZE 10


DEFINE PAGE 'Revisión'  ;
IMAGE ''

@ 303,37 LABEL label_1 ;
WIDTH 112 ;
HEIGHT 24 ;
VALUE 'Descripcion' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 324,38 LABEL label_2 ;
WIDTH 120 ;
HEIGHT 24 ;
VALUE 'Package' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;



@ 353,39 LABEL label_3 ;
WIDTH 120 ;
HEIGHT 17 ;
VALUE 'Precio' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;





@ 266,125 TEXTBOX text_1 ;
HEIGHT 26 ;
WIDTH 241 ;
Font 'MS Sans Serif' ;
size 10 ;
MAXLENGTH 30 ;
UPPERCASE ;
ON CHANGE NIL ;
ON ENTER NIL ;




@ 263,38 LABEL label_4 ;
WIDTH 70 ;
HEIGHT 32 ;
VALUE 'Buscar  x codigo' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;





@ 310,518 BUTTON button_2 ;
CAPTION 'Salir' ;
ACTION { || (catalog.release) } ;
WIDTH 100 ;
HEIGHT 28 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 350,251 LABEL nprecio2 ;
AUTOSIZE ;
VALUE '.......' ;
FONT 'MS Sans Serif' ;





@ 350,392 LABEL nprecio3 ;
AUTOSIZE ;
VALUE '.........' ;
FONT 'MS Sans Serif' ;





@ 61,11 BROWSE browse_1 ;
WIDTH 437 ;
HEIGHT 184 ;
HEADERS {'Nombre','Codigo','Packaging','Rubro','Precio 1','Precio 2','Precio 3','Cod. Barra','Existencia'} ;
WIDTHS  {250,60,100,100,100,100,100,100,100} ;
WORKAREA revent ;
FIELDS  {'hb_oemtoansi(nombre)','codart','cantxbulto','rubro','precio1','precio2','precio3','codbarras','exist'} ;
FONT 'MS Sans Serif' ;
SIZE 10 ;
ON CHANGE NIL  ;
ON HEADCLICK NIL  ;




@ 59,463 IMAGE image_1 ;
PICTURE "x.jpg" ;
WIDTH 220 ;
HEIGHT 197 ;
STRETCH  ;




@ 302,156 LABEL cdescripcion ;
AUTOSIZE ;
VALUE '........' ;
FONT 'MS Sans Serif' ;





@ 325,157 LABEL cpack ;
AUTOSIZE ;
VALUE '........' ;
FONT 'MS Sans Serif' ;




@ 350,158 LABEL nprecio ;
AUTOSIZE ;
VALUE '........' ;
FONT 'MS Sans Serif' ;



END PAGE


DEFINE PAGE 'Impresion'  ;
IMAGE ''

///@ 263,327 RADIOGROUP radio_1 ;
///OPTIONS  {'Por nombre','Por código'}  ;
///VALUE 2 ;
///WIDTH  120 ;
////SPACING  25 ;
///FONT 'MS Sans Serif' ;
///SIZE 10 ;
///TOOLTIP 'Ordenado por...' ;


@ 64,326 LABEL label_5 ;
WIDTH 58 ;
HEIGHT 23 ;
VALUE 'Desde' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




catalog.label_5.fontcolor:={0,0,0}

@ 109,328 LABEL label_6 ;
WIDTH 41 ;
HEIGHT 20 ;
VALUE 'Hasta' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;





@ 334,44 BUTTON button_1 ;
CAPTION 'Imprimir' ;
ACTION nil ;
WIDTH 100 ;
HEIGHT 28 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 171,41 LABEL label_7 ;
WIDTH 40 ;
HEIGHT 18 ;
VALUE 'Rubro' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;



@ 64,40 COMBOBOX combo_arthoja ;
ITEMS  {'2 art. x hoja','4 art. x hoja','8 art. x hoja','9 art. x hoja','15 art. x hoja (oficio)','16 art. x hoja','20 art. x hoja','24 art. x hoja (oficio)','Plantilla' }  ;
VALUE 1 ;
WIDTH  176 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 108,40 COMBOBOX combo_precio ;
ITEMS  {'Precio 1','Precio 2','Precio 3'}  ;
VALUE 1 ;
WIDTH  174 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 173,326 LABEL label_8 ;
WIDTH 91 ;
HEIGHT 22 ;
VALUE 'Desde' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;





@ 217,327 LABEL label_9 ;
WIDTH 92 ;
HEIGHT 21 ;
VALUE 'Hasta' ;
FONT 'MS Sans Serif' ;
SIZE 10 ;





@ 170,100 TEXTBOX rubro ;
HEIGHT 22 ;
WIDTH 48 ;
Font 'MS Sans Serif' ;
size 10 ;
NUMERIC ;
MAXLENGTH 2 ;
ON CHANGE nil  ;




@ 171,429 DATEPICKER datepicker_1 ;
VALUE ctod("  /  /    ")  ;
WIDTH 120 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 63,426 TEXTBOX ndesde ;
HEIGHT 24 ;
WIDTH 120 ;
Font 'MS Sans Serif' ;
size 10 ;
NUMERIC ;
MAXLENGTH 6 ;
ON CHANGE nil  ;




@ 215,429 DATEPICKER datepicker_2 ;
VALUE ctod("  /  /    ")  ;
WIDTH 120 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




@ 43,309 FRAME frame_1 ;
CAPTION "Artículo" ;
WIDTH 262 ;
HEIGHT 104 ;



catalog.frame_1.fontname:='MS Sans Serif'
catalog.frame_1.fontsize:= 10

@ 152,311 FRAME frame_2 ;
CAPTION "Fecha Alta" ;
WIDTH 262 ;
HEIGHT 98 ;



catalog.frame_2.fontname:='MS Sans Serif'
catalog.frame_2.fontsize:= 10


@ 335,202 PROGRESSBAR progressbar_1 obj oprog ;
RANGE 1,100 ;
WIDTH 473 ;
HEIGHT 27 ;
TOOLTIP 'Avance de impresión' ;
SMOOTH  ;

oprog:ladjust := .F.


@ 108,427 TEXTBOX nhasta ;
HEIGHT 24 ;
WIDTH 120 ;
Font 'MS Sans Serif' ;
size 10 ;
NUMERIC ;
MAXLENGTH 6 ;
ON CHANGE nil  ;




@ 213,43 CHECKBOX ltodos ;
CAPTION 'Todos los items' ;
WIDTH 151 ;
HEIGHT 27;
VALUE .F. ;
FONT 'MS Sans Serif' ;
SIZE 10 ;
ON CHANGE nil  ;
ON LOSTFOCUS nil ;




@ 277,42 BUTTON checkbtn_1 ;
CAPTION 'Stop' ;
ACTION nil  ;
WIDTH 100 ;
HEIGHT 28 ;
FONT 'MS Sans Serif' ;
SIZE 10 ;




END PAGE
END TAB


END WINDOW

center window catalog
activate window catalog

return nil



