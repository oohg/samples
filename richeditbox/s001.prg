/*
 * RichEditBox Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to highlight a line of a RichEdit
 * control, using GetCurrentLine, GetSelection, SetSelection,
 * SetSelectionTextColor, SetSelectionBackColor, GetLineIndex
 * and GetLineLength methods, and OnSelChange event.
 *
 * Visit us at https://github.com/oohg/samples
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

   RETURN NIL

FUNCTION Highlight( oRch )

   LOCAL aPos, aColor, nCurrent
   STATIC nPrevious := -1

   IF Empty( oRch:Value )
      RETURN NIL
   ENDIF

   nCurrent := oRch:GetCurrentLine()
   IF nCurrent == nPrevious
      RETURN NIL
   ENDIF

   // Save current selection: [ index of starting char, number of chars ]
   aPos := oRch:GetSelection()

   IF nPrevious # -1
      // Select all text of the previously selected line
      oRch:SetSelection( oRch:GetLineIndex( nPrevious ), oRch:GetLineIndex( nPrevious ) + oRch:GetLineLength( nPrevious ) )

      // Restore colors
      oRch:SetSelectionTextColor( oRch:FontColor )
      oRch:SetSelectionBackColor( oRch:BackColor )
   ENDIF

   // Select all text in the first line of the current selection (the line where the caret rests)
   oRch:SetSelection( oRch:GetLineIndex( nCurrent ), oRch:GetLineIndex( nCurrent ) + oRch:GetLineLength( nCurrent ) )

   // Change colors
   oRch:SetSelectionTextColor( RGB( RED[ 1 ], RED[ 2 ], RED[ 3 ] ) )
   oRch:SetSelectionBackColor( RGB( GREEN[ 1 ], GREEN[ 2 ], GREEN[ 3 ] ) )

   // Restore selection
   oRch:SetSelection( aPos[ 1 ], aPos[ 2 ] )

   nPrevious := nCurrent

   RETURN NIL

/*
 * EOF
 */
