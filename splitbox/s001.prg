/*
 * SplitBox Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display and hide the bands of
 * a SplitBox and how to display and hide its grippers,
 * so the bands can't be resized. It also shows how to find
 * out if a band is visible and if it has a gripper.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include 'oohg.ch'

Function Main()

   DEFINE WINDOW MainForm ;
      OBJ MainForm ;
      AT 0, 0 ;
      WIDTH 600 ;
      HEIGHT 240 ;
      TITLE "ooHG Splitbox Demo" ;
      MAIN ;
      ON INIT MainForm.cmb_Address.SetFocus()

      DEFINE SPLITBOX OBJ Split
         DEFINE TOOLBAR ToolBar_1 BUTTONSIZE 20,20 FLAT BOTTOM
            BUTTON btn_NewPage CAPTION "New Page" ACTION Action() AUTOSIZE
            BUTTON btn_Back    CAPTION "Back"     ACTION Action() AUTOSIZE
            BUTTON btn_Forward CAPTION "Forward"  ACTION Action() AUTOSIZE
            BUTTON btn_Reload  CAPTION "Reload"   ACTION Action() AUTOSIZE
            BUTTON btn_Stop    CAPTION "Stop"     ACTION Action() AUTOSIZE
            BUTTON btn_Home    CAPTION "Home"     ACTION Action() AUTOSIZE
            BUTTON btn_About   CAPTION "About"    ACTION Action() AUTOSIZE
         END TOOLBAR

         COMBOBOX cmb_Address ;
            FONT "Arial" SIZE 9 ;
            ITEMS {"http://www.oohg.org", ;
                   "https://harbour.github.io/", ;
                   "https://groups.google.com/d/forum/oohg"} ;
            VALUE 3 ;
            ON ENTER Action() ;
            DISPLAYEDIT

         DEFINE TOOLBAR ToolBar_2 BUTTONSIZE 20,20 FLAT BOTTOM
            BUTTON btn_Go CAPTION "Go" ACTION Action() AUTOSIZE
         END TOOLBAR
      END SPLITBOX


      /*
       * The band number is given by the control's creation order.
       * In this sample ToolBar_1 has band number 1, cmb_Address
       * has band number 2 and ToolBar_2 has band number 3.
       */

      @ 90, 10 BUTTON btn_ShowB ;
         OBJ btn_ShowB ;
         CAPTION "Show Band" ;
         ACTION {|| Split:ShowBand( 3 ), ;
                    btn_ShowB:Enabled := .F., ;
                    btn_HideB:Enabled := .T.} ;
         DISABLED

      @ 130, 10 BUTTON btn_HideB ;
         OBJ btn_HideB ;
         CAPTION "Hide Band" ;
         ACTION {|| Split:HideBand( 3 ), ;
                    btn_ShowB:Enabled := .T., ;
                    btn_HideB:Enabled := .F.} ;

      @ 170, 10 BUTTON btn_IsV ;
         OBJ btn_IsV ;
         CAPTION "Is Visible" ;
         ACTION AUTOMSGBOX( Split:IsBandVisible( 3 ), "Info" )


      @ 90, 230 BUTTON btn_ShowG ;
         OBJ btn_ShowG ;
         CAPTION "Gripper ON" ;
         ACTION {|| Split:BandGripperON( 3 ), ;
                    btn_ShowG:Enabled := .F., ;
                    btn_HideG:Enabled := .T.} ;
         DISABLED

      @ 130, 230 BUTTON btn_HideG ;
         OBJ btn_HideG ;
         CAPTION "Gripper OFF" ;
         ACTION {|| Split:BandGripperOFF( 3 ), ;
                    btn_ShowG:Enabled := .T., ;
                    btn_HideG:Enabled := .F.} ;

      @ 170, 230 BUTTON btn_IsG ;
         OBJ btn_IsG ;
         CAPTION "Has Gripper" ;
         ACTION AUTOMSGBOX( Split:BandHasGripper( 3 ), "Info" )

      ON KEY ESCAPE ACTION MainForm:Release()

   END WINDOW

   CENTER WINDOW MainForm
   ACTIVATE WINDOW MainForm

RETURN Nil

FUNCTION Action()

  MSGINFO('Action','Info')

RETURN Nil

/*
 * EOF
 */
