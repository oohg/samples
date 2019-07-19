#include "minigui.ch"

// Error en GRADIENT y error en FONDO DE IMÁGENES

PROCEDURE Main

   PUBLIC oMainMenu := NIL, oMenuSetOnOff, oMenuSetAuto
   PUBLIC Font0, Font1, Font2, Font3, Font4

   // These area app-wide fonts.
   // If you don't release them explicitly using RELEASE FONT <name>
   // they will be released on app exit.
   DEFINE FONT font_0 FONTNAME GetDefaultFontName() SIZE 10
   DEFINE FONT font_1 FONTNAME 'Times New Roman' SIZE 10 BOLD
   DEFINE FONT font_2 FONTNAME 'Arial'   SIZE 12 ITALIC
   DEFINE FONT font_3 FONTNAME 'Verdana' SIZE 14 UNDERLINE
   DEFINE FONT font_4 FONTNAME 'Courier' SIZE 16 STRIKEOUT

   Font0 := GetFontHandle( "font_0" )
   Font1 := GetFontHandle( "font_1" )
   Font2 := GetFontHandle( "font_2" )
   Font3 := GetFontHandle( "font_3" )
   Font4 := GetFontHandle( "font_4" )

   SET MENUSTYLE EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "OOHG - OwnerDraw Menu Test" ;
      ICON "SMILE" ;
      NOTIFYICON "SMILE" ;
      MAIN

      ON KEY ESCAPE ACTION ThisWindow.Release()

      LoadMenu( 0 )

      @ 120, 120 LABEL lbl_1 VALUE "UI theme"

      @ 150, 120 RADIOGROUP rdg_1 OBJ oRdgUI ;
         OPTIONS {"Default", "Classic", "Office 2000"} ;
         VALUE 1 ;
         ON CHANGE LoadMenu( oRdgUI:value - 1 )

      DEFINE NOTIFY MENU
         ITEM "About..." ACTION MsgInfo( MiniGuiVersion() ) IMAGE "ABOUT"

         POPUP "Options"
            ITEM "Autorun" OBJ oMenuSetAuto ACTION ToggleAutorun() NAME SetAuto CHECKED CHECKMARK "CHECK"
         END POPUP

         POPUP "Notify Icon"
            ITEM "Get Notify Icon Name" ACTION MsgInfo( Form_1.NotifyIcon )
            ITEM "Change Notify Icon"   ACTION Form_1.NotifyIcon := "Demo2.ico"
         END POPUP

         SEPARATOR

         ITEM "Exit Application" ACTION Form_1.Release IMAGE "res\cancel.bmp"
      END MENU

      DEFINE CONTEXT MENU
         POPUP "Context item 1"
            ITEM "Context item 1.1" ACTION MsgInfo( "Context item 1.1" )
                 ITEM "Context item 1.2" ACTION MsgInfo( "Context item 1.2" )

            POPUP 'Context item 1.3'
               ITEM "Context item 1.3.1" ACTION MsgInfo( "Context item 1.3.1" ) IMAGE "BUG"
               SEPARATOR
                    ITEM "Context item 1.3.2" ACTION MsgInfo( "Context item 1.3.2" ) CHECKED CHECKMARK "CHECK"
            END POPUP
         END POPUP

         ITEM "Context item 2 - Simple"   ACTION MsgInfo( "Context item 2 - Simple" )  CHECKED CHECKMARK "CHECK"
         ITEM "Context item 3 - Disabled" ACTION MsgInfo( "Context item 3 - Disabled" ) DISABLED
         SEPARATOR
         POPUP "Context item 4"
            ITEM "Context item 4.1" ACTION MsgInfo( "Context item 4.1" )
            ITEM "Context item 4.2" ACTION MsgInfo( "Context item 4.2" )
            ITEM "Context item 4.3" ACTION MsgInfo( "Context item 4.3" ) DISABLED
         END POPUP
      END MENU

   END WINDOW

   CENTER WINDOW  Form_1
   ACTIVATE WINDOW  Form_1

   RETURN

STATIC PROCEDURE ToggleAutorun

   oMenuSetAuto:Checked := ! oMenuSetAuto:Checked

   oMenuSetAuto:Picture := iif( oMenuSetAuto:Checked, NIL, "UNCHECK" )

   MsgInfo( "Autorun is " + iif( oMenuSetAuto:Checked, "enabled!", "disabled!") )

   RETURN

STATIC PROCEDURE Test1( param )

   LOCAL lChecked

   lChecked := GetProperty( "Form_1", "Test1" + param, "Checked" )
   SetProperty( "Form_1", "Test1" + param, "Checked", ! lChecked )

   MsgInfo( "Item Test1" + param + " is " + iif( GetProperty( "Form_1", "Test1" + param, "Checked" ), "checked!", "unchecked!" ) )

   RETURN

STATIC PROCEDURE Test2( param )

   SetProperty( "Form_1", "Test1" + param, "Checked", .T. )

   SWITCH param
   CASE "4"
      SetProperty( "Form_1", "Test15", "Checked", .F. )
      SetProperty( "Form_1", "Test16", "Checked", .F. )
      EXIT
   CASE "5"
      SetProperty( "Form_1", "Test14", "Checked", .F. )
      SetProperty( "Form_1", "Test16", "Checked", .F. )
      EXIT
   CASE "6"
      SetProperty( "Form_1", "Test14", "Checked", .F. )
      SetProperty( "Form_1", "Test15", "Checked", .F. )
   END

   RETURN

