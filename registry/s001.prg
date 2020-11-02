/*
 * Windows Registry Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to save the position and size of a
 * form and how to restore them when the form is initialized.
 * It also shows how to save/get an array of binary values.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL lClean

   DEFINE WINDOW FormMain ;
      OBJ oForm ;
      TITLE 'Registry Operations' ;
      MINWIDTH 300 ;
      MINHEIGHT 300 ;
      ON INIT lClean := LoadReg() ;
      ON RELEASE iif( lClean, NIL, CleanReg() )

      @ 20, 20 BUTTON btn_Save ;
         WIDTH 70 ;
         CAPTION 'Save' ;
         ACTION ( SaveReg(), lClean := .F. )

      @ 20, 100 BUTTON btn_Delete ;
         WIDTH 70 ;
         CAPTION 'Delete' ;
         ACTION ( DeleteReg(), lClean := .T. )

      @ 20, 180 BUTTON btn_Load ;
         WIDTH 70 ;
         CAPTION 'Load' ;
         ACTION lClean := LoadReg()

      @ 60, 20 LABEL lbl_Data OBJ oData ;
         WIDTH 200 ;
         HEIGHT 200

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW FormMain
   ACTIVATE WINDOW FormMain

RETURN NIL


#define hKey HKEY_CURRENT_USER
#define cKey 'Software\OOHG\RegistrySample\FormMain'


FUNCTION LoadReg

   LOCAL col, row, width, height, array, data := {"", ""}, i, lRet

   IF IsRegistryKey( hKey, cKey )
      oData:Value := ""
      col := GetRegistryValue( hKey, cKey, 'col', 'N' )
      IF col == NIL
         oData:Value += "Col is NIL !" + CRLF
      ELSE
         oData:Value += "Col = " + hb_ntos( col ) + CRLF
         oForm:Col := col
      ENDIF
      row := GetRegistryValue( hKey, cKey, 'row', 'N' )
      IF row == NIL
         oData:Value += "Row is NIL !" + CRLF
      ELSE
         oData:Value += "Row = " + hb_ntos( row ) + CRLF
         oForm:Row := row
      ENDIF
      width := GetRegistryValue( hKey, cKey, 'width', 'N' )
      IF width == NIL
         oData:Value += "Width is NIL !" + CRLF
      ELSE
         oData:Value += "Width = " + hb_ntos( width ) + CRLF
         oForm:Width := width
      ENDIF
      height := GetRegistryValue( hKey, cKey, 'height', 'N' )
      IF height == NIL
         oData:Value += "Height is NIL !" + CRLF
      ELSE
         oData:Value += "Height = " + hb_ntos( height ) + CRLF
         oForm:Height := height
      ENDIF
      array := GetRegistryValue( hKey, cKey, 'data', 'A' )
      IF array == NIL
         oData:Value += "Data is NIL !" + CRLF
      ELSE
         FOR i := 1 TO Len( array )
            data[1] += ( hb_ntos( array[i] ) + " " )
            data[2] += ( Chr( array[i] ) + " " )
         NEXT I
         oData:Value += "Binary array, len = " + hb_ntos( Len( Array ) ) + CRLF + ;
                        "Data " + data[1] + CRLF + ;
                        "Info " + data[2]
      ENDIF

      lRet := .F.
   ELSE
      oData:Value := "Nothing loaded !" + CRLF
      oData:Value += "Key not found !"
      lRet := .T.
   ENDIF

RETURN lRet


FUNCTION SaveReg

   IF ! IsRegistryKey( hKey, cKey )
      IF CreateRegistryKey( hKey, cKey )
         oData:Value := "Key created !"
      ELSE
         oData:Value := "Key not created !"
         RETURN NIL
      ENDIF
   ENDIF

   IF IsRegistryKey( hKey, cKey )
      oData:Value := ""
      _OOHG_SaveAsDWORD := .F.
      IF ! SetRegistryValue( hKey, cKey, 'col', oForm:Col )
         oData:Value +=  "Error setting Col !" + CRLF
      ENDIF
      IF ! SetRegistryValue( hKey, cKey, 'row', oForm:Row )
         oData:Value += "Error setting Row !" + CRLF
      ENDIF
      _OOHG_SaveAsDWORD := .T.
      IF ! SetRegistryValue( hKey, cKey, 'width', oForm:Width )
         oData:Value += "Error setting Width !" + CRLF
      ENDIF
      IF ! SetRegistryValue( hKey, cKey, 'height', oForm:Height )
         oData:Value += "Error setting Height !" + CRLF
      ENDIF
   	// Binary array
      IF ! SetRegistryValue( hKey, cKey, 'data', { 0x44, 0x41, 0x54, 0x41 } )
         oData:Value += "Error setting Data !" + CRLF
      ENDIF
      IF Empty( oData:Value )
         oData:Value := "Done !"
      ENDIF
   ELSE
      oData:Value := "Key not found !"
   ENDIF

RETURN NIL


FUNCTION DeleteReg

   oData:Value := ""
   IF IsRegistryKey( hKey, cKey )
      oData:Value := "Key found !" + CRLF
   ELSE
      oData:Value := "Nothing deleted !" + CRLF
      oData:Value += "Key not found !"
      RETURN NIL
   ENDIF

   IF DeleteRegistryVar( hKey, cKey, 'col' )
      oData:Value += "Col deleted !" + CRLF
   ELSE
      oData:Value += "Col not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryVar( hKey, cKey, 'row' )
      oData:Value += "Row deleted !" + CRLF
   ELSE
      oData:Value += "Row not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryVar( hKey, cKey, 'width' )
      oData:Value += "Width deleted !" + CRLF
   ELSE
      oData:Value += "Width not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryVar( hKey, cKey, 'height' )
      oData:Value += "Height deleted !" + CRLF
   ELSE
      oData:Value += "Height not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryVar( hKey, cKey, 'data' )
      oData:Value += "Data deleted !" + CRLF
   ELSE
      oData:Value += "Data not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryKey( hKey, 'Software\OOHG\RegistrySample', 'FormMain' )
      oData:Value += "Key FormMain deleted !" + CRLF
   ELSE
      oData:Value += "Key FormMain not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryKey( hKey, 'Software\OOHG', 'RegistrySample' )
      oData:Value += "Key RegistrySample deleted !" + CRLF
   ELSE
      oData:Value += "Key RegistrySample not deleted !" + CRLF
   ENDIF
   IF DeleteRegistryKey( hKey, 'Software', 'OOHG' )
      oData:Value += "Key OOHG deleted !" + CRLF
   ELSE
      oData:Value += "Key OOHG not deleted !" + CRLF
   ENDIF

   IF IsRegistryKey( hKey, cKey )
      oData:Value += "Registry not cleaned !"
   ELSE
      oData:Value += "Registry cleaned !"
   ENDIF

RETURN NIL


FUNCTION CleanReg

   IF MsgYesNo( "Clean registry ?" )
      DeleteReg()
   ENDIF

RETURN NIL

/*
 * EOF
 */
