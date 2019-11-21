
/*
 * Based on the original work of Leonardo Machado adapted
 * for MINIGUI by Marcelo Antonio Lázzaro Carli.
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL aProcesses := ActiveProcesses()

   DEFINE WINDOW Form OBJ oForm ;
      WIDTH 640 HEIGHT 480 CLIENTAREA ;
      TITLE "OOHG - Process Handling" ;
      NOSIZE ;
      MAIN

      @ 20, 20 LABEL lbl1 ;
         VALUE "Current Processes" ;
         AUTOSIZE HEIGHT 20

      @ 40, 20 COMBOBOX cmb1 ;
         WIDTH 440 ;
         ITEMS ( aProcesses )


     @ 200, 20 BUTTON btn1 ;
        CAPTION "Close" ;
        ACTION iif( MsgYesNo( "Close process " + aProcesses[ oForm:cmb1:Value ] + "?" ), ;
               iif( IsProcessActive( aProcesses[ oForm:cmb1:Value ] ), ;
                    EndProcess( aProcesses[ oForm:cmb1:Value ] ), ;
                    MsgStop( "Process " + aProcesses[ oForm:cmb1:Value ] + " is not active!" ) ), ;
               MsgInfo( "Closing of process " + aProcesses[ oForm:cmb1:Value ] + " was aborted!" ) )

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

   RETURN NIL

FUNCTION ActiveProcesses()

   RETURN ProcHelper()

FUNCTION IsProcessActive( cProcessName )

   RETURN ProcHelper( cProcessName, 1 )

FUNCTION EndProcess( cProcessName )

   RETURN ProcHelper( cProcessName, 2 )

FUNCTION ProcHelper( cExeName, nAction )

   LOCAL aProcNames:= {}, oScriptObj, oWmiService, oProcList, oProc, lRet := .F.

   IF ! HB_ISNUMERIC( nAction ) .OR. nAction < 0 .OR. nAction > 2
      nAction := 0
   ENDIF

   BEGIN SEQUENCE WITH { |oErr| Break( oErr ) }
      oScriptObj  := win_OleCreateObject( "wbemScripting.SwbemLocator" )
      oWmiService := oScriptObj:ConnectServer()
   RECOVER
       RETURN iif( nAction == 0, aProcNames, lRet )
   END SEQUENCE

   BEGIN SEQUENCE WITH { |oErr| Break( oErr ) }
      oProcList := oWmiService:ExecQuery( "select * from Win32_Process" + iif( nAction == 0, "", " where Name='" + cExeName + "'" ) )
   RECOVER
       RETURN iif( nAction == 0, aProcNames, lRet )
   END SEQUENCE

   FOR EACH oProc IN oProcList
       AAdd( aProcNames, oProc:Name() )
       lRet:= .T.

       IF nAction == 2
          oProc:Terminate()
       ENDIF
   NEXT oProc

RETURN iif( nAction == 0, aProcNames, lRet )

/*
 * EOF
 */
