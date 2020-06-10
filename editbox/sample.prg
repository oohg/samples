
#include "oohg.ch"

FUNCTION Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 640 HEIGHT 480 ;
		TITLE 'OOHG - How to limit the row length of a EditBox' ;
		MAIN ;
		FONT 'Arial' SIZE 10

		@ 30,10 EDITBOX Edit_1 OBJ oEdit ;
			WIDTH 410 ;
			HEIGHT 140 ;
			ON CHANGE LimitRowLength()

      ON KEY ESCAPE ACTION Form_1.Release()
	END WINDOW

	Form_1.Center()
	Form_1.Activate()

RETURN NIL

PROCEDURE LimitRowLength
   LOCAL where, nLineStartIndex, nLineLength
   LOCAL nLimit := 10

   // get the zero-based index of the first character in the current line
   nLineStartIndex := oEdit:GetLineIndex( -1 )

   // get the length of the line
   nLineLength := oEdit:GetLineLength( nLineStartIndex )

   IF nLineLength > nLimit
      where := oEdit:CaretPos
      oEdit:Value := Stuff( oEdit:Value, nLineStartIndex + nLimit + 1, 0, hb_osNewLine() )
      oEdit:CaretPos := where + Len( hb_osNewLine() )
   ENDIF

RETURN NIL
