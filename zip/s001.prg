/*
 * Zip Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to build a zip file of a folder and
 * it's subfolders. Notice that HB_ZipFile() does not recurse
 * subfolders in Harbour 3.0
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'
#include 'directry.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'How to Zip a Folder with SubFolders Using MiniZip Library' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Choose folder' ;
         ACTION ZipFolder()

      @ 60,20 PROGRESSBAR prg_1 ;
         SMOOTH ;
         WIDTH 480

      @ 100,20 LABEL lbl_1 ;
         VALUE "" ;
         WIDTH 480

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION ZipFolder

   LOCAL cFolder, hZip, aFiles, i

   IF EMPTY( cFolder := GetFolder( 'Folder to Zip', 'C:\' ) )
      RETURN NIL
   ENDIF

   IF FILE( 'ziptest.zip' )
      ERASE ziptest.zip
   ENDIF

   hZip := HB_ZipOpen( 'ziptest.zip' )
   IF EMPTY( hZip )
      MsgExclamation( "Can't create ziptest.zip !!!" )
      RETURN NIL
   ENDIF

   aFiles := {}

   ProcessFiles( cFolder, aFiles )

   IF LEN( aFiles ) > 0
      MainForm.prg_1.RangeMax := LEN( aFiles )

      FOR i := 1 TO LEN( aFiles )
         EVAL( {|cFile, nPos| ProgressUpdate( nPos, cFile ) }, aFiles[ i ], i )

         HB_ZipStoreFile( hZip, ;
                          aFiles[ i ], ;
                          substr( aFiles[ i ], LEN( cFolder ) + 2 ) )
      NEXT

      HB_ZipClose( hZip )

      MsgInfo( 'File ziptest.zip created !!!')
   ELSE
      MsgExclamation( "No files were found !!!" )
   ENDIF

RETURN NIL

FUNCTION ProcessFiles( cFolder, aFiles )

   LOCAL aDir, aFileData

   aDir := DIRECTORY( cFolder + '\*.*', "D" )

   FOR EACH aFileData IN aDir
      IF aFileData[ F_NAME ] == "."
         // ignore
      ELSEIF aFileData[ F_NAME ] == ".."
         // ignore
      ELSEIF 'D' $ aFileData[ F_ATTR ]
         ProcessFiles( cFolder + '\' + aFileData[ F_NAME ], aFiles )
      ELSE
         AADD( aFiles, cFolder + '\' + aFileData[ F_NAME ] )
      ENDIF
   NEXT

RETURN NIL

FUNCTION ProgressUpdate( nPos, cFile )

   MainForm.prg_1.Value := nPos
   MainForm.lbl_1.Value := cFile

RETURN NIL

/*
 * EOF
 */
