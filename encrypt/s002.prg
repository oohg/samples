/*
 * Encrypt Sample n° 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to encrypt/decrypt the content of
 * the CHARACTER fields of a DBF file.
 * Note that the file is encrypted over himself, so you
 * must consider copying it before encryption just in
 * case something goes wrong.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main
   LOCAL oForm1, oBrw1

   REQUEST DBFCDX

   SET AUTORDER TO 1
   SET BROWSESYNC ON
   SET DATE BRITISH

   CreateDBF()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0, 0 ;
      CLIENTAREA ;
      WIDTH 420 HEIGHT 420 ;
      TITLE "oohg - Encryption of a database field" ;
      MAIN ;
      ON RELEASE CleanUp()

      @ 30, 20 BUTTON btn_Enc ;
         CAPTION "Encrypt" ;
         ACTION DoEncrypt() ;
         TOOLTIP "This will encrypt field <Name> of CODE.DBF"

      @ 60, 20 BUTTON lbl_Dec ;
         CAPTION "Decrypt" ;
         ACTION DoDecrypt() ;
         TOOLTIP "This will decrypt field <Name> of CODE.DBF"

      ON KEY ESCAPE ACTION oForm1:Release()
   END WINDOW

   oForm1:Center()
   oForm1:Activate()

RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION DoEncrypt

   // CODE.DBF and the index must be already opened
   USE CODE VIA "DBFCDX"

   ENCODE FROM CODE.DBF ON "strzero( code, 10, 0 )" FIELDS "Name" PASSWORD "OOHG rocks!!!"

   CLOSE DATABASES

   // This command is based on a bitwise XOR of the field's content
   // so we don't have a way to know if it's already encrypted or not.

   MsgInfo( "Field Name of CODE.DBF was encrypted!" )

   RETURN NIL

//--------------------------------------------------------------------------//
FUNCTION DoDecrypt

   // CODE.DBF and the index must be already opened
   USE CODE VIA "DBFCDX"

   DECODE FROM CODE.DBF ON "strzero( code, 10, 0 )" FIELDS "Name" PASSWORD "OOHG rocks!!!"

   // This command is based on a bitwise XOR of the field's content
   // so we don't have a way to know if it's already encrypted or not.

   CLOSE DATABASES

   MsgInfo( "Field Name of CODE.DBF was decoded!" + CRLF + "Compare with OLDCODE.DBF" )

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
   INDEX ON StrZero( code, 10, 0 ) TO CODE

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
     ERASE CODE.CDX
     ERASE DECODE.DBF
     ERASE OLDCODE.DBF
  ENDIF

  RETURN NIL

/*
 * EOF
 */
