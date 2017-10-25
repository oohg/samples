
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

   RETURN NIL

FUNCTION OpenTables()

   CreateTable()

   USE Test Via "DBFCDX"
   INDEX ON Last TAG Last TO Test
   GO TOP

   RETURN NIL

FUNCTION CloseTables()

   Use

   RETURN NIL

PROCEDURE CreateTable

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

   USE test Via "DBFCDX"
   ZAP

   APPEND Blank
   REPLACE Code  With 5555555
   REPLACE First With 'Homer'
   REPLACE Last  With 'Simpson'
   APPEND Blank
   REPLACE Code  With 3246432
   REPLACE First With 'Fox'
   REPLACE Last  With 'Mulder'
   APPEND Blank
   REPLACE Code  With 8942332
   REPLACE First With 'Pepe'
   REPLACE Last  With 'Grillo'
   APPEND Blank
   REPLACE Code  With 4325892
   REPLACE First With 'Max'
   REPLACE Last  With 'Smart'
   APPEND Blank
   REPLACE Code  With 3469873
   REPLACE First With 'James'
   REPLACE Last  With 'Kirk'
   APPEND Blank
   REPLACE Code  With 3949654
   REPLACE First With 'Carlos'
   REPLACE Last  With 'Barriga'
   APPEND Blank
   REPLACE Code  With 4353211
   REPLACE First With 'Ned'
   REPLACE Last  With 'Flanders'
   APPEND Blank
   REPLACE Code  With 1231234
   REPLACE First With 'John'
   REPLACE Last  With 'Smith'
   APPEND Blank
   REPLACE Code  With 0000000
   REPLACE First With 'Flavio'
   REPLACE Last  With 'Pedemonti'
   APPEND Blank
   REPLACE Code  With 5834832
   REPLACE First With 'Juan'
   REPLACE Last  With 'Gomez'
   APPEND Blank
   REPLACE Code  With 3214332
   REPLACE First With 'Raul'
   REPLACE Last  With 'Fernandez'
   APPEND Blank
   REPLACE Code  With 3269430
   REPLACE First With 'Javier'
   REPLACE Last  With 'Borges'
   APPEND Blank
   REPLACE Code  With 5437898
   REPLACE First With 'Alberto'
   REPLACE Last  With 'Alvarez'
   APPEND Blank
   REPLACE Code  With 4378473
   REPLACE First With 'Ambo'
   REPLACE Last  With 'Gonzalez'
   APPEND Blank
   REPLACE Code  With 4852843
   REPLACE First With 'Gol'
   REPLACE Last  With 'Batistuta'
   APPEND Blank
   REPLACE Code  With 4852843
   REPLACE First With 'El Loco'
   REPLACE Last  With 'Suarez'
   APPEND Blank
   REPLACE Code  With 3945983
   REPLACE First With 'Amigo'
   REPLACE Last  With 'Vinazzi'
   APPEND Blank
   REPLACE Code  With 5347984
   REPLACE First With 'Flavio'
   REPLACE Last  With 'Pedemonti'
   APPEND Blank
   REPLACE Code  With 8547873
   REPLACE First With 'Armando'
   REPLACE Last  With 'Samarbide'
   APPEND Blank
   REPLACE Code  With 1111111
   REPLACE First With 'Alejandra'
   REPLACE Last  With 'Pradon'
   APPEND Blank
   REPLACE Code  With 4325836
   REPLACE First With 'Monica'
   REPLACE Last  With 'Reyes'

   Use

   RETURN