STATIC PROCEDURE Test3( param )

   oMenuSetOnOff:Caption := iif( param, "Disable Items", "Enable Items" )

   SetProperty( "Form_1", "Test21", "Enabled", param )
   SetProperty( "Form_1", "Test22", "Enabled", param )
   SetProperty( "Form_1", "Test23", "Enabled", param )

   MsgInfo( "Items Test21-Test23 are " + iif( GetProperty( "Form_1", "Test21", "Enabled" ), "enabled!", "disabled!" ) )

   RETURN

STATIC PROCEDURE LoadMenu( nSet )

   IF HB_ISOBJECT( oMainMenu )
      oMainMenu:Release()
   ENDIF

   DEFINE MAIN MENU OF Form_1 OBJ oMainMenu
      oMainMenu:Params := DefaultMenuParams( nSet )

      POPUP "&File" FONT Font0
         ITEM "&New  " + space(16) + "Ctrl+N" ACTION MsgInfo( "File:New    " ) IMAGE "NEW"
         ITEM "&Open " + space(16) + "Ctrl+O" ACTION MsgInfo( "File:Open   " )
         ITEM "&Save " + space(16) + "Ctrl+S" ACTION MsgInfo( "File:Save   " ) IMAGE "SAVE"
         ITEM "Save &As.."                    ACTION MsgInfo( "File:Save As" ) IMAGE "SAVE_AS"
         SEPARATOR
         ITEM "&Print" + space(16) + "Ctrl+P" ACTION MsgInfo( "File:Print  " ) IMAGE "PRINTER"
         ITEM "Pre&view"                      ACTION MsgInfo( "File:Preview" )
         SEPARATOR
         ITEM "E&xit " + space(16) + "Alt+F4" ACTION Form_1.Release IMAGE "DOOR"
      END POPUP

      // App-wide fonts may be used by handle
      POPUP "F&onts" FONT Font0
         // Or by name
         ITEM "10- Bold"      FONT "font_1"
         ITEM "12- Italic"    FONT "font_2"
         ITEM "14- UnderLine" FONT "font_3"
         ITEM "16- StrikeOut" FONT "font_4"
      END POPUP

      POPUP "&Test" FONT Font0
         ITEM "Item 1" ACTION MsgInfo( Str( oMainMenu:ItemCount ) )
         ITEM "Item 2" ACTION MsgInfo( "Item 2" )
         POPUP "Item 3"
            ITEM "Item 3.1" ACTION MsgInfo( "Item 3.1" )
            ITEM "Item 3.2" ACTION MsgInfo( "Item 3.2" )
            POPUP "Item 3.3"
               ITEM "Item 3.3.1" ACTION MsgInfo( "Item 3.3.1" )
               ITEM "Item 3.3.2" ACTION MsgInfo( "Item 3.3.2" )
               POPUP "Item 3.3.3"
                  ITEM "Item 3.3.3.1" ACTION MsgInfo( "Item 3.3.3.1" )
                  ITEM "Item 3.3.3.2" ACTION MsgInfo( "Item 3.3.3.2" )
                  ITEM "Item 3.3.3.3" ACTION MsgInfo( "Item 3.3.3.3" )
                  ITEM "Item 3.3.3.4" ACTION MsgInfo( "Item 3.3.3.4" )
                  ITEM "Item 3.3.3.5" ACTION MsgInfo( "Item 3.3.3.5" )
                  ITEM "Item 3.3.3.6" ACTION MsgInfo( "Item 3.3.3.6" )
               END POPUP
               ITEM "Item 3.3.4" ACTION MsgInfo( "Item 3.3.4" )
            END POPUP
         END POPUP
         ITEM "Item 4" ACTION MsgInfo( "Item 4" ) DISABLED
      END POPUP

      POPUP "T&est 1-2" FONT Font0
         ITEM "Test 1.1" ACTION Test1( "1" ) NAME Test11 CHECKED CHECKMARK "TICK"
         ITEM "Test 1.2" ACTION Test1( "2" ) NAME Test12 CHECKED CHECKMARK "TICK"
         ITEM "Test 1.3" ACTION Test1( "3" ) NAME Test13 CHECKED
         SEPARATOR
         ITEM "Test 1.4" ACTION Test2( "4" ) NAME Test14 CHECKED CHECKMARK "SHADING"
         ITEM "Test 1.5" ACTION Test2( "5" ) NAME Test15         CHECKMARK "SHADING"
         ITEM "Test 1.6" ACTION Test2( "6" ) NAME Test16         CHECKMARK "SHADING" IMAGE "BUG"
      END POPUP

      POPUP "Te&st 3" FONT Font0
         ITEM "Test 2.1" NAME Test21
         ITEM "Test 2.2" NAME Test22
         ITEM "Test 2.3" NAME Test23 CHECKED CHECKMARK "MARK"
         SEPARATOR
         ITEM "Disable Items" OBJ oMenuSetOnOff ACTION Test3( oMenuSetOnOff:Caption # "Disable Items" ) NAME SetOnOff
      END POPUP

      POPUP "&Misc" FONT Font0
         ITEM "Get MenuBitmap Height" ACTION MsgInfo( "Current height is " + LTrim( Str( _OOHG_MenuBitmapMetrics()[ 1 ] ) ) )
      END POPUP

      POPUP "&Help" FONT Font0
         ITEM "Index" IMAGE "BMPHELP"
         ITEM "Using help"
         SEPARATOR
         ITEM "Online forum" IMAGE "WORLD"
         ITEM "Buy/register" IMAGE "CART_ADD"
         SEPARATOR
         ITEM "About" ACTION MsgInfo( MiniGuiVersion() ) ICON "SMILE"
      END POPUP
   END MENU

   RETURN

/*
 * EOF
 */
