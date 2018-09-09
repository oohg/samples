/* 13-01-2007 - Español  
	Español  
 Grid for Harbour + Oohg + MySql  
 Trabajo realizado sobre original de Novo Antonio   
         email: novoantonio@hotmail.com  
 Arreglos, Adaptacion y Agregados por Gustavo Carlos Asborno  
       email: gustavo@lahersistemas.com.ar   
 Nota:   
	1) Se arreglo bugs en el label de cabecera  
	2) Se agrego DATA aCampo para referenciar Columna del Select  
	3) Se agrego METHOD ejecutar(), para tener un ONCHANGE   
	4) Se agrego METHOD stabilize(), para el metodo Refresh  
	5) Se agrego METHOD MySeek, para realizar Busqueda en el area de trabajo  
  
	English  
  
 Grid for Harbour + Oohg + MySql  
 I work carried out on original of Novo Antonio   
         email: novoantonio@hotmail.com  
 Arrangements, Adaptation and Added for Gustavo Carlos Asborno  
       email: gustavo@lahersistemas.com.ar   
 He/she notices:   
	1) you fixes bugs in the head label  
	2) one adds it DATES I camp to index Column of the Select  
	3) one adds METHOD to execute (), to have an ONCHANGE   
	4) one adds METHOD stabilize (), for the method Refresh  
	5) one adds METHOD MySeek, to carry out Search in the workspace
*/	
*------------------------------------------------------------------------------
#include "HBClass.Ch"
#include "oohg.ch"

CLASS MyGrid FROM TControl
   DATA xxRow      INIT 0
   DATA yyCol      INIT 0
   DATA X          INIT 0
   DATA Y          INIT 0
   DATA WorkArea   INIT ""
   DATA Form1      INIT ""
   DATA Height     INIT 250
   DATA Width      INIT 300     //Still Not Implemented. Help Me !!!!!!
   DATA MaxRows    INIT 22
   DATA MaxCols    INIT 22
   DATA aFields    INIT {}
   DATA aHeads     INIT {}
   DATA HSpacing   INIT 1
   DATA VSpacing   INIT 1
   DATA HeightCell INIT 15
   DATA WidthCell  INIT {}
   DATA FontCell   INIT "Arial"
   DATA SizeCell   INIT 09
   DATA ColorCell  INIT {0,0,0}
   DATA BackColorCell          INIT {230, 230, 230}
   DATA AlternateBackColorCell INIT {255, 255, 255}
   DATA FontColorHead   INIT {255,255,255}
   DATA BackColorHead   INIT {0,0,0}
   DATA FontHead        INIT "Arial"
   DATA SizeHead        INIT 09
   DATA HeightHead      INIT 20
   DATA BackColorSelect INIT {0,0,255}
   DATA FontColorSelect INIT {255,255,255}
   DATA PosVSCroll      INIT 0
   DATA PosVSCroll      INIT 0
   DATA FirstRecno      INIT 0
   DATA LastRecno       INIT 0
   DATA Value           INIT 0
   DATA ActRowGridPos   INIT 0
   DATA aValRows        INIT {}
   DATA aCampo          INIT {}

   *-Properties of: "Reg: xx of: xx"
   DATA ShowRecnoNumber          INIT .F.
   DATA WidtRecnoNumber          INIT 120
   DATA HeightRecnoNumber        INIT 19
   DATA FontRecnoNumber          INIT "Arial"
   DATA SizeFontRecnoNumber      INIT 08
   DATA BackColorRecnoNumber     INIT {230, 230, 230}
   DATA FontColorRecnoNumber     INIT {0,0,0}

   *-Properties of: Navigate Control
   DATA ShowNavigate             INIT .F.
   DATA WidtNavigate             INIT 35
   DATA HeightNavigate           INIT 19
   DATA FontNavigate             INIT "Arial"
   DATA SizeFontNavigate         INIT 08
   DATA BackColorNavigate        INIT {170, 170, 190}
   DATA FontColorNavigate        INIT {0,0,240}
 
   METHOD New(xRow, yRow, xForm1, xWorkArea, xWidh, xHeight)
   METHOD NewColumn(xTitleCol,xCodeBlock,xSizeCol)
   METHOD Show()
   METHOD VSCRollMovement()
   METHOD Hilite(xRow)
   METHOD Refresh()
   METHOD PopulateGrid()
   METHOD Home()
   METHOD End()
   METHOD Prior()
   METHOD Next()
   METHOD Up()
   METHOD Down()
	 METHOD ejecutar()
	 METHOD stabilize()
	 METHOD mySeek()

