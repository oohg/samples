
#include "oohg.ch"
#include "Dbstruct.ch"

REQUEST DBFCDX , DBFFPT

FUNCTION Main

   SET CENTURY ON
   SET DELETE ON
   SET BROWSESYNC ON

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 410 ;
      TITLE 'ooHG Browse Demo' ;
      MAIN NOMAXIMIZE ;
      ON INIT OpenTables() ;
      ON RELEASE CloseTables()

      DEFINE STATUSBAR
        STATUSITEM ""
      END STATUSBAR

      @ 10, 10 BROWSE Browse_1 OBJ oBrw ;
         WIDTH oForm:ClientWidth - 20 ;
         HEIGHT 250 ;
         HEADERS { 'Code' , 'First Name' , 'Last Name' } ;
         WIDTHS { 150 , 150 , 150 } ;
         WORKAREA Test ;
         FIELDS { 'Test->Code' , 'Test->First' , 'Test->Last' } ;
         VALUE 1 ;
         APPEND ;
         DELETE ;
         EDIT INPLACE ;
         FULLMOVE ;
         ON CHANGE oForm:StatusBar:Item( 1, "Recno " + ltrim(str(Test->(RECNO()))) + " Value " + autotype(oBrw:Value) + " cText " + oBrw:cText )

      @ 270, 10 LABEL Lbl_1 OBJ oLbl1 ;
         AUTOSIZE ;
         VALUE "Search by Col " + ;
               LTRIM( STR( oBrw:SearchCol ) ) + ;
               " - Wrap " + ;
               IF( oBrw:SearchWrap, "ON", "OFF" )

      @ 300, 10 BUTTON But_1 ;
         CAPTION "Search by Col 1" ;
         WIDTH 120 ;
         ACTION {|| ( oBrw:SearchCol := 1, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oBrw:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oBrw:SearchWrap, "ON", "OFF" ), ;
                      oBrw:SetFocus() ) }

      @ 300, 150 BUTTON But_2 ;
         CAPTION "Search by Col 3" ;
         WIDTH 120 ;
         ACTION {|| ( oBrw:SearchCol := 3, ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oBrw:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oBrw:SearchWrap, "ON", "OFF" ), ;
                      oBrw:SetFocus() ) }

      @ 300, 290 BUTTON But_3 OBJ oBut3 ;
         CAPTION "Wrap " + IF( oBrw:SearchWrap, "OFF", "ON" ) ;
         WIDTH 120 ;
         ACTION {|| ( oBrw:SearchWrap := ! oBrw:SearchWrap, ;
                      oBut3:Caption := "Wrap " + ;
                                       IF( oBrw:SearchWrap, "OFF", "ON" ), ;
                      oLbl1:Value := "Search by Col " + ;
                                     LTRIM( STR( oBrw:SearchCol ) ) + ;
                                     " - Wrap " + ;
                                     IF( oBrw:SearchWrap, "ON", "OFF" ), ;
                      oBrw:SetFocus() ) }
      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

Return Nil

Function OpenTables()

   CreateTable()

   Use Test Via "DBFCDX"
   INDEX ON Last TAG Last TO Test
   GO TOP

Return Nil

Function CloseTables()
   Use
   ERASE TEST.DBF
   ERASE TEST.FPT
   ERASE TEST.CDX
Return Nil

Procedure CreateTable
LOCAL aDbf[3][4]

        aDbf[1][ DBS_NAME ] := "Code"
        aDbf[1][ DBS_TYPE ] := "Numeric"
        aDbf[1][ DBS_LEN ]  := 10
        aDbf[1][ DBS_DEC ]  := 0
        //
        aDbf[2][ DBS_NAME ] := "First"
        aDbf[2][ DBS_TYPE ] := "Character"
        aDbf[2][ DBS_LEN ]  := 25
        aDbf[2][ DBS_DEC ]  := 0
        //
        aDbf[3][ DBS_NAME ] := "Last"
        aDbf[3][ DBS_TYPE ] := "Character"
        aDbf[3][ DBS_LEN ]  := 25
        aDbf[3][ DBS_DEC ]  := 0
        //

        DBCREATE("Test", aDbf, "DBFCDX")

   Use test Via "DBFCDX"
   zap

   Append Blank
   Replace Code  With 5555555
   Replace First With 'Homer'
   Replace Last  With 'Simpson'
   Append Blank
   Replace Code  With 3246432
   Replace First With 'Fox'
   Replace Last  With 'Mulder'
   Append Blank
   Replace Code  With 8942332
   Replace First With 'Pepe'
   Replace Last  With 'Grillo'
   Append Blank
   Replace Code  With 4325892
   Replace First With 'Max'
   Replace Last  With 'Smart'
   Append Blank
   Replace Code  With 3469873
   Replace First With 'James'
   Replace Last  With 'Kirk'
   Append Blank
   Replace Code  With 3949654
   Replace First With 'Carlos'
   Replace Last  With 'Barriga'
   Append Blank
   Replace Code  With 4353211
   Replace First With 'Ned'
   Replace Last  With 'Flanders'
   Append Blank
   Replace Code  With 1231234
   Replace First With 'John'
   Replace Last  With 'Smith'
   Append Blank
   Replace Code  With 0000000
   Replace First With 'Flavio'
   Replace Last  With 'Pedemonti'
   Append Blank
   Replace Code  With 5834832
   Replace First With 'Juan'
   Replace Last  With 'Gomez'
   Append Blank
   Replace Code  With 3214332
   Replace First With 'Raul'
   Replace Last  With 'Fernandez'
   Append Blank
   Replace Code  With 3269430
   Replace First With 'Javier'
   Replace Last  With 'Borges'
   Append Blank
   Replace Code  With 5437898
   Replace First With 'Alberto'
   Replace Last  With 'Alvarez'
   Append Blank
   Replace Code  With 4378473
   Replace First With 'Ambo'
   Replace Last  With 'Gonzalez'
   Append Blank
   Replace Code  With 4852843
   Replace First With 'Gol'
   Replace Last  With 'Batistuta'
   Append Blank
   Replace Code  With 4852843
   Replace First With 'El Loco'
   Replace Last  With 'Suarez'
   Append Blank
   Replace Code  With 3945983
   Replace First With 'Amigo'
   Replace Last  With 'Vinazzi'
   Append Blank
   Replace Code  With 5347984
   Replace First With 'Flavio'
   Replace Last  With 'Pedemonti'
   Append Blank
   Replace Code  With 8547873
   Replace First With 'Armando'
   Replace Last  With 'Samarbide'
   Append Blank
   Replace Code  With 1111111
   Replace First With 'Alejandra'
   Replace Last  With 'Pradon'
   Append Blank
   Replace Code  With 4325836
   Replace First With 'Monica'
   Replace Last  With 'Reyes'

   Use

Return

/*
 * EOF
 */
