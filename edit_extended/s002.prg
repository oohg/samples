#include "oohg.ch"

/****************************************************************************************
 * OOHG EDIT EXTENDED command demo
 * Adapted from the HMG original demo
 * (c) Roberto López [roblez@ciudad.com.ar]
 *     Cristóbal Mollá [cemese@terra.es]
 * for OOHG by Fernando Yurisich [fyurisich@oohg.org]
 *
 * Application: DEMO.EXE
 *    Function: Main()
 * Description: Main function of the demo. Create the main window.
 *  Parameters: None
 *      Return: NIL
 ***************************************************************************************/
FUNCTION Main()

        // Database driver.
        REQUEST DBFNTX
        REQUEST DBFCDX, DBFFPT

        // [x]Harbour modifiers.
        SET CENTURY ON
        SET DELETED OFF
        SET DATE TO BRITISH

        // Request all languages for test (see i_lang.ch)
        REQUEST HB_LANG_EN
        REQUEST HB_LANG_ES
        REQUEST HB_LANG_FR
        REQUEST HB_LANG_PT
        REQUEST HB_LANG_IT
        REQUEST HB_LANG_EU
        REQUEST HB_LANG_NL
#if ( __HARBOUR__ - 0 > 0x030200 )    // for Harbour 3.4 version
        REQUEST HB_LANG_DE
        REQUEST HB_LANG_EL
        REQUEST HB_LANG_RU
        REQUEST HB_LANG_UK
        REQUEST HB_LANG_PL
        REQUEST HB_LANG_HR
        REQUEST HB_LANG_SL
        REQUEST HB_LANG_CS
        REQUEST HB_LANG_BG
        REQUEST HB_LANG_HU
        REQUEST HB_LANG_SK
        REQUEST HB_LANG_TR
#else
        REQUEST HB_LANG_DEWIN
        REQUEST HB_LANG_ELWIN
        REQUEST HB_LANG_RUWIN
        REQUEST HB_LANG_UAWIN
        REQUEST HB_LANG_PLWIN
        REQUEST HB_LANG_HR852
        REQUEST HB_LANG_SLWIN
        REQUEST HB_LANG_CSWIN
        REQUEST HB_LANG_BGWIN
        REQUEST HB_LANG_HUWIN
        REQUEST HB_LANG_SKWIN
        REQUEST HB_LANG_TRWIN
#endif

        // Set default language to English.
        InitMessages( "EN" )

        // Define the main window.
        DEFINE WINDOW Win_1                     ;
           AT         0,0                       ;
           WIDTH      GetdesktopRealWidth()     ;
           HEIGHT     GetDeskTopRealHeight()-27 ;
           TITLE      "EDIT EXTENDED Demo"      ;
           MAIN                                 ;
           NOMAXIMIZE                           ;
           NOSIZE                               ;
           ON INIT    OpenTable()               ;
           ON RELEASE CloseTable()              ;
           BACKCOLOR  METRO_GRAY_LIGHTER

           DEFINE MAIN MENU OF Win_1
              POPUP "DBF&NTX Demo"
                      ITEM "&Simple EDIT EXTENDED test on DBFNTX driver"        ;
                              ACTION BasicDemo( "TEST2" )
                      ITEM "&Advanced EDIT EXTENDED test on DBFNTX driver"      ;
                              ACTION AdvancedDemo( "TEST2" )
              END POPUP
              POPUP "&DBF&CDX Demo"
                      ITEM "&Simple EDIT EXTENDED test on DBFCDX driver"        ;
                              ACTION BasicDemo( "TEST1" )
                      ITEM "&Advanced EDIT EXTENDED test on DBFCDX driver"      ;
                              ACTION AdvancedDemo( "TEST1" )
              END POPUP
              POPUP "&Language"
                      ITEM "&Select language"                                   ;
                              ACTION SelectLang()
              END POPUP
              POPUP "&Exit"
                      ITEM "About EDIT EXTENDED demo"                           ;
                              ACTION About()
                      SEPARATOR
                      ITEM "&Exit demo"                                         ;
                              ACTION Win_1.Release
              END POPUP
           END MENU

           DEFINE STATUSBAR FONT "ms sans serif" SIZE 9
               STATUSITEM "OOHG EDIT EXTENDED command demo"
           END STATUSBAR

        END WINDOW

        // Open window.
        ACTIVATE WINDOW Win_1

RETURN NIL


/****************************************************************************************
 *    Function: OpenTable()
 * Description: Open the database files and check the index files.
 *  Parameters: None
 *      Return: NIL
 ***************************************************************************************/
