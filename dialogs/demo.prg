
#include "oohg.ch"


Function Main()

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 320 HEIGHT 240 ;
		TITLE 'ooHG Common Dialog Demo' ;
		MAIN ;
		FONT 'Arial' SIZE 10

		DEFINE STATUSBAR
			STATUSITEM 'ooHG Power Ready!'
		END STATUSBAR

		DEFINE MAIN MENU
                        POPUP 'Common &Dialog Functions'
				ITEM 'GetFile()'  ACTION getfile_Click()
				ITEM 'PutFile()'  ACTION Putfile ( { {'Images','*.jpg'} } , 'Save Image' , 'C:\' )
				ITEM 'GetFont()'  ACTION GetFont_Click()
				ITEM 'GetColor()' ACTION GetColor_Click()
				ITEM 'GetFolder()' ACTION Getfolder_Click()
			END POPUP

			POPUP 'H&elp'
				ITEM 'About'		ACTION MsgInfo ("Free GUI Library For Harbour","ooHG Demo")
			END POPUP
		END MENU

	END WINDOW

	Form_1.Center()

	Form_1.Activate()

Return Nil

*-----------------------------------------------------------------------------
Procedure GetFolder_Click
*-----------------------------------------------------------------------------
local a:=GetFolder("Title")
if empty(a)
   msginfo("cancelled")
else
   msginfo(a)
endif
Return

*------------------------------------------------------------------------------*
Procedure Getfile_click
*------------------------------------------------------------------------------*
local a:=(Getfile ( { {'Images','*.jpg'} } , 'Open Image' ))
if empty(a)
   msginfo("cancelled")
else
  msginfo(a)
endif
return

*------------------------------------------------------------------------------*
Procedure GetColor_Click
*------------------------------------------------------------------------------*
Local Color

    Color := GetColor()

    if  Color[1] <> NIL
	AutoMsgInfo( (Color[1]) , "Red Value")
	AutoMsgInfo( (Color[2]) , "Green Value")
	AutoMsgInfo( (Color[3]) , "Blue Value")
    else
        Msginfo("cancelled")
    endif

Return
*------------------------------------------------------------------------------*
Procedure GetFont_Click
*------------------------------------------------------------------------------*
Local a

	a := GetFont ( 'Arial' , 12 , .t. , .t. , {0,0,255} , .f. , .f. , 0 )
	if empty ( a [1] )
           MsgInfo ('Cancelled')
	Else
		MsgInfo( a [1] + Str( a [2] ) )
		if  a [3]
			MsgInfo ("Bold")
		else
			MsgInfo ("Non Bold")
		endif

		if  a [4]
			MsgInfo ("Italic")
		else
			MsgInfo ("Non Italic")
		endif

		MsgInfo ( str( a [5][1]) +str( a [5][2]) +str( a [5][3]), 'Color' )

		if  a [6]
			MsgInfo ("Underline")
		else
			MsgInfo ("Non Underline")
		endif

		if  a [7]
			MsgInfo ("StrikeOut")
		else
			MsgInfo ("Non StrikeOut")
		endif

		MsgInfo ( str ( a [8] ) , 'Charset' )
	EndIf
Return
