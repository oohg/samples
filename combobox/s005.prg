/*
 * Combobox Sample n° 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample published in OOHG list by
 * Vicente Guerra <vic@guerra.com.mx>
 *
 * This sample shows how to use VALUESOURCE clause and how
 * to get the value of a given item.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oWnd, aItems, aValues

   aItems := { "qqq", "www", "eee" }
   aValues := { "QQ", "WW", "EE" }

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "Combobox's ValueSource Clause" ;
      WIDTH 350 ;
      HEIGHT 200

      @ 10,10 COMBOBOX Combo ;
         WIDTH 100 ;
         HEIGHT 100 ;
         ITEMS aItems ;
         VALUESOURCE (aValues) ;     // The parentheses are needed !!!
         ON CHANGE oWnd:Label:Value := ;
                      "The combo's value is: " + oWnd:Combo:Value

      @ 60,10 LABEL Label ;
         VALUE "Select an item in the combo to see it's value !!!" ;
         AUTOSIZE

     @ 90,10 BUTTON Button ;
         CAPTION "Get 'eee' value" ;
         ACTION AutoMsgBox( oWnd:Combo:ItemValue( "eee" ) )      

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN NIL

/*
 * EOF
 */
