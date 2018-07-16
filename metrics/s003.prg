/*
 * Windows Metrics Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to get the system's colors.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   hColors := ;
      { "COLOR_SCROLLBAR"               => COLOR_SCROLLBAR, ;
        "COLOR_BACKGROUND"              => COLOR_BACKGROUND, ;
        "COLOR_ACTIVECAPTION"           => COLOR_ACTIVECAPTION, ;
        "COLOR_INACTIVECAPTION"         => COLOR_INACTIVECAPTION, ;
        "COLOR_MENU"                    => COLOR_MENU, ;
        "COLOR_WINDOW"                  => COLOR_WINDOW, ;
        "COLOR_WINDOWFRAME"             => COLOR_WINDOWFRAME, ;
        "COLOR_MENUTEXT"                => COLOR_MENUTEXT, ;
        "COLOR_WINDOWTEXT"              => COLOR_WINDOWTEXT, ;
        "COLOR_CAPTIONTEXT"             => COLOR_CAPTIONTEXT, ;
        "COLOR_ACTIVEBORDER"            => COLOR_ACTIVEBORDER, ;
        "COLOR_INACTIVEBORDER"          => COLOR_INACTIVEBORDER, ;
        "COLOR_APPWORKSPACE"            => COLOR_APPWORKSPACE, ;
        "COLOR_HIGHLIGHT"               => COLOR_HIGHLIGHT, ;
        "COLOR_HIGHLIGHTTEXT"           => COLOR_HIGHLIGHTTEXT, ;
        "COLOR_BTNFACE"                 => COLOR_BTNFACE, ;
        "COLOR_BTNSHADOW"               => COLOR_BTNSHADOW, ;
        "COLOR_GRAYTEXT"                => COLOR_GRAYTEXT, ;
        "COLOR_BTNTEXT"                 => COLOR_BTNTEXT, ;
        "COLOR_INACTIVECAPTIONTEXT"     => COLOR_INACTIVECAPTIONTEXT, ;
        "COLOR_BTNHIGHLIGHT"            => COLOR_BTNHIGHLIGHT, ;
        "COLOR_3DDKSHADOW"              => COLOR_BTNHIGHLIGHT, ;
        "COLOR_3DLIGHT"                 => COLOR_3DLIGHT, ;
        "COLOR_INFOTEXT"                => COLOR_INFOTEXT, ;
        "COLOR_INFOBK"                  => COLOR_INFOBK, ;
        "COLOR_HOTLIGHT"                => COLOR_HOTLIGHT, ;
        "COLOR_GRADIENTACTIVECAPTION"   => COLOR_GRADIENTACTIVECAPTION, ;
        "COLOR_GRADIENTINACTIVECAPTION" => COLOR_GRADIENTINACTIVECAPTION, ;
        "COLOR_MENUHILIGHT"             => COLOR_MENUHILIGHT, ;
        "COLOR_MENUBAR"                 => COLOR_MENUBAR, ;
        "COLOR_DESKTOP"                 => COLOR_BACKGROUND, ;
        "COLOR_3DFACE"                  => COLOR_BTNFACE, ;
        "COLOR_3DSHADOW"                => COLOR_BTNSHADOW, ;
        "COLOR_3DHIGHLIGHT"             => COLOR_BTNHIGHLIGHT, ;
        "COLOR_3DHILIGHT"               => COLOR_BTNHIGHLIGHT, ;
        "COLOR_BTNHILIGHT"              => COLOR_BTNHIGHLIGHT }

   DEFINE WINDOW Form_1 ;
      AT 0, 0 ;
      WIDTH 450 ;
      HEIGHT 200 ;
      CLIENTAREA ;
      TITLE "System's Colors" ;
      ON INIT oCombo:Value := 1

      @ 13, 10 LABEL lbl_1 ;
         VALUE "Color:" ;
         WIDTH 50

      @ 10, 60 COMBOBOX cmb_1 ;
         OBJ oCombo ;
         ITEMS hColors:Keys ;
         WIDTH 300 ;
         ON CHANGE ShowColor()

      @ 60, 10 LABEL lbl_2 ;
         VALUE "RGB:" ;
         WIDTH 50

      @ 60, 60 LABEL lbl_3 ;
         OBJ oLabel ;
         VALUE "" ;
         WIDTH 300

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION GetSystemColor( nColor )

  local wColor := GetSysColor( nColor )

RETURN { GetRed( wColor ), GetGreen( wColor ), GetBlue( wColor) }

FUNCTION ShowColor

   aColor := GetSystemColor( hColors[ hColors:Keys[ oCombo:Value ] ] )

   oLabel:Value := "{" + Str( aColor[1], 3, 0 ) + ;
                   ", " + Str( aColor[2], 3, 0 ) + ;
                   ", " + Str( aColor[3], 3, 0 ) + "}"

   DRAW RECTANGLE IN WINDOW Form_1 AT 100,10 ;
      TO 190,440 ;
      PENCOLOR aColor ;
      PENWIDTH 5 ;
      FILLCOLOR aColor

RETURN NIL

/*
 * EOF
 */
