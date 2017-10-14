
#include 'oohg.ch'

FUNCTION Main
   LOCAL oLbl

   DEFINE WINDOW Main ;
   TITLE 'Simulated colored frame'

      @ 18,36 LABEL label_1 VALUE "Datos Generales" ;
         FONTCOLOR BLUE OBJ oLbl

      @ 18,31 FRAME frame_1 CAPTION "                            " ;
         WIDTH 200 HEIGHT 100 TRANSPARENT

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   ACTIVATE WINDOW Main
RETURN Nil