PROCEDURE OpenTable()

        // Open the TEST1 database file with the DBFCDX Driver.----------------
        dbUseArea( .t., "DBFCDX", "TEST1.DBF", "TEST1" )

        // Check the existance of the index files.-----------------------------
        if !File( "TEST1.CDX" )

                // Create order by first field plus last field.
                // You can't search by this order. Only for test.
                TEST1->( ordCreate( "TEST1.CDX",                        ;
                                    "First Name",                       ;
                                    "TEST1->First + TEST1->Last",       ;
                                    {|| TEST1->First  + TEST1->Last } ) )

                // Create order by last field.
                TEST1->( ordCreate( "TEST1.CDX",                        ;
                                    "Last Name",                        ;
                                    "TEST1->Last",                      ;
                                    {|| TEST1->Last } ) )

                // Create order by hiredate field.
                TEST1->( ordCreate( "TEST1.CDX",                        ;
                                    "Hire Date",                        ;
                                    "TEST1->Hiredate",                  ;
                                    {|| TEST1->Hiredate } ) )

                // Create order by age field.
                TEST1->( ordCreate( "TEST1.CDX",                        ;
                                    "Age",                              ;
                                    "TEST1->Age",                       ;
                                    {|| TEST1->Age } ) )

                // Create order by.
                // You can't search by this order. Only for test.
                TEST1->( ordCreate( "TEST1.CDX",                        ;
                                    "Married",                          ;
                                    "TEST1->Married",                   ;
                                    {|| TEST1->Married } ) )
        endif

        // Open the index files for TEST1 workarea. ---------------------------
        TEST1->( ordListAdd( "TEST1.CDX", "First Name" ) )
        TEST1->( ordListAdd( "TEST1.CDX", "Last Name" ) )
        TEST1->( ordListAdd( "TEST1.CDX", "Hire Date" ) )
        TEST1->( ordListAdd( "TEST1.CDX", "Age" ) )
        TEST1->( ordListAdd( "TEST1.CDX", "Married" ) )
        TEST1->( ordSetFocus( 1 ) )


        // Open the TEST2 database file with the DBFNTX Driver.----------------
        dbUseArea( .t., "DBFNTX", "TEST2.DBF", "TEST2" )

        // Check the existance of the index files.-----------------------------
        if !File( "TEST2COM.NTX" )

                // Create order by first field plus last field.
                // You can't search by this order. Only for test.
                TEST2->( ordCreate( "TEST2COM.NTX",                     ;
                                    "First Name",                       ;
                                    "TEST2->First + TEST2->Last",       ;
                                    {|| TEST2->First  + TEST2->Last } ) )
        endif
        if !File( "TEST2LAS.NTX" )

                // Create order by last field.
                TEST2->( ordCreate( "TEST2LAS.NTX",                     ;
                                    "Last Name",                        ;
                                    "TEST2->Last",                      ;
                                    {|| TEST2->Last } ) )
        endif
        if !File( "TEST2HIR.NTX" )

                // Create order by hiredate field.
                TEST2->( ordCreate( "TEST2HIR.NTX",                     ;
                                    "Hire Date",                        ;
                                    "TEST2->Hiredate",                  ;
                                    {|| TEST2->Hiredate } ) )
        endif
        if !File( "TEST2AGE.NTX" )

                // Create order by age field.
                TEST2->( ordCreate( "TEST2AGE.NTX",                     ;
                                    "Age",                              ;
                                    "TEST2->Age",                       ;
                                    {|| TEST2->Age } ) )
        endif
        if !File( "TEST2MAR.NTX" )

                // Create order by.
                // You can't search by this order. Only for test.
                TEST2->( ordCreate( "TEST2MAR.NTX",                     ;
                                    "Married",                          ;
                                    "TEST2->Married",                   ;
                                    {|| TEST2->Married } ) )
        endif

        // Open the index files for TEST2 workarea. ---------------------------
        TEST2->( ordListAdd( "TEST2COM.NTX", "First Name" ) )
        TEST2->( ordListAdd( "TEST2LAS.NTX", "Last Name" ) )
        TEST2->( ordListAdd( "TEST2HIR.NTX", "Hire Date" ) )
        TEST2->( ordListAdd( "TEST2AGE.NTX", "Age" ) )
        TEST2->( ordListAdd( "TEST2MAR.NTX", "Married" ) )
        TEST2->( ordSetFocus( 1 ) )

RETURN


/****************************************************************************************
 *    Function: CloseTable()
 * Description: Closes the active databases.
 *  Parameters: None
 *      Return: NIL
 ***************************************************************************************/
PROCEDURE CloseTable()

        CLOSE TEST1
        CLOSE TEST2

RETURN


/****************************************************************************************
 *    Function: BasicDemo( cArea)
 * Description: Run a basic demo (without parameters) of EDIT command.
 *  Parameters: [cArea]         Character. Name of the workarea.
 *      Return: NIL
 ***************************************************************************************/
