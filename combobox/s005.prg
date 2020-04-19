/*
 * Combobox Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a sample published in OOHG list by
 * Vicente Guerra <vic@guerra.com.mx>
 *
 * This sample shows how to:
 * - Use VALUESOURCE clause.
 * - Get the value of a given item.
 * - Add items at runtime.
 * - Delete items.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   IF _OOHG_ComboIndexIsValueArray
      IF MsgYesNo( "Set COMBOINDEXISVALUEARRAY to OFF?" )
         SET COMBOINDEXISVALUEARRAY OFF
      ENDIF
   ELSE
      IF MsgYesNo( "Set COMBOINDEXISVALUEARRAY to ON?" )
         SET COMBOINDEXISVALUEARRAY ON
      ENDIF
   ENDIF

   i := 1

   aItems := { "qqq", "www", "eee" }
   aValues := { "QQ", "WW", "EE" }

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "Combobox's ValueSource Clause" ;
      WIDTH 400 ;
      HEIGHT 300

      @ 10,10 COMBOBOX Combo ;
         WIDTH 100 ;
         HEIGHT 100 ;
         ITEMS aItems ;
         VALUESOURCE ( aValues ) ;     // The parentheses are needed !!!
         ON CHANGE ChangeLabel()

      @ 50,10 LABEL Label ;
         VALUE "Select an item in the combo to see it's value !!!" ;
         AUTOSIZE

     @ 60 + oWnd:Label:Height,10 BUTTON Button1 ;
         CAPTION "Get 'eee' value" ;
         ACTION AutoMsgBox( oWnd:Combo:ItemValue( "eee" ) )

     @ 60 + oWnd:Label:Height,120 BUTTON Button2 ;
         CAPTION "Add item" ;
         ACTION ( oWnd:Combo:AddItem( "xx" + hb_ntos( i ), "XX" + hb_ntos( i ) ), ;
                  MsgInfo( "Item XX" + hb_ntos( i ++ ) + " added!" ) )

     @ 60 + oWnd:Label:Height,230 BUTTON Button3 ;
         CAPTION "Delete item" ;
         ACTION MsgInfo( iif( oWnd:Combo:DeleteItem( 2 ), ;
                              "Second item deleted!", ;
                              "Can't delete second item!" ) )

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   oWnd:ClientHeight := 70 + oWnd:Label:Height + oWnd:Button3:Height

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

   RETURN NIL

FUNCTION ChangeLabel

   nOldH := oWnd:Label:Height
   oWnd:Label:Value := "The combo's value is: " + CRLF + ;
                       iif( ValType( oWnd:Combo:Value ) == "N", ;
                            LTrim( Str( oWnd:Combo:Value ) ), ;
                            oWnd:Combo:Value )
   IF nOldH # oWnd:Label:Height
      oWnd:Button3:Row := ;
      oWnd:Button2:Row := ;
      oWnd:Button1:Row := oWnd:Button1:Row - nOldH + oWnd:Label:Height
      oWnd:ClientHeight := oWnd:Button1:Row + oWnd:Button3:Height + 10
   ENDIF

   RETURN NIL

/*
 * EOF
 */
