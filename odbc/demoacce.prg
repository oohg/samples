/*
* MiniGUI ODBC Demo
* Based upon code from:
*	ODBCDEMO - ODBC Access Class Demonstration
*	Felipe G. Coury <fcoury@flexsys-ci.com>
* MiniGUI Version:
*	Roberto Lopez
*
* For help about hbodbc class use, download harbour contributions package
* from www.harbour-project.org and look at ODBC folder.
*
*/

#include "oohg.ch"

Function Main

	DEFINE WINDOW Win_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 400 ;
		TITLE 'ooHG Access ODBC Demo (MDB)' ;
		MAIN

		DEFINE MAIN MENU
			DEFINE POPUP 'File'
				MENUITEM 'Test' ACTION  Test()
			END POPUP
		END MENU

	END WINDOW

	ACTIVATE WINDOW Win_1

Return

PROCEDURE TEST

   LOCAL cConStr   := ;
      "DBQ=bd1.mdb;" + ;
      "Driver={Microsoft Access Driver (*.mdb)}"

   LOCAL dsFunctions := TODBC():New( cConStr ) // cConStr )

   reg:=""

   WITH OBJECT dsFunctions

      :SetSQL( "SELECT * FROM table1" )
      :Open()


      :Skip()

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :GoTo( 3 )

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :last()

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :Prior()

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :First()

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :Skip()

      autoMsgInfo ( :FieldByName( "field1" ):Value )

      :Close()
      
     /// :SetSQL( "MODIFY * FROM table1 BY 'Vargas' FOR :FieldByName( 'field1' ):Value='pablo'" )
    ///  :Open()
    /// :close()


   END

   dsFunctions:Destroy()

RETURN( NIL )

