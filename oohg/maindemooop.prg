/*
 * MainDemoOOP
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create controls using
 * oop syntax.
 *
 * Based on the original work of Victor Guerra and
 * Ciro Vargas.
 *
 * Visit us at https://github.com/oohg/samples
 */

/*
 * Missing classes in this demo:
 *    TActiveX
 *    TAniGIF
 *    TOBrowse
 *    TOBrowseByCell
 *    TCheckList
 *    TFormSplit
 *    TGridMulti
 *    TGridByCell
 *    THotKey
 *    THotKeyBox
 *    TInternal
 *    TList
 *    TPlayer
 *    TAnimateBox
 *    TMenuContext
 *    TMenuNotify
 *    TMonthCalMulti
 *    TScrollBar
 *    TScrollButton
 *    TSplitBox
 *    TTextArray
 *    TXBrowse
 *    TXBrowseByCell
 */

#include "oohg.ch"
#include "i_windefs.ch"

MEMVAR oWnd, oStat, oTBut1, oTlbar, oTBut2, oMenum, oMenup1, oMenup2, oMenup3
MEMVAR oTxt1, oImg, oTxt2, oPic, oLbl3, oTxt3, oTxt4, oTxt5, oTxt6, oChk1, oBtn1
MEMVAR oBtnChk1, oHLink, ocnTxtMenu, oPop, oSpin, oMcl, oProgm, oDatep, oGrid1
MEMVAR oTab1, oCombo, oInternal, oRad, oLabel, oTree, oBtn2, oBtn3, oFrame, oIP
MEMVAR oProg, oEdit, oRich, oList, oSldr, oTimep, oTmr, aSer, oGraphTest, Code
MEMVAR oPrint, X, _OOHG_PRINTLIBRARY

