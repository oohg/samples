/*
 * Importante: Enlazar librería hbmzip
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

    COMPRESSFILES("ziptest.zip", afiles, {|cFile,nPos| ProgressUpdate( nPos,cFile ) } , .T. )

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

    UNCOMPRESSFILES( "ziptest.zip", {|cFile,nPos| ProgressUpdate( nPos,cFile ) } )

Return nil


*------------------------------------------------------------------------------*
PROCEDURE COMPRESSFILES ( cFileName , aDir , bBlock , lOvr )
*------------------------------------------------------------------------------*
* Based upon HBMZIP Harbour contribution library samples.
LOCAL hZip , i , cPassword

	if valtype (lOvr) == 'L'
		if lOvr == .t.
			if file (cFileName)
				delete file (cFileName)
			endif
		endif
	endif

	hZip := HB_ZIPOPEN( cFileName )
	IF ! EMPTY( hZip )
		FOR i := 1 To Len (aDir)
			if valtype (bBlock) == 'B'
				Eval ( bBlock , aDir [i] , i )     
			endif
			HB_ZipStoreFile( hZip, aDir [ i ], aDir [ i ] , cPassword )
		NEXT
	ENDIF

	HB_ZIPCLOSE( hZip )

RETURN

*------------------------------------------------------------------------------*
PROCEDURE UNCOMPRESSFILES ( cFileName , bBlock )
*------------------------------------------------------------------------------*
* Based upon HBMZIP Harbour contribution library samples.
Local i := 0 , hUnzip , nErr, cFile, dDate, cTime, nSize, nCompSize , f

	hUnzip := HB_UNZIPOPEN( cFileName )

	nErr := HB_UNZIPFILEFIRST( hUnzip )

	DO WHILE nErr == 0

		HB_UnzipFileInfo( hUnzip, @cFile, @dDate, @cTime,,,, @nSize, @nCompSize )

		i++
		if valtype (bBlock) = 'B'
			Eval ( bBlock , cFile , i )     
		endif

		HB_UnzipExtractCurrentFile( hUnzip, NIL, NIL )

		nErr := HB_UNZIPFILENEXT( hUnzip )

	ENDDO

	HB_UNZIPCLOSE( hUnzip )

RETURN