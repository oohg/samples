/*
 * Zip Sample n° 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to zip selected files from a folder.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'
#include 'directry.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'How to Zip Selected Files Using MiniZip Library' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Build' ;
         ACTION ZipFiles()

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION ZipFiles
   LOCAL aFiles := {}

   MemoWrit( 'C:\File0.txt', 'This is file 0' )
   CreateFolder( 'C:\Data' )
   CreateFolder( 'C:\Data\Test' )
   MemoWrit( 'C:\Data\Test\File1.txt', 'This is file 1' )
   MemoWrit( 'C:\Data\Test\File2.txt', 'This is file 2' )

   /* The path of the added files must be relative to an
      upper level folder. Do not add files like:
      \path\file.ext
      c:\path\file.ext
      ..\path\file.ext
      or you'll have problems when unziping.
      You must change the OS current folder to the upper
      level folder before zipping the files.
   */
   AEVAL( DIRECTORY( 'C:\*.TXT'), {|e| AADD( aFiles, e[1] )} )
   AEVAL( DIRECTORY( 'C:\Data\Test\*.TXT'), {|e| AADD( aFiles, 'Data\Test\' + e[1])} )

   DIRCHANGE( 'C:\' )
   HB_ZIPFILE( hb_dirbase() + 'myzip.zip', aFiles, 9, NIL , .T., NIL, .T. )
   DIRCHANGE( 'C:\' + hb_dirbase() )

   DELETE FILE 'C:\Data\Test\File2.txt'
   DELETE FILE 'C:\Data\Test\File1.txt'
   RemoveFolder( 'C:\Data\Test' )
   RemoveFolder( 'C:\Data' )
   DELETE FILE 'C:\File0.txt'

   IF FILE( hb_dirbase() + 'myzip.zip' )
      MsgInfo( 'File myzip.zip was builded !!! ')
   ELSE
      MsgStop( 'File myzip.zip was not builded !!!')
   ENDIF

RETURN NIL

/*
 * EOF
 */
