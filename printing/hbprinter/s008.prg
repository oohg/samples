/*
 * Printing Sample # 8
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use HBPRINTER printing lib
 * in a console program (compile s008 /c).
 *
 * Adapted from MINIGUI's advanced printing sample.
 *
 * Visit us at https://github.com/oohg/samples
 *
 * You can download the related files from
 * https://github.com/oohg/samples/tree/master/printing/hbprinter
 */

/*
#define NO_GUI
#include "winprint.ch"
*/
#include "oohg.ch"
#include "winprint.ch"

MEMVAR aPrinters, aports

FUNCTION Main( lNoPrev )

   LOCAL cprn, lck, i, aStar, aPoly1, aPoly2

   aStar  := {{20, 32}, {44, 26}, {32, 44}, {32, 20}, {44, 38}}
   aPoly1 := {{20, 08}, {68, 26}, {50, 60}, {26, 50}}
   aPoly2 := {{20, 70}, {40, 55}, {30, 45}}

   INIT PRINTSYS

   IF Empty( lNoPrev )
      SELECT DEFAULT PREVIEW
   ELSE
      SELECT DEFAULT
   ENDIF

   IF HBPrnError > 0
      RELEASE PRINTSYS
      RETURN NIL
   ENDIF

   IF .T.
      ENABLE THUMBNAILS
   ENDIF

   IF .T.
      SET PREVIEW RECT 20, 20, GetDesktopHeight()-20, GetDesktopWidth()-20
   ENDIF

_OOHG_CallDump( "define imagelist", "F")
   DEFINE IMAGELIST "ILIST1" PICTURE "flags"
