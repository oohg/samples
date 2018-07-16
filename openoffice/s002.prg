/*
 * OpenOffice Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed bajo The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to open an OpenOffice workbook in
 * read only mode.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

FUNCTION Main

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE 'Open an OpenOffice workbook in readonly mode' ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG power !!!'
      END STATUSBAR

      @ 370,20 BUTTON btn_Abrir ;
         CAPTION 'Open File' ;
         WIDTH 140 ;
         ACTION Open()

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION Open

   LOCAL w_arch, oSerM, oDesk, oPropVals, oBook, x, bErrBlck1

   IF Empty(w_arch := GetFile({ {'*.ods','*.ods'} }, 'Open File', 'C:\', .f., .f.))
      RETURN NIL
   ENDIF

   // open service manager
   #ifndef __XHARBOUR__
      IF( oSerM := win_oleCreateObject( 'com.sun.star.ServiceManager' ) ) == NIL
         MsgStop( 'Error: OpenOffice not available. [' + win_oleErrorText()+ ']' )
         RETURN NIL
      ENDIF
   #else
      oSerM := TOleAuto():New( 'com.sun.star.ServiceManager' )
      IF Ole2TxtError() != 'S_OK'
         MsgStop( 'Error: OpenOffice not available.' )
         RETURN NIL
      ENDIF
   #endif

   // catch any errors
   bErrBlck1 := ErrorBlock( { | x | break( x ) } )

   BEGIN SEQUENCE
      // open desktop service
      IF (oDesk := oSerM:CreateInstance("com.sun.star.frame.Desktop")) == NIL
         MsgStop( 'Error: OpenOffice Desktop not available.' )
         oSerM := NIL
         BREAK
      ENDIF

      // set properties for new book
      oPropVals := oSerM:Bridge_GetStruct("com.sun.star.beans.PropertyValue")
      oPropVals:Name := "ReadOnly"
      oPropVals:Value := .T.

      // open book
      IF (oBook := oDesk:LoadComponentFromURL(OO_ConvertToURL(w_arch), "_blank", 0, {oPropVals})) == NIL
         MsgStop( 'Error: OpenOffice Calc not available.' )
         oDesk := NIL
         oSerM := NIL
         BREAK
      ENDIF

      // set first sheet as current
      oBook:getCurrentController:SetActiveSheet(oBook:Sheets:GetByIndex(0))
   RECOVER USING x
      MsgStop( x:Description, "OpenOffice Error" )
      oDesk := NIL
      oSerM := NIL
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

RETURN NIL

/*
 * EOF
 */
