/*
 * $Id: maindemooop.prg,v 1.5 2017-08-25 19:28:45 fyurisich Exp $
 */

/*
 * ooHG Main Demo oop
 * (c) 2005-2017 Vic
 * Taken from samples distributed in OOHG distro
 * by Ciro Vargas
 */

#include "oohg.ch"
#include "i_windefs.ch"
#include "i_graph.ch"

FUNCTION Main()

   LOCAL oLabel
   Local oWnd
   PUblic _OOHG_printlibrary:="MINIPRINT"

   SET CENTURY ON

   SET TOOLTIPSTYLE BALLOON
   SET TOOLTIPBACKCOLOR  {255,0,0 }
   SET TOOLTIPFORECOLOR  {0,255,0 }

   SET AUTOADJUST ON

   oWnd := TFormMain():Define()
   oWnd:col := 0
   oWnd:row := 0
   oWnd:width:=800
   oWnd:height:=600
   oWnd:title:="Main Demo oop version"
   oWnd:OnClick:={|| msginfo(str(_OOHG_MouseRow)+str(_OOHG_MouseCol)) }


   _DefineAnyKey( oWnd, "ESCAPE", {|| oWnd:Release } )

   DEFINE TOOLBAR Toolbr buttonsize 50,20
      BUTTON TBN1 CAPTION "Boton 1" ACTION MSGINFO("Toolbar 1!")
      BUTTON TBN2 CAPTION "Boton 2" ACTION MSGINFO("Toolbar 2!") dropdown
   END TOOLBAR

   DEFINE DROPDOWN MENU BUTTON TBN2
      ITEM "Tool 1" ACTION MSGINFO("Tool 1")
      ITEM "Tool 2" ACTION MSGINFO("Tool 2")
   END MENU

   oMenum := TMenuMain():Define( )
      oMenup := TMenuItem():DefinePopUp( "Uno" )
         oItem := TMenuItem():DefineItem( "1.1" , {|| MSGINFO("Menu 1.1")} , "menu1" )
         oMenup := TMenuItem():DefinePopUp( "1.2" , "menu2" )
            oItem := TMenuItem():DefineItem( "1.2.1" , {|| MSGINFO("Menu 1.2.1")} )
            oMenup:separator()
            oMenup := TMenuItem():DefinePopUp( "1.2.2" )
               oItem := TMenuItem():DefineItem( "1.2.2.1" , {|| MSGINFO("Menu 1.2.2.1")}  )
               oItem := TMenuItem():DefineItem( "1.2.2.2" , {|| MSGINFO("Menu 1.2.2.2")} )
               oItem := TMenuItem():DefineItem( "1.2.2.3" , {|| MSGINFO("Menu 1.2.2.3")} )
            oMenup:endpopup()
            oItem := TMenuItem():DefineItem( "1.2.3" , {|| MSGINFO("Menu 1.2.3")} )
         oMenup:endpopup()
         oItem := TMenuItem():DefineItem( "1.3" , {|| MSGINFO("Menu 1.3")} )
      oMenup:endpopup()
      oMenup := TMenuItem():DefinePopUp( "Dos" , "menu3"  )
         oItem := TMenuItem():DefineItem( "2.1" , {|| MSGINFO("Menu 2.1")} )
         oItem := TMenuItem():DefineItem( "2.2" , {|| MSGINFO("Menu 2.2")} )
         TMenuItem():DefineItem( "2.3" , {|| MSGINFO("Menu 2.3")} )
      oMenup:endpopup()
      // oMenup:separator()
      oItem := TMenuItem():DefineItem( "Dato" , {|| MSGINFO("Menu Dato")} , "menu4"  )
      oMenup := TMenuItem():DefinePopUp( "Tres" )
         oItem := TMenuItem():DefineItem( "3.1" , {|| MSGINFO("Menu 3.1")}  )
         oItem := TMenuItem():DefineItem( "3.2" , {|| MSGINFO("Menu 3.2")}  )
         oItem := TMenuItem():DefineItem( "3.3" , {|| MSGINFO("Menu 3.3")}  )
      oMenup:endpopup()
      oItem := TMenuItem():DefineItem( "Salir" , {|| oWnd:Release()}  )
   oMenum:endmenu()


   on key F5 action msginfo( str( olabel:row  )+str( olabel:col ),"Hello window" )

   WITH OBJECT oLabel := TLabel():Define()
      :Caption := "(F5) Hello!!"
      :AutoSize := .T.
      :Row := 40
      :Col := 400
      :Action := { || MSGINFO("CLICK!") }
   END WITH

   WITH OBJECT oHlink := Thyperlink():Define()
      :Row := 40
      :Autosize := .T.
      :Col := 10
      :Caption := "www.yahoo.com.mx"
      :Address := "http://www.yahoo.com.mx"
   END WITH

   WITH OBJECT oText1 := Ttext():Define()
      :row       := 70
      :col       := 10
      :width     := 150
      :height    := 17
      :value     := "This is a TEXTBOX!"
      :BAckcolor :=  { GetRed( GetSysColor( COLOR_3DFACE ) ), GetGreen( GetSysColor( COLOR_3DFACE ) ), GetBlue( GetSysColor( COLOR_3DFACE ) ) }
      // :Noborder := .T.
   END WITH

   @ 90,10 TEXTBOX Txt2 VALUE "0940100101000000" WIDTH 150  height 20 INPUTMASK "@R 999-99-999-99-!!-!!!!" AUTOSKIP

   oLabel := oWnd:Txt2

   WITH OBJECT oLbl3 := Tlabel():Define()
      :row      := 110
      :col      := 10
      :value    := "Press '-'"
      :autosize := .T.
   END WITH

   @ 110,60 TEXTBOX Txt3 VALUE "1234567" WIDTH 100 height 20 INPUTMASK "@R 999.999-9" RIGHTALIGN

   oWnd:Txt3:SetKey( VK_SUBTRACT,  0, { || MoveCursor( oWnd:Txt3 ) } )
   oWnd:Txt3:SetKey( VK_OEM_MINUS, 0, { || MoveCursor( oWnd:Txt3 ) } )
   oWnd:Txt3:OnLostFocus := { || MoveCursor( oWnd:Txt3 ) }

   // @ 130,10 TEXTBOX Txt4 VALUE 111.5 WIDTH 150 height 20 numeric INPUTMASK "999,999.99"

   WITH OBJECT otxt4 := TTextpicture():Define()
      :row := 130
      :col := 10
      :picture :=  "999,999.99"
      :value := 111.5
      :transparent := .t.
   END WITH

   // @ 150,10 TEXTBOX Txt5 obj od VALUE date() WIDTH 150 height 20 DATE


   // DefineTextBox( "Txt5", , 10, 150, 150, 20, date(),,,,, .F., .F., .F.,,,,, .F.,, .F. ,.F., .F., .F., .F. , , , , .F. , .F. , .F., .F., .F.,, .F.,, .T., .F.,,, )

   WITH OBJECT oTextd := Ttextpicture():Define(,, , , , ,date() ,,,,,  , , ,,,,, ,,  ,, , ,  , , , ,  ,  , , , ,, ,, .T. , ,,,)
      :row   := 150
      :col   := 10
      :width := 150
      :height:= 20
   END WITH

   // oTextd:value := DATE()

   WITH OBJECT ochk1 := tcheckbox():Define()
      :name:="Chk"
      :row      := 170
      :col      := 10
      :caption  := "This control has a context menu!"
      :value    := .T.
      :onchange := { || msginfo( "change!" ) }
      :autosize := .T.
   END WITH

   WITH OBJECT oBtn1 := Tbutton():Define()
      :row := 200
      :col := 10
      :caption := "BUTTON!"
      :tooltip := "Click me!"
      :action := {|| msginfo(oLabel:vALUE) }
   END WITH

   WITH OBJECT orad := Tradiogroup():Define(,,10 ,230, { "Uno", "Dos", "Tres" })
      :autosize := .T.
      :aControls[ 3 ]:BACKCOLOR := BLUE
      :aControls[ 3 ]:WIDTH     := 100
      :aControls[ 3 ]:COL       := 70
      :aControls[ 1 ]:COL       := 50
      :aControls[ 2 ]:BACKCOLOR := {255,0,0}
      :aControls[ 2 ]:caption   := orAD:aControls[2]:caption
      :aControls[ 2 ]:tooltip   := "Individual tooltip"
   END WITH

   oWnd:menu1:checked := .t.
   oWnd:menu2:checked := .t.
   oWnd:menu3:enabled := .f.
   oWnd:menu4:enabled := .f.

   WITH OBJECT oMcl := Tmonthcal():Define()
      :row := 320
      :col := 10
      :value := date()
   END WITH

     omenuc:=TMenuDropDown():Define( "Chk" , )
       opop:=TMenuItem():DefinePopUp( "Nivel 1" )
          TMenuItem():DefineItem( "Nivel 1.1" , {|| MsgInfo( "Nivel 1.1!" )} )
          TMenuItem():DefineItem( "Nivel 1.2" , {|| MsgInfo( "Nivel 1.2!" )} )
       opop:endpopup()
       opop1:=TMenuItem():DefinePopUp( "Nivel 2" )
          TMenuItem():DefineItem( "Nivel 2.1" , {|| MsgInfo( "Nivel 2.1!" )} )
          TMenuItem():DefineItem( "Nivel 2.2" , {|| MsgInfo( "Nivel 2.2!" )} )
       opop1:endpopup()
     omenuc:endmenu()

   // @  0,200 GRID grd obj ogrid1 width 150 height 100 headers { "UNO", "DOS", "TRES" } widths {45,45,45} edit ;
   // items { {"1","2","3"},{"A","@","C"},{"x","y","z"} } ;
   // JUSTIFY { GRID_JTFY_RIGHT, GRID_JTFY_CENTER, GRID_JTFY_LEFT } ;
   // FONTCOLOR ORANGE;
   // DYNAMICBACKCOLOR { RGB(0,255,0), , RGB(255,0,0) } ;
   // DYNAMICFORECOLOR { NIL, RGB(255,255,0), NIL } ;
   // ON headclick { {|| ogrid1:toexcel } , {|| NIL}, {|| NIL}   }

   /*
   WITH ogrid1 := tgrid():Define()
      :row              := 40
      :col              := 200
      :width            := 150
      :height           := 100
      :aheaders         := { "UNO", "DOS", "TRES" }
      :AddItem( {"1","2","3"}, NIL, NIL )
      // :awidths       := { 45, 45, 45 }
      // :aitems        := { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } }
      :ajust            := { GRID_JTFY_RIGHT, GRID_JTFY_CENTER, GRID_JTFY_LEFT }
      :fontcolor        := ORANGE
      :dynamicbackcolor := { RGB(0,255,0), , RGB(255,0,0) }
      :dynamicforecolor := { NIL, RGB(255,255,0), NIL }
      :Aheadclick       := { { || ogrid1:toexcel() } , { || NIL }, { || NIL } }
      :SetRangeColor( 0, , 2, 2 )
   END WITH
   */
   define tab tab at 140,210 width 150 height 100
      ownd:tab:transparent := .t.
      define page "uno"
      @ 30,10 label ll1 value "tab 1" autosize
      end page
      define page "dos"
      @ 50,10 label ll2 value "tab 2" autosize
      end page
      define page "tres"
      @ 30,10 label ll3 value "tab 3" autosize

      define tab tab2 at 50,10 width 150 height 50
         define page "aaa"
         @ 30,10 label ll4 value "tab a" autosize
         end page
         define page "bbb"
         @ 30,14 label ll5 value "tab b" autosize
         end page
         define page "ccc"
         @ 30,18 label ll6 value "tab c" autosize
         end page
      end tab

      end page
   end tab

   WITH OBJECT ospin:= tspinner():Define()
      :row      := 250
      :col      := 200
      :width    := 150
      :height   := 20
      :rangemin := 0
      :rangemax := 100
   END WITH

   WITH OBJECT oCombo:= tcombo():Define()
      :row   :=280
      :col   := 200
      :width := 150
      :additem( "Uno" )
      :additem( "Dos" )
      :additem( "tres" )
   END WITH

   WITH OBJECT oDatep:= tdatepick():Define()
      oDatep:row   := 310
      oDatep:col   := 240
      oDatep:value := DATE()
   END WITH

   WITH OBJECT oTimep := ttimepick():Define()
      :row   := 513
      :col   := 21
      :value :=time()
   END WITH

   WITH OBJECT oprogm := TProgressMeter():Define()
      :row    := 350
      :col    := 240
      :width  := 120
      :height := 20
      :value  := 75
   END WITH

   DEFINE WINDOW internal obj ointernal AT 390,240 WIDTH 120 HEIGHT 100 INTERNAL VIRTUAL WIDTH 200 VIRTUAL HEIGHT 150
   @ 10, 10 LABEL LabelRed   VALUE "A" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR RED
   @ 10, 60 LABEL LabelGreen VALUE "B" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR GREEN
   @ 10,110 LABEL LabelBlue  VALUE "C" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR BLUE
   END WINDOW

   DEFINE TREE Tree_1 AT 80,400 WIDTH 150 HEIGHT 240 VALUE 15

      NODE 'Item 1'
         TREEITEM 'Item 1.1'
         TREEITEM 'Item 1.2' ID 999
         TREEITEM 'Item 1.3'
      END NODE

      NODE 'Item 2'

         TREEITEM 'Item 2.1'

         NODE 'Item 2.2'
            TREEITEM 'Item 2.2.1'
            TREEITEM 'Item 2.2.2'
            TREEITEM 'Item 2.2.3'
            TREEITEM 'Item 2.2.4'
            TREEITEM 'Item 2.2.5'
            TREEITEM 'Item 2.2.6'
         END NODE

         TREEITEM 'Item 2.3'

      END NODE

      NODE 'Item 3'
         TREEITEM 'Item 3.1'
         TREEITEM 'Item 3.2'

         NODE 'Item 3.3'
            TREEITEM 'Item 3.3.1'
            TREEITEM 'Item 3.3.2'
         END NODE

      END NODE

   END TREE

   WITH OBJECT obtn2 := tbutton():Defineimage()
      :row     := 330
      :col     := 400
      :width   := 100
      :height  := 100
      :Picture := "RESOURCES\EDIT_NEW.BMP"
      :ToolTip := "Graph Print"
      :Action  := { || printform( ) }
   END WITH

   WITH OBJECT obtn3 := tbutton():Defineimage()
      :row     := 330
      :col     := 510
      :width   := 90
      :height  := 90
      :Picture := "RESOURCES\EDIT_NEW.BMP"
      :ToolTip := "Tprint examples"
      :Action  := { || test( ) }
   END WITH

   WITH OBJECT oframe:= tframe():Define()
      :row := 10
      :col := 600
      :width := 150
      :height := 60
      :caption := "Frame"
   END WITH

   WITH OBJECT otip:= tipaddress():Define()
      :row := 30
      :col := 610
      :width := 130
      :value := {1,2,3,4}
   END WITH

   WITH OBJECT oprog:= tprogressbar():Define()
      :row      := 90
      :col      := 600
      :width    := 150
      :height   := 20
      :rangemin :=0
      :rangemax := 100
      :value    := 50
   END WITH

   WITH OBJECT oedit:= tedit():Define()
      :Row := 120
      :Col := 600
      :width := 150
      :height := 60
      :value :=  "texto1"
   END WITH

   WITH OBJECT orich:= teditrich():Define()
      :row := 200
      :col := 600
      :width := 150
      :height := 60
      :value :=  "texto2"
   END WITH

   WITH OBJECT olist:= tlistmulti():Define()
      :row   := 280
      :col   := 600
      :width := 150
      // :rows := {"uno","dos","tres"}
      :additem( "Uno" )
      :additem( "Dos" )
      :additem( "Tres" )
   END WITH

   DEFINE STATUSBAR

      STATUSITEM "This is a statusbar test!" ACTION MSGINFO( "Statusbar!" )
      CLOCK ACTION MSGINFO( "Clock!" )

   END STATUSBAR

   ownd:EndWindow()
   ownd:Center()
   ownd:activate()

   RETURN