PROCEDURE BasicDemo( cArea )

        // Basic demo of EDIT command.
        EDIT EXTENDED WORKAREA &cArea

RETURN


/****************************************************************************************
 *    Function: AdvancedDemo( cArea )
 * Description: Runs a advanced demo of EDIT command with all parameters.
 *  Parameters: [cArea]         Character. Name of the workarea.
 *      Return: NIL
 ***************************************************************************************/
PROCEDURE AdvancedDemo( cArea )

        // Local variable declarations.----------------------------------------
        LOCAL aFieldName   := { "First Name", "Last Name", "Adress", "City",    ;
                                "State", "ZIP Code", "Hire date", "Married?",   ;
                                "Age", "Salary", "Notes"    }
        LOCAL aFieldAdvise := { "Enter the first name of the employee",         ;
                                "Enter the last name of the employee",          ;
                                "Enter the adress",                             ;
                                "Enter the city",                               ;
                                "Enter the State in two character mode",        ;
                                "Enter the Zip code in xxxxx-xxxx format",      ;
                                "Select the hire date",                         ;
                                "Check the box if the employee is married",     ;
                                "Enter the age",                                ;
                                "Enter the salary",                             ;
                                "Enter some notes of this employee if you want" }
        LOCAL aVisTable    := { .t., .t., .t., .t., .f., .f., .f., .f., .t., .t., .f. }
        LOCAL aFieldEdit   := { .t., .t., .t., .t., .t., .t., .t., .t., .t., .f., .t. }
        LOCAL aOptions     := Array( 3, 2 )
        LOCAL bSave        := {|aValues, lNew| AdvancedSave( aValues, lNew, cArea ) }
        LOCAL bSearch      := {|| MsgInfo( "Your own search function", "EDIT EXTENDED demo" ) }
        LOCAL bPrint       := {|| MsgInfo( "Your own print function", "EDIT EXTENDED demo" ) }
        aOptions[1,1] := "Execute option 1"
        aOptions[1,2] := {|| MsgInfo( "You can do something here 1", "EDIT EXTENDED demo" ) }
        aOptions[2,1] := "Execute option 2"
        aOptions[2,2] := { || MsgInfo( "You can do something here 2", "EDIT EXTENDED demo" ) }
        aOptions[3,1] := "Execute option 3"
        aOptions[3,2] := { || MsgInfo( "You can do something here 3", "EDIT EXTENDED demo" ) }

        // Edit extended demo.-------------------------------------------------
        EDIT EXTENDED                           ;
                WORKAREA &cArea                 ;
                TITLE "Employees maintenance"   ;
                FIELDNAMES aFieldName           ;
                FIELDMESSAGES aFieldAdvise      ;
                FIELDENABLED aFieldEdit         ;
                TABLEVIEW aVisTable             ;
                OPTIONS aOptions                ;
                ON SAVE bSave                   ;
                ON FIND bSearch                 ;
                ON PRINT bPrint

RETURN


/****************************************************************************************
 *    Function: AdvancedSave( aValues, lNew )
 * Description: Checks and save the record.
 *  Parameters: [aValues]       Array. Values of the record.
 *              [lNew]          Logical. If .t. append mode, .f. edit mode.
 *      Return: lReturn         Logical. If .t. exit edit window, .f. stay in edit window.
 ***************************************************************************************/
FUNCTION AdvancedSave( aValues, lNew, cArea )

        // Variable declaration.-----------------------------------------------
        LOCAL i := 1

        // Check for empty values.
        IF Empty( aValues[1] )   // First name.
                msgInfo( "First name can't be an empty value", "EDIT EXTENDED demo" )
                return ( .f. )
        ENDIF

        // Calculate the salary.
        aValues[10] := 100.5

        // Save the record.
        IF lNew
                (cArea)->( dbAppend() )
        ENDIF
        FOR i := 1 TO Len( aValues )
                (cArea)->( FieldPut( i, aValues[i] ) )
        NEXT

RETURN .T.


/****************************************************************************************
 *    Function: SelectLang()
 * Description: Select the [x]Harbour default language.
 *  Parameters: None
 *      Return: NIL
****************************************************************************************/
PROCEDURE SelectLang()

   LOCAL aLangName := { "Basque", ;
                        "Bulgarian", ;
                        "Croatian", ;
                        "Czech", ;
                        "Dutch", ;
                        "English", ;
                        "Finnish", ;
                        "French", ;
                        "German", ;
                        "Greek", ;
                        "Hungarian", ;
                        "Italian", ;
                        "Polish", ;
                        "Portuguese", ;
                        "Russian", ;
                        "Slovak", ;
                        "Slovenian", ;
                        "Spanish", ;
                        "Turkish", ;
                        "Ukranian" }

