/*
 * Zip Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to extract all the files from a zip
 * archive while recreating the stored folder's structure.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'
#include 'directry.ch'

FUNCTION Main()
   LOCAL oUnzip, oZipFile, oFolder

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'How to Unzip Files Using MiniZip Library' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Choose zip file' ;
         ACTION oUnzip:Enabled := ! EMPTY( oZipFile:Value := GetFile( { {'Zip Files','*.zip'} }, 'File to unzip', 'C:\' ) )

      @ 20,140 BUTTON btn_2 ;
         CAPTION 'Choose folder' ;
         ACTION oUnzip:Enabled := ! EMPTY( oFolder:Value := BrowseForFolder( Nil, BIF_NEWDIALOGSTYLE, 'Destination Folder to Unzip', 'C:\' ) )

      @ 20,260 BUTTON btn_3 ;
         OBJ oUnzip ;
         CAPTION 'Unzip' ;
         ACTION UnzipFiles( oZipFile:Value, oFolder:Value ) ;
         DISABLED

      @ 60,20 PROGRESSBAR prg_1 ;
         SMOOTH ;
         WIDTH 480

      @ 100,20 LABEL lbl_1 ;
         VALUE "" ;
         WIDTH 480

      @ 150,20 LABEL lbl_2 ;
         OBJ oZipFile ;
         VALUE "" ;
         WIDTH 480

      @ 200,20 LABEL lbl_3 ;
         OBJ oFolder ;
         VALUE "" ;
         WIDTH 480

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION UnzipFiles( cZipFile, cFolder )

   MainForm.prg_1.RangeMax := hb_GetFileCount( cZipFile )

   IF Right( cFolder, 1 ) != "\"
      cFolder += "\"
   ENDIF

   hb_UnzipFile( cZipFile, {|cFile, nPos| ProgressUpdate( nPos, cFile ) }, .T., Nil, cFolder )

   MsgInfo( "Done !!!" )

   MainForm.prg_1.Value := 0
   MainForm.lbl_1.Value := ""

RETURN

FUNCTION ProgressUpdate( nPos, cFile )

   MainForm.prg_1.Value := nPos
   MainForm.lbl_1.Value := cFile

RETURN NIL

/*
 * EOF
 */
