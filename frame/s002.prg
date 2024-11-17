/*
 * Frame Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how mouse events and tooltips are
 * handled by frame controls. It also shows the effect
 * of the frame's POSTPARENT clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW form1 MAIN OBJ form1 ;
      AT 0, 0 ;
      WIDTH 640 HEIGHT 480 ;
      NOSIZE ;
      TITLE "Mouse events and tooltips for Frame controls" ;
      ON MOUSEMOVE form_MouseMove()

      @ 10, 20 LABEL lbl_form OBJ lbl_form ;
         WIDTH 300 HEIGHT 30 BORDER ;
         VALUE ""

      @ 50, 20 LABEL lbl_frame OBJ lbl_frame ;
         WIDTH 300 HEIGHT 30 BORDER ;
         VALUE ""

      @ 10, 330 LABEL 0 ;
         WIDTH 110 HEIGHT 100 ;
         VALUE "Move the mouse around and see what happens!"

      @ 150, 20 FRAME frame1 OBJ frame1 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip No PostParent" ;
         TOOLTIP "With Tooltip No PostParent"
      frame1:OnMouseMove := { || frame_MouseMove() }
      frame1:OnMouseLeave := { || frame_MouseLeave() }

      @ 150, 210 FRAME frame2 OBJ frame2 ;
         WIDTH 160 HEIGHT 280 ;
         CAPTION "With Tooltip PostParent" ;
         TOOLTIP "With Tooltip PostParent" POSTPARENT
      frame2:OnMouseMove := { || frame_MouseMove() }
      frame2:OnMouseLeave := { || frame_MouseLeave() }

      @ 150, 400 LABEL 0 ;
         AUTOSIZE ;
         VALUE "Note that subclause POSTPARENT" + CRLF + ;
               "forces the FRAME control to " + CRLF + ;
               "relay its WM_MOUSEMOVE messages" + CRLF + ;
               "to its parent and to ignore its" + CRLF + ;
               "WM_MOUSELEAVE messages."

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
   lbl_form:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

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
   lbl_frame:Value := obj:Name + " : " + "Row " + hb_ntos( x ) + " Col " + hb_ntos( y )

   RETURN NIL

FUNCTION frame_MouseLeave()

   LOCAL x, y
   LOCAL obj := _OOHG_ThisObject

   x := _OOHG_MouseRow
   y := _OOHG_MouseCol
   IF ! obj:lForm
      x += obj:nRow
      y += obj:nCol
   ENDIF
   lbl_frame:Value := obj:Name + " : " + "MouseLeave"

   RETURN NIL

/*
 * EOF
 */
