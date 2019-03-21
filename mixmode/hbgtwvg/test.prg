
#include "button.ch"
#include "inkey.ch"
#include "set.ch"
#include "hbclass.ch"
#include "error.ch"
#include "common.ch"
#include "hbgtwvg.ch"
#include "hbgtinfo.ch"
#include "hbver.ch"

REQUEST HB_GT_WVG_DEFAULT
REQUEST HB_GT_WVG

PROCEDURE Main

   PUBLIC _OOHG_PRINTLIBRARY

    Wvt_SetGui( .T. )
    hb_gtInfo( HB_GTI_CODEPAGE, "ES850C" )
    hb_gtInfo( HB_GTI_FONTNAME, 'Lucida Console' )
    hb_gtInfo( HB_GTI_CLOSABLE, .F. )
    hb_gtInfo( HB_GTI_SELECTCOPY,.T. )
    hb_gtInfo( HB_GTI_RESIZABLE, .T. )
    hb_gtInfo( HB_GTI_MOUSESTATUS, 1 )
    hb_gtInfo( HB_GTI_ISFULLSCREEN, .F. )      // , "we should be on full screen"
    hb_gtInfo( HB_GTI_ALTENTER, .T. )          // , "Alt+Enter is now enabled, try it"
    hb_gtInfo( HB_GTI_MAXIMIZED, .F. )
    hb_gtInfo( HB_GTI_COMPATBUFFER, .T. )
    hb_gtInfo( HB_GTI_ESCDELAY, 50 )
    hb_gtInfo( HB_GTI_ISGRAPHIC, .T. )
    hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_FONT )
    hb_gtInfo( HB_GTI_FONTQUALITY,HB_GTI_FONTQ_HIGH )
    hb_gtInfo( HB_GTI_SCREENWIDTH, hb_gtInfo( HB_GTI_DESKTOPWIDTH ) )
    hb_gtInfo( HB_GTI_SCREENHEIGHT, hb_gtInfo( HB_GTI_DESKTOPHEIGHT ) )
    screenWidth := hb_gtInfo( HB_GTI_DESKTOPWIDTH )
    screenHeight := hb_gtInfo( HB_GTI_DESKTOPHEIGHT )

    hb_gtInfo( HB_GTI_SPEC, HB_GTS_WNDSTATE, HB_GTS_WS_MAXIMIZED )

    IF screenWidth > 1920
       hb_gtInfo( HB_GTI_FONTWIDTH, 16  )
       hb_gtInfo( HB_GTI_FONTSIZE, 28 )
    ELSEIF screenWidth >= 1600                   // 1280*960
        hb_gtInfo( HB_GTI_FONTWIDTH, 14  )
        hb_gtInfo( HB_GTI_FONTSIZE, 25 )
    ELSEIF screenWidth >= 1280                  // 1280*960
        hb_gtInfo( HB_GTI_FONTWIDTH, 15 )
        hb_gtInfo( HB_GTI_FONTSIZE, 21 )                     // 15*80=1200   36*25=900
    ELSEIF screenWidth >= 1024                  // 1024*760
        hb_gtInfo( HB_GTI_FONTWIDTH, 10 )
        hb_gtInfo( HB_GTI_FONTSIZE, 22 )
    ELSEIF screenWidth >= 800
        hb_gtInfo( HB_GTI_FONTWIDTH, 10 )
        hb_gtInfo( HB_GTI_FONTSIZE, 22 )
    ELSE
        hb_gtInfo( HB_GTI_FONTWIDTH, 10 )
        hb_gtInfo( HB_GTI_FONTSIZE, 22 )
    ENDIF

    SetColor( 'r+/w++' )
    SETMODE(29,85)
    CLEAR
    Wvt_SetTitle( 'PUNTO DE VENTAS' )

   SETBLINK( .F. )
   Set( _SET_DATEFORMAT, "dd/mm/yyyy" )
   Set( _SET_DELETED,  TRUE)
   Set( _SET_CONFIRM, TRUE )
   Set( _SET_FIXED, TRUE )
   Set( _SET_DECIMALS, 3 )
   Set( _SET_EPOCH, 2000 )
   Set( _SET_MESSAGE, 24 )
   Set( _SET_MCENTER, .T. )
   Set( _SET_CANCEL, .T. )
   SET MENU  OFF
   SET SCOREBOARD OFF
   SET EXACT ON
   SET CENTURY ON
   SETCURSOR(2)

   oPrint := TPrint( "PDFPRINT" )

   oPrint:Init()
// oPrint:Init( hb_gtInfo( HB_GTI_SPEC, HB_GTS_WINDOWHANDLE ) )
// Since March 20, 2019 it's not needed to send the handle
// because OOHG creates a hidden modal window as MAIN.
// If sended then it's used.

   oPrint:SelPrinter( .F., .F., .F., 9 )
   oPrint:SetFont( "times new roman", 8 )
   IF oPrint:lPrError
      oPrint:Release()
      RETURN
   ENDIF

   oPrint:Begindoc( hb_CurDrive() + ':\' + CurDir() + '\test.pdf' )
   oPrint:SetLMargin(1)
   oPrint:BeginPage()

   oPrint:PrintData( 001, 001, "DISTRIBUCIONES XXXX" )
   oPrint:PrintData( 002, 001, "RUC: 200000000001" )
   oPrint:PrintData( 003, 001, "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD" )
   oPrint:PrintData( 004, 004, "FACTURA ELECTRONICA " + "F001-00000020" )
   dlinea:= 5
   oPrint:PrintData( dlinea, 001, "De   : CORPORACION FARMACEUTICA LA PASTILLA" )
   dlinea++
   oPrint:PrintData( dlinea, 001, "F.EMISIÓN  : 06/03/2019" )
   dlinea++
   oPrint:PrintData( dlinea, 001, "SEÑOR(ES)  : PEDRO RAMIREZ" )
   dlinea++
   oPrint:PrintData( dlinea, 001, "DIRECCION  : CALLE 345" )
   dlinea++
   oPrint:PrintData( dlinea, 001, "RUC/DNI       : 06825813" )
   dlinea++
   oPrint:PrintLine( dlinea, 0, dlinea, 055,, 0.3 )
   dlinea++
   oPrint:PrintData( dlinea, 000, "CANT.   C/F  DESCRIPCION                P.UNIT   P.TOTAL" )
   dlinea++
   oPrint:PrintLine( dlinea, 0, dlinea, 055,, 0.3 )
   dlinea++
   oPrint:PrintLine( dlinea, 0, dlinea, 055,, 0.3 )
   dlinea++
   oPrint:PrintData( dlinea, 001, "SON: importe en letras" )
   dlinea++
   oPrint:PrintLine( dlinea, 0, dlinea, 055,, 0.3 )
   dlinea++

   oPrint:EndPage()
   oPrint:EndDoc()
   oPrint:Release()

RETURN

/*
 * EOF
 */

