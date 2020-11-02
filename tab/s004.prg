/*
 * Tab Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how set and change the position of
 * the tabs.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW frm_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'ooHG - Tab demo: styles' ;
      MAIN

      DEFINE MAIN MENU
         MENUITEM 'Exit'            ACTION ThisWindow.Release
         DEFINE POPUP 'Style'
            MENUITEM 'Top pages'    ACTION DefineTab( "TOP" )
            MENUITEM 'Bottom pages' ACTION DefineTab( "BOTTOM" )
            MENUITEM 'Left pages'   ACTION DefineTab( "LEFT" )
            MENUITEM 'Right pages'  ACTION DefineTab( "RIGHT" )
         END POPUP
      END MENU

      DefineTab( "TOP" )

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW frm_1
   ACTIVATE WINDOW frm_1

RETURN NIL


PROCEDURE DefineTab( cStyle )

   IF IsControlDefined( tab_1, frm_1 )
      frm_1.tab_1.Release
   ENDIF

   IF cStyle == "TOP"
      DEFINE TAB tab_1 ;
         OF frm_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         TOOLTIP 'Tab Control' ;
         ITEMSIZE 120, 30 ;
         FIXEDWIDTH ;
         ICONLEFT ;
         LABELLEFT ;
         PADDING 5, 10


   ELSEIF cStyle == "BOTTOM"
      DEFINE TAB tab_1 ;
         OF frm_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         TOOLTIP 'Tab Control' ;
         BOTTOM ;
         MULTILINE RAGGEDRIG

   ELSEIF cStyle == "LEFT"
      DEFINE TAB tab_1 ;
         OF frm_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         TOOLTIP 'Tab Control' ;
         VERTICAL ;
         MINWIDTH 200

   ELSEIF cStyle == "RIGHT"
      DEFINE TAB tab_1 ;
         OF frm_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1 ;
         TOOLTIP 'Tab Control' ;
         RIGHT ;
         ONRCLICK {|nRow, nCol| AutoMsgBox( {nRow, nCol, ( frm_1.tab_1.Object ):ItemAtPos( nRow, nCol ) } ) } ;
         ITEMSIZE 150, 30 ;
  //       FIXEDWIDTH

   ENDIF

      PAGE 'Page 1' IMAGE 'Exit.Bmp' TOOLTIP "I'm page 1"

         @ 240, 40 LABEL lbl_1 ;
            VALUE "This LABEL has TRANSPARENT clause." ;
            TRANSPARENT ;
            AUTOSIZE

         @ 280, 40 LABEL lbl_2 OBJ oLbl ;
            VALUE "This LABEL hasn't." ;
            AUTOSIZE

         @ 240, 300 CHECKBOX chk_1 ;
            CAPTION "Click me!" ;
            TRANSPARENT

      END PAGE

      PAGE 'Page 2' IMAGE 'Info.Bmp'

         @ 50, 50 FRAME frm_1 ;
            CAPTION "This is a frame" ;
            WIDTH 200 ;
            HEIGHT 200

      END PAGE

      PAGE 'Page 3' IMAGE 'Check.Bmp' // TOOLTIP "I'm page 3"

         @ 90, 20 RADIOGROUP rdg_11 ;
            OBJ oR11 ;
            OPTIONS { 'One', 'Two', 'Three', 'Four' } ;
            WIDTH 80 ;
            SPACING 24 ;
            OOHGDRAW ;
            BACKCOLOR RED ;
            TRANSPARENT
         oR11:aOptions[ 1 ]:FontColor := GREEN
         oR11:aOptions[ 2 ]:BackColor := BLUE

      END PAGE

   END TAB

RETURN

/*
 * EOF
 */
