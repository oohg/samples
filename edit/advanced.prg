#include "oohg.ch"

FUNCTION Main()

   // Database driver.
   REQUEST DBFCDX , DBFFPT

   // [x]Harbour modifiers.
   SET CENTURY ON
   SET DELETED OFF
   SET DATE TO BRITISH

   // Request all languages for test (see i_lang.ch)
   REQUEST HB_LANG_EN
   REQUEST HB_LANG_ES
   REQUEST HB_LANG_FR
   REQUEST HB_LANG_PT
   REQUEST HB_LANG_IT
   REQUEST HB_LANG_EU
   REQUEST HB_LANG_NL
#if ( __HARBOUR__ - 0 > 0x030200 )    // for Harbour 3.4 version
   REQUEST HB_LANG_DE
   REQUEST HB_LANG_EL
   REQUEST HB_LANG_RU
   REQUEST HB_LANG_UK
   REQUEST HB_LANG_PL
   REQUEST HB_LANG_HR
   REQUEST HB_LANG_SL
   REQUEST HB_LANG_CS
   REQUEST HB_LANG_BG
   REQUEST HB_LANG_HU
   REQUEST HB_LANG_SK
   REQUEST HB_LANG_TR
#else
   REQUEST HB_LANG_DEWIN
   REQUEST HB_LANG_ELWIN
   REQUEST HB_LANG_RUWIN
   REQUEST HB_LANG_UAWIN
   REQUEST HB_LANG_PLWIN
   REQUEST HB_LANG_HR852
   REQUEST HB_LANG_SLWIN
   REQUEST HB_LANG_CSWIN
   REQUEST HB_LANG_BGWIN
   REQUEST HB_LANG_HUWIN
   REQUEST HB_LANG_SKWIN
   REQUEST HB_LANG_TRWIN
#endif

   // Set default language to English.
   InitMessages( "EN" )

   // Define window.
   DEFINE WINDOW Win_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "EDIT Command Demo" 	;
      MAIN ;
      ON INIT OpenTable() ;
      ON RELEASE CloseTable() ;
      BACKCOLOR METRO_GRAY_LIGHTER

      DEFINE MAIN MENU OF Win_1
         POPUP "&File"
            ITEM "&Simple Edit test"   ACTION EDIT WORKAREA CLIENTES
            ITEM "&Advanced Edit test" ACTION AdvTest()
            SEPARATOR
            ITEM "Language selection"  ACTION SelecLang()
            SEPARATOR
            ITEM "About"               ACTION About()
            SEPARATOR
            ITEM "E&xit"               ACTION Win_1.Release
         END POPUP
      END MENU

   END WINDOW

   // Open window.
   MAXIMIZE WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN NIL

/*------------------------------------------------------------------------------*/
FUNCTION OpenTable()

   USE CLIENTES VIA "DBFCDX" INDEX CLIENTES NEW

RETURN NIL

/*------------------------------------------------------------------------------*/
FUNCTION CloseTable()

   CLOSE CLIENTES

RETURN NIL

/*------------------------------------------------------------------------------*/
FUNCTION AdvTest()

   LOCAL aFields   := { "Nombre", "Apellidos", "Dirección", "Población " ,;
                        "Estado", "Codigo ZIP", "F. Nacimiento", "Casado",;
                        "Edad", "Salario", "Notas"    }
   LOCAL aReadOnly := { .F., .F., .F., .F., .F., .F., .F., .F., .T., .F., .F. }
   LOCAL bSave     := {|aContent, lEdit| AdvTestSave( aContent, lEdit ) }

   // Advise.
   MsgInfo( "This sample shows the advanced features of EDIT." + CRLF + ;
            CRLF +;
            "It was designed for Spanish language, so we are" + CRLF + ;
            "changing to such language for better performance.", "EDIT demo" )
   InitMessages( "ES" )

   // Advanced EDIT.
   EDIT WORKAREA CLIENTES ;
      TITLE "Clientes" ;
      FIELDS aFields ;
      READONLY aReadOnly ;
      SAVE bSave

RETURN NIL

/*------------------------------------------------------------------------------*/
FUNCTION AdvTestSave( aContent, lEdit )

   LOCAL i
   LOCAL aFields  := { "Nombre", "Apellidos", "Dirección", "Población " , ;
                       "Estado", "Codigo ZIP", "F. Nacimiento", "Casado", ;
                       "Edad", "Salario", "Notas" }

   // Chek content.
   FOR i := 1 TO Len( aContent ) - 4
      IF Empty( aContent[i] )
         MsgInfo( aFields[i] + " no puede estar vacío.", "EDIT demo" )
         RETURN .F.
      ENDIF
   NEXT

   // Calculate age.
   aContent[9] := 0
   FOR i := ( Year( aContent[7] ) + 1 ) TO Year( Date() )
      aContent[9] ++
   NEXT

   // Save record.
   IF ! lEdit
      CLIENTES->( dbAppend() )
   ENDIF
   FOR i := 1 TO Len( aContent )
      CLIENTES->( FieldPut( i, aContent[i] ) )
   NEXT

