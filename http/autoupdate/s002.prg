/*
 * HTTP Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licenced under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to autoupdate an application
 * from Internet. To test you also need "MyApp.prg".
 * This sample was successfully tested using an "http"
 * address to download the new file. The test with an
 * "https" address was unsuccessfull.
 * Please send me a mail if you succeed.
 *
 * Visit us at https://github.com/oohg/samples
 *
 *
 * You can download MyApp.prg from
 * https://github.com/oohg/samples/tree/master/Http
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL cUpdated

   IF UpdateIsAvailable()   
      IF DownloadUpdate()
         RENAME ( "MyApp.exe" ) TO ( "OldApp_" + DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "_") + ".exe" )
         IF ! FILE( "MyApp.exe" )
            hb_UnzipFile( "NewApp.zip" )
            IF FILE( "NewApp.exe" )
               RENAME ( "NewApp.exe" ) TO ( "MyApp.exe" )
            ENDIF
            IF FILE( "MyApp.exe" )
               cUpdated := "T"
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   IF File( "MyApp.exe")
      EXECUTE FILE "MyApp.exe" PARAMETERS cUpdated
   ELSE
      MsgStop( "Application not found !!!" )
   ENDIF
RETURN NIL

FUNCTION UpdateIsAvailable
RETURN .T.

FUNCTION DownloadUpdate
   LOCAL cUrl := "http://..."
   LOCAL oUrl
   LOCAL oHTTP

   oUrl := TUrl():New( cUrl )
   oHTTP := TIpClientHTTP():New( oUrl )
   IF ( lRetVal := oHTTP:Open() )
      oHTTP:ReadToFile( "NewApp.zip" )
      oHTTP:Close()
   ENDIF
RETURN lRetVal

/*
 * EOF
 */
