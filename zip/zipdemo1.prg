/*
 * Importante: Enlazar librería hbziparc
 *
 */

#include "oohg.ch"

Function main()

   DEFINE WINDOW form_1 ;
      AT 114,218 ;
      WIDTH 334 ;
      HEIGHT 276 ;
      TITLE 'ZIP TEST' ;
      MAIN

      DEFINE MAIN MENU
         DEFINE POPUP "Test"
             MENUITEM 'Create Zip' ACTION CreateZip()
             MENUITEM 'UnZip File' ACTION UnPackZip()
         END POPUP

      END MENU

      @ 80,120 PROGRESSBAR Progress_1 RANGE 0,10 SMOOTH

      @ 120,120 LABEL label_1 VALUE ''


   END WINDOW

   form_1.center
   form_1.activate

Return NIL

*------------------------------------------------------------------------------*
Function CreateZip()  
*------------------------------------------------------------------------------*
local aDir:=Directory("*.txt")
local afiles:={}
Local x
local nLen

	For x:=1 to len(aDir)
	    aadd(afiles,adir[x,1])
	next

    Hb_ZIPFILE("ziptest.zip", afiles, , {|cFile,nPos| ProgressUpdate( nPos,cFile ) } , .T. )

Return nil

*------------------------------------------------------------------------------*
function ProgressUpdate(nPos , cFile )
*------------------------------------------------------------------------------*

	Form_1.Progress_1.Value := nPos
	Form_1.Label_1.Value := cFile

Return Nil
*------------------------------------------------------------------------------*
Function UnPackZip() 
*------------------------------------------------------------------------------*

    Hb_UNZIPFILE( "ziptest.zip", {|cFile,nPos| ProgressUpdate( nPos,cFile ) } )

Return nil


/* Notas sobre las funciones:

FUNCTION hb_ZipFile( cFileName, acFiles, nLevel, bUpdate,lOverwrite, cPassword,;
                     lWithPath, lWithDrive, bProgress, lFullPath, acExclude )

 EXAMPLES

    PROCEDURE Main()
 
      IF hb_ZipFile( "test.zip", "test.prg" )
         QOut( "File was successfully created" )
      ENDIF
 
      IF hb_ZipFile( "test1.zip", { "test.prg", "C:\windows\win.ini" } )
         QOut( "File was successfully created" )
      ENDIF
 
      IF hb_ZipFile( "test2.zip", { "test.prg", "C:\windows\win.ini" }, 9, {| cFile, nPos | QOut( cFile ) } )
         QOut( "File was successfully created" )
      ENDIF
 
      aFiles := { "test.prg", "C:\windows\win.ini" }
      nLen   := Len( aFiles )
      aGauge := GaugeNew( 5, 5, 7, 40, "W/B", "W+/B" , "." )
      GaugeDisplay( aGauge )
      hb_ZipFile( "test33.zip", aFiles, 9, {| cFile, nPos | GaugeUpdate( aGauge, nPos / nLen ) },, "hello" )

    RETURN


FUNCTION hb_UnzipFile( cFileName, bUpdate, lWithPath, cPassword, cPath, acFiles, bProgress )


 EXAMPLES

    PROCEDURE Main()
 
      aExtract := hb_GetFilesInZip( "test.zip" )  // extract all files in zip
      IF hb_UnzipFile( "test.zip",,,, ".\", aExtract )
         QOut( "File was successfully extracted" )
      ENDIF
 
      aExtract := hb_GetFilesInZip( "test2.zip" )  // extract all files in zip
      IF hb_UnzipFile( "test2.zip", {| cFile | QOut( cFile ) },,, ".\", aExtract )
         QOut( "File was successfully extracted" )
      ENDIF

    RETURN

*/

