#include "oohg.ch"

PROCEDURE SetValue

   DECLARE WINDOW &(cMainWin)

   &(cMainWin).Txt1.value := "hola"

   RETURN

PROCEDURE Main

   PUBLIC cMainWin := "Win_1"

   DEFINE WINDOW Win_1 ;
         TITLE 'Hola Mundo!' ;
         MAIN ;
         ON INIT SetValue()

      @ 10,10 TEXTBOX Txt1

      @ 40, 10 BUTTON But1 ACTION Win_1.SaveAs( "win1.bmp", .t., "BMP", 100, 8 )
   END WINDOW

   ACTIVATE WINDOW Win_1

   RETURN