ENDCLASS


METHOD New(xRow, yCol, xForm1, xWorkArea, xWidth, xHeight, change) CLASS MyGrid
    ::xxRow    := xRow
    ::yyCol    := yCol
    ::Form1    := xForm1
    ::WorkArea := xWorkArea
    ::Width    := xWidth
    ::Height   := xHeight
	  ASSIGN ::OnChange    VALUE change    TYPE "B"
    
RETURN self

*--------------------------------------------------------------------------------
METHOD NewColumn(xTitleCol,xCodeBlock,xSizeCol) CLASS MyGrid
    AADD(::aHeads,    xTitleCol)
    AADD(::aFields,   xCodeBlock)
    AADD(::WidthCell, xSizeCol)
RETURN self

*--------------------------------------------------------------------------------
*-Draw the Grid Control
*--------------------------------------------------------------------------------
METHOD Show() CLASS MyGrid
*----------------------------
    LOCAL clabel := "", acolor := {}, I := 0, J := 0
    ::MaxRows := INT( ( ::Height - ::HeightHead ) / ( ::HeightCell + ::HSpacing ) )

    ::X := ::xxRow
    ::Y := ::yyCol

    AADD(::WidthCell,60)
    AADD(::WidthCell,60)

    _DefineHotKey( ::Form1, 0, VK_HOME, { || ::Home() } )

    _DefineHotKey( ::Form1, 0, VK_END, { || ::End() } )

    _DefineHotKey( ::Form1, 0, VK_PRIOR, { || ::Prior() } )

    _DefineHotKey( ::Form1, 0, VK_NEXT, { || ::Next() } )

    _DefineHotKey( ::Form1, 0, VK_UP, { || ::Up() } )

    _DefineHotKey( ::Form1, 0, VK_DOWN, { || ::Down() } )
