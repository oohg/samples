/*
 * Grid Sample # 19
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to displahy a menu when the user
 * right-clicks on the grid's header and how to perform
 * and action when ther user clicks the grid's header.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE MAIN

   DEFINE WINDOW MAIN ;
      CLIENTAREA ;
      TITLE "Right Click on Headers" ;
      WIDTH 400 HEIGHT 400

      @ 10, 10 GRID Grid ;
         WIDTH 300 HEIGHT 300 ;
         OBJ oGrid ;
         HEADERS { "One", "Two", "Three" } ;
         WIDTHS  { 50, 50, 50 } ;
         ITEMS { { "1111111111", "1", "1" }, ;
                 { "2", "2", "2222222222" },  ;
                 { "3", "3333333333", "3" }, ;
                 { "4444", "4444", "4444" } } ;
         VALUE 1 ;
         ONHEADRCLICK {|nColumn| ShowHeaderRightClickMenu( nColumn ) } ;
         ON HEADCLICK { { || MsgInfo( 'Click 1' ) }, ;
                        { || MsgInfo( 'Click 2' ) }, ;
                        { || MsgInfo( 'Click 3' ) } } ;

      @ 370, 10 LABEL label ;
         WIDTH 400 HEIGHT 30 ;
         FONTCOLOR RED ;
         VALUE "See what happens when you right click on a column's header."

      ON KEY ESCAPE ACTION MAIN.RELEASE()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN
RETURN

FUNCTION ShowHeaderRightClickMenu( nColumn )

   LOCAL oMenu

   DEFINE MENU DYNAMIC OF MAIN OBJ oMenu
      ITEM 'RClick on Column ' + ltrim(str(nColumn)) ACTION NIL
   END MENU

   oMenu:Activate()

/*
 * Return values:
 *
 *    .F. prevents the grid's from scrolling to the left until the first
 *   column is shown.
 *
 *   other values: the grid scrolls to the left until the first column
 *   is shown (this is the default action).
 */

RETURN .F.

/*
 * EOF
 */