#if ( __HARBOUR__ - 0 > 0x030200 )    // for Harbour 3.4 version
   LOCAL aLangID   := { "EU", ;
                        "BG", ;
                        "HR", ;
                        "CS", ;
                        "NL", ;
                        "EN", ;
                        "FI", ;
                        "FR", ;
                        "DE", ;
                        "EL", ;
                        "HU", ;
                        "IT", ;
                        "PL", ;
                        "PT", ;
                        "RU", ;
                        "SK", ;
                        "SL", ;
                        "ES", ;
                        "TR", ;
                        "UK" }
#else
   LOCAL aLangID   := { "EU", ;
                        "BGWIN", ;
                        "HR852", ;
                        "CSWIN", ;
                        "NL", ;
                        "EN", ;
                        "FI", ;
                        "FR", ;
                        "DEWIN", ;
                        "ELWIN", ;
                        "HUWIN", ;
                        "IT", ;
                        "PLWIN", ;
                        "PT", ;
                        "RUWIN", ;
                        "SKWIN", ;
                        "SLWIN", ;
                        "ES", ;
                        "TRWIN", ;
                        "UKWIN" }
#endif

   LOCAL nItem

   // Language selection.
   MsgInfo( "The interface language of EDIT EXTENDED command" + CRLF + ;
            "is OOHG's default language and can changed using" + CRLF + ;
            "function InitMessages()." + CRLF + CRLF + ;
            "If your language isn't supported but you are willing" + CRLF + ;
            "to help with the translation, please send a message" + CRLF + ;
            "to https://groups.google.com/forum/#!forum/oohg", "EDIT EXTENDED demo" )
   nItem := SelectItem( aLangName )
   IF ! nItem == 0
      InitMessages( aLangID[nItem] )
      MsgInfo( "Interface language was changed to " + aLangName[nItem], "EDIT EXTENDED demo" )
   ENDIF

RETURN NIL


/****************************************************************************************
 *    Function: SelectItem( acItems )
 * Description: Select an item from an array of character items.
 *  Parameters: [acItems]       Array of character items.
 *      Return: [nItem]         Number of selected item.
 ***************************************************************************************/
FUNCTION SelectItem( acItems )

        // Local variable declarations.----------------------------------------
        LOCAL nItem := 0

        // Create the selection window.----------------------------------------
        DEFINE WINDOW wndSelItem ;
           AT 0, 0 ;
           WIDTH 160 ;
           HEIGHT 200 ;
           CLIENTAREA ;
           TITLE "Click to select or Esc to exit" ;
           MODAL ;
           NOSIZE ;
           NOSYSMENU

           @ 10, 20 LISTBOX lbxItems ;
           WIDTH 120 ;
           HEIGHT 180 ;
           ITEMS acItems ;
           VALUE 1 ;
           FONT "Arial" ;
           SIZE 9 ;
           ON CHANGE {|| nItem := wndSelItem.lbxItems.Value, wndSelItem.Release }

           ON KEY ESCAPE ACTION ThisWindow:Release()
        END WINDOW

        // Activate the window.------------------------------------------------
        CENTER WINDOW wndSelItem
        ACTIVATE WINDOW wndSelItem

RETURN nItem


/****************************************************************************************
 *    Function: About()
 * Description: Shows the about window.
 *  Parameters: None
 *      Return: NIL
****************************************************************************************/
PROCEDURE About()

        // Shows the about window.---------------------------------------------
   MsgInfo( CRLF + ;
            "EDIT EXTENDED command for OOHG adapted from" + CRLF + ;
            "the original work developed for HMG by:" + CRLF + ;
            " *  Roberto López" + CRLF + ;
            " *  Grigory Filatov" + CRLF + ;
            " *  Cristóbal Mollá" + CRLF + ;
            CRLF + ;
            "Status of the language support:" + CRLF + ;
            " *  English    - Ready" + CRLF + ;
            " *  Spanish    - Ready" + CRLF + ;
            " *  Basque     - Ready (Thanks to Gerardo Fernández)" + CRLF + ;
            " *  Russian    - Ready (Thanks to Grigory Filatov)" + CRLF + ;
            " *  Portuguese - Ready (Thanks to Clovis Nogueira Jr.)" + CRLF + ;
            " *  Polish     - Ready (Thanks to Janusz Poura)" + CRLF + ;
		      " *  French     - Ready (Thanks to Chris Jouniauxdiv)" + CRLF + ;
		      " *  Italian    - Ready (Thanks to Lupano Piero)" + CRLF + ;
            " *  German     - Ready (Thanks to Janusz Poura)" + CRLF + ;
            CRLF + ;
		      "Please report bugs to OOHG support group at https://groups.google.com/forum/#!forum/oohg", ;
            "EDIT EXTENDED demo" )

RETURN
