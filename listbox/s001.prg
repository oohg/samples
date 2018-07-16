/*
 * Listbox Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a MULTICOLUM listbox.
 *
 * Based on a sample from HMG Extended contributed by Janusz Pora
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

FUNCTION Main
   LOCAL aItem

   aItem := {'ARGENTINA', ;
             'ALASKA', ;
             'ALABAMA', ;
             'ARKANSAS', ;
             'ARIZONA', ;
             'BELGICA', ;
             'BRASIL', ;
             'CALIFORNIA', ;
             'CHILE', ;
             'COLOMBIA', ;
             'CANADA', ;
             'COLORADO', ;
             'COSTA RICA', ;
             'CONNECTICUT', ;
             'DELAWARE', ;
             'DISTRITO FEDERAL', ;
             'ECUADOR', ;
             'ESPAÑA', ;
             'FLORIDA', ;
             'GEORGIA', ;
             'GRECIA', ;
             'IDAHO', ;
             'ILLINOIS', ;
             'INDIANA', ;
             'IRELAND', ;
             'KANSAS', ;
             'KENTUCKY', ;
             'LOUSIANA', ;
             'MASSACHUSETTS', ;
             'MISSOURI', ;
             'MINNESOTA', ;
             'MONTANA', ;
             'MISSISSIPPI', ;
             'MEXICO', ;
             'NORTH CAROLINA', ;
             'NORTH DAKOTA', ;
             'NEW ENGLAND', ;
             'NEW HAMPSHIRE', ;
             'NEW JERSEY', ;
             'NEW MEXICO', ;
             'NEVADA', ;
             'NEW YORK', ;
             'OHIO', ;
             'OKLAHOMA', ;
             'OREGON', ;
             'PENNSYLVANIA', ;
             'PERU', ;
             'SOUTH CAROLINA', ;
             'SOUTH DAKOTA', ;
             'TENNESSEE', ;
             'TEXAS', ;
             'UTAH', ;
             'URUGUAY', ;
             'VIRGINIA', ;
             'VENEZUELA', ;
             'VERMONT', ;
             'WASHINGTON', ;
             'WISCONSIN', ;
             'WEST VIRGINIA', ;
             'WYOMING', ;
             'HAWAII'}

   DEFINE WINDOW Form_1 AT 100,60 WIDTH 450 HEIGHT 450 ;
      TITLE "MultiColumn ListBox" ;
      MAIN ;
      NOMAXIMIZE ;
      NOSIZE

      @ 10,10 LABEL lbl_1 VALUE 'Style MULTICOLUMN ' ;
         AUTOSIZE ;
         BOLD

      @ 30,10 LISTBOX lst_1 ;
         WIDTH 300 ;
         HEIGHT 160 ;
         ITEMS aItem ;
         VALUE 2 ;
         MULTICOLUMN COLUMNWIDTH 130

      @ 220,10 BUTTON btn1 CAPTION 'Add'    ACTION Item_add()
      @ 250,10 BUTTON btn2 CAPTION 'Del'    ACTION Item_del()
      @ 280,10 BUTTON btn3 CAPTION 'Modify' ACTION Item_modify()
      @ 310,10 BUTTON btn4 CAPTION 'View'   ACTION Item_view()
      @ 340,10 BUTTON btn5 CAPTION 'Close'  ACTION Form_1.Release()

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   Form_1.Center
   Form_1.Activate
RETURN Nil


PROCEDURE Item_add
   LOCAL nn := Form_1.lst_1.ItemCount + 1

   Form_1.lst_1.AddItem( 'Item_' +  ALLTRIM( STR( nn ) ) )
   Form_1.lst_1.Value := nn
   Form_1.lst_1.SetFocus
RETURN


PROCEDURE Item_del
   LOCAL n1
   LOCAL nn := Form_1.lst_1.Value

   Form_1.lst_1.DeleteItem( nn )
   n1 := Form_1.lst_1.ItemCount
   IF nn <= n1
      Form_1.lst_1.Value := nn
   ELSE
      Form_1.lst_1.Value := n1
   ENDIF
   Form_1.lst_1.SetFocus
RETURN


PROCEDURE Item_modify
   LOCAL nn := Form_1.lst_1.Value

   Form_1.lst_1.Item( nn ) := 'New_' + ALLTRIM( STR( nn ) )
   Form_1.lst_1.Value := nn
   Form_1.lst_1.SetFocus
RETURN


PROCEDURE Item_view
   MsgInfo( Form_1.lst_1.Item( Form_1.lst_1.Value ) )
   Form_1.lst_1.SetFocus
RETURN

/*
 * EOF
 */
