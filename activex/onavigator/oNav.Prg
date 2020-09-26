/*
 * ActiveX Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to build an Internet browse
 * using "Shell.Explorer.2".
 *
 * Based on a sample by MigSoft <fugaz_cl/at/yahoo.es>
 * and Ciro Vargas C. <cvc@oohg.org>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'
#include 'i_windefs.ch'

#ifndef __XHARBOUR__
#xcommand TRY => BEGIN SEQUENCE WITH s_bBreak
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS
#endif

STATIC s_bBreak := { |oErr| break( oErr ) }

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Main

   // The compatibility key must be set before creating the ActiveX object
   CreateCompatibilityKey()

   PUBLIC nTabsCount := 1, oTab, oProg, oCombo, aTitle := {""}, aObj := {}

   DEFINE WINDOW st1 OBJ st1 ;
      AT 0, 0 ;
      WIDTH 800 ;
      HEIGHT 600 ;
      CLIENTAREA ;
      TITLE "" ;
      ICON "ONE" ;
      MAIN ;
      ON INIT { || Adjust(), Navegar() } ;
      ON SIZE Adjust() ;
      ON RELEASE DeleteCompatibilityKey()

      DEFINE STATUSBAR OBJ oStat FONT "Arial" SIZE 9
         @ 4, 2 PROGRESSBAR pgb_Status OBJ oProg ;
           RANGE 0, 10 ;
           WIDTH oStat:ClientWidth - 4 ;
           HEIGHT oStat:ClientHeight - 6 ;
           SMOOTH
      END STATUSBAR

      DEFINE SPLITBOX
         DEFINE TOOLBAR ToolBar_1 BUTTONSIZE 20, 20 FONT "Arial" SIZE 9 FLAT BOTTOM
            BUTTON AddP    TOOLTIP "Nueva Pagina"     PICTURE "siete"           ACTION NuevoTab() AUTOSIZE
            BUTTON Retro   TOOLTIP "Retrocede"        PICTURE "uno"             ACTION Retro1()   AUTOSIZE
            BUTTON avanza  TOOLTIP "Avanzar"          PICTURE "dos"             ACTION Avanza1()  AUTOSIZE
            BUTTON Recarga TOOLTIP "Recargar"         PICTURE "cuatro"          ACTION Navegar()  AUTOSIZE
            BUTTON Detiene TOOLTIP "Detener"          PICTURE "tres"            ACTION Detiene1() AUTOSIZE
            BUTTON home    TOOLTIP "Pagina principal" PICTURE "cinco"           ACTION Home1()    AUTOSIZE
            BUTTON Acerca  Tooltip "Acerca"           PICTURE "MINIGUI_EDIT_OK" ACTION Acerca()   AUTOSIZE
         END TOOLBAR

         @ 30, 0 COMBOBOX directo OBJ oCombo ;
            FONT "Arial" SIZE 9 ;
            WIDTH 720 ;
            ITEMS {"https://oohg.github.io/", "http://www.google.com", "https://groups.google.com/d/forum/oohg"} ;
            VALUE 1 ;
            ON ENTER Navegar() ;
            ON CHANGE Navegar() ;
            DISPLAYEDIT

         DEFINE TOOLBAR ir BUTTONSIZE 20, 20 FONT "Arial" SIZE 9 FLAT BOTTOM
            BUTTON ir_Btn1 PICTURE "seis" ACTION Navegar() TOOLTIP "Ir" AUTOSIZE
         END TOOLBAR
      END SPLITBOX

      DEFINE TAB Tab_1 OBJ oTab ;
         AT 70, 2 ;
         WIDTH st1:ClientWidth - 4 ;
         HEIGHT st1:ClientHeight - 70 + oStat:ClientHeightUsed() - 2 ;
         VALUE 1 ;
         FONT "Arial" SIZE 9 ;
         ON CHANGE st1:Title := aTitle[ oTab:Value ]

         PAGE "ooHG"
            @ 24, 2 ACTIVEX ActiveX ;
               WIDTH oTab:ClientWidth - 6 ;
               HEIGHT oTab:ClientHeight - oTab:oContainerBase:TabsAreaHeight() - 7 ;
               PROGID "Shell.Explorer.2" ;
               OBJ oActiveX_0001

            AAdd( aObj, oActiveX_0001 )
         END PAGE
      END TAB

     oTab:lFixFont := .T.
   END WINDOW

   CENTER WINDOW st1
   ACTIVATE WINDOW st1

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Acerca

   MsgInfo( 'Mybrowser Nav (c)2009 CVC' + CRLF + 'ooHG Navigator (c)2007 MigSoft', 'Información' )

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Navegar

   oStat:Item( 1, "Cargando" )

   IF oCombo:ItemValue( oCombo:DisplayValue ) == 0
      oCombo:AddItem( oCombo:DisplayValue )
   ENDIF

   xoActiveX := "oActiveX_" + StrZero( oTab:Value, 4 )
   &xoActiveX:EventMap( AX_SE2_PROGRESSCHANGE, "OnProgressChange" )
   &xoActiveX:EventMap( AX_SE2_TITLECHANGE, { |cTitle| CambiaTitulo( cTitle ) } )
   &xoActiveX:EventMap( AX_SE2_DOCUMENTCOMPLETE, { || oProg:Visible := .F., oStat:Item( 1, "Listo" ) }  )
   &xoActiveX:Navigate( oCombo:ItemBySource( oCombo:Value ) )

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE OnProgressChange( nAct, nTot )

   oProg:RangeMin := 0
   oProg:RangeMax := nTot
   oProg:Value    := nAct
   IF nAct == 0
      oProg:Visible := .F.
      oStat:Item( 1, "Listo" )
   ELSE
      oStat:Item( 1, "" )
      oProg:Visible := .T.
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE NuevoTab

   LOCAL xoActiveX

   // Increase tab count
   nTabsCount ++

   xoActiveX := "oActiveX_" + StrZero( nTabsCount, 4 )
   PUBLIC &xoActiveX

   @ 24, 2 ACTIVEX &xoActiveX ;
      OF st1 ;
      OBJ &xoActiveX ;
      WIDTH oTab:ClientWidth - 6 ;
      HEIGHT oTab:ClientHeight - oTab:oContainerBase:TabsAreaHeight() - 7 ;
      PROGID "Shell.Explorer.2"

   AAdd( aObj, &xoActiveX )

   AAdd( aTitle, "Nueva Pagina " + LTrim( Str( nTabsCount ) ) )

   oTab:AddPage( nTabsCount, ATail( aTitle ) )
   oTab:AddControl( xoActiveX, nTabsCount, 24, 2 )
   oTab:Value := nTabsCount

   oCombo:SetFocus()

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Retro1

   LOCAL i := oTab:Value

   xoActiveX := "oActiveX_" + StrZero( i, 4 )
   IF HB_ISOBJECT( &xoActiveX )
      TRY
         &xoActiveX:GoBack()
      CATCH e
      END
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Avanza1

   LOCAL i := oTab:Value

   xoActiveX := "oActiveX_" + StrZero( i, 4 )
   IF HB_ISOBJECT( &xoActiveX )
      TRY
         &xoActiveX:GoForward()
      CATCH e
      END
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Detiene1

   LOCAL i := oTab:Value

   xoActiveX := "oActiveX_" + StrZero( i, 4 )
   IF HB_ISOBJECT( &xoActiveX )
      &xoActiveX:Stop()
      oProg:Visible := .F.
      oStat:Item( 1, "Listo" )
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Home1

   LOCAL i := oTab:Value

   xoActiveX := "oActiveX_" + StrZero( i, 4 )
   &xoActiveX:Navigate( "https://oohg.github.io/" )

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE Adjust

   LOCAL i := oTab:Value

   IF HB_ISNUMERIC( i )
      IF i > 0
         oTab:Width  := st1:ClientWidth - 4
         oTab:Height := st1:ClientHeight - 70 + oStat:ClientHeightUsed() - 2

         xoActiveX := "oActiveX_" + StrZero( i, 4 )

         &xoActiveX:Width  := oTab:ClientWidth - 6
         &xoActiveX:Height := oTab:ClientHeight - oTab:oContainerBase:TabsAreaHeight() - 7
      ENDIF
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE CambiaTitulo( cTitle )

   LOCAL i := oTab:Value, cCaption

   IF HB_ISNUMERIC( i ) .AND. ValType( cTitle ) == "C"
      IF i > 0
         st1:Title := ;
         aTitle[i] := cTitle
         IF At( "http://" , cTitle ) == 1
            cTitle := SubStr( cTitle, 8 )
         ELSEIF At( "https://" , cTitle ) == 1
            cTitle := SubStr( cTitle, 9 )
         ENDIF
         IF Len( cTitle ) > 20
            cTitle := Left( cTitle, 17 ) + "..."
         ENDIF
         oTab:Caption( i, cTitle )
      ENDIF
      Adjust()
   ENDIF

   RETURN

#define cKey "Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE CreateCompatibilityKey( lEnableMsgs )

   LOCAL nVal

   ASSIGN lEnableMsgs VALUE lEnableMsgs TYPE "L" DEFAULT .F.

   IF IsRegistryKey( HKEY_CURRENT_USER, cKey )
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " already exists !" )
      ENDIF
   ELSE
      IF CreateRegistryKey( HKEY_CURRENT_USER, cKey )
         IF lEnableMsgs
            AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " was created !" )
         ENDIF
      ELSE
         IF lEnableMsgs
            AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " can't be created !" )
         ENDIF
      ENDIF
   ENDIF

   nVal := GetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 'N' )
   IF nVal == NIL
      IF SetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 11001, REG_DWORD )
         nVal := GetRegistryValue( HKEY_CURRENT_USER, cKey, App.FileName, 'N' )
         IF nVal == NIL
            IF lEnableMsgs
               AutoMsgBox( "Unable to read just created registry value !" )
            ENDIF
         ELSE
            IF lEnableMsgs
               AutoMsgBox( "Registry value was created !" + CRLF + "Value is: " + hb_ntos( nVal ) )
            ENDIF
         ENDIF
      ELSE
         IF lEnableMsgs
            AutoMsgBox( "Can't create registry value !" )
         ENDIF
      ENDIF
   ELSE
      IF lEnableMsgs
         AutoMsgBox( "Registry value is: " + hb_ntos( nVal ) )
      ENDIF
   ENDIF

   RETURN

/*--------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE DeleteCompatibilityKey( lEnableMsgs )

   ASSIGN lEnableMsgs VALUE lEnableMsgs TYPE "L" DEFAULT .F.

   IF DeleteRegistryVar( HKEY_CURRENT_USER, cKey, App.FileName )
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " was deleted !" )
      ENDIF
   ELSE
      IF lEnableMsgs
         AutoMsgBox( 'HKEY_CURRENT_USER\' + cKey + " can't be deleted !" )
      ENDIF
   ENDIF

   RETURN

/*
 * EOF
 */
