/*
 * ooHG - Object Oriented Harbour GUI library
 * https://oohg.github.io/
 * "Auto.prg v.1.0" Ejemplo de AutoAdjust
 * Copyright 2007 MigSoft <fugaz_cl/at/yahoo.es>
 */

#include 'oohg.ch'

*------------------------------------------------------*
Function Main()
*------------------------------------------------------*



SET AUTOADJUST ON
SET ADJUSTWIDTH ON  /// por defecto si
SET ADJUSTFONT OFF  /// por defecto si

msginfo("Test de autoajuste, se ajusta posicion, ancho pero no font","Informacion")





   DEFINE WINDOW  Principal AT 126,66 WIDTH 648 HEIGHT 404 ;
   TITLE 'AutoAdjust (c)2007 MigSoft ' ;

       @ 320,400 BUTTON button_1 CAPTION 'Aceptar' ;
       ACTION msginfo('Button pressed') WIDTH 100 HEIGHT 28 ;
       FONT 'MS Sans Serif' SIZE 10 ;

       principal.button_1.fontcolor:={0,0,0}

       @ 320,507 BUTTON button_2 CAPTION 'Cancelar' ;
       ACTION msginfo('Button pressed') WIDTH 100 HEIGHT 28 ;
       FONT 'MS Sans Serif' SIZE 10 ;

       principal.button_2.fontcolor:={0,0,0}

       @ 18,31 FRAME frame_1 CAPTION "Datos Generales" ;
       WIDTH 576 HEIGHT 281 ;

       principal.frame_1.fontcolor:={0,0,0}
       principal.frame_1.fontname:='MS Sans Serif'
       principal.frame_1.fontsize:= 10

       @ 322,35 LABEL label_1 WIDTH 95 HEIGHT 21 ;
       VALUE 'Nombres' FONT 'MS Sans Serif' SIZE 10 ;

       principal.label_1.fontcolor:={0,0,0}

       @ 321,150 TEXTBOX text_1 HEIGHT 24 WIDTH 219 ;
       Font 'MS Sans Serif' size 10 MAXLENGTH 30 ;

       principal.text_1.fontcolor:={0,0,0}
       principal.text_1.backcolor:={255,255,255}

       @ 40,491 IMAGE image_1 PICTURE "hbprint_save" ;
       WIDTH 100 HEIGHT 100 STRETCH  ;

       @ 86,309 DATEPICKER datepicker_1 WIDTH 120 ;
       FONT 'MS Sans Serif' SIZE 10 ;

       principal.datepicker_1.fontcolor:={0,0,0}
       principal.datepicker_1.backcolor:={255,255,255}

       DEFINE TAB tab_1 AT 40,40 WIDTH 250 HEIGHT 250 ;
       FONT 'MS Sans Serif' SIZE 10 ;

           DEFINE PAGE 'Page 1' IMAGE ''

               @ 48,24 GRID grid_1 WIDTH 200 HEIGHT 158 ;
               HEADERS {'one','two'} WIDTHS  {60,60} ;
               FONT 'MS Sans Serif' SIZE 10 INPLACE ;

               principal.grid_1.fontcolor:={0,0,0}

           END PAGE

           DEFINE PAGE 'Page 2' IMAGE ''

               @ 121,29 PROGRESSBAR progressbar_1 ;
               WIDTH 191 HEIGHT 34 ;

               principal.progressbar_1.fontcolor:={0,0,0}

          END PAGE
       END TAB

       @ 128,308 LISTBOX list_1 WIDTH 158 HEIGHT 99 ;
       FONT 'MS Sans Serif' SIZE 10 ;

       principal.list_1.fontcolor:={0,0,0}
       principal.list_1.backcolor:={255,255,255}

       @ 244,313 COMBOBOX combo_1 WIDTH 100 VALUE 3;
       FONT 'MS Sans Serif' SIZE 10 ITEMS {"HMG","MiniGUI","ooHG"} ;

       principal.combo_1.fontcolor:={0,0,0}
       principal.combo_1.backcolor:={255,255,255}

       @ 243,488 BUTTON picbutt_3 PICTURE 'hbprint_close';
       ACTION msginfo('Pic button pressed') WIDTH 100 HEIGHT 44 ;

   END WINDOW

   activate window principal

Return Nil

Function AltoDP()
   principal.datepicker_1.height := 24
Return Nil
