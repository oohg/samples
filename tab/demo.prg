#include "oohg.ch"
////// By CAS
////// Modified Ciro Vargas Clemow

Function Main

DEFINE WINDOW Form_1 obj form_1;
	AT 0,0 WIDTH 480 HEIGHT 300 ;
        TITLE 'TAB / Page    -    DEMO' ;
	MAIN

	DEFINE MAIN MENU
          DEFINE POPUP 'Option'
            MENUITEM 'Add page'    ACTION Form_1.Tab_1.AddPage ( 2 , 'New Page' , 'bmp.Bmp' )
            MENUITEM 'Delete Page' ACTION (Form_1.tab_1.DeletePage ( 2 ) , Form_1.tab_1.refresh() )
            MENUITEM 'Change Page' ACTION f_page()
          END POPUP
	END MENU

	ON KEY F1 ACTION f_page_value( 1 )
	ON KEY F2 ACTION f_page_value( 2 )

	DEFINE STATUSBAR 
		STATUSITEM "" ACTION nil
	END STATUSBAR

	DEFINE TAB Tab_1 ;
		AT 10,10 ;
		WIDTH 450 ;
		HEIGHT 200 ;
		VALUE 1 ;
		TOOLTIP 'Tab Control' ;
		ON CHANGE F_CHANGE()

		PAGE 'Press F1'
			@  60,10 textbox txt_1 value '1-uno'
			@  90,10 textbox txt_2 value '2-Dos'
			@ 120,10 textbox txt_3 value '3-Tres' 
		END PAGE

		PAGE 'Press F2'
			@ 40,10 textbox txt_a value 'A-Uno' width 90
			@ 40,110 textbox txt_b value 'B-Dos' width 90

         DEFINE TAB Tab_2 ;
		      AT 70,10 ;
		      WIDTH 200 ;
		      HEIGHT 100 ;

      		PAGE 'IN1'
      			@  60,10 textbox txt_4 value '4-cuatro'
      		END PAGE

      		PAGE 'IN2'
      			@  60,10 textbox txt_5 value '5-cinco'
      		END PAGE

	      END TAB

      END PAGE

	END TAB

	f_change()

END WINDOW

Form_1:Center()
Form_1:Activate()

Return Nil

*____________________________________________________*

func f_page_value( n_para )
        form_1:tab_1:value := n_para
	f_change()
return

*____________________________________________________*

func f_page
        n_value   := Form_1:Tab_1:Value
        x_caption := Form_1:tab_1:caption( n_value )
	v_caption := InputBox( 'Label' , 'Title' , x_caption )
	if .not. empty( alltrim(v_caption) )
              Form_1.tab_1.caption( n_value ) := v_caption
	endif
return nil

*____________________________________________________*

func f_change

n_value = form_1:tab_1:value

if n_value = 1
        form_1:txt_1:setfocus()
else
        form_1:txt_a:setfocus()
endif

Form_1.StatusBar.Item(1) := ;
        'Form_1.Tab_1.Caption(' + alltrim(str(n_value)) + ') = '+;
        form_1.tab_1.caption( form_1.tab_1.value )

return nil
