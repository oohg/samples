/*
   Este ejemplo requiere que tengas instalado el ocx de RMChart
   puedes descargarlo de http://www.rmchart.com/
   Oscar Lira Lira |oSkAr| - adaptado para ooHG por MigSoft
*/

#include "oohg.ch"
#include "RMChart.ch"

Static oChart, oWnd

FUNCTION Main()

   Define Window Start OBJ oWnd At 0,0 Width 480 Height 300     ;
          Title "Demo RMChart - Thanks |oSkAr|" Main            ;
          ON Size Ajust() ON Maximize Ajust()

          @ 0,0 ACTIVEX ActiveX OBJ oChart Width oWnd:Width - 7 ;
          Height oWnd:Height - 35 PROGID "RMChart.RMChartX"

   end window

   oChart:Font             := "Tahoma"
   oChart:RMCStyle         := RMC_CTRLSTYLEFLAT
   oChart:RMCUserWatermark := "Test by MigSoft"

   oChart:AddRegion()

   WITH OBJECT oChart:Region( 1 )

        :Footer = "https://oohg.github.io/"
        :AddCaption()

         WITH OBJECT :Caption()
              :Titel     := "ooHG Test"
              :FontSize  := 10
              :Bold      := .T.
         END

         :AddGridlessSeries()

         WITH OBJECT :GridLessSeries
               :SeriesStyle      := RMC_PIE_GRADIENT
               :Alignment        := RMC_FULL
               :Explodemode      := RMC_EXPLODE_NONE
               :Lucent           := .F.
               :ValueLabelOn     := RMC_VLABEL_ABSOLUTE
               :HatchMode        := RMC_HATCHBRUSH_OFF
               :StartAngle       := 0
               :DataString       := "30*15*40*35"
         END

   END

  /// oChart:Draw2Clipboard( RMC_EMF )
   oChart:Draw( .T. )

   oWnd:Center()
   oWnd:Activate()

RETURN(Nil)

Procedure Ajust()
   oChart:Width  := iif( oWnd:Width  -  7 < 50, 50, oWnd:Width  -  7 )
   oChart:Height := iif( oWnd:Height - 35 < 50, 50, oWnd:Height - 35 )
Return(Nil)
