/*
 * Form Sample n° 10
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to set the value of the currently
 * focused control of a form from a different form.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW FormMain ;
      AT 0, 0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Set previously focused control" ;
      MAIN ;
      NOMAXIMIZE ;
      NOSIZE

      @ 20, 20 BUTTON btn1 ;
         CAPTION "Click me"

      @ 50, 20 TEXTBOX txt1 ;
         NUMERIC ;
         PICTURE "999,999.99" ;
         VALUE 0

      @ 80, 20 TEXTBOX txt2 ;
         NUMERIC ;
         PICTURE "999,999.99" ;
         VALUE 0

      @ 110, 20 LABEL lbl1 ;
         VALUE 'Click any control and hit F5' ;
         AUTOSIZE

      ON KEY ESCAPE ACTION ThisWindow.Release()
      ON KEY F5 ACTION OpenSecond( GetControlObjectByHandle( GetFocus() ) )
   END WINDOW

   ACTIVATE WINDOW FormMain

RETURN NIL

FUNCTION OpenSecond( oCtrl )

   LOCAL lSet := .F.

   IF ! ( oCtrl:Type == "NUMTEXT" .OR. ( oCtrl:Type == "TEXTPICTURE" .AND. oCtrl:DataType == "N" ) )
      RETURN NIL
   ENDIF

   DEFINE WINDOW SecondForm ;
      AT 100, 400 ;
      WIDTH 420 ;
      HEIGHT 220 ;
      TITLE "Second Form" ;
      NOMAXIMIZE ;
      NOSIZE ;
      ON RELEASE IIF( lSet, oCtrl:Value := oNewValue:Value, NIL )

      @ 20, 20 TEXTBOX txt3 OBJ oNewValue ;
         NUMERIC ;
         PICTURE "999,999.99" ;
         VALUE 0

      @ 50, 20 LABEL lbl2 ;
         HEIGHT 40 ;
         VALUE 'Enter new value for [' + oCtrl:Name + '] and click Save, hit ESC or click X to Abort' ;
         AUTOSIZE

      @ 100, 20 BUTTON btn2 ;
         CAPTION "Save" ;
         ACTION ( lSet := .T., ThisWindow.Release() )

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   ACTIVATE WINDOW SecondForm

RETURN NIL

/*
 * EOF
 */
