/*
 * Bos Taurus Sample # 13
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to draw graphs.
 *
 * Based on a sample contributed by S.Rathinagiri <srgiri@dataone.in>
 * and adapted for Minigui Extended by Grigory Filatov <gfilatov@inbox.ru>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "bostaurus.ch"

MEMVAR nPenWidth

PROCEDURE Main

   SET FONT TO GetDefaultFontName(), GetDefaultFontSize()

   DEFINE WINDOW WinGraph OBJ oWin ;
      AT 0, 0 ;
      WIDTH 700 ;
      HEIGHT 700 ;
      CLIENTAREA ;
      TITLE 'Bos Taurus: Graph' ;
      MAIN ;
      NODWP

      DEFINE LABEL SelectType
         ROW 13
         COL 45
         WIDTH 100
         VALUE 'Select Graph Type'
      END LABEL

      DEFINE COMBOBOX GraphType
         ROW 10
         COL 150
         WIDTH 100
         ITEMS { 'Bar', 'Lines', 'Points', 'Pie' }
         ONCHANGE DrawGraph()
      END COMBOBOX

      DEFINE CHECKBOX Enable3D
         ROW 08
         COL 280
         WIDTH 80
         CAPTION 'Enable 3D'
         ONCHANGE DrawGraph()
         VALUE .T.
         LEFTALIGN .T.
      END CHECKBOX

      DEFINE IMAGE GraphArea
         ROW 50
         COL 50
         WIDTH 600
         HEIGHT 600
         STRETCH .T.
      END IMAGE

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   WinGraph.GraphType.Value := 1
   WinGraph.Center
   WinGraph.Activate

   RETURN


PROCEDURE DrawGraph
   LOCAL cImage := GetTempFolder() + '\graph.bmp'
   LOCAL nImageWidth := WinGraph.GraphArea.Width
   LOCAL nImageHeight := WinGraph.GraphArea.Height
   LOCAL cTitle := 'Sample Graph'
   LOCAL aYValues := { "Jan", "Feb", "Mar", "Apr", "May" }
   LOCAL aData := { { 14280, 20420, 12870, 25347, 7640 }, ;
                    { 8350, 10315, 15870, 5347, 12340 }, ;
                    { 12345, -8945, 10560, 15600, 17610 } }
   LOCAL nBarDepth := 15
   LOCAL nBarWidth := 15
   LOCAL nHValues := 5
   LOCAL l3D := WinGraph.Enable3D.Value
   LOCAL lGrid := .T.
   LOCAL lXGrid := .T.
   LOCAL lYGrid := .T.
   LOCAL lXVal := .T.
   LOCAL lYVal := .T.
   LOCAL nGraphType := WinGraph.GraphType.Value
   LOCAL lViewVal := .T.
   LOCAL lLegends := .T.
   LOCAL cPicture := '99,999.99'
   LOCAL aSeries := { "Serie 1", "Serie 2", "Serie 3" }
   LOCAL aColors := { { 128, 128, 255 }, { 255, 102, 10 }, { 55, 201, 48 } }
   LOCAL lNoBorder := .F.
   LOCAL nLegendWidth := 50

   IF WinGraph.GraphType.Value == 4 // pie
      DrawPieGraphInBitmap( cImage, nImageWidth, nImageHeight, { 1500, 1800, 200, 500, 800 }, { "Product 1", "Product 2", "Product 3", "Product 4", "Product 5" }, { { 255, 0, 0 }, { 0, 0, 255 }, { 255, 255, 0 }, { 0, 255, 0 }, { 255, 128, 64 }, { 128, 0, 128 } }, "Sales", 25, l3D, lXVal, lLegends, lNoBorder )
   ELSE
      GraphSave( cImage, nImageWidth, nImageHeight, aData, cTitle, aYValues, nBarDepth, nBarWidth, NIL, nHValues, l3D, lGrid, lXGrid, lYGrid, lXVal, lYVal, lLegends, aSeries, aColors, nGraphType, lViewVal, cPicture, nLegendWidth, lNoBorder )
   ENDIF
   WinGraph.GraphArea.Picture := cImage
   FErase( cImage )

   RETURN


PROCEDURE GraphSave( cImageFileName, nWidth, nHeight, aData, cTitle, aYVals, nBarD, nWideB, nSep, nXRanges, l3D, lGrid, lXGrid, lYGrid, lXVal, lYVal, lLegends, aSeries, aColors, nType, lViewVal, cPicture, nLegendWindth, lNoBorder )
   LOCAL nI, nJ, nPos, nMax, nMin, nMaxBar, nDeep
   LOCAL nRange, nResH, nResV,  nWide, aPoint, cName
   LOCAL nXMax, nXMin, nHigh, nRel, nZero, nRPos, nRNeg
   LOCAL hBitMap, hDC, BTStruct
   LOCAL nTop := 0
   LOCAL nLeft := 0
   LOCAL nBottom := nHeight
   LOCAL nRight := nWidth

   DEFAULT cTitle := ""
   DEFAULT nSep := 0
   DEFAULT cPicture := "999,999.99"
   DEFAULT nLegendWindth := 50

   PRIVATE nPenWidth := 1

   IF ( Len( aSeries ) != Len( aData ) ) .OR. ( Len( aSeries ) != Len( aColors ) )
      OOHG_MsgError( "DRAW GRAPH: 'Series' / 'SerieNames' / 'Colors' arrays size mismatch." )
   ENDIF

   hBitMap := BT_BitmapCreateNew( nWidth, nHeight, { 255, 255, 255 } )
   hDC := BT_CreateDC( hBitMap, BT_HDC_BITMAP, @BTStruct )

   IF lGrid
      lXGrid := lYGrid := .T.
   ENDIF

   IF nBottom <> NIL .AND. nRight <> NIL
      nHeight := nBottom - nTop / 2
      nWidth  := nRight - nLeft / 2
      nBottom -= IF( lYVal, 42, 32 )
      nRight  -= IF( lLegends, 32 + nLegendWindth, 32 )
   ENDIF
   nTop  += 1 + IF( Empty( cTitle ), 30, 44 )                             // Top gap
   nLeft += 1 + IF( lXVal, 80 + nBarD, 30 + nBarD )                       // Left
   DEFAULT nBottom := nHeight - 2 - IF( lYVal, 40, 30 )                   // Bottom
   DEFAULT nRight  := nWidth - 2 - IF( lLegends, 30 + nLegendWindth, 30 ) // RIGHT

   l3D     := IF( nType == 3, .F., l3D )      // POINTS
   nDeep   := IF( l3D, nBarD, 1 )
   nMaxBar := nBottom - nTop - nDeep - 5
   nResH   := nResV := 1
   nWide   := ( nRight - nLeft ) * nResH / ( nMax( aData ) + 1 ) * nResH

   // Graph area
   IF ! lNoborder
      DrawWindowBoxInBitmap( hDC, Max( 1, nTop - 44 ), Max( 1, nLeft - 80 - nBarD ), nHeight - 1, nWidth - 1 )
   ENDIF

   // Back area
   IF l3D
      DrawRectInBitmap( hDC, nTop + 1, nLeft, nBottom - nDeep, nRight, { 255, 255, 255 } )
   ELSE
      DrawRectInBitmap( hDC, nTop - 5, nLeft, nBottom, nRight, { 255, 255, 255 } )
   ENDIF

   IF l3D
      // Bottom area
      FOR nI := 1 TO nDeep + 1
         DrawLineInBitmap( hDC, nBottom - nI, nLeft - nDeep + nI, nBottom - nI, nRight - nDeep + nI, { 255, 255, 255 } )
      NEXT nI

      // Lateral
      FOR nI := 1 TO nDeep
         DrawLineInBitmap( hDC, nTop + nI, nLeft - nI, nBottom - nDeep + nI, nLeft - nI, { 192, 192, 192 } )
      NEXT nI

      // Graph borders
      FOR nI := 1 TO nDeep + 1
         DrawLineInBitmap( hDC, nBottom - nI, nLeft - nDeep + nI - 1, nBottom - nI, nLeft - nDeep + nI, GRAY )
         DrawLineInBitmap( hDC, nBottom - nI, nRight - nDeep + nI - 1, nBottom - nI, nRight - nDeep + nI, BLACK )
         DrawLineInBitmap( hDC, nTop + nDeep - nI + 1, nLeft - nDeep + nI - 1, nTop + nDeep - nI + 1, nLeft - nDeep + nI, BLACK )
         DrawLineInBitmap( hDC, nTop + nDeep - nI + 1, nLeft - nDeep + nI - 3, nTop + nDeep - nI + 1, nLeft - nDeep + nI - 2, BLACK )
      NEXT nI

      FOR nI = 1 TO nDeep + 2
         DrawLineInBitmap( hDC, nTop + nDeep - nI + 1, nLeft - nDeep + nI - 3, nTop + nDeep - nI + 1, nLeft - nDeep + nI - 2, BLACK )
         DrawLineInBitmap( hDC, nBottom + 2 -nI + 1, nRight - nDeep + nI, nBottom + 2 -nI + 1, nRight - nDeep + nI - 2, BLACK )
      NEXT nI

      DrawLineInBitmap( hDC, nTop, nLeft, nTop, nRight, BLACK )
      DrawLineInBitmap( hDC, nTop - 2, nLeft, nTop - 2, nRight + 2, BLACK )
      DrawLineInBitmap( hDC, nTop, nLeft, nBottom - nDeep, nLeft, GRAY  )
      DrawLineInBitmap( hDC, nTop + nDeep, nLeft - nDeep, nBottom, nLeft - nDeep, BLACK )
      DrawLineInBitmap( hDC, nTop + nDeep, nLeft - nDeep - 2, nBottom + 2, nLeft - nDeep - 2, BLACK )
      DrawLineInBitmap( hDC, nTop, nRight, nBottom - nDeep, nRight, BLACK )
      DrawLineInBitmap( hDC, nTop - 2, nRight + 2, nBottom - nDeep + 2, nRight + 2, BLACK )
      DrawLineInBitmap( hDC, nBottom - nDeep, nLeft, nBottom - nDeep, nRight, GRAY  )
      DrawLineInBitmap( hDC, nBottom, nLeft - nDeep, nBottom, nRight - nDeep, BLACK )
      DrawLineInBitmap( hDC, nBottom + 2, nLeft - nDeep - 2, nBottom + 2, nRight - nDeep, BLACK )
   ENDIF

   // Graph info
   IF ! Empty( cTitle )
      DrawTextInBitmap( hDC, nTop - 30 * nResV, nLeft + nWidth / 3, cTitle, 'Arial', 12, RED, 2 )
   ENDIF

   // Legends
   IF lLegends
      nPos := nTop
      FOR nI := 1 TO Len( aSeries )
         DrawBarInBitmap( hDC, nRight + ( 8 * nResH ), nPos + ( 9 * nResV ), 8 * nResH, 7 * nResV, l3D, 1, aColors[ nI ] )
         DrawTextInBitmap( hDC, nPos, nRight + ( 20 * nResH ), aSeries[ nI ], 'Arial', 8, BLACK, 0 )
         nPos += 18 * nResV
      NEXT nI
   ENDIF

   // Max, Min values
   nMax := 0
   FOR nJ := 1 TO Len( aSeries )
      FOR nI := 1 TO Len( aData[ nJ ] )
         nMax := Max( aData[ nJ ][ nI ], nMax )
      NEXT nI
   NEXT nJ
   nMin := 0
   FOR nJ := 1 TO Len( aSeries )
      FOR nI := 1 TO Len( aData[ nJ ] )
         nMin := Min( aData[ nJ ][ nI ], nMin )
      NEXT nI
   NEXT nJ

   nXMax   := IF( nMax > 0, DetMaxVal( nMax ), 0 )
   nXMin   := IF( nMin < 0, DetMaxVal( nMin ), 0 )
   nHigh   := nXMax + nXMin
   nMax    := Max( nXMax, nXMin )
   nRel    := ( nMaxBar / nHigh )
   nMaxBar := nMax * nRel
   nZero   := nTop + ( nMax * nRel ) + nDeep + 5

   IF l3D
      FOR nI := 1 TO nDeep + 1
         DrawLineInBitmap( hDC, nZero - nI + 1, nLeft - nDeep + nI, nZero - nI + 1, nRight - nDeep + nI, { 192, 192, 192 } )
      NEXT nI
      FOR nI := 1 TO nDeep + 1
         DrawLineInBitmap( hDC, nZero - nI + 1, nLeft - nDeep + nI - 1, nZero - nI + 1, nLeft - nDeep + nI, GRAY )
         DrawLineInBitmap( hDC, nZero - nI + 1, nRight - nDeep + nI - 1, nZero - nI + 1, nRight - nDeep + nI, BLACK )
      NEXT nI
      DrawLineInBitmap( hDC, nZero - nDeep, nLeft, nZero - nDeep, nRight, GRAY )
   ENDIF

   aPoint := Array( Len( aSeries ), Len( aData[ 1 ] ), 2 )
   nRange := nMax / nXRanges

   // X labels
   nRPos := nRNeg := nZero - nDeep
   FOR nI := 0 TO nXRanges
      IF lXVal
         IF nRange * nI <= nXMax
            DrawTextInBitmap( hDC, nRPos, nLeft - nDeep - 70, Transform( nRange * nI, cPicture ), 'Arial', 8, BLUE )
         ENDIF
         IF nRange * ( -nI ) >= nXMin * ( -1 )
            DrawTextInBitmap( hDC, nRNeg, nLeft - nDeep - 70, Transform( nRange *- nI, cPicture ), 'Arial', 8, BLUE )
         ENDIF
      ENDIF

      IF lXGrid
         IF nRange * nI <= nXMax
            IF l3D
               FOR nJ := 0 TO nDeep + 1
                  DrawLineInBitmap( hDC, nRPos + nJ, nLeft - nJ - 1, nRPos + nJ, nLeft - nJ, BLACK )
               NEXT nJ
            ENDIF
            DrawLineInBitmap( hDC, nRPos, nLeft, nRPos, nRight, BLACK )
         ENDIF
         IF nRange *- nI >= nXMin *- 1
            IF l3D
               FOR nJ := 0 TO nDeep + 1
                  DrawLineInBitmap( hDC, nRNeg + nJ, nLeft - nJ - 1, nRNeg + nJ, nLeft - nJ, BLACK )
               NEXT nJ
            ENDIF
            DrawLineInBitmap( hDC, nRNeg, nLeft, nRNeg, nRight, BLACK )
         ENDIF
      ENDIF
      nRPos -= ( nMaxBar / nXRanges )
      nRNeg += ( nMaxBar / nXRanges )
   NEXT nI

   IF lYGrid .and. nType <> 1        // BARS
      nPos := IF( l3D, nTop, nTop - 5 )
      nI  := nLeft + nWide
      FOR nJ := 1 TO nMax( aData )
         DrawLineInBitmap( hDC, nBottom - nDeep, nI, nPos, nI, { 100, 100, 100 } )
         DrawLineInBitmap( hDC, nBottom, nI - nDeep, nBottom - nDeep, nI, { 100, 100, 100 } )
         nI += nWide
      NEXT
   ENDIF

   DO WHILE .T.    // Bar adjust
      nPos = nLeft + ( nWide / 2 )
      nPos += ( nWide + nSep ) * ( Len( aSeries ) + 1 ) * Len( aData[ 1 ] )
      IF nPos > nRight
         nWide --
      ELSE
         EXIT
      ENDIF
   ENDDO

   nMin := nMax / nMaxBar

   // First point
   nPos := nLeft + ( ( nWide + nSep ) / 2 )            
   nRange := ( ( nWide + nSep ) * Len( aSeries ) ) / 2

   // Show Y labels
   IF lYVal .AND. Len( aYVals ) > 0                
      nWideB  := ( nRight - nLeft ) / ( nMax( aData ) + 1 )
      nI := nLeft + nWideB
      FOR nJ := 1 TO nMax( aData )
         cName := "yVal_Name_" + LTrim( Str( nJ ) )
         DrawTextInBitmap( hDC, nBottom + 8, nI - nDeep - IF( l3D, 0, 8 ), aYVals[ nJ ], 'Arial', 8, BLUE )
         nI += nWideB
      NEXT
   ENDIF

   IF lYGrid .and. nType == 1    // BARS
      nPos := IF( l3D, nTop, nTop - 5 )
      nI  := nLeft + ( ( nWide + nSep ) / 2 ) + nWide
      FOR nJ := 1 TO nMax( aData )
         DrawLineInBitmap( hDC, nBottom - nDeep, nI - nWide , nPos, nI - nWide, { 100,100, 100 } )
         DrawLineInBitmap( hDC, nBottom, nI - nDeep - nWide , nBottom - nDeep, nI - nWide, { 100, 100, 100 } )
         nI += ( Len( aSeries ) + 1 ) * ( nWide + nSep )
      NEXT
   ENDIF

   IF nType == 1    // BARS
      IF nMin <> 0
         nPos := nLeft + ( ( nWide + nSep ) / 2 )
         FOR nI = 1 TO Len( aData[ 1 ] )
            FOR nJ = 1 TO Len( aSeries )
               DrawBarInBitmap( hDC, nPos, nZero, aData[ nJ, nI ] / nMin + nDeep, nWide, l3D, nDeep, aColors[ nJ ] )
               nPos += nWide + nSep
            NEXT nJ
            nPos += nWide + nSep
         NEXT nI
      ENDIF
   ENDIF

   IF nType == 2   // LINES
      IF nMin <> 0
         nWideB  := ( nRight - nLeft ) / ( nMax( aData ) + 1 )
         nPos := nLeft + nWideB
         FOR nI := 1 TO Len( aData[ 1 ] )
            FOR nJ = 1 TO Len( aSeries )
               IF ! l3D
                  DrawPointInBitmap( hDC, nType, nPos, nZero, aData[ nJ, nI ] / nMin + nDeep, aColors[ nJ ] )
               ENDIF
               aPoint[ nJ, nI, 2 ] := nPos
               aPoint[ nJ, nI, 1 ] := nZero - ( aData[ nJ, nI ] / nMin + nDeep )
            NEXT nJ
            nPos += nWideB
         NEXT nI

         FOR nI := 1 TO Len( aData[ 1 ] ) -1
            FOR nJ := 1 TO Len( aSeries )
               IF l3D
                  DrawPolygonInBitmap( hDC, ;
                                       { { aPoint[ nJ, nI, 1 ], aPoint[ nJ, nI, 2 ] }, ;
                                         { aPoint[ nJ, nI + 1, 1 ], aPoint[ nJ, nI + 1, 2 ] }, ;
                                         { aPoint[ nJ, nI + 1, 1 ] - nDeep, aPoint[ nJ, nI + 1, 2 ] + nDeep }, ;
                                         { aPoint[ nJ, nI, 1 ] - nDeep, aPoint[ nJ, nI, 2 ] + nDeep }, ;
                                         { aPoint[ nJ, nI, 1 ], aPoint[ nJ, nI, 2 ] } }, ;
                                       NIL, ;
                                       NIL, ;
                                       aColors[ nJ ] )
               ELSE
                  DrawLineInBitmap( hDC, aPoint[ nJ, nI, 1 ], aPoint[ nJ, nI, 2 ], aPoint[ nJ, nI + 1, 1 ], aPoint[ nJ, nI + 1, 2 ], aColors[ nJ ] )
               ENDIF
            NEXT nJ
         NEXT nI
      ENDIF
   ENDIF

   IF nType == 3   // POINTS
      IF nMin <> 0
         nWideB := ( nRight - nLeft ) / ( nMax( aData ) + 1 )
         nPos := nLeft + nWideB
         FOR nI := 1 TO Len( aData[ 1 ] )
            FOR nJ = 1 TO Len( aSeries )
               DrawPointInBitmap( hDC, nType, nPos, nZero, aData[ nJ, nI ] / nMin + nDeep, aColors[ nJ ] )
               aPoint[ nJ, nI, 2 ] := nPos
               aPoint[ nJ, nI, 1 ] := nZero - aData[ nJ, nI ] / nMin
            NEXT nJ
            nPos += nWideB
         NEXT nI
      ENDIF
   ENDIF

   IF lViewVal
      IF nType == 1
         nPos := nLeft + nWide + ( ( nWide + nSep ) * ( Len( aSeries ) / 2 ) )
      ELSE
         nWideB := ( nRight - nLeft ) / ( nMax( aData ) + 1 )
         nPos := nLeft + nWideB
      ENDIF
      FOR nI := 1 TO Len( aData[ 1 ] )
         FOR nJ := 1 TO Len( aSeries )                                                   // BARS
            DrawTextInBitmap( hDC, nZero - ( aData[ nJ, nI ] / nMin + nDeep + 18 ), IF( nType == 1, nPos - IF( l3D, 44, 46 ), nPos + 10 ), Transform( aData[ nJ, nI ], cPicture ), 'Arial', 8 )
            nPos += IF( nType == 1, nWide + nSep, 0 )
         NEXT nJ
         IF nType == 1
            nPos += nWide + nSep
         ELSE
            nPos += nWideB
         ENDIF
      NEXT nI
   ENDIF

   IF l3D
      DrawLineInBitmap( hDC, nZero, nLeft - nDeep, nZero, nRight - nDeep, BLACK )
   ELSE
      IF nXMax <> 0 .AND. nXMin <> 0
         DrawLineInBitmap( hDC, nZero - 1, nLeft - 2, nZero - 1, nRight, RED )
      ENDIF
   ENDIF

   BT_BitmapSaveFile( hBitmap, cImageFileName )
   BT_DeleteDC( BTstruct )
   BT_BitmapRelease( hBitmap )

   RETURN


PROCEDURE DrawWindowBoxInBitmap( hDC, row, col, rowr, colr )

   BT_DrawRectangle( hDC, Row, Col, Colr - col, rowr - row, { 0, 0, 0 }, nPenWidth )

   RETURN


PROCEDURE DrawRectInBitmap( hDC, row, col, row1, col1, aColor )

   BT_DrawFillRectangle( hDC, Row, Col, col1 - col, row1 - row, aColor, aColor, nPenWidth )

   RETURN


PROCEDURE DrawLineInBitmap( hDC, Row1, Col1, Row2, Col2, aColor )

   BT_DrawLine ( hDC, Row1, Col1, Row2, Col2, aColor, nPenWidth )

   RETURN


FUNCTION DrawTextInBitmap( hDC, Row, Col, cText, cFontName, nFontSize, aColor, nAlign )

   DEFAULT nAlign := 0
   DO CASE
   CASE nAlign == 0
      BT_DrawText( hDC, Row, Col, cText, cFontName, nFontSize, aColor, , BT_TEXT_TRANSPARENT )
   CASE nAlign == 1
      BT_DrawText( hDC, Row, Col, cText, cFontName, nFontSize, aColor, , , BT_TEXT_RIGHT + BT_TEXT_TOP )
   CASE nAlign == 2
      BT_DrawText( hDC, Row, Col, cText, cFontName, nFontSize, aColor, , , BT_TEXT_CENTER + BT_TEXT_TOP )
   ENDCASE

   RETURN NIL


PROCEDURE DrawBarInBitmap( hDC, nY, nX, nHigh, nWidth, l3D, nDeep, aColor )
   LOCAL nI, nColTop, nShadow, nH := nHigh

   nColTop := ClrShadow( RGB( aColor[ 1 ], aColor[ 2 ], aColor[ 3 ] ), 20 )
   nShadow := ClrShadow( nColTop, 20 )
   nShadow2 := ClrShadow( nColTop, 40 )
   nColTop := { GetRed( nColTop ), GetGreen( nColTop ), GetBlue( nColTop ) }
   nShadow := { GetRed( nShadow ), GetGreen( nShadow ), GetBlue( nShadow ) }
   nShadow2 := { GetRed( nShadow2 ), GetGreen( nShadow2 ), GetBlue( nShadow2 ) }

   BT_DrawGradientFillVertical( hDC, nX + nDeep - nHigh, nY, nWidth + 1, nHigh - nDeep, aColor, nShadow2 )

   IF l3D
      // Lateral
      DrawPolygonInBitmap( hDC, ;
                           { { nX - 1, nY + nWidth + 1 }, ;
                             { nX + nDeep - nHigh, nY + nWidth + 1 }, ;
                             { nX - nHigh + 1, nY + nWidth + nDeep }, ;
                             { nX - nDeep, nY + nWidth + nDeep }, ;
                             { nX - 1, nY + nWidth + 1 } }, ;
                             nShadow, ;
                             NIL, ;
                             nShadow )
      // Superior
      nHigh   := Max( nHigh, nDeep )
      DrawPolygonInBitmap( hDC, ;
                           { { nX - nHigh + nDeep, nY + 1 }, ;
                           { nX - nHigh + nDeep, nY + nWidth + 1 }, ;
                           { nX - nHigh + 1, nY + nWidth + nDeep }, ;
                           { nX - nHigh + 1, nY + nDeep }, ;
                           { nX - nHigh + nDeep, nY + 1 } }, ;
                           nColTop, ;
                           NIL, ;
                           nColTop )
      // Border
      DrawBoxInBitmap( hDC, nY, nX, nH, nWidth, l3D, nDeep )
   ENDIF

   RETURN


FUNCTION ClrShadow( nColor, nFactor )
   LOCAL aHSL, aRGB

   aHSL := RGB2HSL( GetRed( nColor ), GetGreen( nColor ), GetBlue( nColor ) )
   aHSL[ 3 ] -= nFactor
   aRGB := HSL2RGB( aHSL[ 1 ], aHSL[ 2 ], aHSL[ 3 ] )

   RETURN RGB( aRGB[ 1 ], aRGB[ 2 ], aRGB[ 3 ] )


FUNCTION nMax( aData )
   LOCAL nI, nMax := 0

   FOR nI := 1 TO Len( aData )
      nMax := Max( Len( aData[ nI ] ), nMax )
   NEXT nI

   RETURN nMax


FUNCTION DetMaxVal( nNum )
   LOCAL nE, nMax, nMan, nVal, nOffset

   nE := 9
   nVal := 0
   nNum := Abs( nNum )

   DO WHILE .T.
      nMax := 10 ** nE

      IF Int( nNum / nMax ) > 0
         nMan := ( nNum / nMax ) - Int( nNum / nMax )
         nOffset := 1
         nOffset := IF( nMan <= .75, .75, nOffset )
         nOffset := IF( nMan <= .50, .50, nOffset )
         nOffset := IF( nMan <= .25, .25, nOffset )
         nOffset := IF( nMan <= .00, .00, nOffset )
         nVal := ( Int( nNum / nMax ) + nOffset ) * nMax
         EXIT
      ENDIF

      nE --
   ENDDO

   RETURN nVal


PROCEDURE DrawPointInBitmap( hDC, nType, nY, nX, nHigh, aColor )

   IF nType == 3         // POINTS
      DrawCircleInBitmap( hDC, nX - nHigh - 3, nY - 3, 8, aColor )
   ELSEIF nType == 2     // LINES
      DrawCircleInBitmap( hDC, nX - nHigh - 2, nY - 2, 6, aColor )
   ENDIF

   RETURN


PROCEDURE DrawCircleInBitmap( hDC, nCol, nRow, nWidth, aColor )

   BT_DrawFillEllipse( hDC, nCol, nRow, nWidth, nWidth, aColor, aColor, nPenWidth )

   RETURN


PROCEDURE DrawPieGraphInBitmap( cImageFileName, nWidth, nHeight, aSeries, aName, aColors, cTitle, nDepth, l3D, lXVal, lSLeg, lNoBorder )
   LOCAL fromrow := 0
   LOCAL fromcol := 0
   LOCAL torow := nHeight
   LOCAL tocol := nWidth
   LOCAL topleftrow := fromrow
   LOCAL topleftcol := fromcol
   LOCAL toprightrow := fromrow
   LOCAL toprightcol := tocol
   LOCAL bottomrightrow := torow
   LOCAL bottomrightcol := tocol
   LOCAL bottomleftrow := torow
   LOCAL bottomleftcol := fromcol
   LOCAL middletoprow := fromrow
   LOCAL middletopcol := fromcol + Int( tocol - fromcol ) / 2
   LOCAL middleleftrow := fromrow + Int( torow - fromrow ) / 2
   LOCAL middleleftcol := fromcol
   LOCAL middlebottomrow := torow
   LOCAL middlebottomcol := fromcol + Int( tocol - fromcol ) / 2
   LOCAL middlerightrow := fromrow + Int( torow - fromrow ) / 2
   LOCAL middlerightcol := tocol
   LOCAL fromradialrow := 0
   LOCAL fromradialcol := 0
   LOCAL toradialrow := 0
   LOCAL toradialcol := 0
   LOCAL degrees := {}
   LOCAL cumulative := {}
   LOCAL j, i, sum := 0
   LOCAL cname := ""
   LOCAL shadowcolor := {}
   LOCAL previos_cumulative
   LOCAL hDC, hBitMap, BTStruct

   PRIVATE nPenWidth := 1

   hBitMap := BT_BitmapCreateNew( nWidth, nHeight, { 255, 255, 255 } )
   hDC := BT_CreateDC( hBitMap, BT_HDC_BITMAP, @BTStruct )

   IF ! lNoBorder
      DrawWindowBoxInBitmap( hDC, fromrow, fromcol, torow - 1, tocol - 1 )
   ENDIF

   IF Len( AllTrim( cTitle ) ) > 0
      DrawTextInBitmap( hDC, fromrow + 10, IIF( Len( AllTrim( cTitle ) ) * 12 > ( tocol - fromcol ), fromcol, Int( ( ( tocol - fromcol ) - ( Len( AllTrim( cTitle ) ) * 12 ) ) / 2 ) + fromcol ), AllTrim( cTitle ), 'Arial', 12, { 0, 0, 255 } )
      fromrow := fromrow + 40
   ENDIF

   IF lSLeg
      IF Len( aName ) * 20 > ( torow - fromrow )
         MsgInfo( "No space for showing legends" )
      ELSE
         torow := torow - ( Len( aName ) * 20 )
      ENDIF
   ENDIF

   DrawRectInBitmap( hDC, fromrow + 10, fromcol + 10, torow - 10, tocol - 10, { 255, 255, 255 } )

   IF l3D
      torow := torow - nDepth
   ENDIF

   fromcol := fromcol + 25
   tocol := tocol - 25
   torow := torow - 25
   fromrow := fromrow + 25
   topleftrow := fromrow
   topleftcol := fromcol
   toprightrow := fromrow
   toprightcol := tocol
   bottomrightrow := torow
   bottomrightcol := tocol
   bottomleftrow := torow
   bottomleftcol := fromcol
   middletoprow := fromrow
   middletopcol := fromcol + Int( tocol - fromcol ) / 2
   middleleftrow := fromrow + Int( torow - fromrow ) / 2
   middleleftcol := fromcol
   middlebottomrow := torow
   middlebottomcol := fromcol + Int( tocol - fromcol ) / 2
   middlerightrow := fromrow + Int( torow - fromrow ) / 2
   middlerightcol := tocol
   torow := torow + 1
   tocol := tocol + 1

   FOR i := 1 TO Len( aSeries )
      sum := sum + aSeries[ i ]
   NEXT i
   FOR i := 1 TO Len( aSeries )
      AAdd( degrees, Round( aSeries[ i ] / sum * 360, 0 ) )
   NEXT i
   sum := 0
   FOR i := 1 TO Len( degrees )
      sum := sum + degrees[ i ]
   NEXT i
   IF sum <> 360
      degrees[ Len( degrees ) ] := degrees[ Len( degrees ) ] + ( 360 - sum )
   ENDIF

   sum := 0
   FOR i := 1 TO Len( degrees )
      sum := sum + degrees[ i ]
      AAdd( cumulative, sum )
   NEXT i

   previos_cumulative := -1

   fromradialrow := middlerightrow
   fromradialcol := middlerightcol
   FOR i := 1 TO Len( cumulative )
      IF cumulative[ i ] == previos_cumulative
         LOOP
      ENDIF

      previos_cumulative := cumulative[ i ]

      shadowcolor := { IIF( aColors[ i, 1 ] > 50, aColors[ i, 1 ] - 50, 0 ), IIF( aColors[ i, 2 ] > 50, aColors[ i, 2 ] - 50, 0 ), IIF( aColors[ i, 3 ] > 50, aColors[ i, 3 ] - 50, 0 ) }

      DO CASE
      CASE cumulative[ i ] <= 45
         toradialcol := middlerightcol
         toradialrow := middlerightrow - Round( cumulative[ i ] / 45 * ( middlerightrow - toprightrow ), 0 )
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 90 .AND. cumulative[ i ] > 45
         toradialrow := toprightrow
         toradialcol := toprightcol - Round( ( cumulative[ i ] - 45 ) / 45 * ( toprightcol - middletopcol ), 0 )
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 135 .AND. cumulative[ i ] > 90
         toradialrow := topleftrow
         toradialcol := middletopcol - Round( ( cumulative[ i ] - 90 ) / 45 * ( middletopcol - topleftcol ), 0 )
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 180 .AND. cumulative[ i ] > 135
         toradialcol := topleftcol
         toradialrow := topleftrow + Round( ( cumulative[ i ] - 135 ) / 45 * ( middleleftrow - topleftrow ), 0 )
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 225 .AND. cumulative[ i ] > 180
         toradialcol := topleftcol
         toradialrow := middleleftrow + Round( ( cumulative[ i ] - 180 ) / 45 * ( bottomleftrow - middleleftrow ), 0 )
         IF l3D
            FOR j := 1 TO nDepth
               DrawArcInBitmap( hDC, fromrow + j, fromcol, torow + j, tocol, fromradialrow + j, fromradialcol, toradialrow + j, toradialcol, shadowcolor )
            NEXT j
         ENDIF
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 270 .AND. cumulative[ i ] > 225
         toradialrow := bottomleftrow
         toradialcol := bottomleftcol + Round( ( cumulative[ i ] - 225 ) / 45 * ( middlebottomcol - bottomleftcol ), 0 )
         IF l3D
            FOR j := 1 TO nDepth
               DrawArcInBitmap( hDC, fromrow + j, fromcol, torow + j, tocol, fromradialrow + j, fromradialcol, toradialrow + j, toradialcol, shadowcolor )
            NEXT j
         ENDIF
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 315 .AND. cumulative[ i ] > 270
         toradialrow := bottomleftrow
         toradialcol := middlebottomcol + Round( ( cumulative[ i ] - 270 ) / 45 * ( bottomrightcol - middlebottomcol ), 0 )
         IF l3D
            FOR j := 1 TO nDepth
               DrawArcInBitmap( hDC, fromrow + j, fromcol, torow + j, tocol, fromradialrow + j, fromradialcol, toradialrow + j, toradialcol, shadowcolor )
            NEXT j
         ENDIF
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      CASE cumulative[ i ] <= 360 .AND. cumulative[ i ] > 315
         toradialcol := bottomrightcol
         toradialrow := bottomrightrow - Round( ( cumulative[ i ] - 315 ) / 45 * ( bottomrightrow - middlerightrow ), 0 )
         IF l3D
            FOR j := 1 TO nDepth
               DrawArcInBitmap( hDC, fromrow + j, fromcol, torow + j, tocol, fromradialrow + j, fromradialcol, toradialrow + j, toradialcol, shadowcolor )
            NEXT j
         ENDIF
         DrawPieInBitmap( hDC, fromrow, fromcol, torow, tocol, fromradialrow, fromradialcol, toradialrow, toradialcol,,, aColors[ i ] )
         fromradialrow := toradialrow
         fromradialcol := toradialcol
      ENDCASE
      IF l3D
         DrawLineInBitmap( hDC, middleleftrow, middleleftcol, middleleftrow + nDepth, middleleftcol, { 0, 0, 0 } )
         DrawLineInBitmap( hDC, middlerightrow, middlerightcol, middlerightrow + nDepth, middlerightcol, { 0, 0, 0 } )
         DrawArcInBitmap( hDC, fromrow + nDepth, fromcol, torow + nDepth, tocol, middleleftrow + nDepth, middleleftcol, middlerightrow + nDepth, middlerightcol )
      ENDIF
   NEXT i

   IF lSLeg
      fromrow := torow + 20 + iif( l3D, nDepth, 0 )
      FOR i := 1 TO Len( aName )
         DrawRectInBitmap( hDC, fromrow, fromcol, fromrow + 15, fromcol + 15, aColors[ i ] )
         DrawTextInBitmap( hDC, fromrow, fromcol + 20, aName[ i ] + iif( lXVal, " - " + AllTrim( Str( aSeries[ i ], 19, 2 ) ) + " (" + AllTrim( Str( degrees[ i ] / 360 * 100, 6, 2 ) ) + " %)", "" ), 'Arial', 8, aColors[ i ] )
         fromrow := fromrow + 20
      NEXT i
   ENDIF

   BT_BitmapSaveFile( hBitmap, cImageFileName )
   BT_DeleteDC( BTstruct )
   BT_BitmapRelease( hBitmap )

   RETURN


PROCEDURE DrawArcInBitmap( hDC, row, col, row1, col1, rowr, colr, rowr1, colr1, penrgb, penwidth )

   IF ValType( penrgb ) == "U"
      penrgb = { 0, 0, 0 }
   ENDIF
   IF ValType( penwidth ) == "U"
      penwidth = 1
   ENDIF

   ArcDrawBitmap( hDC, row, col, row1, col1, rowr, colr, rowr1, colr1, penrgb, penwidth )

   RETURN


PROCEDURE DrawPieInBitmap( hDC, row, col, row1, col1, rowr, colr, rowr1, colr1, penrgb, penwidth, fillrgb )
   LOCAL fill

   IF ValType( penrgb ) == "U"
      penrgb = { 0, 0, 0 }
   ENDIF
   IF ValType( penwidth ) == "U"
      penwidth = 1
   ENDIF
   IF ValType( fillrgb ) == "U"
      fillrgb := { 255, 255, 255 }
      fill := .F.
   ELSE
      fill := .T.
   ENDIF

   PieDrawBitmap( hDC, row, col, row1, col1, rowr, colr, rowr1, colr1, penrgb, penwidth, fillrgb, fill )

   RETURN


PROCEDURE DrawPolygonInBitmap( hDC, apoints, penrgb, penwidth, fillrgb )
   LOCAL xarr := {}
   LOCAL yarr := {}
   LOCAL x := 0
   LOCAL fill

   IF ValType( penrgb ) == "U"
      penrgb = { 0, 0, 0 }
   ENDIF
   IF ValType( penwidth ) == "U"
      penwidth = 1
   ENDIF
   IF ValType( fillrgb ) == "U"
      fillrgb := { 255, 255, 255 }
      fill := .F.
   ELSE
      fill := .T.
   ENDIF
   FOR x := 1 TO Len( apoints )
      AAdd( xarr, apoints[ x, 2 ] )
      AAdd( yarr, apoints[ x, 1 ] )
   NEXT x

   PolygonDrawBitmap( hDC, xarr, yarr, penrgb, penwidth, fillrgb, fill )

   RETURN


FUNCTION RGB2HSL( nR, nG, nB )
   LOCAL nMax, nMin
   LOCAL nH, nS, nL

   IF nR < 0
      nR := Abs( nR )
      nG := GetGreen( nR )
      nB := GetBlue( nR )
      nR := GetRed( nR )
   ENDIF

   nR := nR / 255
   nG := nG / 255
   nB := nB / 255
   nMax := Max( nR, Max( nG, nB ) )
   nMin := Min( nR, Min( nG, nB ) )
   nL := ( nMax + nMin ) / 2

   IF nMax == nMin
      nH := 0
      nS := 0
   ELSE
      IF nL < 0.5
         nS := ( nMax - nMin ) / ( nMax + nMin )
      ELSE
         nS := ( nMax - nMin ) / ( 2.0 - nMax - nMin )
      ENDIF

      DO CASE
      CASE nR = nMax
         nH := ( nG - nB ) / ( nMax - nMin )
      CASE nG = nMax
         nH := 2.0 + ( nB - nR ) / ( nMax - nMin )
      CASE nB = nMax
         nH := 4.0 + ( nR - nG ) / ( nMax - nMin )
      ENDCASE
   ENDIF

   nH := Int( ( nH * 239 ) / 6 )
   IF nH < 0
      nH += 240
   ENDIF
   nS := Int( nS * 239 )
   nL := Int( nL * 239 )

   RETURN { nH, nS, nL }


FUNCTION HSL2RGB( nH, nS, nL )
   LOCAL nFor
   LOCAL nR, nG, nB
   LOCAL nTmp1, nTmp2, aTmp3 := { 0, 0, 0 }

   nH /= 239
   nS /= 239
   nL /= 239
   IF nS == 0
      nR := nL
      nG := nL
      nB := nL
   ELSE
      IF nL < 0.5
         nTmp2 := nL * ( 1 + nS )
      ELSE
         nTmp2 := nL + nS - ( nL * nS )
      ENDIF
      nTmp1 := 2 * nL - nTmp2
      aTmp3[ 1 ] := nH + 1 / 3
      aTmp3[ 2 ] := nH
      aTmp3[ 3 ] := nH - 1 / 3
      FOR nFor := 1 TO 3
         IF aTmp3[ nFor ] < 0
            aTmp3[ nFor ] += 1
         ENDIF
         IF aTmp3[ nFor ] > 1
            aTmp3[ nFor ] -= 1
         ENDIF
         IF 6 * aTmp3[ nFor ] < 1
            aTmp3[ nFor ] := nTmp1 + ( nTmp2 - nTmp1 ) * 6 * aTmp3[ nFor ]
         ELSE
            IF 2 * aTmp3[ nFor ] < 1
               aTmp3[ nFor ] := nTmp2
            ELSE
               IF 3 * aTmp3[ nFor ] < 2
                  aTmp3[ nFor ] := nTmp1 + ( nTmp2 - nTmp1 ) * ( ( 2 / 3 ) - aTmp3[ nFor ] ) * 6
               ELSE
                  aTmp3[ nFor ] := nTmp1
               ENDIF
            ENDIF
         ENDIF
      NEXT nFor
      nR := aTmp3[ 1 ]
      nG := aTmp3[ 2 ]
      nB := aTmp3[ 3 ]
   ENDIF

   RETURN { Int( nR * 255 ), Int( nG * 255 ), Int( nB * 255 ) }


PROCEDURE DrawBoxInBitmap( hDC, nY, nX, nHigh, nWidth, l3D, nDeep )

   // Set border
   DrawLineInBitmap( hDC, nX, nY, nX - nHigh + nDeep, nY, BLACK )                           // Left
   DrawLineInBitmap( hDC, nX, nY + nWidth, nX - nHigh + nDeep, nY + nWidth, BLACK )         // Right
   DrawLineInBitmap( hDC, nX - nHigh + nDeep, nY, nX - nHigh + nDeep, nY + nWidth, BLACK )  // Top
   DrawLineInBitmap( hDC, nX, nY, nX, nY + nWidth, BLACK )                                  // Bottom

   IF l3D
      // Set shadow
      DrawLineInBitmap( hDC, nX - nHigh + nDeep, nY + nWidth, nX - nHigh, nY + nDeep + nWidth, BLACK )
      DrawLineInBitmap( hDC, nX, nY + nWidth, nX - nDeep, nY + nWidth + nDeep, BLACK )
      IF nHigh > 0
         DrawLineInBitmap( hDC, nX - nDeep, nY + nWidth + nDeep, nX - nHigh, nY + nWidth + nDeep, BLACK )
         DrawLineInBitmap( hDC, nX - nHigh, nY + nDeep, nX - nHigh, nY + nWidth + nDeep, BLACK )
         DrawLineInBitmap( hDC, nX - nHigh + nDeep, nY, nX - nHigh, nY + nDeep, BLACK )
      ELSE
         DrawLineInBitmap( hDC, nX - nDeep, nY + nWidth + nDeep, nX - nHigh + 1, nY + nWidth + nDeep, BLACK )
         DrawLineInBitmap( hDC, nX, nY, nX - nDeep, nY + nDeep, BLACK )
      ENDIF
   ENDIF

   RETURN


#pragma BEGINDUMP

#include <windows.h>
#include "hbapi.h"
#include "oohg.h"

HB_FUNC( PIEDRAWBITMAP )
{
   HDC hdc1;
   HGDIOBJ hgdiobj1,hgdiobj2;
   HPEN hpen;
   HBRUSH hbrush;

   hdc1 = HDCparam( 1 );
   hpen = CreatePen( (int) PS_SOLID, (int) hb_parni(11), (COLORREF) RGB( (int) hb_parvni(10,1), (int) hb_parvni(10,2), (int) hb_parvni(10,3) ) );
   hgdiobj1 = SelectObject( (HDC) hdc1, hpen );
   if( hb_parl(13) )
   {
      hbrush = CreateSolidBrush( (COLORREF) RGB( (int) hb_parvni( 12, 1 ), (int) hb_parvni( 12, 2 ), (int) hb_parvni( 12, 3 ) ) );
      hgdiobj2 = SelectObject( (HDC) hdc1, hbrush );
   }
   else
   {
      hbrush = GetSysColorBrush( (int) COLOR_WINDOW );
      hgdiobj2 = SelectObject( (HDC) hdc1, hbrush );
   }

   Pie( (HDC) hdc1, (int) hb_parni( 3 ), (int) hb_parni( 2 ), (int) hb_parni( 5 ), (int) hb_parni( 4 ), (int) hb_parni( 7 ), (int) hb_parni( 6 ), (int) hb_parni( 9 ), (int) hb_parni( 8 ) );

   SelectObject( (HDC) hdc1, (HGDIOBJ) hgdiobj1 );
   SelectObject( (HDC) hdc1, (HGDIOBJ) hgdiobj2 );
   DeleteObject( hpen );
   DeleteObject( hbrush );
}


HB_FUNC( POLYGONDRAWBITMAP )
{
   HDC hdc1;
   HGDIOBJ hgdiobj1, hgdiobj2;
   HPEN hpen;
   HBRUSH hbrush;
   POINT apoints[ 1024 ];
   int number = hb_parinfa( 2, 0 );
   int i;

   hdc1 = HDCparam( 1 );
   hpen = CreatePen( (int) PS_SOLID, (int) hb_parni( 5 ), (COLORREF) RGB( (int) hb_parvni( 4, 1 ), (int) hb_parvni( 4, 2 ), (int) hb_parvni( 4, 3 ) ) );
   hgdiobj1 = SelectObject( (HDC) hdc1, hpen );
   if( hb_parl( 7 ) )
   {
      hbrush = CreateSolidBrush( (COLORREF) RGB( (int) hb_parvni( 6, 1 ), (int) hb_parvni( 6, 2 ), (int) hb_parvni( 6, 3 ) ) );
      hgdiobj2 = SelectObject( (HDC) hdc1, hbrush );
   }
   else
   {
      hbrush = GetSysColorBrush( (int) COLOR_WINDOW );
      hgdiobj2 = SelectObject( (HDC) hdc1, hbrush );
   }
   for( i = 0; i <= number - 1; i ++ )
   {
      apoints[ i ].x = hb_parvni( 2, i + 1 );
      apoints[ i ].y = hb_parvni( 3, i + 1 );
   }

   Polygon( (HDC) hdc1, apoints, number );

   SelectObject( (HDC) hdc1, (HGDIOBJ) hgdiobj1 );
   SelectObject( (HDC) hdc1, (HGDIOBJ) hgdiobj2 );
   DeleteObject( hpen );
   DeleteObject( hbrush );
}


HB_FUNC( ARCDRAWBITMAP )
{
   HDC hdc1;
   HGDIOBJ hgdiobj1;
   HPEN hpen;

   hdc1 = HDCparam( 1 );
   hpen = CreatePen( PS_SOLID, (int) hb_parni( 11 ), (COLORREF) RGB( (int) hb_parvni( 10, 1 ), (int) hb_parvni( 10, 2 ), (int) hb_parvni( 10, 3 ) ) );
   hgdiobj1 = SelectObject( hdc1, hpen );

   Arc( hdc1, (int) hb_parni( 3 ), (int) hb_parni( 2 ), (int) hb_parni( 5 ), (int) hb_parni( 4 ), (int) hb_parni( 7 ), (int) hb_parni( 6 ), (int) hb_parni( 9 ), (int) hb_parni( 8 ) );

   SelectObject( hdc1, hgdiobj1 );
   DeleteObject( hpen );
}


HB_FUNC( POLYBEZIERDRAWBITMAP )
{
   HDC hdc1;
   HGDIOBJ hgdiobj1;
   HPEN hpen;
   POINT apoints[ 1024 ];
   DWORD number= (DWORD) hb_parinfa( 2, 0 );
   DWORD i;

   hdc1 = HDCparam( 1 );
   hpen = CreatePen( (int) PS_SOLID, (int) hb_parni( 5 ), (COLORREF) RGB( (int) hb_parvni( 4, 1 ), (int) hb_parvni( 4, 2 ), (int) hb_parvni( 4, 3 ) ) );
   hgdiobj1 = SelectObject( (HDC) hdc1, hpen );
   for( i = 0; i <= number - 1; i ++ )
   {
      apoints[ i ].x = hb_parvni( 2, i + 1 );
      apoints[ i ].y = hb_parvni( 3, i + 1 );
   }

   PolyBezier( (HDC) hdc1, apoints, number );

   SelectObject( (HDC) hdc1, (HGDIOBJ) hgdiobj1 );
   DeleteObject( hpen );
}


#pragma ENDDUMP


/*
 * EOF
 */
