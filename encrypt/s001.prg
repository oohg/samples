/*
 * Encrypt Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to encrypt/decrypt the header of
 * a file so it can't be opened by USE command.
 * Note that the DBF records are not modified.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main
   LOCAL oForm1, oBrw1

   REQUEST DBFCDX

   SET BROWSESYNC ON
   SET DATE BRITISH

   CreateDBF()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 HEIGHT 420 ;
      TITLE 'oohg - File encryption' ;
      MAIN ;
      ON RELEASE CleanUp()

      @ 30, 20 BUTTON btn_Enc ;
         CAPTION "Encrypt" ;
         ACTION DoEncrypt() ;
         TOOLTIP "This will encrypt a file (any kind) as a whole."

      @ 60, 20 BUTTON lbl_Dec ;
         CAPTION "Decrypt" ;
         ACTION DoDecrypt() ;
         TOOLTIP "This will decrypt a file (any kind) as a whole."

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION DoEncrypt

   LOCAL uRet

   ENCODE FILE CODE.DBF PASSWORD "OOHG rocks!!!" RESULT uRet

   IF uRet == NIL
      // File is already encrypted
   ELSEIF uRet
      MsgInfo( "CODE.DBF was encrypted!" )
   ELSE
      MsgStop( "An error was detected." + CRLF + "The file may be unusable!" + CRLF + "Restore from backup." )
   ENDIF

   RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION DoDecrypt

   DECODE FILE CODE.DBF PASSWORD "OOHG rocks!!!" RESULT uRet

   IF uRet == NIL
      // File is not encrypted
   ELSEIF uRet
      MsgInfo( "CODE.DBF was decoded!" + CRLF + "Compare with OLDCODE.DBF" )
   ELSE
      MsgStop( "An error was detected." + CRLF + "The file may be unusable!" + CRLF + "Restore from backup." )
   ENDIF

   RETURN NIL


//--------------------------------------------------------------------------//
FUNCTION CreateDBF()

   LOCAL aDbf1[ 2 ][ 4 ]

   aDbf1[ 1 ][ DBS_NAME ] := "Code"
   aDbf1[ 1 ][ DBS_TYPE ] := "Numeric"
   aDbf1[ 1 ][ DBS_LEN ]  := 10
   aDbf1[ 1 ][ DBS_DEC ]  := 0

   aDbf1[ 2 ][ DBS_NAME ] := "Name"
   aDbf1[ 2 ][ DBS_TYPE ] := "Character"
   aDbf1[ 2 ][ DBS_LEN ]  := 25
   aDbf1[ 2 ][ DBS_DEC ]  := 0

   dbCreate( "CODE", aDbf1, "DBFCDX" )

   SELECT 0
   USE CODE VIA "DBFCDX"
   ZAP

   APPEND BLANK
   REPLACE Code WITH 123
   REPLACE Name WITH 'Homer'
   APPEND BLANK
   REPLACE Code WITH 355
   REPLACE Name WITH 'Tom'
   APPEND BLANK
   REPLACE Code WITH 76
   REPLACE Name WITH 'Mike'
   APPEND BLANK
   REPLACE Code WITH 7
   REPLACE Name WITH 'Martha'

   CLOSE DATABASES

   COPY FILE CODE.DBF TO OLDCODE.DBF

   RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION OpenDBF()

   SELECT 0
   USE CODE VIA "DBFCDX"
   GO TOP

   RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION CleanUp()

  dbCloseAll()

  IF MsgYesNo( "Delete all auxiliary file?" )
     ERASE CODE.DBF
     ERASE DECODE.DBF
     ERASE OLDCODE.DBF
  ENDIF

  RETURN NIL

/*
 * EOF
 */