*    _DefineHotKey( ::Form1, 0, VK_RETURN, { || MsgBox(Str(::Value)) } )
    *---------------------------------------------------
    *-Header Table
    ::X := ::xxRow
    ::MaxCols := LEN(::aFields)
    ::aCampo := ARRAY(::MaxCols)
    FOR J := 1 TO ::MaxCols
      cLabel := "LABEL"+ALLTRIM(STR(0))+"_"+ALLTRIM(STR(J))
      
      DEFINE   LABEL &cLabel 
      	ROW ::X
      	COL ::Y 
        WIDTH ::WidthCell[J]
        HEIGHT ::HeightHead
        VALUE ::aHeads[J]
        FONTNAME ::FontHead
        FONTSIZE ::SizeHead
        BACKCOLOR ::BackColorHead
        FONTCOLOR ::FontColorHead
	    END LABEL
	    
      ::Y += ::WidthCell[J] + ::HSpacing
    NEXT
    ::X += ::HeightHead + ::VSpacing
    *----------------------------------------------------
    ::aValRows:= ARRAY(::MaxRows)
    Afill(::aValRows, 0)
    ::FirstRecno := IIF(::WorkArea:LastRec() > 0, 1, 0)
    ::LastRecno := IIF(::WorkArea:LastRec() > 0, ::WorkArea:LastRec(), 0)
    ::Value  := ::LastRecno
    ::ActRowGridPos := ::MaxRows
    *----------------------------------------------------
    *-Vertical ScrollBar
    DEFINE SLIDER VSCROLL 
    	ROW ::X
    	COL ::Y 
      WIDTH 15
      HEIGHT ( ::MaxRows * ::HeightCell ) 
      RANGEMIN ::FirstRecno 
      RANGEMAX::LastRecno
      VALUE 0 
      ON CHANGE ::VSCROLLMovement()
      vertical .t.
      NOTICKS .t.
      BOTH .t.
    END SLIDER  
   *----------------------------------------------------
    *-Body of Table
    FOR I := 1 TO ::MaxRows
        ::Y := ::yyCol
        FOR J := 1 TO ::MaxCols
            cLabel := "LABEL"+ALLTRIM(STR(I))+"_"+ALLTRIM(STR(J))
            aColor := IIF(I % 2 == 0,::AlternateBackColorCell,::BackColorCell)
            @ ::X, ::Y LABEL &cLabel;
                        VALUE "";
                        ACTION ::Hilite();
                        WIDTH ::WidthCell[J];
                        HEIGHT ::HeightCell;
                        FONT ::FontCell;
                        SIZE ::SizeCell;
                        BACKCOLOR aColor;
                        FONTCOLOR ::ColorCell
            ::Y += ::WidthCell[J] + ::HSpacing
        NEXT
        ::X += ::HeightCell + ::VSpacing
    NEXT
    ::Y := ::yyCol
    IF ::ShowRecnoNumber 
        @ ::X, ::Y LABEL ShowRecno VALUE "" ACTION ::Hilite() WIDTH ::WidtRecnoNumber;
               HEIGHT ::HeightRecnoNumber FONT ::FontRecnoNumber SIZE ::SizeFontRecnoNumber;
               BACKCOLOR ::BackColorRecnoNumber FONTCOLOR ::FontColorRecnoNumber
        ::Y += ::WidtRecnoNumber
    ENDIF
    IF ::ShowNavigate
        @ ::X, ::Y BUTTON First CAPTION "|<" ACTION { || ::Home() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Ir al Primer Registro"
        ::Y += ::WidtNavigate
        @ ::X, ::Y BUTTON Prior CAPTION "<<" ACTION { || ::Prior() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Atrás una Página"
        ::Y += ::WidtNavigate
        @ ::X, ::Y BUTTON Up CAPTION "<" ACTION { || ::Up() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Atrás un Registro"
        ::Y += ::WidtNavigate
        @ ::X, ::Y BUTTON Down CAPTION ">" ACTION { || ::Down() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Adelante un Registro"
        ::Y += ::WidtNavigate
        @ ::X, ::Y BUTTON Next CAPTION ">>" ACTION { || ::Next() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Adelante una Página"
        ::Y += ::WidtNavigate
        @ ::X, ::Y BUTTON Last  CAPTION ">|" ACTION { || ::End() } WIDTH ::WidtNavigate HEIGHT ::HeightNavigate FONT ::FontNavigate SIZE ::SizeFontNavigate TOOLTIP "Ir al Ultimo Registro"
    ENDIF
    ::Home()
    *----------------------------------------------------
RETURN self

*------------------------------------------------------------------------------
*-Hilite Actual Row
*------------------------------------------------------------------------------
METHOD Hilite(XRow) CLASS MyGrid
*---------------------------------
LOCAL cLabel := "", clabel2 := "", clabel3 := "", I := 0, J := 0, lData := .F.,oRow
    IF xRow == Nil
        cLabel3 := THIS.Name
    ELSE
        IF xRow == 0
            xRow := 1
        ENDIF
        cLabel3 := "LABEL"+ALLTRIM(STR(xRow))+"_"
    ENDIF
    cLabel3  := LEFT(cLabel3, AT("_",cLabel3))
    FOR I := 1 TO ::MaxRows
        cLabel := "LABEL"+ALLTRIM(STR(I))+"_"
        FOR J := 1 TO ::MaxCols            
            cLabel2  := LEFT(cLabel, AT("_",cLabel)) + ALLTRIM(STR(J))
            IF clabel == clabel3
                xRow := I
                ::Value := ::aValRows[I]
								oRow := ::WorkArea:GetRow(::value)
                ::aCampo[J]:=HB_ValToStr(oRow:FieldGet(::aFields[J]))
                _SetFontColor(clabel2, ::Form1, ::FontColorSelect)
                _SetBackColor(clabel2, ::Form1, ::BackColorSelect)
                IF ::ShowRecnoNumber
                    _SetValue("ShowRecno", ::Form1, "Reg: "+ALLTRIM(STR(::Value))+" de: "+ALLTRIM(STR(::LastRecno)))
                ENDIF
                _SetValue("VSCroll", ::Form1, ::Value)
            ELSE
                _SetFontColor(clabel2, ::Form1, ::ColorCell)
                _SetBackColor(clabel2, ::Form1, IIF(I % 2 == 0,::AlternateBackColorCell,::BackColorCell))
            ENDIF
        NEXT
    NEXT
    ::ejecutar()
    IF EMPTY(::aValRows[xRow])
        FOR I :=  ::MaxRows TO 1 STEP -1
            IF ::aValRows[I] <> 0
                lData := .T.
                ::Value  := ::aValRows[I]
                ::ActRowGridPos := I
                EXIT
            ENDIF
        NEXT
        IF lData
            ::Hilite(::ActRowGridPos)
        ENDIF
    ENDIF
RETURN self

*------------------------------------------------------------------------------
*-Move the Vertical Slider
*------------------------------------------------------------------------------
METHOD VSCROLLMovement() CLASS MyGrid
*---------------------------------------

RETURN self


*------------------------------------------------------------------------------
*-Go To First Record of Grid
*------------------------------------------------------------------------------
METHOD Home() CLASS MyGrid
*-------------------------
    LOCAL I := 0
    ::Value   := ::FirstRecno
    ::ActRowGridPos := 1
    Afill(::aValRows, 0)
    FOR I := 1 TO ::MaxRows
        IF ::Value <= ::LastRecno
            ::aValRows[I] := ::Value
        ELSE
            EXIT
        ENDIF
        ::Value ++
    NEXT
    ::PopulateGrid()
    ::Hilite(1)
RETURN self

*------------------------------------------------------------------------------
*-Go To Last Record of Grid
*------------------------------------------------------------------------------
METHOD End() CLASS MyGrid
*------------------------
    LOCAL I := 0, aTemp := ARRAY(LEN(::aValRows)), X := 0
    ::Value  := ::LastRecno
    ::ActRowGridPos := ::MaxRows
    Afill(::aValRows, 0)
    FOR I := 1 TO ::MaxRows
        IF ::Value <= ::LastRecno .AND. ::Value >= ::FirstRecno
            ::aValRows[::MaxRows-I+1] := ::Value
        ELSE
            EXIT
        ENDIF
        ::Value --
    NEXT
    IF I-1 < ::MaxRows
        Afill(aTemp, 0)
        FOR I := 1 TO LEN(::aValRows)            
            AADD(aTemp,::aValRows[I])
        NEXT
        AFILL(::aValRows,0)
        X := 0
        FOR I := 1 TO LEN(aTemp)
            IF aTemp[I] <> 0
                ::aValRows[++X] := aTemp[I]
                ::ActRowGridPos := X
                ::Value := aTemp[I]
            ENDIF
        NEXT
    ENDIF    
    ::PopulateGrid()
    ::Hilite(::ActRowGridPos)
RETURN self

*------------------------------------------------------------------------------
*-Go To Prior Page of Grid
*------------------------------------------------------------------------------
METHOD Prior() CLASS MyGrid
*--------------------------
    LOCAL I := 0
    IF ::Value == ::FirstRecno
        Return Self
    ENDIF
    Afill(::aValRows, 0)
    ::WorkArea:GetRow(::Value)
    FOR I := 1 TO ::MaxRows
        IF ::Value >= ::FirstRecno
            ::Value --
            ::aValRows[::MaxRows-I+1] := ::Value
        ELSE
            EXIT
        ENDIF
    NEXT
    IF I-1 == ::MaxRows
        ::Value := ::aValRows[1]
        ::ActRowGridPos := 1
        ::PopulateGrid()
        ::Hilite(1)
    ELSE
        ::Home()
    ENDIF
RETURN self

*------------------------------------------------------------------------------
*-Go To Next Page of Grid
*------------------------------------------------------------------------------
METHOD Next() CLASS MyGrid
*-------------------------
    LOCAL I := 0
    IF ::Value == ::LastRecno
        Return Self
    ENDIF
    Afill(::aValRows, 0)
    ::WorkArea:GetRow(::Value)
    FOR I := 1 TO ::MaxRows
        IF ::Value < ::LastRecno
            ::Value ++
            ::aValRows[I] := ::Value
        ELSE
            EXIT
        ENDIF
    NEXT
    IF I-1 == ::MaxRows
        ::ActRowGridPos := ::MaxRows
        ::PopulateGrid()
        ::Hilite(::MaxRows)
    ELSE
        ::End()
    ENDIF
RETURN self

*------------------------------------------------------------------------------
*-Up One Row of Grid
*------------------------------------------------------------------------------
METHOD Up() CLASS MyGrid
*--------------------------
    LOCAL POS := 0, I := 0
    IF ::Value == ::FirstRecno
        Return Self
    ENDIF
    IF (POS := ASCAN(::aValRows, ::Value)) <> 0
        IF --POS > 0
            IF  ::aValRows[POS] <> 0
                ::Value := ::aValRows[POS]
                ::Hilite(POS)
            ENDIF
        ELSE
            POS := ::aValRows[1] - 1
            IF POS >= ::FirstRecno
                FOR I := LEN(::aValRows) TO 2 STEP -1
                    ::aValRows[I] := ::aValRows[I-1]
                NEXT
                ::aValRows[1] := POS
                ::Value := ::aValRows[1]
                ::PopulateGrid()
                ::Hilite(1)
            ENDIF
        ENDIF
    ENDIF
RETURN self

*------------------------------------------------------------------------------
*-Down One Row of Grid
*------------------------------------------------------------------------------
METHOD Down() CLASS MyGrid
*----------------------------
    LOCAL POS := 0, I := 0
    IF ::Value == ::LastRecno
        Return Self
    ENDIF
    IF (POS := ASCAN(::aValRows, ::Value)) <> 0
        IF ++POS <= LEN(::aValRows)
            IF  ::aValRows[POS] <> 0
                ::Value := ::aValRows[POS]
                ::Hilite(POS)
            ENDIF
        ELSE
            POS := ::aValRows[LEN(::aValRows)] + 1
            IF POS <= ::LastRecno
                FOR I := 2 TO LEN(::aValRows)
                    ::aValRows[I-1] := ::aValRows[I]
                NEXT
                ::aValRows[LEN(::aValRows)] := POS
                ::Value := ::aValRows[LEN(::aValRows)]
                ::PopulateGrid()
                ::Hilite(::MaxRows)
            ENDIF
        ENDIF
    ENDIF        
RETURN self

*------------------------------------------------------------------------------
*-Populate Grid
*------------------------------------------------------------------------------
METHOD PopulateGrid() CLASS MyGrid
*---------------------------------
    LOCAL j := 1, i := 1, clabel := "", oRow := ""
    FOR I := 1 TO ::MaxRows
        FOR J := 1 TO ::MaxCols
            cLabel := "LABEL"+ALLTRIM(STR(I))+"_"+ALLTRIM(STR(J))
            IF .NOT. EMPTY(::aValRows[I])
               oRow := ::WorkArea:GetRow(::aValRows[I])
               _SetValue(clabel, ::Form1, HB_ValToStr(oRow:FieldGet(::aFields[J])))
            ELSE
                _SetValue(clabel, ::Form1, "")
            ENDIF
        NEXT
    NEXT
RETURN self
*------------------------------------------------------------------------------
* To execute a function
*------------------------------------------------------------------------------
METHOD ejecutar() CLASS MyGrid
::doevent(::OnChange)
*------------------------------------------------------------------------------
*-Refresh Grid (Not Terminated Yet)
*------------------------------------------------------------------------------
METHOD Refresh(xWorkArea) CLASS MyGrid
*----------------------------
Local cLabel := "", clabel2 := "", clabel3 := "", I := 0, J := 0, lData := .F.
Local actreg:=str(ASCAN(::aValRows, ::Value))

	    ::WorkArea := xWorkArea
			::stabilize(ASCAN(::aValRows, ::Value))

*------------------------------------------------------------------------------
* Used method for Refresh
*------------------------------------------------------------------------------
METHOD stabilize(XRow) CLASS MyGrid
LOCAL cLabel := "", clabel2 := "", clabel3 := "", I := 0, J := 0, lData := .F.,oRow
    IF xRow == Nil
        cLabel3 := THIS.Name
    ELSE
        IF xRow == 0
            xRow := 1
        ENDIF
        cLabel3 := "LABEL"+ALLTRIM(STR(xRow))+"_"
    ENDIF
    cLabel3  := LEFT(cLabel3, AT("_",cLabel3))
    FOR I := 1 TO ::MaxRows
        cLabel := "LABEL"+ALLTRIM(STR(I))+"_"
        FOR J := 1 TO ::MaxCols            
            cLabel2  := LEFT(cLabel, AT("_",cLabel)) + ALLTRIM(STR(J))
            IF clabel == clabel3
                xRow := I
                ::Value := ::aValRows[I]
								oRow := ::WorkArea:GetRow(::value)
                ::aCampo[J]:=HB_ValToStr(oRow:FieldGet(::aFields[J]))
                _SetFontColor(clabel2, ::Form1, ::FontColorSelect)
                _SetBackColor(clabel2, ::Form1, ::BackColorSelect)
		            _SetValue(clabel2, ::Form1, ::aCampo[J])
                IF ::ShowRecnoNumber
                    _SetValue("ShowRecno", ::Form1, "Reg: "+ALLTRIM(STR(::Value))+" de: "+ALLTRIM(STR(::LastRecno)))
                ENDIF
                _SetValue("VSCroll", ::Form1, ::Value)
            ELSE
                _SetFontColor(clabel2, ::Form1, ::ColorCell)
                _SetBackColor(clabel2, ::Form1, IIF(I % 2 == 0,::AlternateBackColorCell,::BackColorCell))
            ENDIF
        NEXT
    NEXT
    ::ejecutar()
    IF EMPTY(::aValRows[xRow])
        FOR I :=  ::MaxRows TO 1 STEP -1
            IF ::aValRows[I] <> 0
                lData := .T.
                ::Value  := ::aValRows[I]
                ::ActRowGridPos := I
                EXIT
            ENDIF
        NEXT
        IF lData
            ::Hilite(::ActRowGridPos)
        ENDIF
    ENDIF
RETURN self
*------------------------------------------------------------------------------
/* METHOD Seek(acampo,atext)
   lcampo Position in the select of the field  
   Atext search reference  
*/
*------------------------------------------------------------------------------
METHOD mySeek( campo, atext,xworkarea) CLASS MyGrid
Local maxseek:=::LastRecno, lcampo:='',lbus:=len(atext), lcount:=0, ldat:=.f., I:=0
  ::WorkArea := xWorkArea
  FOR J := 1 TO maxseek
		oRow := ::WorkArea:GetRow(J)
    lcampo:=HB_ValToStr(oRow:FieldGet(::aFields[campo]))
		if substr(lcampo,1,lbus)==ALLTRIM(atext)
				ldat:=.t.
			::value=J-1
	    IF ::Value == ::LastRecno
        Return Self
  	  ENDIF
    	Afill(::aValRows, 0)
	    ::WorkArea:GetRow(::Value)
  	  FOR I := 1 TO ::MaxRows
        IF ::Value < ::LastRecno
            ::Value ++
            ::aValRows[I] := ::Value
        ELSE
            EXIT
        ENDIF
    	NEXT
	    IF I-1 == ::MaxRows
        ::ActRowGridPos := ::MaxRows
        ::PopulateGrid()
        ::Hilite(1)
  	  ELSE
        ::End()
    	ENDIF
			EXIT
		ENDIF
	Next
	if !ldat
		msgstop('Objeto no encontrado')
	endif

return self