RETURN .T.

/*------------------------------------------------------------------------------*/
FUNCTION SelecLang()

   LOCAL aLangName := { "Basque", ;
                        "Bulgarian", ;
                        "Croatian", ;
                        "Czech", ;
                        "Dutch", ;
                        "English", ;
                        "Finnish", ;
                        "French", ;
                        "German", ;
                        "Greek", ;
                        "Hungarian", ;
                        "Italian", ;
                        "Polish", ;
                        "Portuguese", ;
                        "Russian", ;
                        "Slovak", ;
                        "Slovenian", ;
                        "Spanish", ;
                        "Turkish", ;
                        "Ukranian" }

#if ( __HARBOUR__ - 0 > 0x030200 )    // for Harbour 3.4 version
   LOCAL aLangID   := { "EU", ;
                        "BG", ;
                        "HR", ;
                        "CS", ;
                        "NL", ;
                        "EN", ;
                        "FI", ;
                        "FR", ;
                        "DE", ;
                        "EL", ;
                        "HU", ;
                        "IT", ;
                        "PL", ;
                        "PT", ;
                        "RU", ;
                        "SK", ;
                        "SL", ;
                        "ES", ;
                        "TR", ;
                        "UK" }
#else
   LOCAL aLangID   := { "EU", ;
                        "BGWIN", ;
                        "HR852", ;
                        "CSWIN", ;
                        "NL", ;
                        "EN", ;
                        "FI", ;
                        "FR", ;
                        "DEWIN", ;
                        "ELWIN", ;
                        "HUWIN", ;
                        "IT", ;
                        "PLWIN", ;
                        "PT", ;
                        "RUWIN", ;
                        "SKWIN", ;
                        "SLWIN", ;
                        "ES", ;
                        "TRWIN", ;
                        "UKWIN" }
#endif

   LOCAL nItem

   // Language selection.
   MsgInfo( "The interface language of EDIT command is OOHG's default" + CRLF + ;
            "language. You can change it using InitMessages() function." + CRLF + ;
            CRLF +;
            "If your language isn't supported but you are willing" + CRLF + ;
            "to help with the translation, please send a message" + CRLF + ;
            "to https://groups.google.com/forum/#!forum/oohg", "EDIT demo" )
   nItem := SelItem( aLangName )
   IF ! nItem == 0
      InitMessages( aLangID[nItem] )
      MsgInfo( "EDIT interface language was changed to" + CRLF + ;
               aLangName[nItem] + CRLF + ;
               'Goto "Simple Edit test" menu to see the effects.', "EDIT demo" )
   ENDIF

RETURN NIL

/*------------------------------------------------------------------------------*/
FUNCTION SelItem( aItems )

   LOCAL nItem := 0

   DEFINE WINDOW wndSelItem ;
      AT 0, 0 ;
      WIDTH 160 ;
      HEIGHT 200 ;
      CLIENTAREA ;
      TITLE "Click to select or Esc to exit" ;
      MODAL ;
      NOSIZE ;
      NOSYSMENU

      @ 10, 20 LISTBOX lbxItems ;
      WIDTH 120 ;
      HEIGHT 180 ;
      ITEMS aItems ;
      VALUE 1 ;
      FONT "Arial" ;
      SIZE 9 ;
      ON CHANGE {|| nItem := wndSelItem.lbxItems.Value, wndSelItem.Release }

      ON KEY ESCAPE ACTION ThisWindow:Release()
   END WINDOW

   CENTER WINDOW wndSelItem
   ACTIVATE WINDOW wndSelItem

RETURN nItem

/*------------------------------------------------------------------------------*/
PROCEDURE About()

   MsgInfo( CRLF + ;
            "EDIT command for OOHG adapted from the" + CRLF + ;
            "original work developed for MINIGUI by:" + CRLF + ;
            " *  Roberto López" + CRLF + ;
            " *  Grigory Filatov" + CRLF + ;
            " *  Cristóbal Mollá" + CRLF + ;
            CRLF + ;
            "Status of the language support:" + CRLF + ;
            " *  English    - Ready" + CRLF + ;
            " *  Spanish    - Ready" + CRLF + ;
            " *  Russian    - Ready (Thanks to Grigory Filatov)" + CRLF + ;
            " *  Portuguese - Ready (Thanks to Clovis Nogueira Jr.)" + CRLF + ;
            " *  Polish     - Ready (Thanks to Janusz Poura)" + CRLF + ;
		      " *  French     - Ready (Thanks to C. Jouniauxdiv)" + CRLF + ;
		      " *  Italian    - Ready (Thanks to Lupano Piero)" + CRLF + ;
            " *  German     - Ready (Thanks to Janusz Poura)" + CRLF + ;
            CRLF + ;
		      "Please report bugs to OOHG support group at https://groups.google.com/forum/#!forum/oohg", ;
            "EDIT demo" )

RETURN