_OOHG_CallDump( iif( HBPRNERROR == 1, "error imagelist", "ok imagelist" ), "F" )
   DEFINE IMAGELIST "ILIST2" PICTURE "mytoolbar" ICONCOUNT 11

   DEFINE FONT "f0" NAME "courier new" size 12 BOLD
   DEFINE FONT "f1" NAME "times new roman" SIZE 30 WIDTH 30 BOLD ITALIC UNDERLINE STRIKEOUT
   DEFINE FONT "f2" NAME "times new roman" SIZE 30 BOLD
   DEFINE FONT "f3" NAME "times new roman" SIZE 12 BOLD

   DEFINE PEN "p0" STYLE PS_SOLID WIDTH 1 COLOR 0x000000
   DEFINE PEN "p1" STYLE PS_SOLID WIDTH 10 COLOR 0xFF0000
   DEFINE PEN "p2" STYLE PS_NULL

   DEFINE BRUSH "b0" STYLE BS_SOLID COLOR 0xCCFFAA
   DEFINE BRUSH "b1" STYLE BS_HATCHED COLOR hbprn:DxColors( "YELLOW" ) HATCH HS_DIAGCROSS
   DEFINE BRUSH "b2" STYLE BS_NULL

   DEFINE ELLIPTIC REGION "r0" AT 0, 0, 20, 30
   DEFINE ELLIPTIC REGION "r1" AT 0, HBPrnMaxCol - 30, 20, HBPrnMaxCol
   DEFINE ELLIPTIC REGION "r2" AT 10, 20, 40, HBPrnMaxCol - 20
   COMBINE REGIONS "r0", "r1" TO "r4" STYLE WINDING
   COMBINE REGIONS "r4", "r2" TO "r5" STYLE WINDING

   SET PAGE ORIENTATION DMORIENT_PORTRAIT PAPERSIZE DMPAPER_A4 FONT "f0"

   START DOC NAME "Test"

      SELECT FONT "f0"
      SELECT PEN "p0"

      START PAGE
         @ 01, 01, HBPrnMaxRow + 1, HBPrnMaxCol RECTANGLE PEN "p1" // BRUSH "b1"
         @ 10, 10 PICTURE "gfx/sand.gif" SIZE 5, 5 EXTEND HBPrnMaxRow - 20, HBPrnMaxCol - 20
         POLYGON aStar PEN "p0" BRUSH "b1"
         POLYBEZIER aPoly1 PEN "p0"
         @ 50, 30, 35, 70 LINE PEN "p0"
         MOVE TO 25, 75
         POLYBEZIERTO aPoly2 PEN "p0"
         MOVE TO 0, 0
         @ 05, 01 SAY "FONT F1 BOLD ITALIC UNDERLINE STRIKEOUT 30%WIDTH" FONT "f1" TO PRINT
         @ 08, 01 SAY "FONT F2 BOLD" FONT "f2" TO PRINT
      END PAGE

      START PAGE
         SELECT CLIP REGION "r5"
         @ 00, 00 PICTURE "gfx/sand.gif" SIZE 41, HBPrnMaxCol + 1
         @ 15, 20 SAY "Mickey Mouse !!!" TO PRINT
         @ 17, 20 SAY "Regions demo" TO PRINT
         DELETE CLIP REGION
      END PAGE

      SET PAGE ORIENTATION DMORIENT_PORTRAIT

      START PAGE
         SELECT PEN "p1"
         SELECT BRUSH "b0"

         @ 01, 01, 05, 031 RECTANGLE
         @ 03, 02 SAY "RECTANGLE" TO PRINT

         @ 01, 32, 05, 61 FILLRECT
         @ 03, 33 SAY "FILLRECT" TO PRINT

         @ 06, 01, 10, 31 ROUNDRECT ROUNDR 1 ROUNDC 1
         @ 08, 02 SAY "ROUNDRECT" TO PRINT

         @ 06, 32, 10, 61 FRAMERECT BRUSH "b1"
         @ 08, 33 SAY "FRAMERECT" TO PRINT

         @ 13, 2 SAY "INVERTRECT" TO PRINT
         @ 11, 01, 15, 31 INVERTRECT

         @ 11, 31, 15, 60 ELLIPSE
         @ 13, 32 SAY "ELLIPSE" TO PRINT
      END PAGE

      START PAGE
         @ 10, 10 PICTURE "gfx/sand.gif" SIZE 15, 15 EXTEND 35, 35
         SET TEXTCOLOR 0xff0000
         FOR i := 0 TO HBPrnMaxRow
            @ i, 05 SAY "This is a text. This is only a text." + Str( i, 3 ) FONT "f3" TO PRINT
         NEXT
         @ 12, 12, HBPrnMaxRow - 10, HBPrnMaxCol - 10 INVERTRECT
      END PAGE

      SET PAGE ORIENTATION DMORIENT_LANDSCAPE
      CHANGE PEN "p2" STYLE PS_SOLID
      SELECT PEN "p2"
      SELECT FONT "f2"

      START PAGE
         CHANGE BRUSH "b0" COLOR 0xCCFFAA
         CHANGE PEN "p2" COLOR 0xff0000 WIDTH 5
         @ 00, 00, HBPrnMaxRow, HBPrnMaxCol RECTANGLE PEN "p2" BRUSH "b0"
         SET TEXTCOLOR 0xFF0000
         FOR i := 1 TO 8
            IF i % 2 == 0
               CHANGE FONT "F2" SIZE 45 NOBOLD NOITALIC NOUNDERLINE NOSTRIKEOUT WIDTH 100
            ELSE
               CHANGE FONT "F2" SIZE 30 BOLD ITALIC UNDERLINE STRIKEOUT ANGLE 10 WIDTH 50
            ENDIF
            @ i * 5, 05 SAY "This is a text. This is only a text." FONT "f2" TO PRINT
         NEXT
      END PAGE

      SET PAGE ORIENTATION DMORIENT_PORTRAIT

      START PAGE
         SELECT FONT "f0"
         SELECT PEN "P0"
         SELECT BRUSH "B2"

         @ 01, 07 SAY "IMAGELIST 1" COLOR 0xff TO PRINT
         FOR i := 1 TO 20
            @ i * 2, 02, ( i + 0.9 ) * 2, 06 DRAW IMAGELIST "ILIST1" ICON i
            @ i * 2, 02, ( i + 0.9 ) * 2, 06 RECTANGLE
            @ i * 2, 07 SAY "Flag number " + Str( i, 2 ) TO PRINT
         NEXT
         @ 01, 01, 43, 22 RECTANGLE

         @ 01, 45 SAY "IMAGELIST 2" COLOR 0xff TO PRINT
         @ 02, 25 SAY "STYLE:" TO PRINT
         @ 03, 25 SAY "NORMAL BLEND50 BLEND25 MASK BACKGROUND" TO PRINT
         @ 04, 54 SAY "GREEN" TO PRINT
         FOR i := 5 TO 16
            @ i, 25, i + 1, 27 DRAW IMAGELIST "ILIST2" ICON i - 4
            @ i, 32, i + 1, 34 DRAW IMAGELIST "ILIST2" ICON i - 4 BLEND50
            @ i, 40, i + 1, 42 DRAW IMAGELIST "ILIST2" ICON i - 4 BLEND25
            @ i, 48, i + 1, 50 DRAW IMAGELIST "ILIST2" ICON i - 4 MASK
            @ i, 54, i + 1, 56 DRAW IMAGELIST "ILIST2" ICON i - 4 BACKGROUND RGB( 0, 255, 0 )
         NEXT
         @ 01, 24, 17, 65 RECTANGLE
_OOHG_CallDump( "draw imagelist", "F")

         @ 19, 24 SAY "JPG from resource" TO PRINT
         @ 20, 24 PICTURE "PICTUREJPG" SIZE 15, 30

         @ 39, 24 SAY "GIF from resource" TO PRINT
         @ 40, 24 PICTURE "picturegif" SIZE 15, 30
      END PAGE


   END DOC

   RELEASE PRINTSYS

   RETURN NIL

/*
 * EOF
 */
