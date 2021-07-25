/*
 * Label Sample # 5
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows AUTOSIZE, AUTOWIDTH and AUTOHEIGHT
 * clauses.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   DEFINE WINDOW Form OBJ oWin ;
      AT 0,0 ;
      WIDTH 800 HEIGHT 400 ;
      TITLE "OOHG - Label's AUTOSIZE, AUTOWIDTH and AUTOHEIGHT clauses" ;
      MAIN

      @ 20,20 LABEL lbl_1 OBJ oLbl1 ;
         VALUE "this label has autosize clause" ;
         HEIGHT 50 WIDTH 50 ;
         SIZE 8 ;
         AUTOSIZE ;
         BORDER

      @ 120,20 LABEL lbl_2 OBJ oLbl2 ;
         VALUE "this label has autowidth clause" ;
         HEIGHT 50 WIDTH 50 ;
         SIZE 8 ;
         AUTOWIDTH ;
         BORDER

      @ 220,20 LABEL lbl_3 OBJ oLbl3 ;
         VALUE "this label has autoheight clause" ;
         HEIGHT 50 WIDTH 400 ;
         SIZE 8 ;
         AUTOHEIGHT ;
         BORDER

      @ 320, 20 BUTTON btn_1 ;
         CAPTION "Change 1" ;
         ACTION ChangeLabel1()

      @ 320, 140 BUTTON btn_2 ;
         CAPTION "Change 2" ;
         ACTION ChangeLabel2()

      @ 320, 260 BUTTON btn_3 ;
         CAPTION "Change 3" ;
         ACTION ChangeLabel3()


      ON KEY ESCAPE ACTION Form.Release
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

RETURN NIL


FUNCTION ChangeLabel1

   STATIC lChange := .F.

   lChange := ! lChange
   IF lChange
      oLbl1:Caption := "this label has autosize clause, a longer caption and bigger font"
      oLbl1:SetFont( NIL, 20 )
   ELSE
      oLbl1:Caption := "this label has autosize clause"
      oLbl1:SetFont( NIL, 8 )
   ENDIF

RETURN NIL


FUNCTION ChangeLabel2

   STATIC lChange := .F.

   lChange := ! lChange
   IF lChange
      oLbl2:Caption := "this label has autowidth clause and a very long caption"
   ELSE
      oLbl2:Caption := "this label has autowidth clause"
   ENDIF

RETURN NIL


FUNCTION ChangeLabel3

   STATIC lChange := .F.

   lChange := ! lChange
   IF lChange
      oLbl3:SetFont( NIL, 20 )
   ELSE
      oLbl3:SetFont( NIL, 8 )
   ENDIF

RETURN NIL

/*
 * EOF
 */
