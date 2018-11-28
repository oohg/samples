/*
 * MainDemoAlt
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create controls using
 * alternative syntax.
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
#include "i_graph.ch"

PROCEDURE Main

   SET CENTURY ON
   SET TOOLTIPSTYLE BALLOON
   SET TOOLTIPBACKCOLOR AQUA
   SET TOOLTIPFORECOLOR NAVY
   SET AUTOADJUST ON

   DEFINE WINDOW 0 ;
      OBJ oWnd ;
      MAIN ;
      AT 0, 0 ;
      WIDTH 900 ;
      HEIGHT 600 ;
      TITLE "OOHG - Main Demo - Alternative Syntax Version" ;
      ON MOUSECLICK MsgInfo( Str( _OOHG_MouseRow ) + Str( _OOHG_MouseCol ) ) ;
      NOTIFYICON "ZZZ_AAAOOHG" ;
      NOTIFYTOOLTIP "OOHG - Main Demo - OOP Version" ;
      ON NOTIFYCLICK ( oWnd:Restore(), oWnd:Flash( FLASHW_ALL, 6 ) )

      DEFINE STATUSBAR OBJ oStat
         STATUSITEM "This is the first items of the statusbar." ACTION MsgInfo( "Statusbar's first item clicked !" )
         CLOCK ACTION MsgInfo( "Statusbar's clock clicked !" )
      END STATUSBAR
      oStat:ToolTip := oStat:Type

      oWnd:Height -= oStat:ClientHeightUsed

      ON KEY ESCAPE ACTION oWnd:Release

      DEFINE TOOLBAR Toolbr OBJ oTlBar BUTTONSIZE 50,20
         BUTTON TBN1 CAPTION "Button 1" ACTION MsgInfo( "Toolbar's button 1 clicked !" )
         BUTTON TBN2 CAPTION "Button 2" ACTION MsgInfo( "Toolbar's button 2 clicked !" ) DROPDOWN
      END TOOLBAR
      oTlBar:ToolTip := oTlBar:Type

      DEFINE DROPDOWN MENU BUTTON TBN2
         ITEM "Tool 1" ACTION MsgInfo( "Tool 1" )
         ITEM "Tool 2" ACTION MsgInfo( "Tool 2" )
      END MENU

      DEFINE MAIN MENU OBJ oMenuM NAME "MyMenu"
         POPUP "One" 
            ITEM "1.1" ACTION MsgInfo( "Menu 1.1" ) NAME "Menu1" CHECKED
            POPUP "1.2" 
               ITEM "1.2.1" ACTION MsgInfo( "Menu 1.2.1" )
               SEPARATOR
               POPUP "1.2.2" 
                  ITEM "1.2.2.1" ACTION MsgInfo( "Menu 1.2.2.1" )
                  ITEM "1.2.2.2" ACTION MsgInfo( "Menu 1.2.2.2" )
                  ITEM "1.2.2.3" ACTION MsgInfo( "Menu 1.2.2.3" )
               END POPUP
               ITEM "1.2.3" ACTION MsgInfo( "Menu 1.2.3" )
            END POPUP
            ITEM "1.3" ACTION MsgInfo( "Menu 1.3" )
         END POPUP
         POPUP "Two"
            ITEM "2.1" ACTION MsgInfo( "Menu 2.1" )
            ITEM "2.2" ACTION MsgInfo( "Menu 2.2" )
            ITEM "2.3" ACTION MsgInfo( "Menu 2.3" )
         END POPUP
         ITEM "Data" ACTION MsgInfo( "Menu Data" ) NAME "Menu2" DISABLED
         POPUP "Three"
            ITEM "3.1" ACTION MsgInfo( "Menu 3.1" )
            ITEM "3.2" ACTION MsgInfo( "Menu 3.2" )
            ITEM "3.3" ACTION MsgInfo( "Menu 3.3" )
         END POPUP
         ITEM "Exit" ACTION oWnd:Release()
      END MENU

   /*--------------------------------------  GROUP 1  --------------------------------------*/

      PRIVATE oHlink
      DEFINE HYPERLINK 0
         OBJECT oHlink
         ROW 50
         COL 10
         AUTOSIZE .T.
         CAPTION "Object Oriented (x)Harbour GUI"
         ADDRESS "https://oohg.github.io/"
         HEIGHT 20
         HANDCURSOR .T.
      END HYPERLINK
      oHlink:ToolTip := oHlink:Type

      PRIVATE oTxt1
      DEFINE TEXTBOX 0
         OBJECT oTxt1
         ROW 80
         COL 10
         WIDTH 150
         HEIGHT 20
         VALUE "This is a TEXTBOX !"
         BACKCOLOR { GetRed( GetSysColor( COLOR_3DFACE ) ), GetGreen( GetSysColor( COLOR_3DFACE ) ), GetBlue( GetSysColor( COLOR_3DFACE ) ) }
      END TEXTBOX
      oTxt1:ToolTip := oTxt1:Type

      PRIVATE oImg
      DEFINE IMAGE 0
         OBJECT oImg
         ROW 80
         COL 180
         IMAGESIZE .T.
         PICTURE "ZZZ_AAAOOHG"
      END IMAGE
      oImg:ToolTip := oImg:Type

      PRIVATE oTxt2
      DEFINE TEXTBOX 0
         OBJECT oTxt2
         ROW 110
         COL 10
         WIDTH 150
         HEIGHT 20
         AUTOSKIP .T.
         INPUTMASK "@R 999-99-999-99-!!-!!!!"
         VALUE "0940100101000000"
      END TEXTBOX
      oTxt2:ToolTip := oTxt2:Type

      PRIVATE oPic
      DEFINE PICTURE 0
         OBJECT oPic
         ROW 120
         COL 180
         IMAGESIZE .T.
         PICTURE "ZZZ_AAAOOHG"
      END PICTURE
      oPic:ToolTip := oPic:Type

      PRIVATE oLbl3
      DEFINE LABEL 0
         OBJECT oLbl3
         ROW 140
         COL 10
         HEIGHT 20
         VALUE "Press '-'"
         AUTOSIZE .T.
      END LABEL
      oLbl3:ToolTip := oLbl3:Type

      PRIVATE oTxt3
      DEFINE TEXTBOX 0
         OBJECT oTxt3
         ROW 140
         COL 60
         WIDTH 100
         HEIGHT 20
         PICTURE "@R 999.999-9"
         VALUE "1234567"
         RIGHT .T.
         ONLOSTFOCUS MoveCursor( oTxt3 )
      END TEXTBOX
      oTxt3:ToolTip := oTxt3:Type + " - Char"

      PRIVATE oTxt4
      DEFINE TEXTBOX 0
         OBJECT oTxt4
         ROW 170
         COL 10
         WIDTH 100
         HEIGHT 20
         INPUTMASK "999,999.99"
         VALUE 111.5
         NUMERIC .T.
      END TEXTBOX
      oTxt4:ToolTip := oTxt4:Type + " - Numeric"

      PRIVATE oTxt5
      DEFINE TEXTBOX 0
         OBJECT oTxt5
         ROW 170
         COL 120
         WIDTH 100
         HEIGHT 20
         VALUE 111.5                              // Control only supports integer numbers
         NUMERIC .T.
      END TEXTBOX
      oTxt5:ToolTip := oTxt5:Type

      PRIVATE oTxt6
      DEFINE TEXTBOX 0
         OBJECT oTxt6
         ROW 200
         COL 10
         WIDTH 150
         HEIGHT 20
         VALUE Date()
      END TEXTBOX
      oTxt6:ToolTip := oTxt6:Type + " - Date"

      PRIVATE oChk1
      DEFINE CHECKBOX 0
         OBJECT oChk1
         ROW 230
         COL 10
         CAPTION "I have an OnChange event !"
         VALUE .T.
         ONCHANGE MsgInfo( "On Change fired !" )
         AUTOSIZE .T.
      END CHECKBOX
      oChk1:ToolTip := oChk1:Type

      PRIVATE oBtn1
      DEFINE BUTTON 0
         OBJECT oBtn1
         ROW 260
         COL 10
         CAPTION "BUTTON"
         ACTION MsgInfo( oTxt2:Value )
      END BUTTON
      oBtn1:ToolTip := oBtn1:Type + " - See what happens when you click or right click me."

      PRIVATE oBtnChk1
      DEFINE CHECKBUTTON 0
         OBJECT oBtnChk1
         ROW 260
         COL 130
         CAPTION "CheckButton"
         ON CHANGE MsgInfo( "Control's value is " + iif( oBtnChk1:Value, ".T.", ".F." ) )
      END CHECKBUTTON
      oBtnChk1:ToolTip := oBtnChk1:Type + " - Click to see my value."

      DEFINE CONTEXT MENU CONTROL ( oBtn1 )
         POPUP "Btn menu 1"
            ITEM "Btn menu 1.1" ACTION MsgInfo( "Btn menu 1.1 !" )
            ITEM "Btn menu 1.2" ACTION MsgInfo( "Btn menu 1.2 !" )
         END POPUP
         POPUP "Btn menu 2"
            ITEM "Btn menu 2.1" ACTION MsgInfo( "Btn menu 2.1 !" )
            ITEM "Btn menu 2.2" ACTION MsgInfo( "Btn menu 2.2 !" )
         END POPUP
      END MENU

      PRIVATE oSpin
      DEFINE SPINNER 0
         OBJECT oSpin
         ROW 290
         COL 10
         WIDTH 120
         HEIGHT 20
         RANGEMIN 0
         RANGEMAX 100
      END SPINNER
      oSpin:ToolTip := oSpin:Type

      PRIVATE oMcl
      DEFINE MONTHCALENDAR 0
         OBJECT oMcl
         ROW 320
         COL 10
         VALUE Date()
      END MONTHCALENDAR
      oMcl:ToolTip := oMcl:Type

      PRIVATE oProgm
      DEFINE PROGRESSMETER 0
         OBJECT oProgm
         ROW 500
         COL 10
         WIDTH 120
         HEIGHT 20
         VALUE 75
         CLIENTEDGE .T.
      END PROGRESSMETER
      oProgm:ToolTip := oProgm:Type

      PRIVATE oDateP
      DEFINE DATEPICKER 0
         OBJECT oDateP
         ROW 500
         COL 150
         VALUE Date()
      END DATEPICKER
      oDateP:ToolTip := oDateP:Type

   /*--------------------------------------  GROUP 2  --------------------------------------*/

      PRIVATE oGrid1
      DEFINE GRID 0
         OBJECT oGrid1
         ROW 40
         COL 260
         WIDTH 200
         HEIGHT 120
         HEADERS { "ONE", "TWO", "THREE" } 
         WIDTHS { 45, 45, 45 } 
         ITEMS { { "1", "2", "3" }, { "A", "@", "C" }, { "x", "y", "z" } } 
         JUSTIFY { GRID_JTFY_RIGHT, GRID_JTFY_CENTER, GRID_JTFY_LEFT } 
         FONTCOLOR ORANGE
         DYNAMICBACKCOLOR { GREEN, NIL, RED } 
         DYNAMICFORECOLOR { NIL, YELLOW, NIL } 
         ON HEADCLICK { { || oGrid1:ToExcel() }, { || NIL }, { || NIL } }
      END GRID
      oGrid1:ToolTip := oGrid1:Type

      DEFINE CONTEXT MENU CONTROL ( oGrid1 )
         ITEM "Change Colors" ACTION oGrid1:RefreshColors( { BLACK, BLACK, BLACK }, { AQUA, AQUA, AQUA } )
      END MENU

      DEFINE TAB Tab1 OBJ oTab1 AT 170,260 WIDTH 200 HEIGHT 120
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
      oTab1:ToolTip := oTab1:Type             // It shows only when the cursor hovers the tabs

      PRIVATE oCombo
      DEFINE COMBOBOX 0
         OBJECT oCombo
         ROW 310
         COL 300
         WIDTH 120
         ITEMS { "One", "Two", "Three" }
      END COMBOBOX
      oCombo:ToolTip := oCombo:Type

      DEFINE WINDOW IntWin OBJ oInternal AT 350,300 WIDTH 120 HEIGHT 100 INTERNAL VIRTUAL WIDTH 200 VIRTUAL HEIGHT 150
         @ 10, 010 LABEL LabelRed   VALUE "A" WIDTH 50 HEIGHT 100 BACKCOLOR RED TOOLTIP "TLabel inside TFormInternal" CENTER
         @ 10, 060 LABEL LabelGreen VALUE "B" WIDTH 50 HEIGHT 100 BACKCOLOR GREEN TOOLTIP "TLabel inside TFormInternal" CENTER
         @ 10, 110 LABEL LabelBlue  VALUE "C" WIDTH 50 HEIGHT 100  BACKCOLOR BLUE TOOLTIP "TLabel inside TFormInternal" CENTER
      END WINDOW

      PRIVATE oRad
      DEFINE RADIOGROUP 0
         OBJECT oRad
         ROW 460
         COL 300
         OPTIONS { "One", "Two", "Three" }
      END RADIOGROUP
      oRad:ToolTip := oRad:Type + " - Group tooltip"
      oRad:aOptions[1]:FontColor := RED
      oRad:aOptions[2]:Col       := 320
      oRad:aOptions[2]:ToolTip   := oRad:aOptions[2]:Type + " - Item tooltip"
      oRad:aOptions[3]:Col       := 340
      oRad:aOptions[3]:BackColor := BLUE

   /*--------------------------------------  GROUP 3  --------------------------------------*/

      PRIVATE oLabel
      DEFINE LABEL 0
         OBJECT oLabel
         ROW 40
         COL 500
         AUTOSIZE .T.
         CAPTION "(F5) Hello !"
         ACTION MsgInfo( "Clicked !" )
      END LABEL
      oLabel:ToolTip := oLabel:Type + " - I have an Action event !"

      ON KEY F5 ACTION MsgInfo( Str( oLabel:Row  ) + Str( oLabel:Col ), "Hello window" )

      DEFINE TREE Tree_1 OBJ oTree AT 80,500 WIDTH 150 HEIGHT 200 VALUE 15
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
      oTree:ToolTip := oTree:Type

      PRIVATE oBtn2
      DEFINE BUTTON 0
         OBJECT oBtn2
         ROW 300
         COL 500
         WIDTH 150
         HEIGHT 100
         PICTURE "MINIGUI_EDIT_OK"
         ACTION PrintForm()
      END BUTTON
      oBtn2:ToolTip := oBtn2:Type + " - Click me to see a Graph demo"

      PRIVATE oBtn3
      DEFINE BUTTON 0
         OBJECT oBtn3
         ROW 420
         COL 500
         WIDTH 150
         HEIGHT 100
         PICTURE "MINIGUI_EDIT_NEW"
         ACTION Test()
      END BUTTON
      oBtn3:ToolTip := oBtn3:Type + " - Click me to see a TPrint demo"

   /*--------------------------------------  GROUP 4  --------------------------------------*/

      PRIVATE oFrame
      DEFINE FRAME 0
         OBJECT oFrame
         ROW 50
         COL 700
         WIDTH 150
         HEIGHT 60
         CAPTION "Frame"
         EXCLUDEAREA { {10,25,140,45} }      // { {left,top,right,bottom} }
      END FRAME
      oFrame:ToolTip := oFrame:Type

      PRIVATE oIp
      DEFINE IPADDRESS 0
         OBJECT oIp
         ROW 75
         COL 710
         WIDTH 130
         HEIGHT 20
         VALUE { 255, 255, 255, 255 }
      END IPADDRESS
      oIp:ToolTip := oIp:Type                // By design the tooltip only appears when the mouse is over the edge

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

RETURN NIL


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
