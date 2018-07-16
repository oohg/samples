/*
 * TextArray Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use a TextArray control to mimic
 * a console output window.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE 'TextArray control' ;
      MAIN ;
      ON INIT ( oTxtArr:DevPos( 0, 0 ), oTxtArr:CursorType( 2 ) )

      @ 10, 10 TEXTARRAY tar OBJ oTxtArr ;
         WIDTH 500 ;
         HEIGHT 400 ;
         ROWCOUNT 50 ;
         COLCOUNT 60 ;
         BORDER ;
         FONT "Courier New" ;
         VALUE "#command @ <row>, <col> TEXTARRAY <name> ;" + hb_eol() + ;
               "      [ OBJ <obj> ] ;" + hb_eol() + ;
               "      [ <dummy1: OF, PARENT> <parent> ] ;" + hb_eol() + ;
               "      [ ACTION <action> ] ;" + hb_eol() + ;
               "      [ WIDTH <width> ] ;" + hb_eol() + ;
               "      [ HEIGHT <height> ] ;" + hb_eol() + ;
               "      [ ROWCOUNT <rowcount> ] ;" + hb_eol() + ;
               "      [ COLCOUNT <colcount> ] ;" + hb_eol() + ;
               "      [ FONT <fontname> ] ;" + hb_eol() + ;
               "      [ SIZE <fontsize> ] ;" + hb_eol() + ;
               "      [ <bold: BOLD> ] ;" + hb_eol() + ;
               "      [ <italic: ITALIC> ] ;" + hb_eol() + ;
               "      [ <underline: UNDERLINE> ] ;" + hb_eol() + ;
               "      [ <strikeout: STRIKEOUT> ] ;" + hb_eol() + ;
               "      [ TOOLTIP <tooltip> ] ;" + hb_eol() + ;
               "      [ BACKCOLOR <backcolor> ] ;" + hb_eol() + ;
               "      [ FONTCOLOR <fontcolor> ] ;" + hb_eol() + ;
               "      [ <border: BORDER> ] ;" + hb_eol() + ;
               "      [ <clientedge: CLIENTEDGE> ] ;" + hb_eol() + ;
               "      [ HELPID <helpid> ] ;" + hb_eol() + ;
               "      [ <invisible: INVISIBLE> ] ;" + hb_eol() + ;
               "      [ <rtl: RTL> ] ;" + hb_eol() + ;
               "      [ SUBCLASS <subclass> ] ;" + hb_eol() + ;
               "      [ VALUE <value> ] ;" + hb_eol() + ;
               "      [ <notabstop: NOTABSTOP> ] ;" + hb_eol() + ;
               "      [ <disabled: DISABLED> ] ;" + hb_eol() + ;
               "      [ <dummy2: ONGOTFOCUS, ON GOTFOCUS> <gotfocus> ] ;" + hb_eol() + ;
               "      [ <dummy3: ONLOSTFOCUS, ON LOSTFOCUS> <lostfocus> ]"

      @ 400, 520 BUTTON btn ;
         CAPTION "try me" ;
         ACTION oTxtArr:QQOut( "New text" ) ;
         WIDTH 80

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN Nil

/*
 * EOF
 */
