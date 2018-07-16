/*
 * Tree Sample n° 6
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use ITEMIDS clause in a Tree
 * Control, and how to assign an ID automatically.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main()

   LOCAL oForm, oTree, aIDs := {}

   DEFINE WINDOW Form_1 OBJ oForm ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 410 ;
      TITLE 'TreeView with ITEMIDS' ;
      MAIN

      DEFINE TREE Tree_1 OBJ oTree ;
         AT 10,10 ;
         WIDTH 300 ;
         HEIGHT 202 ;
         SELBOLD ;
         ITEMIDS

         NODE 'Documents' ID 'DOCS'
            NODE 'Utilities' ID 'UTIL'
               NODE 'Electricity' ID 'ELE'
                  NODE '2011' ID 'ELE_2011'
                  END NODE
                  NODE '2012' ID 'ELE_2012'
                  END NODE
               END NODE
               NODE 'Gas' ID 'GAS'
                  NODE '2011' ID 'GAS_2011'
                  END NODE
                  NODE '2012' ID 'GAS_2012'
                  END NODE
               END NODE
               NODE 'Phone' ID 'PHO'
                  NODE '2013' ID 'PHO_2013'
                  END NODE
               END NODE
               NODE 'Tv' ID 'TV'
               END NODE
            END NODE
         END NODE
      END TREE

/*
 * Last parameter in .T. will assign an ID using AUTOID.
 * This ID is returned by AddItem method.
 */
      @ 250,10 BUTTON Button_1 ;
         CAPTION 'Add to Gas/2011' ;
         WIDTH 160 ;
         ACTION oTree:Value := ;
                   oTree:AddItem( 'Invoice 123', 'GAS_2011', NIL, NIL, ;
                                  NIL, NIL, NIL, NIL, NIL, .T. )

/*
 * Adds and item with a given ID under the selected node.
 */
      @ 250,180 BUTTON Button_2 ;
         CAPTION 'Add to Selected' ;
         WIDTH 160 ;
         ACTION oTree:Value := oTree:AddItem( 'Invoice 555', ;
                                              oTree:SelectionID(), ;
                                              'INV_555' )

      ON KEY ESCAPE OF (oForm) ACTION oForm:Release()
   END WINDOW

   ACTIVATE WINDOW Form_1

RETURN NIL

/*
 * EOF
 */
