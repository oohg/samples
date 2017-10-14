#include "oohg.ch"


*-------------------------
Function Main
*-------------------------

DEFINE WINDOW Ventana AT 370 , 333 WIDTH 560 HEIGHT 400 TITLE "Mixed Mode!" ICON NIL MAIN
   
   DEFINE BUTTON Button_1
      ROW    170
      COL    180
      WIDTH  150
      HEIGHT 50
      CAPTION "Run Console!!!"
      ACTION   Console()
      FONTNAME  "Arial"
      FONTSIZE  9
   END BUTTON
   
END WINDOW

Activate window Ventana

Return Nil


*-------------------------
Function Console()
*-------------------------
REQUEST HB_GT_WIN_DEFAULT


SetMode(25,80)

CLS

@ 10,10 say 'Hello'

alert('Hello')

Return nil









