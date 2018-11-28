#include "oohg.ch"

FUNCTION Main()

   MsgInfo("Test de autoajuste, se ajusta posición, ancho y font, pero al boton 'Salir' solo se le ajusta posición.")

   SET INTERACTIVECLOSE OFF
   SET AUTOADJUST ON

   DEFINE WINDOW catalog ;
      AT 45,74 ;
      WIDTH 753 ;
      HEIGHT 560 ;
      TITLE 'Catálogo de productos' ;
      MAIN ;
      FONT 'MS Sans Serif' ;
      SIZE 10 ;
      ON SIZE MsgBox( "¡Cambió tamaño!" )

      DEFINE STATUSBAR
         STATUSITEM "" WIDTH 80
         KEYBOARD
         DATE WIDTH 80
         CLOCK WIDTH 80
      END STATUSBAR

      DEFINE TAB tab_1 ;
         AT 11,14 ;
         WIDTH 719 ;
         HEIGHT 403 ;
         VALUE 0 ;
         FONT 'MS Sans Serif' ;
         SIZE 10

         DEFINE PAGE 'Revisión'

            @ 303,37 LABEL label_1 ;
               WIDTH 112 ;
               HEIGHT 24 ;
               VALUE 'Descripción' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 324,38 LABEL label_2 ;
               WIDTH 120 ;
               HEIGHT 24 ;
               VALUE 'Package' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 353,39 LABEL label_3 ;
               WIDTH 120 ;
               HEIGHT 17 ;
               VALUE 'Precio' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 266,125 TEXTBOX text_1 ;
               HEIGHT 26 ;
               WIDTH 241 ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               MAXLENGTH 30 ;
               UPPERCASE

            @ 263,38 LABEL label_4 ;
               WIDTH 70 ;
               HEIGHT 32 ;
               VALUE 'Buscar x código' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 310,518 BUTTON button_2 OBJ oBut ;
               CAPTION 'Salir' ;
               ACTION catalog.Release ;
               WIDTH 100 ;
               HEIGHT 28 ;
               FONT 'MS Sans Serif' ;
               SIZE 10
            oBut:lFixWidth := .T.
            oBut:lFixFont  :=  .T.

            @ 350,251 LABEL nprecio2 ;
               AUTOSIZE ;
               VALUE '.......' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 350,392 LABEL nprecio3 ;
               AUTOSIZE ;
               VALUE '.........' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 61,11 BROWSE browse_1 ;
               WIDTH 437 ;
               HEIGHT 184 ;
               HEADERS {'Nombre','Código','Packaging','Rubro','Precio 1','Precio 2','Precio 3','Cod. Barra','Existencia'} ;
               WIDTHS {250,60,100,100,100,100,100,100,100} ;
               WORKAREA revent ;
               FIELDS {'hb_oemtoansi(nombre)','codart','cantxbulto','rubro','precio1','precio2','precio3','codbarras','exist'} ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 59,463 IMAGE image_1 ;
               PICTURE "ZZZ_AAAOOHG" ;
               WIDTH 220 ;
               HEIGHT 197 ;
               STRETCH

            @ 302,156 LABEL cdescripcion ;
               AUTOSIZE ;
               VALUE '........' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 325,157 LABEL cpack ;
               AUTOSIZE ;
               VALUE '........' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 350,158 LABEL nprecio ;
               AUTOSIZE ;
               VALUE '........' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

         END PAGE

         DEFINE PAGE 'Impresión'

            @ 64,40 COMBOBOX combo_arthoja ;
               ITEMS {'2 art. x hoja','4 art. x hoja','8 art. x hoja','9 art. x hoja','15 art. x hoja (oficio)','16 art. x hoja','20 art. x hoja','24 art. x hoja (oficio)','Plantilla' } ;
               VALUE 1 ;
               WIDTH 176 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 108,40 COMBOBOX combo_precio ;
               ITEMS {'Precio 1','Precio 2','Precio 3'} ;
               VALUE 1 ;
               WIDTH 174 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 171,41 LABEL label_7 ;
               WIDTH 40 ;
               HEIGHT 18 ;
               VALUE 'Rubro' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 213,43 CHECKBOX ltodos ;
               CAPTION 'Todos los ítems' ;
               WIDTH 151 ;
               HEIGHT 27;
               VALUE .F. ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 277,42 BUTTON checkbtn_1 ;
               CAPTION 'Stop' ;
               ACTION NIL ;
               WIDTH 100 ;
               HEIGHT 28 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 334,44 BUTTON button_1 ;
               CAPTION 'Imprimir' ;
               ACTION NIL ;
               WIDTH 100 ;
               HEIGHT 28 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 43,309 FRAME frame_1 ;
               CAPTION "Artículo" ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               WIDTH 262 ;
               HEIGHT 104

            @ 64,326 LABEL label_5 ;
               WIDTH 58 ;
               HEIGHT 23 ;
               VALUE 'Desde' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 109,328 LABEL label_6 ;
               WIDTH 41 ;
               HEIGHT 20 ;
               VALUE 'Hasta' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 152,309 FRAME frame_2 ;
               CAPTION "Fecha Alta" ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               WIDTH 262 ;
               HEIGHT 98

            @ 173,326 LABEL label_8 ;
               WIDTH 91 ;
               HEIGHT 22 ;
               VALUE 'Desde' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 217,327 LABEL label_9 ;
               WIDTH 92 ;
               HEIGHT 21 ;
               VALUE 'Hasta' ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 170,100 TEXTBOX rubro ;
               HEIGHT 22 ;
               WIDTH 48 ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               NUMERIC ;
               MAXLENGTH 2

            @ 63,429 TEXTBOX ndesde ;
               HEIGHT 24 ;
               WIDTH 120 ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               NUMERIC ;
               MAXLENGTH 6

            @ 108,429 TEXTBOX nhasta ;
               HEIGHT 24 ;
               WIDTH 120 ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               NUMERIC ;
               MAXLENGTH 6

            @ 170,429 DATEPICKER datepicker_1 ;
               VALUE CToD( "" ) ;
               WIDTH 120 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 215,429 DATEPICKER datepicker_2 ;
               VALUE CToD( "" ) ;
               WIDTH 120 ;
               FONT 'MS Sans Serif' ;
               SIZE 10

            @ 263,327 RADIOGROUP radio_1 ;
               OPTIONS {'Por nombre','Por código'} ;
               VALUE 2 ;
               WIDTH 120 ;
               SPACING 25 ;
               FONT 'MS Sans Serif' ;
               SIZE 10 ;
               TOOLTIP 'Ordenado por...'

            @ 335,307 PROGRESSBAR progressbar_1 ;
               RANGE 1,100 ;
               WIDTH 370 ;
               HEIGHT 27 ;
               TOOLTIP 'Avance de impresión' ;
               SMOOTH

         END PAGE

      END TAB

   END WINDOW

   ACTIVATE WINDOW catalog

RETURN NIL

/*
 * EOF
 */
