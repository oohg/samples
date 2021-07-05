/*
 * GroupBox Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how mouse events and tooltips are
 * handled by groupbox and frame controls.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW form1 MAIN OBJ form1 ;
      AT 0, 0 ;
      WIDTH 800 HEIGHT 620 ;
      TITLE "Mouse events and tooltips for Frame and GroupBox controls" ;
      ON MOUSEMOVE form_MouseMove()

      @ 10, 20 LABEL label1 OBJ label1 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // form
      @ 50, 20 LABEL label2 OBJ label2 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // frame and groupbox
      @ 10, 400 LABEL label3 OBJ label3 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE "" ;
         ON MOUSEMOVE label_MouseMove() ;
         ON MOUSELEAVE label_MouseLeave()      // itself
      @ 50, 400 LABEL label4 OBJ label4 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // checkbox

      @ 110, 20 LABEL 0 WIDTH 350 VALUE "GROUPBOXES" ;
         CENTERALIGN BACKCOLOR YELLOW

      @ 110, 400 LABEL 0 WIDTH 350 VALUE "FRAMES" ;
         CENTERALIGN BACKCOLOR YELLOW

      DEFINE GROUPBOX groupbox1 OBJ groupbox1 ;
         AT 150, 20 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "With Tooltip" ;
         TOOLTIP "With Tooltip"
         groupbox1:OnMouseMove := { || frame_MouseMove() }
         groupbox1:OnMouseLeave := { || frame_MouseLeave() }

         @ 190, 40 CHECKBOX checkbox1 OBJ checkbox1 ;
            CAPTION "checkbox1" ;
            WIDTH 100 HEIGHT 28 ;
            TOOLTIP "checkbox1"
         checkbox1:OnMouseMove := { || checkbox_MouseMove() }
         checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }

         @ 250, 40 LABEL label5 OBJ label5 BORDER ;
            VALUE "label5" ;
            WIDTH 120 HEIGHT 60 ;
            TOOLTIP "label5"
         label5:OnMouseMove := { || label_MouseMove() }
         label5:OnMouseLeave := { || label_MouseLeave() }

      END GROUPBOX

      DEFINE GROUPBOX groupbox2 OBJ groupbox2 ;
         AT 150, 210 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "Without Tooltip"
         groupbox2:OnMouseMove := { || frame_MouseMove() }
         groupbox2:OnMouseLeave := { || frame_MouseLeave() }

         DEFINE GROUPBOX groupbox3 OBJ groupbox3 ;
            AT 190, 230 ;
            WIDTH 120 HEIGHT 90 ;
            CAPTION "Inner"
            groupbox3:OnMouseMove := { || frame_MouseMove() }
            groupbox3:OnMouseLeave := { || frame_MouseLeave() }

            @ 220, 250 CHECKBOX checkbox2 ;
               OBJ checkbox2 ;
               CAPTION "checkbox2" ;
               WIDTH 80 HEIGHT 28 ;
               TOOLTIP "checkbox2"
            checkbox2:OnMouseMove := { || checkbox_MouseMove() }
            checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }

         END GROUPBOX

         @ 300, 230 CHECKBOX checkbox3 ;
            OBJ checkbox3 ;
            CAPTION "checkbox3" ;
            WIDTH 80 HEIGHT 28 ;
            TOOLTIP "checkbox3"
         checkbox3:OnMouseMove := { || checkbox_MouseMove() }
         checkbox3:OnMouseLeave := { || checkbox_MouseLeave() }

      END GROUPBOX

      @ 400, 20 LABEL 0 WIDTH 150 HEIGHT 150 VALUE "Move the mouse around and see what happens!"

      @ 150, 400 FRAME frame11 OBJ frame11 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "With Tooltip" ;
         TOOLTIP "With Tooltip"
      frame11:OnMouseMove := { || frame_MouseMove() }
      frame11:OnMouseLeave := { || frame_MouseLeave() }

      @ 190, 420 CHECKBOX checkbox14 OBJ checkbox14 ;
         CAPTION "checkbox14" ;
         WIDTH 120 HEIGHT 28 ;
         TOOLTIP "checkbox14"
      checkbox14:OnMouseMove := { || checkbox_MouseMove() }
      checkbox14:OnMouseLeave := { || checkbox_MouseLeave() }
      frame11:AddExcludeArea( checkbox14:Name, {420, 190, 540, 218} )

      @ 250, 420 LABEL label16 OBJ label16 BORDER ;
         VALUE "label16" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "label16"
      label16:OnMouseMove := { || label_MouseMove() }
      label16:OnMouseLeave := { || label_MouseLeave() }
      frame11:AddExcludeArea( label16:Name, {420, 250, 540, 278} )

      @ 150, 590 FRAME frame12 OBJ frame12 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "Without Tooltip"
      frame12:OnMouseMove := { || frame_MouseMove() }
      frame12:OnMouseLeave := { || frame_MouseLeave() }

      @ 190, 610 FRAME frame13 OBJ frame13 ;
         WIDTH 120 HEIGHT 90 ;
         CAPTION "Inner"
      frame13:OnMouseMove := { || frame_MouseMove() }
      frame13:OnMouseLeave := { || frame_MouseLeave() }

      @ 220, 630 CHECKBOX checkbox15 ;
         OBJ checkbox15 ;
         CAPTION "checkbox15" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "checkbox15"
      checkbox15:OnMouseMove := { || checkbox_MouseMove() }
      checkbox15:OnMouseLeave := { || checkbox_MouseLeave() }

      @ 300, 610 CHECKBOX checkbox16 ;
         OBJ checkbox16 ;
         CAPTION "checkbox16" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "checkbox16"
      checkbox16:OnMouseMove := { || checkbox_MouseMove() }
      checkbox16:OnMouseLeave := { || checkbox_MouseLeave() }

// Second row, no exclusions: control tooltips are ignored!

      @ 370, 400 FRAME frame21 OBJ frame21 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "With Tooltip No Excl." ;
         TOOLTIP "With Tooltip No Excl."
      frame21:OnMouseMove := { || frame_MouseMove() }
      frame21:OnMouseLeave := { || frame_MouseLeave() }

      @ 410, 420 CHECKBOX checkbox24 OBJ checkbox24 ;
         CAPTION "checkbox24" ;
         WIDTH 120 HEIGHT 28 ;
         TOOLTIP "checkbox24"
      checkbox24:OnMouseMove := { || checkbox_MouseMove() }
      checkbox24:OnMouseLeave := { || checkbox_MouseLeave() }

      @ 470, 420 LABEL label26 OBJ label26 BORDER ;
         VALUE "label26" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "label26"
      label26:OnMouseMove := { || label_MouseMove() }
      label26:OnMouseLeave := { || label_MouseLeave() }

      @ 370, 590 FRAME frame22 OBJ frame22 ;
         WIDTH 160 HEIGHT 200 ;
         CAPTION "Without Tooltip No Excl."
      frame22:OnMouseMove := { || frame_MouseMove() }
      frame22:OnMouseLeave := { || frame_MouseLeave() }

      @ 410, 610 FRAME frame23 OBJ frame23 ;
         WIDTH 120 HEIGHT 90 ;
         CAPTION "Inner"
      frame23:OnMouseMove := { || frame_MouseMove() }
      frame23:OnMouseLeave := { || frame_MouseLeave() }

      @ 440, 630 CHECKBOX checkbox25 ;
         OBJ checkbox25 ;
         CAPTION "checkbox25" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "checkbox25"
      checkbox25:OnMouseMove := { || checkbox_MouseMove() }
      checkbox25:OnMouseLeave := { || checkbox_MouseLeave() }

      @ 520, 610 CHECKBOX checkbox26 ;
         OBJ checkbox26 ;
         CAPTION "checkbox26" ;
         WIDTH 80 HEIGHT 28 ;
         TOOLTIP "checkbox26"
      checkbox26:OnMouseMove := { || checkbox_MouseMove() }
      checkbox26:OnMouseLeave := { || checkbox_MouseLeave() }

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW ( LastForm.Name )
   ACTIVATE WINDOW ( LastForm.Name )

   RETURN NIL

FUNCTION form_MouseMove()

   LOCAL x, y
   LOCAL obj := _OOHG_ThisObject

   x := _OOHG_MouseRow
   y := _OOHG_MouseCol
   IF ! obj:lForm
      x += obj:nRow
      y += obj:nCol
   ENDIF
   label1:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

   RETURN NIL

FUNCTION frame_MouseMove()

   LOCAL x, y
   LOCAL obj := _OOHG_ThisObject

   x := _OOHG_MouseRow
   y := _OOHG_MouseCol
   IF ! obj:lForm
      x += obj:nRow
      y += obj:nCol
   ENDIF
   label2:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

   RETURN NIL

FUNCTION frame_MouseLeave()

   label2:Value := ""

   RETURN NIL

FUNCTION label_MouseMove()

   LOCAL x, y
   LOCAL obj := _OOHG_ThisObject

   x := _OOHG_MouseRow
   y := _OOHG_MouseCol
   IF ! obj:lForm
      x += obj:nRow
      y += obj:nCol
   ENDIF
   obj:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

   RETURN NIL

FUNCTION label_MouseLeave()

   _OOHG_ThisObject:Value := _OOHG_ThisObject:Name

   RETURN NIL

FUNCTION checkbox_MouseMove()

   LOCAL x, y
   LOCAL obj := _OOHG_ThisObject

   x := _OOHG_MouseRow
   y := _OOHG_MouseCol
   IF ! obj:lForm
      x += obj:nRow
      y += obj:nCol
   ENDIF
   label4:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

   RETURN NIL

FUNCTION checkbox_MouseLeave()

   label4:Value := ""

   RETURN NIL

/*
 * EOF
 */
