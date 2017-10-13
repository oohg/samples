/*
 * Windows Registry Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to save the position and size of a
 * form and how to restore them when the form is initialized.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW FormMain ;
      OBJ oForm ;
      TITLE 'Registry Operations' ;
      ON INIT LoadReg()

      @ 20, 20 BUTTON btn_Save ;
         CAPTION 'Save' ;
         ACTION SaveReg()

      @ 100, 20 BUTTON btn_Delete ;
         CAPTION 'Delete' ;
         ACTION DeleteReg()

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW FormMain
   ACTIVATE WINDOW FormMain

RETURN NIL


#define hKey HKEY_CURRENT_USER
#define cKey 'Software\OOHG\RegistrySample\FormMain'


FUNCTION LoadReg
   LOCAL col, row, width, height

   IF IsRegistryKey( hKey, cKey )
      col := GetRegistryValue( hKey, cKey, 'col', 'N' )
      IF ! HB_IsNil( col )
         oForm:Col := col
      ENDIF
      row := GetRegistryValue( hKey, cKey, 'row', 'N' )
      IF ! HB_IsNil( row )
         oForm:Row := row
      ENDIF
      width := GetRegistryValue( hKey, cKey, 'width', 'N' )
      IF ! HB_IsNil( width )
         oForm:Width := width
      ENDIF
      height := GetRegistryValue( hKey, cKey, 'height', 'N' )
      IF ! HB_IsNil( height )
         oForm:Height := height
      ENDIF
   ENDIF

RETURN NIL


FUNCTION SaveReg

   IF ! IsRegistryKey( hKey, cKey )
      IF ! CreateRegistryKey( hKey, cKey )
         RETURN NIL
      ENDIF
   ENDIF

   IF IsRegistryKey( hKey, cKey )
      SetRegistryValue( hKey, cKey, 'col', oForm:Col )
      SetRegistryValue( hKey, cKey, 'row', oForm:Row )
      SetRegistryValue( hKey, cKey, 'width', oForm:Width )
      SetRegistryValue( hKey, cKey, 'height', oForm:Height )
   ENDIF

RETURN NIL


FUNCTION DeleteReg

   DeleteRegistryVar( hKey, cKey, 'col' )
   DeleteRegistryVar( hKey, cKey, 'row' )
   DeleteRegistryVar( hKey, cKey, 'width' )
   DeleteRegistryVar( hKey, cKey, 'height' )
   DeleteRegistryKey( hKey, 'Software\OOHG\RegistrySample', 'FormMain' )
   DeleteRegistryKey( hKey, 'Software\OOHG', 'RegistrySample' )
   DeleteRegistryKey( hKey, 'Software', 'OOHG' )

RETURN NIL

/*
 * EOF
 */
