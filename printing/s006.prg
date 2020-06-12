/*
 * Printing Sample # 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * HBPRINTER Simple Demo.
 * Adapted from an HMG Extended sample.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "winprint.ch"

PROCEDURE Main

   PUBLIC hbprn

   SET AUTOADJUST ON

   DEFINE WINDOW Win_1 ;
      AT 0, 0 ;
      WIDTH 400 ;
      HEIGHT 400 ;
      TITLE 'OOHG - HBPRINTER Demo' ;
      ICON 'ZZZ_PRINTICON' ;
      MAIN

      DEFINE MAIN MENU
         MENUITEM 'Test Default' ACTION Demo( 1 )
         MENUITEM 'Test Dialog'  ACTION Demo( 2 )
         MENUITEM 'Exit'         ACTION ThisWindow.Release
      END MENU

      @ 50, 20 CHECKBOX chk_Preview ;
         CAPTION "Preview" ;
         VALUE .T.

      ON KEY ESCAPE ACTION ThisWindow.Release
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

   QUIT

   RETURN

PROCEDURE Demo( nOption )

   a10colors := { YELLOW, PINK, RED, FUCHSIA, BROWN, ORANGE, GREEN, PURPLE, BLACK, BLUE }

   aColor := Array( 200 )
   FOR i := 0 TO 19
      FOR j := 1 TO 10
         aColor[ i * 10 + j ] := a10colors[ j ]
      NEXT j
   NEXT i

   INIT PRINTSYS FOLDER hb_DirBase()   // Initialize HBPrinter system

   IF nOption == 2
      SELECT BY DIALOG                 // Let the user select a printer via dialog
   ELSE
      SELECT DEFAULT                   // Select the default printer
   ENDIF

   IF HBPRNERROR != 0                  // Test error code
      MsgStop( 'Print cancelled!' )
      RETURN
   ENDIF

   /*
    * The best way to get the most similiar printout on various printers
    * is to use SET UNITS MM and set margins large enough for all of them.
    */
   SET UNITS MM                        // Set @... units to milimeters

   SET PAPERSIZE DMPAPER_A4            // Set paper's size to A4

   SET ORIENTATION PORTRAIT            // Set paper's orientation to portrait

   SET BIN DMBIN_FIRST                 // Set paper's origin to the first bin

   SET QUALITY DMRES_HIGH              // Set printer's quality to high

   SET COLORMODE DMCOLOR_COLOR         // Set printer's color mode to color

   SET COPIES TO 2                     // Set printer's number of copies

   IF Win_1.chk_Preview.Value
      SET PREVIEW ON                      // Enable preview
   ELSE
      SET PREVIEW OFF                      // Disable preview
   ENDIF

   SET PREVIEW RECT MAXIMIZED          // Maximize the preview window

   ENABLE THUMBNAILS                   // Show page thumbnails

   DEFINE FONT "TitleFont" ;           // Creates a font to use with @...SAY command
      NAME "Courier New" ;
      SIZE 24 ;
      BOLD

   START DOC                           // Initialize the print job

      FOR i := 1 TO Len( aColor )

         START PAGE                    // Create a page

            @ 20,20,50,190 RECTANGLE

            @ 25,25 PICTURE "ZZZ_AAAOOHG" ;
               SIZE 20,15

            @ 35,60 SAY "HBPrinter Demo" ;
               FONT "TitleFont" ;
               COLOR RED ;
               TO PRINT

            @ 140,60 SAY "Page Number: " + LTrim( Str( i ) ) ;
               FONT "TitleFont" ;
               COLOR aColor[ i ] ;
               TO PRINT

            @ 270,20,270,190 LINE

         END PAGE

      NEXT

   END DOC SIZE

   RELEASE PRINTSYS                    // Release HBPrinter system

   RETURN

/*
 * EOF
 */
