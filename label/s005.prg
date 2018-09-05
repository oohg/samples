/*
 * Label Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create multiline labels.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 330 HEIGHT 200 ;
      TITLE "oohg- Multiline Label Demo" ;
      MAIN

      @ 20,20 LABEL lbl OBJ oLbl SUBCLASS myLABEL ;
         VALUE "This is a multiline "    + HB_OSNewLine() + ;
               "label."                  + HB_OSNewLine() + ;
               "I am line 3 !!!"         + HB_OSNewLine() + ;
               "This is a multiline "    + HB_OSNewLine() + ;
               "label."                  + HB_OSNewLine() + ;
               "I am line 6 !!!"         + HB_OSNewLine() + ;
               "This is a multiline "    + HB_OSNewLine() + ;
               "label."                  + HB_OSNewLine() + ;
               "I am line 9 !!!" ;
         WIDTH 200 ;
         HEIGHT 50 ;
         VSCROLL

      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL


#include "hbclass.ch"

CLASS myLABEL FROM TLabel

   METHOD Events_VScroll

ENDCLASS

METHOD Events_VScroll( wParam ) CLASS myLABEL

   LOCAL nAction := LoWord( wParam )

   IF nAction == SB_LINEDOWN
      cAction := "SB_LINEDOWN"
   ELSEIF nAction == SB_LINEUP      
      cAction := "SB_LINEUP"
   ELSEIF nAction == SB_PAGEUP      
      cAction := "SB_PAGEUP"
   ELSEIF nAction == SB_PAGEDOWN    
      cAction := "SB_PAGEDOWN"
   ELSEIF nAction == SB_TOP         
      cAction := "SB_TOP"
   ELSEIF nAction == SB_BOTTOM      
      cAction := "SB_BOTTOM"
   ELSEIF nAction == SB_THUMBPOSITION
      cAction := "SB_THUMBPOSITION to position " + LTrim( Str( HiWord( wParam ) ) )
   ELSEIF nAction == SB_THUMBTRACK
      cAction := "SB_THUMBTRACK to position " + LTrim( Str( HiWord( wParam ) ) )
   ELSEIF nAction == SB_ENDSCROLL
      cAction := "SB_ENDSCROLL at position " + LTrim( Str( HiWord( wParam ) ) )
   ELSE
      cAction := "UNKNOWN"
   ENDIF

   AutoMsgBox( cAction )

   RETURN

/*
 * EOF
 */
