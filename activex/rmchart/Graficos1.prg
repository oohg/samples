#include "oohg.ch"
#include "RMChart_SDC.ch"

Function Main
request HB_CODEPAGE_ESMWIN        //Estas lineas hacen que se visualicen correctamente los simbolos especiales!!!
hb_setcodepage("ESMWIN")
set language to spanish
SET(_SET_DBCODEPAGE,"CP850")
REQUEST DBFCDX                     //Cargo el controlador de CDXs
RDDSETDEFAULT("DBFCDX")            //Establesco al DBFCDX por defecto
SET AUTORDER TO 1                  //Al abrise el indice, selecciono el 1ø indice

Set Century On
Set Epoch To 1960
Set Deleted On
Set Date To British
Set Exclusive Off
Set Exact On
Set Multiple Off Warning
Set Navigation Extended
Set ToolTipBalloon On

_OOHG_NestedSameEvent( .T. )  //Esto permite multiples ejecuciones de Procedure o Function
SetOneArrayItemPerLine( .T. )

Define Window Principal At 0,0 Width 480 Height 360  Title "Demo RMChart - |Serginio|" Main
  DEFINE MAIN MENU
      DEFINE POPUP "&Graficos" NAME Graf
        MENUITEM "Graficar RMChart"          ACTION Graficador() 
        MENUITEM "Salir"                     ACTION Exit Program 
      END POPUP  
  END MENU
End Window
Center Window Principal
Activate Window Principal
Return


function Graficador
Public oRMChart, oWnd

Define Window Start OBJ oWnd At 0,0 Width 480 Height 360  Title "Demo RMChart - |Serginio|" Modal  ON Size Ajust() ON Maximize Ajust()
  @ 0,0 ACTIVEX ActiveX OBJ oRMChart Width 480-15 Height 300-34 PROGID "RMChart.RMChartX"
  @ 290,10  BUTTON btnAceptar OBJ btn  CAPTION 'Acep&tar'  ACTION Graficar()
  @ 290,110 BUTTON btnPrinter OBJ btn1 CAPTION '&Imprimir' ACTION { || oRMChart:Draw2Printer() } 
  @ 290,220 BUTTON btnFile    OBJ btn2 CAPTION '&Archivo'  ACTION { || oRMChart:Draw2File('c:\sergito.png') } 
End Window

   oRMChart:Reset()
   oRMChart:RMCWidth            := 480-15
   oRMChart:RMCHeight           := 300-34
   oRMChart:RMCBgImage          := ""
   oRMChart:Font                := "Tahoma"
   oRMChart:RMCToolTipWidth     := 0
   oRMChart:RMCHelpingGridSize  := 0
   oRMChart:RMCHelpingGridColor := Default
   oRMChart:RMCBitmapColor      := Default
   oRMChart:RMCStyle            := RMC_CTRLSTYLE3D           //RMC_CTRLSTYLEFLATSHADOW //RMC_CTRLSTYLEFLAT
   oRMChart:RMCUserWatermark    := "SDC Soluciones Informáticas"
   oRMChart:RMCUserWMAlignment  := RMC_TEXTLEFT 
   oRMChart:RMCUserWMLucent     := 30
   oRMChart:RMCBackColor        := LightBlue
   
   oRMChart:AddRegion()
     oRMChart:Region(1):Left = 0
     oRMChart:Region(1):Top = 0
     oRMChart:Region(1):Width = 200
     oRMChart:Region(1):Footer = "http://www.sdcinformatica.com.ar"
   oRMChart:Region(1):AddCaption()
     oRMChart:Region(1):Caption:Titel     := "Oohg..."
     oRMChart:Region(1):Caption:FontSize  := 10
     oRMChart:Region(1):Caption:Bold      := .t.
   oRMChart:Region(1):AddGridlessSeries()
     oRMChart:Region(1):GridLessSeries:SeriesStyle      := RMC_PIE_3D_GRADIENT
     oRMChart:Region(1):GridLessSeries:Alignment        := RMC_HALF_BOTTOM
     oRMChart:Region(1):GridLessSeries:Explodemode      := RMC_EXPLODE_SMALLEST
     oRMChart:Region(1):GridLessSeries:Lucent           := .F.
     oRMChart:Region(1):GridLessSeries:ValueLabelOn     := RMC_VLABEL_ABSOLUTE
     oRMChart:Region(1):GridLessSeries:HatchMode        := RMC_HATCHBRUSH_OFF
     oRMChart:Region(1):GridLessSeries:StartAngle       := 0
     oRMChart:Region(1):GridLessSeries:DataString       := "30*15*40*35*32*12"

   oRMChart:AddRegion()
     oRMChart:Region(2):Left = 230
     oRMChart:Region(2):Top = 0
     oRMChart:Region(2):Width = 200
     oRMChart:Region(2):Footer = "www.sdcinformatica.com.ar"
   oRMChart:Region(2):AddCaption()
     oRMChart:Region(2):Caption:Titel     := "Totales"
     oRMChart:Region(2):Caption:FontSize  := 10
     oRMChart:Region(2):Caption:Bold      := .t.
   oRMChart:Region(2):AddGridlessSeries()
     oRMChart:Region(2):GridLessSeries:SeriesStyle      := RMC_PIE_3D_GRADIENT
     oRMChart:Region(2):GridLessSeries:Alignment        := RMC_FULL
     oRMChart:Region(2):GridLessSeries:Explodemode      := RMC_EXPLODE_SMALLEST
     oRMChart:Region(2):GridLessSeries:Lucent           := .T.
     oRMChart:Region(2):GridLessSeries:ValueLabelOn     := RMC_VLABEL_ABSOLUTE
     oRMChart:Region(2):GridLessSeries:HatchMode        := RMC_HATCHBRUSH_OFF
     oRMChart:Region(2):GridLessSeries:StartAngle       := 0
     oRMChart:Region(2):GridLessSeries:DataString       := "30*15*40*35*32*12"
   
   oRMChart:Visible:=.f.
Center Window Start
Activate Window Start
Return

Procedure Ajust()
   oRMChart:Width  := iif( oWnd:Width  -  15 < 50 , 50 , oWnd:Width  -  15 )
   oRMChart:Height := iif( oWnd:Height - 34-40 < 50 , 50 , oWnd:Height - 34-40 )
   btn:col  := iif( oWnd:Width  -  470 < 50 , 50 , oWnd:Width  -  470 )
   btn:row  := iif( oWnd:Height - 70 < 50 , 50 , oWnd:Height - 70 )
Return(Nil)

Function Graficar
Static nCant:=0
nCant++
   oRMChart:Visible:=.t.
   oRMChart:Region(1):Caption:Titel := "Oohg..."+StrZero(nCant,3)
   If nCant=10
      oRMChart:Region(1):GridLessSeries:StartAngle       := 50
      oRMChart:Region(1):GridLessSeries:Alignment := RMC_FULL
      oRMChart:RMCStyle                           := RMC_CTRLSTYLEIMAGE
      oRMChart:RMCBgImage                         := "paper.jpg"
      
   EndIf   
   oRMChart:Region(1):GridLessSeries:DataString := '30*15*40*'+AllTrim(Str(nCant))+'*35*32*12'
   oRMChart:Draw(.t.)
Return


