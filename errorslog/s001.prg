/*
 * Errors Log Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to change the name and the folder
 * of the runtime errors log.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   SET AUTOADJUST ON
   SET LANGUAGE TO SPANISH

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 500 ;
      HEIGHT 500 ;
      TITLE "Change Name, Folder and Language of Errors Log" ;
      MAIN ;
      ON INIT AutoMsgBox( INEXISTENT_VARIABLE )
      /*
       * INEXISTENT_VARIABLE raises an error
       * so the errors log is created
       */

      @ 10,10 LISTBOX List_1 ;
         OBJ oList ;
         ITEMS { 'Chat', 'Edit', 'Help', 'Move', 'Sound' } ;
         VALUE 1 ;
         HEIGHT 310 ;
         WIDTH 300
   END WINDOW

   /*
    * The default values are ENGLISH, EXE FOLDER and ERRORLOG.HTM
    */
   PUBLIC _OOHG_TxtError := OOHG_TErrorHtml():New( SET( _SET_LANGUAGE ) )
   _OOHG_TxtError:Path     := "C:\"
   _OOHG_TxtError:FileName := "MyErrorLog.htm"
   _OOHG_TxtError:cBufferScreen := ;
      "Please, report this error to the programmer." + ;
      CRLF + ;
      "Thank you." + ;
      CRLF + ;
      CRLF

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