PROCEDURE Main

   SET CENTURY ON
   SET TOOLTIPSTYLE BALLOON
   SET TOOLTIPBACKCOLOR AQUA
   SET TOOLTIPFORECOLOR NAVY
   SET AUTOADJUST ON

   oWnd := TFormMain():Define()
      oWnd:Col     := 0
      oWnd:Row     := 0
      oWnd:Width   := 900
      oWnd:Height  := 600
      oWnd:Title   := "OOHG - Main Demo - OOP Version"
      oWnd:OnClick := { || MsgInfo( Str( _OOHG_MouseRow ) + Str( _OOHG_MouseCol ) ) }

      // TNotifyIcon()
      oWnd:NotifyIconObject:Picture := "ZZZ_AAAOOHG"
      oWnd:NotifyIconObject:ToolTip := "OOHG - Main Demo - OOP Version"
      oWnd:NotifyIconObject:OnClick := { || oWnd:Restore(), oWnd:Flash( FLASHW_ALL, 6 ) }

      oStat := TMessageBar():Define()
         oStat:AddItem( "This is the first items of the statusbar.",, { || MsgInfo( "Statusbar's first item clicked !" ) } )
         oStat:SetClock(,, { || MsgInfo( "Statusbar clock clicked !" ) } )
         oStat:ToolTip := oStat:Type
      _EndMessageBar()
      /*
      DEFINE STATUSBAR
         STATUSITEM "This is the first items of the statusbar." ACTION MsgInfo( "Statusbar's first item clicked !" )
         CLOCK ACTION MsgInfo( "Statusbar's clock clicked !" )
      END STATUSBAR
      */

      oWnd:Height -= oStat:ClientHeightUsed

      /*
      ON KEY ESCAPE ACTION oWnd:Release
      */
      _DefineAnyKey( oWnd, "ESCAPE", { || oWnd:Release } )

      oTlBar := TToolBar():Define( "Toolbr",,,, 50, 20 )
         oTBut1 := TToolButton():Define( "TBN1" )
         oTBut1:Caption := "Button 1"
         oTBut1:OnClick := { || MsgInfo( "Toolbar's button 1 clicked !" ) }
         oTBut2 := TToolButton():Define( "TBN2",,,,,,,,,,,,,,,, .T. )
         oTBut2:Caption := "Button 2"
         oTBut2:OnClick := { || MsgInfo( "Toolbar's button 2 clicked !" ) }
      _EndToolBar()
      oTlBar:ToolTip := oTlBar:Type
      /*
      DEFINE TOOLBAR Toolbr BUTTONSIZE 50,20
         BUTTON TBN1 CAPTION "Boton 1" ACTION MsgInfo( "Toolbar's button 1 clicked !" )
         BUTTON TBN2 CAPTION "Boton 2" ACTION MsgInfo( "Toolbar's button 2 clicked !" ) DROPDOWN
      END TOOLBAR
      */

      TMenuDropDown():Define( oTBut2:Name )
      TMenuItem():DefineItem( "Tool 1", { || MsgInfo( "Tool 1" ) } )
      TMenuItem():DefineItem( "Tool 2", { || MsgInfo( "Tool 2" ) } )
      _EndMenu()
      /*
      DEFINE DROPDOWN MENU BUTTON TBN2
         ITEM "Tool 1" ACTION MsgInfo( "Tool 1" )
         ITEM "Tool 2" ACTION MsgInfo( "Tool 2" )
      END MENU
      */

      oMenuM := TMenuMain():Define(, "MyMenu")
         oMenuP1 := TMenuItem():DefinePopUp( "One" )
            TMenuItem():DefineItem( "1.1", { || MsgInfo( "Menu 1.1" ) }, "Menu1" )
            oMenuP2 := TMenuItem():DefinePopUp( "1.2" )
               TMenuItem():DefineItem( "1.2.1", { || MsgInfo( "Menu 1.2.1" ) } )
               oMenuP2:Separator()
               oMenuP3 := TMenuItem():DefinePopUp( "1.2.2" )
                  TMenuItem():DefineItem( "1.2.2.1", { || MsgInfo( "Menu 1.2.2.1" ) }  )
                  TMenuItem():DefineItem( "1.2.2.2", { || MsgInfo( "Menu 1.2.2.2" ) } )
                  TMenuItem():DefineItem( "1.2.2.3", { || MsgInfo( "Menu 1.2.2.3" ) } )
               oMenuP3:EndPopUp()
               TMenuItem():DefineItem( "1.2.3", { || MsgInfo( "Menu 1.2.3" ) } )
            oMenuP2:EndPopUp()
            TMenuItem():DefineItem( "1.3", { || MsgInfo( "Menu 1.3" ) } )
         oMenuP1:EndPopUp()
         oMenuP1 := TMenuItem():DefinePopUp( "Two" )
            TMenuItem():DefineItem( "2.1", { || MsgInfo( "Menu 2.1" ) } )
            TMenuItem():DefineItem( "2.2", { || MsgInfo( "Menu 2.2" ) } )
            TMenuItem():DefineItem( "2.3", { || MsgInfo( "Menu 2.3" ) } )
         oMenuP1:EndPopUp()
         TMenuItem():DefineItem( "Data", { || MsgInfo( "Menu Data" ) }, "Menu2" )
         oMenuP1 := TMenuItem():DefinePopUp( "Three" )
            TMenuItem():DefineItem( "3.1", { || MsgInfo( "Menu 3.1" ) } )
            TMenuItem():DefineItem( "3.2", { || MsgInfo( "Menu 3.2" ) } )
            TMenuItem():DefineItem( "3.3", { || MsgInfo( "Menu 3.3" ) } )
         oMenuP1:EndPopUp()
         TMenuItem():DefineItem( "Exit", { || oWnd:Release() } )
      oMenuM:EndMenu()
      oWnd:Menu1:Checked := .T.
      oWnd:Menu2:Enabled := .F.

   /*--------------------------------------  GROUP 1  --------------------------------------*/

      oHlink := THyperLink():Define()
      oHlink:Row      := 50
      oHlink:Autosize := .T.
      oHlink:Col      := 10
      oHlink:Caption  := "Object Oriented (x)Harbour GUI"
      oHlink:Address  := "https://oohg.github.io/"
      oHlink:Height   := 20
      oHlink:Cursor   := IDC_HAND
      oHlink:ToolTip  := oHlink:Type

      oTxt1 := TText():Define()
      oTxt1:Row       := 80
      oTxt1:Col       := 10
      oTxt1:Width     := 150
      oTxt1:Height    := 20
      oTxt1:Value     := "This is a TEXTBOX !"
      oTxt1:BackColor :=  { GetRed( GetSysColor( COLOR_3DFACE ) ), GetGreen( GetSysColor( COLOR_3DFACE ) ), GetBlue( GetSysColor( COLOR_3DFACE ) ) }
      oTxt1:ToolTip   := oTxt1:Type

      oImg := TImage():Define()
      oImg:Row       := 80
      oImg:Col       := 180
      oImg:ImageSize := .T.
      oImg:Picture   := "ZZZ_AAAOOHG"
      oImg:ToolTip   := oImg:Type

      /*
      @ 110,10 TEXTBOX Txt2 VALUE "0940100101000000" WIDTH 150 HEIGHT 20 INPUTMASK "@R 999-99-999-99-!!-!!!!" AUTOSKIP
      oTxt2 := oWnd:Txt2
      */
      oTxt2 := TTextPicture():Define()
      oTxt2:Row       := 110
      oTxt2:Col       := 10
      oTxt2:Width     := 150
      oTxt2:Height    := 20
      oTxt2:lAutoSkip := .T.
      oTxt2:Picture   := "@R 999-99-999-99-!!-!!!!"
      oTxt2:Value     := "0940100101000000"
      oTxt2:ToolTip   := oTxt2:Type

      oPic := TPicture():Define()
      oPic:Row       := 120
      oPic:Col       := 180
      oPic:ImageSize := .T.
      oPic:Picture   := "ZZZ_AAAOOHG"
      oPic:ToolTip   := oPic:Type

      oLbl3 := Tlabel():Define()
      oLbl3:Row      := 140
      oLbl3:Col      := 10
      oLbl3:Value    := "Press '-'"
      oLbl3:AutoSize := .T.
      oLbl3:Height   := 20
      oLbl3:ToolTip  := oLbl3:Type

      /*
      @ 140,60 TEXTBOX Txt3 VALUE "1234567" WIDTH 100 HEIGHT 20 INPUTMASK "@R 999.999-9" RIGHTALIGN
      oWnd:Txt3:SetKey( VK_SUBTRACT,  0, { || MoveCursor( oWnd:Txt3 ) } )
      oWnd:Txt3:SetKey( VK_OEM_MINUS, 0, { || MoveCursor( oWnd:Txt3 ) } )
      oWnd:Txt3:OnLostFocus := { || MoveCursor( oWnd:Txt3 ) }
      */
      oTxt3 := TTextPicture():Define()
      oTxt3:Row       := 140
      oTxt3:Col       := 60
      oTxt3:Width     := 100
      oTxt3:Height    := 20
      oTxt3:Picture   := "@R 999.999-9"
      oTxt3:Value     := "1234567"
      oTxt3:ToolTip   := oTxt3:Type + " - Char"
      WindowStyleFlag( oTxt3:hWnd, ES_RIGHT, ES_RIGHT )
      oTxt3:SetKey( VK_SUBTRACT,  0, { || MoveCursor( oTxt3 ) } )
      oTxt3:SetKey( VK_OEM_MINUS, 0, { || MoveCursor( oTxt3 ) } )
      oTxt3:OnLostFocus := { || MoveCursor( oTxt3 ) }

      /*
      @ 170,10 TEXTBOX Txt4 OBJ oTxt4 VALUE 111.5 WIDTH 150 HEIGHT 20 NUMERIC INPUTMASK "999,999.99"
      */
      oTxt4 := TTextPicture():Define(,,,,,, 111.5 )      // The picture is derived from the value -> Numeric
      oTxt4:Row     := 170
      oTxt4:Col     := 10
      oTxt4:Height  := 20
      oTxt4:Width   := 100
      oTxt4:Picture := "999,999.99"
      oTxt4:ToolTip := oTxt4:Type + " - Numeric"

      /*
      @ 200,10 TEXTBOX Txt5 OBJ oTxt5 VALUE Date() WIDTH 150 HEIGHT 20 DATE
      DefineTextBox( "Txt5",, 10, 200, 150, 20, Date(),,,,, .F., .F., .F.,,,,, .F.,, .F.,.F., .F., .F., .F.,,,, .F., .F., .F., .F., .F.,, .F.,, .T., .F.,,, )
      */
      oTxt5 := TTextNum():Define()
      oTxt5:Row     := 170
      oTxt5:Col     := 120
      oTxt5:Height  := 20
      oTxt5:Width   := 100
      oTxt5:Value   := 111.5                              // Control only support integer numbers
      oTxt5:ToolTip := oTxt5:Type

      oTxt6 := TTextPicture():Define(,,,,,, Date() )      // The picture is derived from the value -> Date
      oTxt6:Row     := 200
      oTxt6:Col     := 10
      oTxt6:Width   := 150
      oTxt6:Height  := 20
      oTxt6:ToolTip := oTxt6:Type + " - Date"

      oChk1:= TCheckBox():Define()
      oChk1:lLibDraw := .F.
      oChk1:Row      := 230
      oChk1:Col      := 10
      oChk1:Caption  := "I have an OnChange event !"
      oChk1:Value    := .T.
      oChk1:OnChange := { || MsgInfo( "On Change fired !" ) }
      oChk1:AutoSize := .T.
      oChk1:ToolTip  := oChk1:Type

      oBtn1 := TButton():Define()
      oBtn1:Row     := 260
      oBtn1:Col     := 10
      oBtn1:Caption := "BUTTON"
      oBtn1:Action  := { || MsgInfo( oTxt2:Value ) }
      oBtn1:ToolTip := oBtn1:Type + " - See what happens when you click or right click me."

      oBtnChk1 := TButtonCheck():Define()
      oBtnChk1:Row     := 260
      oBtnChk1:Col     := 130
      oBtnChk1:Caption := "CheckButton"
      oBtnChk1:Action  := { || MsgInfo( "Control's value is " + iif( oBtnChk1:Value, ".T.", ".F." ) ) }
      oBtnChk1:ToolTip := oBtnChk1:Type + " - Click to see my value."

      oCntxtMenu := TMenuDropDown():Define( oBtn1:Name )
         oPop := TMenuItem():DefinePopUp( "Btn menu 1" )
            TMenuItem():DefineItem( "Btn menu 1.1", { || MsgInfo( "Btn menu 1.1 !" ) } )
            TMenuItem():DefineItem( "Btn menu 1.2", { || MsgInfo( "Btn menu 1.2 !" ) } )
         oPop:EndPopUp()
         oPop := TMenuItem():DefinePopUp( "Btn menu 2" )
            TMenuItem():DefineItem( "Btn menu 2.1", { || MsgInfo( "Btn menu 2.1 !" ) } )
            TMenuItem():DefineItem( "Btn menu 2.2", { || MsgInfo( "Btn menu 2.2 !" ) } )
         oPop:EndPopup()
      oCntxtMenu:EndMenu()

      oSpin:= TSpinner():Define()
      oSpin:Row      := 290
      oSpin:Col      := 10
      oSpin:Width    := 120
      oSpin:Height   := 20
      oSpin:RangeMin := 0
      oSpin:RangeMax := 100
      oSpin:ToolTip  := oSpin:Type

      oMcl := TMonthCal():Define()
      oMcl:Row     := 320
      oMcl:Col     := 10
      oMcl:Value   := Date()
      oMcl:ToolTip := oMcl:Type

      oProgm := TProgressMeter():Define()
      oProgm:Row     := 500
      oProgm:Col     := 10
      oProgm:Width   := 120
      oProgm:Height  := 20
      oProgm:Value   := 75
      oProgm:ToolTip := oProgm:Type
      oProgm:ExStyle( WS_EX_CLIENTEDGE )

      oDateP := TDatePick():Define()
      oDateP:Row      := 500
      oDateP:Col      := 150
      oDateP:Value    := Date()
      oDateP:ToolTip := oDateP:Type

   /*--------------------------------------  GROUP 2  --------------------------------------*/

      /*
      @  40,260 GRID 0 OBJ oGrid1 ;
         WIDTH 200 HEIGHT 120 ;
         HEADERS { "ONE", "TWO", "THREE" } ;
         WIDTHS { 45, 45, 45 } ;
         ITEMS { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } } ;
         JUSTIFY { GRID_JTFY_RIGHT, GRID_JTFY_CENTER, GRID_JTFY_LEFT } ;
         FONTCOLOR ORANGE;
         DYNAMICBACKCOLOR { GREEN, NIL, RED } ;
         DYNAMICFORECOLOR { NIL, YELLOW, NIL } ;
         ON HEADCLICK { { || oGrid1:ToExcel() }, { || NIL }, { || NIL } }
      */
      /*
      oGrid1:= TGrid():Define(,, 260, 40, 200, 120, { "ONE", "TWO", "THREE" }, { 45, 45, 55 }, ;
                  { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } },,,,,,,;
                  { { || oGrid1:ToExcel() }, { || NIL }, { || NIL } },,,,, { GRID_JTFY_RIGHT, GRID_JTFY_CENTER, GRID_JTFY_LEFT }, ;
                  ,,,,,,, ;
                  ,,,,ORANGE, ;
                  { GREEN, NIL, RED }, { NIL, YELLOW, NIL } )
      */
      /*
      oGrid1:= TGrid():Define()
      oGrid1:FontColor := ORANGE
      // Columns must be added before the items
      oGrid1:AddColumn( 1, "ONE",   45, GRID_JTFY_RIGHT,  NIL,    GREEN, .T.,,, { || oGrid1:ToExcel() } )
      oGrid1:AddColumn( 2, "TWO",   45, GRID_JTFY_CENTER, YELLOW, NIL,   .T. )
      oGrid1:AddColumn( 3, "THREE", 55, GRID_JTFY_LEFT,   NIL,    RED,   .T. )
      // Items must be added after the columns
      oGrid1:aItems := { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } }
      oGrid1:Row    := 40
      oGrid1:Col    := 260
      oGrid1:Width  := 200
      oGrid1:Height := 120
      */
      oGrid1:= TGrid():Define()
      oGrid1:FontColor := ORANGE
      // Columns must be added before the items
      oGrid1:AddColumn( 1, "ONE",  45 )
      oGrid1:AddColumn( 2, "TWO",  45 )
      oGrid1:AddColumn( 3, "THREE", 55 )
      // Colors must be defined before adding the items because the control is not
      // automatically repainted.
      // In the following two assignments the use of a color array
      // (like {255,255,0} or YELLOW) is not supported. Such arrays
      // are considered as arrays of colors thus column 1 and two
      // are assigned RED and column 3 BLACK. Use a color number or
      // a code block to assign the same color to all the columns.
      oGrid1:DynamicBackColor := { GREEN, NIL, RED }
      oGrid1:DynamicForeColor := { NIL, YELLOW, NIL }
      // Items must be added after the columns
      oGrid1:aItems  := { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } }
      oGrid1:Row     := 40
      oGrid1:Col     := 260
      oGrid1:Width   := 200
      oGrid1:Height  := 120
      oGrid1:ToolTip := oGrid1:Type

      oCntxtMenu := TMenuDropDown():Define( oGrid1:Name )
         TMenuItem():DefineItem( "Change Colors", { || oGrid1:RefreshColors( { BLACK, BLACK, BLACK }, { AQUA, AQUA, AQUA } ) } )
      oCntxtMenu:EndMenu()

      /*
      DEFINE TAB Tab1 AT 170,260 WIDTH 200 HEIGHT 120
         DEFINE PAGE "one"
            @ 30,10 LABEL ll1 VALUE "tab 1" AUTOSIZE TRANSPARENT
         END PAGE
         DEFINE PAGE "two"
            @ 50,10 LABEL ll2 VALUE "tab 2" AUTOSIZE TRANSPARENT
         END PAGE
         DEFINE PAGE "three"
            @ 30,10 LABEL ll3 VALUE "tab 3" AUTOSIZE TRANSPARENT
            DEFINE TAB Tab2 AT 50,10 WIDTH 150 HEIGHT 50 BUTTONS
               DEFINE PAGE "aaa"
                  @ 30,10 LABEL ll4 VALUE "tab a" AUTOSIZE TRANSPARENT
               END PAGE
               DEFINE PAGE "bbb"
                  @ 30,14 LABEL ll5 VALUE "tab b" AUTOSIZE TRANSPARENT
               END PAGE
               DEFINE PAGE "ccc"
                  @ 30,18 LABEL ll6 VALUE "tab c" AUTOSIZE TRANSPARENT
               END PAGE
            END TAB
         END PAGE
      END TAB
      */
      oTab1 := TTab():Define( "Tab1",, 260, 170, 200, 120 )
         _BeginTabPage( "one" )
            TLabel():Define( "ll1",, 10, 30, "tab 1",,,,,,,,,, .T.,,,,,,,,,, .T. )
         _EndTabPage()
         _BeginTabPage( "two" )
            TLabel():Define( "ll2",, 10, 50, "tab 2",,,,,,,,,, .T.,,,,,,,,,, .T. )
         _EndTabPage()
         _BeginTabPage( "three" )
            TLabel():Define( "ll3",, 10, 30, "tab 3",,,,,,,,,, .T.,,,,,,,,,, .T. )
            TTab():Define( "Tab2",, 10, 50, 150, 50 )
               _BeginTabPage( "aaa" )
                  TLabel():Define( "ll4",, 10, 30, "tab a",,,,,,,,,, .T.,,,,,,,,,, .T. )
               _EndTabPage()
               _BeginTabPage( "bbb" )
                  TLabel():Define( "ll5",, 14, 30, "tab b",,,,,,,,,, .T.,,,,,,,,,, .T. )
               _EndTabPage()
               _BeginTabPage( "ccc" )
                  TLabel():Define( "ll6",, 18, 30, "tab c",,,,,,,,,, .T.,,,,,,,,,, .T. )
               _EndTabPage()
            _EndTab()
         _EndTabPage()
      _EndTab()
      oTab1:ToolTip := oTab1:Type             // It shows only when the cursor hovers the tabs

      oCombo:= TCombo():Define()
      oCombo:Row     := 310
      oCombo:Col     := 300
      oCombo:Width   := 120
      oCombo:ToolTip := oCombo:Type
      oCombo:AddItem( "One" )
      oCombo:AddItem( "Two" )
      oCombo:AddItem( "Three" )

      /*
      DEFINE WINDOW IntWin OBJ oInternal AT 350,300 WIDTH 120 HEIGHT 100 INTERNAL VIRTUAL WIDTH 200 VIRTUAL HEIGHT 150
         @ 10, 010 LABEL LabelRed   VALUE "A" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR RED
         @ 10, 060 LABEL LabelGreen VALUE "B" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR GREEN
         @ 10, 110 LABEL LabelBlue  VALUE "C" WIDTH 50 HEIGHT 100 CENTER BACKCOLOR BLUE
      END WINDOW
      */
      oInternal := TFormInternal():Define( "IntWin" )
      oInternal:Col           := 300
      oInternal:Row           := 350
      oInternal:Width         := 120
      oInternal:Height        := 100
      oInternal:VirtualWidth  := 200
      oInternal:VirtualHeight := 150
         TLabel():Define( "LabelRed",,   010, 10, "A", 50, 100,,,,,,,,,   RED,,, "TLabel inside TFormInternal",,,,,,,, .T. )
         TLabel():Define( "LabelGreen",, 060, 10, "B", 50, 100,,,,,,,,, GREEN,,, "TLabel inside TFormInternal",,,,,,,, .T. )
         TLabel():Define( "LabelBlue",,  110, 10, "C", 50, 100,,,,,,,,,  BLUE,,, "TLabel inside TFormInternal",,,,,,,, .T. )
      _EndWindow()

      oRad := TRadioGroup():Define(,, 300, 460, { "One", "Two", "Three" } )
      oRad:ToolTip               := oRad:Type + " - Group tooltip"
      oRad:aOptions[1]:FontColor := RED
      oRad:aOptions[2]:Col       := 320
      oRad:aOptions[2]:ToolTip   := oRad:aOptions[2]:Type + " - Item tooltip"
      oRad:aOptions[3]:Col       := 340
      oRad:aOptions[3]:BackColor := BLUE

   /*--------------------------------------  GROUP 3  --------------------------------------*/

      oLabel := TLabel():Define()
      oLabel:Caption  := "(F5) Hello !"
      oLabel:AutoSize := .T.
      oLabel:Row      := 40
      oLabel:Col      := 500
      oLabel:Action   := { || MsgInfo( "Clicked !" ) }
      oLabel:ToolTip  := oLabel:Type + " - I have an Action event !"

      /*
      ON KEY F5 ACTION MsgInfo( Str( oLabel:Row  ) + Str( oLabel:Col ), "Hello window" )
      */
      _DefineAnyKey( oWnd, "F5", { || MsgInfo( Str( oLabel:Row  ) + Str( oLabel:Col ), "Hello window !" ) } )

      /*
      DEFINE TREE Tree_1 AT 80,500 WIDTH 150 HEIGHT 200 VALUE 15
         NODE 'Item 1'
            TREEITEM 'Item 1.1'
            TREEITEM 'Item 1.2' ID 999
            TREEITEM 'Item 1.3'
         END NODE
         NODE 'Item 2'
            TREEITEM 'Item 2.1'
            NODE 'Item 2.2'
               TREEITEM 'Item 2.2.1'
               TREEITEM 'Item 2.2.2'
               TREEITEM 'Item 2.2.3'
               TREEITEM 'Item 2.2.4'
               TREEITEM 'Item 2.2.5'
               TREEITEM 'Item 2.2.6'
            END NODE
            TREEITEM 'Item 2.3'
         END NODE
         NODE 'Item 3'
            TREEITEM 'Item 3.1'
            TREEITEM 'Item 3.2'
            NODE 'Item 3.3'
               TREEITEM 'Item 3.3.1'
               TREEITEM 'Item 3.3.2'
            END NODE
         END NODE
      END TREE
      */

      oTree := TTree():Define( "Tree_1",, 80, 500, 150, 200,,,,,,,,, 15 )
         _DefineTreeNode( 'Item 1' )
            _DefineTreeItem( 'Item 1.1' )
            _DefineTreeItem( 'Item 1.2',, 999 )
            _DefineTreeItem( 'Item 1.3' )
         _EndTreeNode()
         _DefineTreeNode( 'Item 2' )
            _DefineTreeItem( 'Item 2.1' )
            _DefineTreeNode( 'Item 2.2' )
               _DefineTreeItem( 'Item 2.2.1' )
               _DefineTreeItem( 'Item 2.2.2' )
               _DefineTreeItem( 'Item 2.2.3' )
               _DefineTreeItem( 'Item 2.2.4' )
               _DefineTreeItem( 'Item 2.2.5' )
               _DefineTreeItem( 'Item 2.2.6' )
            _EndTreeNode()
            _DefineTreeItem( 'Item 2.3' )
         _EndTreeNode()
         _DefineTreeNode( 'Item 3' )
            _DefineTreeItem( 'Item 3.1' )
            _DefineTreeItem( 'Item 3.2' )
            _DefineTreeNode( 'Item 3.3' )
               _DefineTreeItem( 'Item 3.3.1' )
               _DefineTreeItem( 'Item 3.3.2' )
            _EndTreeNode()
         _EndTreeNode()
      _EndTree()
      oTree:ToolTip := oTree:Type

      oBtn2 := TButton():DefineImage()
      oBtn2:Row     := 300
      oBtn2:Col     := 500
      oBtn2:Width   := 150
      oBtn2:Height  := 100
      oBtn2:Picture := "MINIGUI_EDIT_OK"
      oBtn2:ToolTip := oBtn2:Type + " - Click me to see a Graph demo"
      oBtn2:Action  := { || PrintForm() }

      oBtn3 := TButton():DefineImage()
      oBtn3:Row     := 420
      oBtn3:Col     := 500
      oBtn3:Width   := 150
      oBtn3:Height  := 100
      oBtn3:Picture := "MINIGUI_EDIT_NEW"
      oBtn3:ToolTip := oBtn3:Type + " - Click me to see a TPrint demo"
      oBtn3:Action  := { || Test() }

   /*--------------------------------------  GROUP 4  --------------------------------------*/

      /*
      @ 50, 700 FRAME 0 ;
         OBJ oFrame ;
         CAPTION "Frame" ;
         WIDTH 150 ;
         HEIGHT 60 ;
         TOOLTIP TFrame():Type ;
         EXCLUDEAREA { {10,25,140,45} }
      */
      oFrame := TFrame():Define()
      oFrame:Row          := 50
      oFrame:Col          := 700
      oFrame:Width        := 150
      oFrame:Height       := 60
      oFrame:Caption      := "Frame"
      oFrame:ToolTip      := oFrame:Type
      oFrame:aExcludeArea := { {10,25,140,45} }      // { {left,top,right,bottom} }

      oIp := TIpAddress():Define()
      oIp:Row     := 75
      oIp:Col     := 710
      oIp:Width   := 130
      oIp:Height  := 20
      oIp:Value   := { 1, 2, 3, 4 }
      oIp:ToolTip := oIp:Type                        // By design the tooltip only appears when the mouse is over the edge

      oProg := TProgressBar():Define()
      oProg:Row      := 130
      oProg:Col      := 700
      oProg:Width    := 150
      oProg:Height   := 20
      oProg:RangeMin := 0
      oProg:RangeMax := 100
      oProg:Value    := 50
      oProg:ToolTip  := oProg:Type

      oEdit := TEdit():Define()
      oEdit:Row     := 160
      oEdit:Col     := 700
      oEdit:Width   := 150
      oEdit:Height  := 60
      oEdit:Value   := "text"
      oEdit:ToolTip := oEdit:Type

      oRich := TEditRich():Define()
      oRich:Row     := 260
      oRich:Col     := 700
      oRich:Width   := 150
      oRich:Height  := 60
      oRich:Value   := "text"
      oRich:ToolTip := oRich:Type

      oList := TListMulti():Define()
      oList:Row     := 340
      oList:Col     := 700
      oList:Width   := 150
      oList:aItems  := {"one", "two", "three"}
      oList:ToolTip := oList:Type

      oSldr := TSlider():Define()
      oSldr:Row      := 470
      oSldr:Col      := 700
      oSldr:Width    := 100
      oSldr:Height   := 30
      oSldr:RangeMin := 0
      oSldr:RangeMax := 100
      oSldr:Value    := 30
      oSldr:OnChange := { || MsgInfo( "Value = " + hb_ntos( oSldr:Value ) ) }
      oSldr:ToolTip  := oSldr:Type

      oTimeP := TTimePick():Define()
      oTimeP:Row     := 510
      oTimeP:Col     := 700
      oTimeP:Value   := Time()
      oTimeP:ToolTip := oTimeP:Type + " - Linked to a " + TTimer():Type

      oTmr := TTimer():Define()
      oTmr:OnClick := { || oTimeP:Value := Time() }
      oTmr:Value := 1000

      oBtn2:SetFocus()

   oWnd:EndWindow()
   oWnd:Center()
   oWnd:Activate()

