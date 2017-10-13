/*
 * RichEditBox Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how highlight a line of a RichEdit
 * control, using GetCurrentLine, GetSelection, SetSelection,
 * SetSelectionTextColor, SetSelectionBackColor, GetLineIndex
 * and GetLineLength methods, and OnSelChange event.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oWnd, oRch

   DEFINE WINDOW Win_1 OBJ oWnd ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 400 ;
      TITLE 'Richedit Control - Line Highlight'

      ON KEY ESCAPE ACTION oWnd:Release()

      @ 20,20 RICHEDITBOX rch_edit ;
         OBJ oRch ;
         WIDTH 500 ;
         HEIGHT 250

      oRch:OnSelChange := {|| Highlight( oRch )}

   END WINDOW

   ownd:Center()
   ownd:Activate()

RETURN Nil

FUNCTION Highlight( oRch )

   LOCAL aPos, aColor, nCurrent
   STATIC nPrevious := -1

   // Prevents changing default format
   IF EMPTY( oRch:Value )
      RETURN Nil
   ENDIF

   // If you change the color a second time
   // the line will be painted with the default color
   nCurrent := oRch:GetCurrentLine()
   IF nCurrent == nPrevious
      RETURN Nil
   ENDIF
   nPrevious := nCurrent

   // Save previous selection
   aPos := oRch:GetSelection()

   // Select all
   oRch:SetSelection( 0, -1 )

   // Restore defaults colors
   // If FontColor is Nil defaults to COLOR_WINDOWTEXT
   // If BackColor is Nil defaults to COLOR_WINDOW
    oRch:SetSelectionTextColor( oRch:FontColor )
    oRch:SetSelectionBackColor( oRch:BackColor )

   // Select current line
   oRch:SetSelection( oRch:GetLineIndex( nCurrent ), oRch:GetLineIndex( nCurrent ) + oRch:GetLineLength( nCurrent ) )

   // Change colors
   oRch:SetSelectionTextColor( RGB( RED[ 1 ], RED[ 2 ], RED[ 3 ] ) )
   oRch:SetSelectionBackColor( RGB( GREEN[ 1 ], GREEN[ 2 ], GREEN[ 3 ] ) )

   // Restore previous selection
   oRch:SetSelection( aPos[ 1 ], aPos[ 2 ] )

RETURN Nil

/*
 * EOF
 */
