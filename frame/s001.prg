/*
 * Frame Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how mouse events and tooltips are
 * handled by frame controls.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW form1 MAIN OBJ form1 ;
      AT 0, 0 ;
      WIDTH 980 HEIGHT 500 ;
      TITLE "Mouse events and tooltips for Frame controls" ;
      ON MOUSEMOVE form_MouseMove()

      @ 10, 20 LABEL label1 OBJ label1 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // form
      @ 50, 20 LABEL label2 OBJ label2 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // frame
      @ 10, 450 LABEL label3 OBJ label3 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE "" ;
         ON MOUSEMOVE label_MouseMove() ;
         ON MOUSELEAVE label_MouseLeave()      // itself
      @ 50, 450 LABEL label4 OBJ label4 ;
         WIDTH 300 HEIGHT 30 BORDER VALUE ""   // checkbox

      @ 10, 330 LABEL 0 WIDTH 110 HEIGHT 100 VALUE "Move the mouse around and see what happens!"

// Line 1, column 1
      row := 150
      col := 20

      @ row, col FRAME c1_frame1 OBJ c1_frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "Without Tooltip"
      c1_frame1:OnMouseMove := { || frame_MouseMove() }
      c1_frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ row + 40, col + 20 FRAME c1_frame2 OBJ c1_frame2 ;
         WIDTH 130 HEIGHT 90 ;
         CAPTION "Inner No TT"
      c1_frame2:OnMouseMove := { || frame_MouseMove() }
      c1_frame2:OnMouseLeave := { || frame_MouseLeave() }
      c1_frame1:AddExcludeArea( c1_frame2:Name, {col + 20, row + 40, col + 20 + 130, row + 40 + 90} )

      @ row + 70, col + 40 CHECKBOX c1_checkbox1 OBJ c1_checkbox1 ;
         CAPTION "c1_checkbox1" ;
         WIDTH 95 HEIGHT 28 ;
         TOOLTIP "c1_checkbox1"
      c1_checkbox1:OnMouseMove := { || checkbox_MouseMove() }
      c1_checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }
      c1_frame2:AddExcludeArea( c1_checkbox1:Name, {col + 40, row + 70, col + 40 + 60, row + 70 + 28} )

      @ row + 150, col + 20 CHECKBOX c1_checkbox2 OBJ c1_checkbox2 ;
         CAPTION "c1_checkbox2" ;
         WIDTH 110 HEIGHT 28 ;
         TOOLTIP "c1_checkbox2"
      c1_checkbox2:OnMouseMove := { || checkbox_MouseMove() }
      c1_checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }
      c1_frame1:AddExcludeArea( c1_checkbox2:Name, {col + 20, row + 150, col + 20 + 110, row + 150 + 28} )

      @ row + 200, col + 20 LABEL c1_label1 OBJ c1_label1 ;
         BORDER ;
         VALUE "c1_label1" ;
         WIDTH 120 HEIGHT 60 ;
         TOOLTIP "c1_label1"
      c1_label1:OnMouseMove := { || label_MouseMove() }
      c1_label1:OnMouseLeave := { || label_MouseLeave() }
      c1_frame1:AddExcludeArea( c1_label1:Name, {col + 20, row + 200, col + 20 + 120, row + 200 + 60} )

// Line 1, column 2
      row += 0
      col += 190

      @ row, col FRAME c2_frame1 OBJ c2_frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip" ;
         TOOLTIP "With Tooltip"
      c2_frame1:OnMouseMove := { || frame_MouseMove() }
      c2_frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ row + 40, col + 20 FRAME c2_frame2 OBJ c2_frame2 ;
         WIDTH 130 HEIGHT 90 ;
         CAPTION "Inner No TT"
      c2_frame2:OnMouseMove := { || frame_MouseMove() }
      c2_frame2:OnMouseLeave := { || frame_MouseLeave() }
      c2_frame1:AddExcludeArea( c2_frame2:Name, {col + 20, row + 40, col + 20 + 130, row + 40 + 90} )

      @ row + 70, col + 40 CHECKBOX c2_checkbox1 OBJ c2_checkbox1 ;
         CAPTION "c2_checkbox1" ;
         WIDTH 95 HEIGHT 28 ;
         TOOLTIP "c2_checkbox1"
      c2_checkbox1:OnMouseMove := { || checkbox_MouseMove() }
      c2_checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }
      c2_frame2:AddExcludeArea( c2_checkbox1:Name, {col + 40, row + 70, col + 40 + 60, row + 70 + 28} )

      @ row + 150, col + 20 CHECKBOX c2_checkbox2 OBJ c2_checkbox2 ;
         CAPTION "c2_checkbox2" ;
         WIDTH 110 HEIGHT 28 ;
         TOOLTIP "c2_checkbox2"
      c2_checkbox2:OnMouseMove := { || checkbox_MouseMove() }
      c2_checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }
      c2_frame1:AddExcludeArea( c2_checkbox2:Name, {col + 20, row + 150, col + 20 + 110, row + 150 + 28} )

      @ row + 200, col + 20 LABEL c2_label1 OBJ c2_label1 ;
         BORDER ;
         VALUE "c2_label1" ;
         WIDTH 120 HEIGHT 60 ;
         TOOLTIP "c2_label1"
      c2_label1:OnMouseMove := { || label_MouseMove() }
      c2_label1:OnMouseLeave := { || label_MouseLeave() }
      c2_frame1:AddExcludeArea( c2_label1:Name, {col + 20, row + 200, col + 20 + 120, row + 200 + 60} )

// Line 1, column 3
      row += 0
      col += 190

      @ row, col FRAME c3_frame1 OBJ c3_frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip PostParent" ;
         TOOLTIP "With Tooltip PostParent" POSTPARENT
      c3_frame1:OnMouseMove := { || frame_MouseMove() }
      c3_frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ row + 40, col + 20 FRAME c3_frame2 OBJ c3_frame2 ;
         WIDTH 130 HEIGHT 90 ;
         CAPTION "Inner No TT"
      c3_frame2:OnMouseMove := { || frame_MouseMove() }
      c3_frame2:OnMouseLeave := { || frame_MouseLeave() }
      c3_frame1:AddExcludeArea( c3_frame2:Name, {col + 20, row + 40, col + 20 + 130, row + 40 + 90} )

      @ row + 70, col + 40 CHECKBOX c3_checkbox1 OBJ c3_checkbox1 ;
         CAPTION "c3_checkbox1" ;
         WIDTH 95 HEIGHT 28 ;
         TOOLTIP "c3_checkbox1"
      c3_checkbox1:OnMouseMove := { || checkbox_MouseMove() }
      c3_checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }
      c3_frame2:AddExcludeArea( c3_checkbox1:Name, {col + 40, row + 70, col + 40 + 60, row + 70 + 28} )

      @ row + 150, col + 20 CHECKBOX c3_checkbox2 OBJ c3_checkbox2 ;
         CAPTION "c3_checkbox2" ;
         WIDTH 110 HEIGHT 28 ;
         TOOLTIP "c3_checkbox2"
      c3_checkbox2:OnMouseMove := { || checkbox_MouseMove() }
      c3_checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }
      c3_frame1:AddExcludeArea( c3_checkbox2:Name, {col + 20, row + 150, col + 20 + 110, row + 150 + 28} )

      @ row + 200, col + 20 LABEL c3_label1 OBJ c3_label1 ;
         BORDER ;
         VALUE "c3_label1" ;
         WIDTH 120 HEIGHT 60 ;
         TOOLTIP "c3_label1"
      c3_label1:OnMouseMove := { || label_MouseMove() }
      c3_label1:OnMouseLeave := { || label_MouseLeave() }
      c3_frame1:AddExcludeArea( c3_label1:Name, {col + 20, row + 200, col + 20 + 120, row + 200 + 60} )

// Line 1, column 4
      row += 0
      col += 190

      @ row, col FRAME c4_frame1 OBJ c4_frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip PostParent" ;
         TOOLTIP "With Tooltip PostParent" POSTPARENT
      c4_frame1:OnMouseMove := { || frame_MouseMove() }
      c4_frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ row + 40, col + 20 FRAME c4_frame2 OBJ c4_frame2 ;
         WIDTH 130 HEIGHT 90 ;
         CAPTION "Inner with TT" ;
         TOOLTIP "Inner No PostParent"
      c4_frame2:OnMouseMove := { || frame_MouseMove() }
      c4_frame2:OnMouseLeave := { || frame_MouseLeave() }
      c4_frame1:AddExcludeArea( c4_frame2:Name, {col + 20, row + 40, col + 20 + 130, row + 40 + 90} )

      @ row + 70, col + 40 CHECKBOX c4_checkbox1 OBJ c4_checkbox1 ;
         CAPTION "c4_checkbox1" ;
         WIDTH 95 HEIGHT 28 ;
         TOOLTIP "c4_checkbox1"
      c4_checkbox1:OnMouseMove := { || checkbox_MouseMove() }
      c4_checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }
      c4_frame2:AddExcludeArea( c4_checkbox1:Name, {col + 40, row + 70, col + 40 + 60, row + 70 + 28} )

      @ row + 150, col + 20 CHECKBOX c4_checkbox2 OBJ c4_checkbox2 ;
         CAPTION "c4_checkbox2" ;
         WIDTH 110 HEIGHT 28 ;
         TOOLTIP "c4_checkbox2"
      c4_checkbox2:OnMouseMove := { || checkbox_MouseMove() }
      c4_checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }
      c4_frame1:AddExcludeArea( c4_checkbox2:Name, {col + 20, row + 150, col + 20 + 110, row + 150 + 28} )

      @ row + 200, col + 20 LABEL c4_label1 OBJ c4_label1 ;
         BORDER ;
         VALUE "c4_label1" ;
         WIDTH 120 HEIGHT 60 ;
         TOOLTIP "c4_label1"
      c4_label1:OnMouseMove := { || label_MouseMove() }
      c4_label1:OnMouseLeave := { || label_MouseLeave() }
      c4_frame1:AddExcludeArea( c4_label1:Name, {col + 20, row + 200, col + 20 + 120, row + 200 + 60} )

// Line 1, column 5
      row += 0
      col += 190

      @ row, col FRAME c5_frame1 OBJ c5_frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip PostParent" ;
         TOOLTIP "With Tooltip PostParent" POSTPARENT
      c5_frame1:OnMouseMove := { || frame_MouseMove() }
      c5_frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ row + 40, col + 20 FRAME c5_frame2 OBJ c5_frame2 ;
         WIDTH 130 HEIGHT 90 ;
         CAPTION "Inner with TT" ;
         TOOLTIP "Inner PostParent" POSTPARENT
      c5_frame2:OnMouseMove := { || frame_MouseMove() }
      c5_frame2:OnMouseLeave := { || frame_MouseLeave() }
      c5_frame1:AddExcludeArea( c5_frame2:Name, {col + 20, row + 40, col + 20 + 130, row + 40 + 90} )

      @ row + 70, col + 40 CHECKBOX c5_checkbox1 OBJ c5_checkbox1 ;
         CAPTION "c5_checkbox1" ;
         WIDTH 95 HEIGHT 28 ;
         TOOLTIP "c5_checkbox1"
      c5_checkbox1:OnMouseMove := { || checkbox_MouseMove() }
      c5_checkbox1:OnMouseLeave := { || checkbox_MouseLeave() }
      c5_frame2:AddExcludeArea( c5_checkbox1:Name, {col + 40, row + 70, col + 40 + 60, row + 70 + 28} )

      @ row + 150, col + 20 CHECKBOX c5_checkbox2 OBJ c5_checkbox2 ;
         CAPTION "c5_checkbox2" ;
         WIDTH 110 HEIGHT 28 ;
         TOOLTIP "c5_checkbox2"
      c5_checkbox2:OnMouseMove := { || checkbox_MouseMove() }
      c5_checkbox2:OnMouseLeave := { || checkbox_MouseLeave() }
      c5_frame1:AddExcludeArea( c5_checkbox2:Name, {col + 20, row + 150, col + 20 + 110, row + 150 + 28} )

      @ row + 200, col + 20 LABEL c5_label1 OBJ c5_label1 ;
         BORDER ;
         VALUE "c5_label1" ;
         WIDTH 120 HEIGHT 60 ;
         TOOLTIP "c5_label1"
      c5_label1:OnMouseMove := { || label_MouseMove() }
      c5_label1:OnMouseLeave := { || label_MouseLeave() }
      c5_frame1:AddExcludeArea( c5_label1:Name, {col + 20, row + 200, col + 20 + 120, row + 200 + 60} )

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