RETURN


PROCEDURE PrintForm

   PUBLIC aSer := { {14280, 20420, 12870, 25347,  7640}, ;
                    { 8350, 10315, 15870,  5347, 12340}, ;
                    {12345, -8945, 10560, 15600, 17610} }

   DEFINE WINDOW GraphTest OBJ oGraphTest ;
      AT 0,0 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Printing Bar Graphs" ;
      MODAL ;
      BACKCOLOR WHITE ;
      ON INIT DrawBarGraph( aser ) ;
      ON MOUSECLICK oGraphTest:Print()

   END WINDOW

   CENTER WINDOW GraphTest
   ACTIVATE WINDOW GraphTest

RETURN


PROCEDURE DrawBarGraph( aSer )

   ERASE WINDOW GraphTest

   DRAW GRAPH ;
      IN WINDOW GraphTest ;
      AT 20,20 ;
      TO 400,610 ;
      TITLE "Sales and Product" ;
      TYPE BARS ;
      SERIES aSer ;
      YVALUES {"Jan","Feb","Mar","Apr","May"} ;
      DEPTH 15 ;
      BARWIDTH 15 ;
      HVALUES 5 ;
      SERIENAMES {"Serie 1","Serie 2","Serie 3"} ;
      COLORS { {128,128,255}, {255,102,10}, {55,201,48} } ;
      3DVIEW ;
      SHOWGRID ;
      SHOWXVALUES ;
      SHOWYVALUES ;
      SHOWLEGENDS

RETURN 


PROCEDURE MoveCursor( oCtrl )

   oCtrl:Value := PadL( StrTran( Left( oCtrl:Value, 6 ), " ", "" ), 6 ) + Right( oCtrl:Value, 1 )
   oCtrl:CaretPos := 8

RETURN


#include "printtest.prg"

/*
 * EOF
 */
