#include <i_windefs.ch>
#include "oohg.ch"
#include "SDC_Colores.ch"

*------------------------------------------------------------------------------*
* ListBox - Ejemplo de utilización usando gráficos y nuevas funciones          *
*                                                                              *
* Creado para ooHG - Sergio Castellari - sergio1972ar@yahoo.com.ar - 08-2011   *
*------------------------------------------------------------------------------*
Function Main
	DEFINE WINDOW Form_1 AT 0,0 WIDTH 700 HEIGHT 335 TITLE 'ListBox - Utilizando imagenes...' ICON 'Desktop.ico' MAIN NOSIZE NOMAXIMIZE BACKCOLOR Nil 

    DEFINE IMAGE Image_1
        ROW    0
        COL    0
        WIDTH  700
        HEIGHT 335
        PICTURE 'Fondo.jpg'
        HELPID Nil
        VISIBLE .T.
        STRETCH .F.
        ACTION Nil
    END IMAGE
    Form_1.Image_1.Enabled:=.f.
    
    @ 10,10 LISTBOX List_1 obj oListbox ;
      HEIGHT 277 ;
      WIDTH 320 ;
			ITEMS { {'Información General',0,4} , {'Configuraciones',1,5} , {'Reparar Tablas',2,6} , {'Salir...',3,7}  } ;
			VALUE 1 ;
		  FONT 'Tahoma' ;
		  SIZE 16 ;
		  BOLD ;
      NOVSCROLL ;
		  BACKCOLOR VerdeSapo ;
		  FONTCOLOR VerdeAgua ;
		  ON DBLCLICK { || VeoQueHago() } ;
		  ON ENTER { || VeoQueHago() } ;
			IMAGE {"Info.bmp","Estimate.bmp","Repair.bmp","Exit.bmp","Info2.bmp","Estimate2.bmp","Repair2.bmp","Exit2.bmp" } ;
			TEXTHEIGHT 68

*      oListbox:Style:=oListbox:Style-WS_VSCROLL       //Quitamos la Barra de desplazamiento lateral...
*      oListbox:Width:=oListbox:Width-15               //Ajustamos el nuevo Width sin la barra...

	END WINDOW
	CENTER WINDOW Form_1
	ACTIVATE WINDOW Form_1
Return

*------------------------------------------------------------------------------*
* VeoQueHago() Se ejecuta en el On Enter o DobleClick de cada opción           *
*------------------------------------------------------------------------------*
Static Function VeoQueHago
If Form_1.List_1.Value == 4
  Form_1.Release
EndIf
Return

/*
Por cada Item del ListBox:
--------------------------
a.- Se puede solo colocar un String
b.- Se puede colocar un String más una Imagen
c.- Se puede colocar un String con una Imagen para cuando esta sin seleccionar y otra imagen cuando el Item esta eleccionado
d.- El indice de imagen comienza en cero

Propiedades del ListBox:
------------------------
LISTBOX <name> [ OBJ <obj> ] ;
		[ <dummy1: OF, PARENT> <parent> ] ;
		[ WIDTH <w> ] ;
		[ HEIGHT <h> ] ;
		[ ITEMS <aRows> ] ;
		[ VALUE <value> ] ;
    [ NOVSCROLL ] ;
		[ FONT <fontname> ] ;
		[ SIZE <fontsize> ] ;
		[ <bold : BOLD> ] ;
		[ <italic : ITALIC> ] ;
		[ <underline : UNDERLINE> ] ;
		[ <strikeout : STRIKEOUT> ] ;
		[ TOOLTIP <tooltip> ] ;
		[ BACKCOLOR <backcolor> ] ;
		[ FONTCOLOR <fontcolor> ] ;
		[ ON GOTFOCUS <gotfocus> ] ;
		[ ON CHANGE <change> ] ;
		[ ON LOSTFOCUS <lostfocus> ] ;
		[ ON DBLCLICK <dblclick> ] ;
		[ <multiselect : MULTISELECT> ] ;
		[ HELPID <helpid> ] 		;
		[ <break: BREAK> ] ;
		[ <invisible : INVISIBLE> ] ;
		[ <notabstop : NOTABSTOP> ] ;
		[ <sort : SORT> ] ;
                [ <rtl: RTL> ] ;
                [ ON ENTER <enter> ]            ;
                [ <disabled: DISABLED> ]        ;
                [ SUBCLASS <subclass> ]         ;
                [ IMAGE <aImage> [ <fit: FIT> ] ] ;
                [ TEXTHEIGHT <textheight> ] ;

Recursos Gráficos:
------------------

Para Imagenes: http://www.iconarchive.com/
Para Edición: IcoFX - http://icofx.ro/

*/
