/*
 * Form Sample n° 9
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use method SaveAs to save the
 * form's whole window to a file.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

PROCEDURE Main

   PUBLIC oWin

   DEFINE WINDOW Win_1 ;
      MAIN ;
      TITLE 'Save A Snapshot Of A Form To A File' ;
      OBJ oWin ;
      WIDTH 700 HEIGHT 300

      @ 010,10 TEXTBOX Txt0 VALUE "Click to save"

      @ 040, 10 BUTTON But1 CAPTION "BMP" ACTION Save( "bmp" )
      @ 070, 10 BUTTON But2 CAPTION "JPG" ACTION Save( "jpg" )
      @ 100, 10 BUTTON But3 CAPTION "TIF" ACTION Save( "tif" )
      @ 130, 10 BUTTON But4 CAPTION "PNG" ACTION Save( "png" )

      ON KEY ESCAPE ACTION oWin:Release
   END WINDOW

   CENTER WINDOW Win_1
   ACTIVATE WINDOW Win_1

RETURN


PROCEDURE Save( cType )

   oWin:SaveAs( "SnapShot." + cType, .T., cType )
   MsgBox( "SnapShot." + cType + " saved to current folder!")

RETURN

/*
 * EOF
 */