FUNCTION printform( )

   PUBLIC aSer := { ;
               { 14280, 20420, 12870, 25347, 7640 }, ;
               { 8350, 10315, 15870, 5347, 12340 }, ;
               { 12345, -8945, 10560, 15600, 17610 } }

   Define Window GraphTest obj graphtest ;
      At 0,0 ;
      Width 640 ;
      Height 480 ;
      Title "Printing Bar Graphs" ;
       modal ;
                BACKCOLOR {255,255,255 } ;
      On Init DrawBarGraph ( aser ) ;
                on mouseclick graphtest:print()

   End Window

   GraphTest.Center

   Activate Window GraphTest

   RETURN

PROCEDURE DrawBarGraph ( aSer )

   ERASE WINDOW GraphTest

   DRAW GRAPH                     ;
      IN WINDOW GraphTest               ;
      AT 20,20                  ;
      TO 400,610                  ;
      TITLE "Sales and Product"            ;
      TYPE BARS                  ;
      SERIES aSer                  ;
      YVALUES {"Jan","Feb","Mar","Apr","May"}         ;
      DEPTH 15                  ;
      BARWIDTH 15                  ;
      HVALUES 5                  ;
      SERIENAMES {"Serie 1","Serie 2","Serie 3"}      ;
      COLORS { {128,128,255}, {255,102, 10}, {55,201, 48} }   ;
      3DVIEW                      ;
      SHOWGRID                                 ;
      SHOWXVALUES                              ;
      SHOWYVALUES                              ;
      SHOWLEGENDS

   RETURN NIL

PROCEDURE MoveCursor( oCtrl )

   oCtrl:Value := PADL( STRTRAN( LEFT( oCtrl:Value, 6 ), " ", "" ), 6 ) + RIGHT( oCtrl:Value, 1 )
   oCtrl:CaretPos := 8

   RETURN

#include "printtest.prg"

