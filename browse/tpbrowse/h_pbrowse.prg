/*
 * $Id: tp_browse.prg,v 1.1
 */
/*
 * PBrowse definitions
 *
 * Copyright 2018 Jacek Pospischil <praskiso/[at/]o2/[dot/]pl>
 *
 * Portions of this project are based upon Object Oriented (x)Harbour GUI.
 * Copyright 2005-2018, https://oohg.github.io/
 */
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file LICENSE.txt. If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1335, USA (or download from http://www.gnu.org/licenses/).
 *
 * As a special exception, the copyright holder gives permission for
 * additional uses of the code contained in this file.
 *
 * The exception is that, if you link this file with other files to produce
 * an executable, this does not by itself cause the resulting executable to
 * be covered by the GNU General Public License. Your use of that executable
 * is in no way restricted on account of linking this code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to this code. If you copy code from other
 * project along this file, as the General Public License permits, the
 * exception does not apply to the code that you add in this way.
 * To avoid misleading anyone as to the status of such modified files,
 * you must delete this exception notice from them.
 *
 * If you write modifications of your own for this file, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 */


#include "oohg.ch"
#include "hbclass.ch"
#include "i_windefs.ch"

#define GO_TOP    -1
#define GO_BOTTOM  1

CLASS TPBrowse FROM TOBrowse

   DATA Type                      INIT "PBROWSE" READONLY
   DATA DbCondition               INIT '.t.'
   DATA AddDbCon                  INIT ''
   DATA Seek_db                   INIT ''
   DATA Seek1_db                  INIT ''
   DATA DbFunc                    INIT ''
   DATA RecHome                   INIT 0 PROTECTED
   DATA BarCode                   INIT '' PROTECTED
   DATA BarCodeBuff               INIT '' PROTECTED
   DATA MaxLenBarCode             INIT 13
   DATA MinLenBarCode             INIT 8
   DATA MSBarCode                 INIT 200
   DATA TimeBarCode               INIT 0 PROTECTED
   DATA ActiveBarCode             INIT .f.
   DATA BarCodeFunc               INIT nil
   DATA SearchClmn                INIT 0
   DATA SearchTextBox             INIT nil
   DATA aSearch                   INIT {}
   DATA SearchStatus              INIT 0 PROTECTED
   DATA MessNotFound              INIT 'Item not found !!!'
   DATA MessOutOfRange            INIT 'BarCode outside the currently selected item group'
   DATA SaveVScroll               INIT nil

   METHOD PageUp
   METHOD Home
   METHOD End
   METHOD TopBottom
   METHOD DbSkip
   METHOD DbGoTo
   METHOD Events
   METHOD Skip_db       
   METHOD DbFirstRow
   METHOD DbLastRow
   METHOD Refres2
   METHOD BarCodeSearch
   METHOD DbSearch
   METHOD GetBarCode

ENDCLASS

*------------------------------------------------------------------------------*
METHOD PageUp() CLASS TPBrowse
*------------------------------------------------------------------------------*
Local _RecNo, cWorkArea

   if ::CurrentRow == 1
      cWorkArea := ::WorkArea
      If Select( cWorkArea ) == 0
         ::RecCount := 0
         Return Self
      EndIf
      _RecNo := ( cWorkArea )->( RecNo() )
      if Len( ::aRecMap ) == 0
         ::TopBottom( GO_TOP )
        else
         ::DbGoTo( ::aRecMap[ 1 ] )
      endIf

      ::DbSkip( - ::CountPerPage + 1 )
	  if ::Bof()
	    ::TopBottom( GO_TOP )
		_RecNo := ::RecHome
	  endif

      ::VScrollUpdate()
      ::Update()
      ::DbGoTo( _RecNo )
      ::CurrentRow := 1
    else
      ::FastUpdate( 1 - ::CurrentRow, 1 )
      ::BrowseOnChange()
   endIf

 //  ::BrowseOnChange()

Return Self

*------------------------------------------------------------------------------*
METHOD Home() CLASS TPBrowse                         // METHOD GoTop
*------------------------------------------------------------------------------*
Local _RecNo, cWorkArea

   cWorkArea := ::WorkArea
   If Select( cWorkArea ) == 0
      ::RecCount := 0
      Return Self
   EndIf
   _RecNo := ( cWorkArea )->( RecNo() )
   ::TopBottom( GO_TOP )
   ::VScrollUpdate()
   ::Update()
   ::DbGoTo( _RecNo )
   ::CurrentRow := 1
   ::RecHome := _RecNo 
   ::BrowseOnChange()

Return Self

*------------------------------------------------------------------------------*
METHOD End( lAppend ) CLASS TPBrowse                 // METHOD GoBottom
*------------------------------------------------------------------------------*
Local _RecNo, _BottomRec, cWorkArea

   cWorkArea := ::WorkArea
   If Select( cWorkArea ) == 0
      ::RecCount := 0
      Return Self
   EndIf
   _RecNo := ( cWorkArea )->( RecNo() )
   ::TopBottom( GO_BOTTOM )
   _BottomRec := ( cWorkArea )->( RecNo() )
   ::VScrollUpdate()

   // If it's for APPEND, leaves a blank line ;)
   ASSIGN lAppend VALUE lAppend TYPE "L" DEFAULT .F.
   ::DbSkip( - ::CountPerPage + IF( lAppend, 2, 1 ) )
   if ::Bof()
     ::TopBottom( GO_TOP )
     _RecNo := ::RecHome
   endif
   ::Update( 1, .F. )
   ::DbGoTo( _RecNo )
   ::CurrentRow := aScan( ::aRecMap, _BottomRec )

   ::BrowseOnChange()

Return Self

*------------------------------------------------------------------------------*
METHOD TopBottom( nDir ) CLASS TPBrowse
*------------------------------------------------------------------------------*
Local cWorkArea := ::WorkArea
Local _DbCondition := ::DbCondition

   If ::lDescending
      nDir := - nDir
   EndIf
   If nDir == GO_BOTTOM
      //( cWorkArea )->( DbGoBottom() )
	  ::DbLastRow()
   Else
      //( cWorkArea )->( DbGoTop() )
	  ::DbFirstRow()
   EndIf
   ::Bof := .F.
   ::Eof := ( cWorkArea )->( Eof() ) .or. !(&_DbCondition)

Return Self

*------------------------------------------------------------------------------*
METHOD DbSkip( nRows ) CLASS TPBrowse
*------------------------------------------------------------------------------*
Local cWorkArea := ::WorkArea
Local _DbCondition := ::DbCondition

   ASSIGN nRows VALUE nRows TYPE "N" DEFAULT 1
   if ! ::lDescending
      //( cWorkArea )->( DbSkip(   nRows ) )
	  ::Skip_db(nRows)
      ::Bof := ( cWorkArea )->( Bof() ) .or. !(&_DbCondition)
      ::Eof := ( cWorkArea )->( Eof() ) .or. !(&_DbCondition) .OR. ( ( cWorkArea )->( Recno() ) > ( cWorkArea )->( RecCount() ) )
   else
      //( cWorkArea )->( DbSkip( - nRows ) )
	  ::Skip_db(-nRows)
      if ( cWorkArea )->( Eof() ) .or. !(&_DbCondition)
         //( cWorkArea )->( DbGoBottom() )
		 ::DbLastRow()
         ::Bof := .T.
         ::Eof := ( cWorkArea )->( Eof() ) .or. !(&_DbCondition)
      elseIf ( cWorkArea )->( Bof() ) .or. !(&_DbCondition)
         ::Eof := .T.
         ::DbGoTo( 0 )
      endIf
   endif

return Self

*------------------------------------------------------------------------------*
METHOD DbGoTo( nRecNo ) CLASS TPBrowse
*------------------------------------------------------------------------------*
Local cWorkArea := ::WorkArea
Local _DbCondition := ::DbCondition

   ( cWorkArea )->( DbGoTo( nRecNo ) )
   ::Bof := .F.
   ::Eof := ( cWorkArea )->( Eof() ) .or. !(&_DbCondition) .OR. ( ( cWorkArea )->( Recno() ) > ( cWorkArea )->( RecCount() ) )

Return Self

*------------------------------------------------------------------------------*
METHOD Refres2() CLASS TPBrowse
*------------------------------------------------------------------------------*
   ::Refresh()
   ::BrowseOnChange()
Return Self

*------------------------------------------------------------------------------*
METHOD BarCodeSearch(kkey) CLASS TPBrowse
*------------------------------------------------------------------------------*
local _i,_fun,_reb
do case
   case kkey=13
   if len(::BarCodeBuff) < ::MinLenBarCode
     ::BarCodeBuff := ''
	 retu Self
   endi
   ::BarCode := ::BarCodeBuff
   ::BarCodeBuff := ''
   if !empty(::BarCodeFunc)
     _fun := ::BarCodeFunc
	 if type(_fun+'()') == 'UI'
	   _i := &_fun()
       do case
	      case _i=0
		  MsgInfo(::MessNotFound)
		 * 
		  case _i = -1
		  MsgInfo(::MessOutOfRange)
		 * 
		  case _i > 0
 	      _reb := ( ::WorkArea )->( RecNo() )
		  ::DbGoto(_i)
          ::VScrollUpdate()
          ::Update()
          ::DbGoTo( _reb )
          ::CurrentRow := 1
          ::BrowseOnChange()
	   endc
	 endif
   endif
  *
   case empty(::BarCodeBuff)
   ::BarCodeBuff := chr(kkey)
  *
   case HB_MilliSeconds() > ::TimeBarCode + ::MSBarCode
   ::BarCodeBuff := chr(kkey)
  *
   othe
   ::BarCodeBuff += chr(kkey)
endc
::TimeBarCode := HB_MilliSeconds()
retu Self

*-------------------------------------------------------------------------------*
METHOD DbSearch() class TPBrowse
*-------------------------------------------------------------------------------*
para _next
local _i,_l,_ctr
   if valtype(::SaveVScroll) = 'U'
     ::SaveVScroll := ::VScrollVisible
   endif
   if ::SearchTextBox != nil .or. ::SearchStatus > 0
     retu nil
   endif
   if type('_next') <> 'N'
     _next = 0
   endif
   if empty(::aSearch)
     return nil
   endif
   ::SearchStatus += 1
   _l := ::SearchClmn+_next
   if _l = 0 
     _l=1
   endif 
   ::SearchClmn := 0
   for _i := _l to len(::aSearch)
     if ::aSearch[_i,1] > 0
	   ::SearchClmn := _i
	   exit
	 endif
   next
   if ::SearchClmn = 0
     for _i := 1 to len(::aSearch)
       if ::aSearch[_i,1] > 0
	     ::SearchClmn := _i
	     exit
	   endif
     next
   endif
   if ::SearchClmn = 0
     ::SearchStatus -= 1
	 return nil
   endif
   resc := ListView_GetSubitemRect( ::hWnd, 0, ::SearchClmn-1 )
   _i := ::aSearch[::SearchClmn,1]
   if upper(::DbCondition) <> '.T.'
     ::DbCondition := '.t.'
	 ::Seek_db := ''
	 ::Seek1_db := ''
	 ::Home()
	 if !(::VScrollVisible) .and. ::SaveVScroll
	   ::Width += GetVScrollBarWidth()
	 endif
     ::VScrollVisible := ::SaveVScroll
   endif
   (::WorkArea)->(ordsetfocus(_i))
   ::Refres2()
   _ctr := GetControlObjectByHandle( GetFocus() )
   _obj := _ctr:parent
   if !hb_isobject(::SearchTextBox)
	 ::SearchTextBox := TtextPicture():Define('tx_search',_ctr,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,::aSearch[::SearchClmn,4])
   endif
   ::SearchTextBox:row   := resc[1] - ::ItemHeight() - ::HeaderHeight()
   ::SearchTextBox:col   := resc[2]
   ::SearchTextBox:width := resc[3]
   ::SearchTextBox:height:= 20
   ::SearchTextBox:nMaxLength := ::aSearch[::SearchClmn,2]
   ::SearchTextBox:Picture := ::aSearch[::SearchClmn,3]
   ::SearchTextBox:OnLostFocus := {||tx_release(::SearchTextBox,_ctr)}
   ::SearchTextBox:SetKey(VK_RETURN,0,{|| RunSearch(::SearchTextBox,_ctr),This:release(),_ctr:SearchTextBox := nil } )
   ::SearchTextBox:SetKey(VK_ESCAPE,0,{||::setfocus(),This:release(),_ctr:SearchTextBox := nil} )
   ::SearchTextBox:SetKey(VK_TAB,0,{|| ::setfocus(),This:release(),_ctr:SearchTextBox := nil,_ctr:DbSearch(1)} )
   ::SearchTextBox:setfocus()
   ::SearchStatus -= 1
return nil

*-------------------------------------------------------------------------------*
func textup
*-------------------------------------------------------------------------------*
para _klucz
retu subs(_klucz,1,len(_klucz)-1)+chr(asc(subs(_klucz,len(_klucz),1))+1)

*-------------------------------------------------------------------------------*
func tx_release
*-------------------------------------------------------------------------------*
para _obj,_obj2
    _obj:visible = .f.
    _obj:release()
    _obj2:setfocus()
	_obj2:SearchTextBox := nil
	retu nil

*-------------------------------------------------------------------------------*
function RunSearch
*-------------------------------------------------------------------------------*
para _obj,_obj2
local _i,_k,_ctr,_tx,_reb,_fun,_cnd
  if hb_isobject(_obj)
    if valtype(_obj2:SaveVScroll) = 'U'
	  _obj2:SaveVScroll := _obj2:VScrollVisible
	endif
    //_tx := polz(trim(_obj:value),5,StandPl)
	_tx :=trim(_obj:value)
    if empty(_tx)
	  tx_release(_obj,_obj2)
      return nil
    endif
    _obj2:setfocus()
    _k := _obj2:SearchClmn
	*
	* Search
	*
    _reb := (_obj2:Workarea)->(recno())
    _i := _obj2:aSearch[_k,1]
	_fun := _obj2:aSearch[_k,5]
    (_obj2:WorkArea)->(ordsetfocus(_i))
    _obj2:Refres2()
	if !empty(_fun)
	  _tx=&_fun(_tx)
	endif
	(_obj2:Workarea)->(dbseek(_tx))
	if (_obj2:Workarea)->(!found())
	  MsgInfo(_obj2:MessNotFound)
      _obj2:DbGoTo(_reb)
	  return nil
	endif
	_cnd := dod_alias((_obj2:WorkArea)->(indexkey(_i)),_obj2:WorkArea)+'="'+_tx+'"'
	if !DbAddCon(_obj2:AddDbCon,_obj2:DbFunc)
	  _obj2:Skip_db(1)
	endi
   	if (_obj2:Workarea)->(eof()) .or. !(&_cnd) .or. !DbAddCon(_obj2:AddDbCon,_obj2:DbFunc)
	  MsgInfo(_obj2:MessNotFound)
      _obj2:DbGoTo(_reb)
	  return nil
	endif
	_obj2:DbCondition := _cnd
	_obj2:Seek_db := _tx
	_obj2:Seek1_db := textup(_tx)
	_obj2:Home()
	if upper(_obj2:DbCondition) = '.T.'
      if !(_obj2:VScrollVisible) .and. _obj2:SaveVScroll
	    _obj2:Width += GetVScrollBarWidth()
	  endif
      _obj2:VScrollVisible := _obj2:SaveVScroll
	 else
      if _obj2:VScrollVisible
	    _obj2:Width -= GetVScrollBarWidth()
	  endif
	  _obj2:VScrollVisible := .f.
	endif  
	_obj2:Refres2()
  endi
return nil

*-------------------------------------------------------------------------------*
func DbAddCon
*-------------------------------------------------------------------------------*
para _addcon, _addfun
if empty(_addcon)
  retu .t.
endi
if !empty(_addfun)
  do &_addfun
endi  
retu &_addcon

*-------------------------------------------------------------------------------*
func sort_brw
*-------------------------------------------------------------------------------*
para _ix
local _obj := GetControlObjectByHandle( GetFocus() )
if hb_isobject(_obj)
  if upper(_obj:DbCondition)='.T.'
    (_obj:WorkArea)->(ordsetfocus(_ix))
     _obj:Refres2()
  endif
endif 
return nil

*-------------------------------------------------------------------------------*
func dod_alias
*-------------------------------------------------------------------------------*
para _klcz,_al
local _i,_j,_k,_tx,_zwr,_pole
_zwr = ''
_tx = _klcz
_k = 0
do whil !empty(_tx)
  _i=at('+',_tx)
  if _i=0
    _i=len(_tx)  
  endif
  _k += _i
  _pole = subs(_tx,1,_i)
  _j=rat('(',_pole)
  if _j>0
	_zwr += subs(_pole,1,_j)+_al+'->'+subs(_pole,_j+1)
   else
	_zwr += _al+'->'+_pole
  endif
  _tx = subs(_klcz,_k+1)
endd
retu _zwr

*------------------------------------------------------------------------------*
METHOD Events( hWnd, nMsg, wParam, lParam ) CLASS TPBrowse
*------------------------------------------------------------------------------*
Local cWorkArea, _RecNo, nRow, uGridValue, aCellData, aPos, resc

   do case
   case ::ActiveBarCode .and. (nMsg == WM_CHAR .or. nMsg == WM_GETDLGCODE .and. wParam=13 .and. !empty(::BarCodeBuff) .and. HB_MilliSeconds() <= ::TimeBarCode + ::MSBarCode)
      ::BarCodeSearch(wParam)
      return 0
   case nMsg == WM_CHAR
      if wParam < 32
         ::cText := ""
         Return 0
       elseif empty( ::cText )
         ::uIniTime := HB_MilliSeconds()
         ::cText := Upper( Chr( wParam ) )
       elseif HB_MilliSeconds() > ::uIniTime + ::SearchLapse
         ::uIniTime := HB_MilliSeconds()
         ::cText := Upper( Chr( wParam ) )
       else
         ::uIniTime := HB_MilliSeconds()
         ::cText += Upper( Chr( wParam ) )
      endif
      if ::SearchCol < 1 .OR. ::SearchCol > ::ColumnCount
         Return 0
      endif
      cWorkArea := ::WorkArea
      if Select( cWorkArea ) == 0
         return 0
      endIf
      _RecNo := ( cWorkArea )->( RecNo() )
      nRow := ::Value
      if nRow == 0
         if Len( ::aRecMap ) == 0
            ::TopBottom( GO_TOP )
         else
           ::DbGoTo( ::aRecMap[ 1 ] )
         endif
         if ::Eof()
           ::DbGoTo( _RecNo )
           Return 0
         endif
         nRow := ( cWorkArea )->( RecNo() )
      endif
      ::DbGoTo( nRow )
      ::DbSkip()
      do while ! ::Eof()
         if ::FixBlocks()
            uGridValue := Eval( ::aColumnBlocks[ ::SearchCol ], cWorkArea )
         else
            uGridValue := Eval( ::ColumnBlock( ::SearchCol ), cWorkArea )
         endif
         if ValType( uGridValue ) == "A"      // TGridControlImageData
            uGridValue := uGridValue[ 1 ]
         endif
         if upper( left( uGridValue, len( ::cText ) ) ) == ::cText
            exit
         endif
         ::DbSkip()
      enddo
      if ::Eof() .AND. ::SearchWrap
         ::TopBottom( GO_TOP )
         do while ! ::Eof() .AND. ( cWorkArea )->( RecNo() ) != nRow
            if ::FixBlocks()
               uGridValue := Eval( ::aColumnBlocks[ ::SearchCol ], cWorkArea )
            else
               uGridValue := Eval( ::ColumnBlock( ::SearchCol ), cWorkArea )
            endif
            if ValType( uGridValue ) == "A"      // TGridControlImageData
               uGridValue := uGridValue[ 1 ]
            endIf
            if upper( left( uGridValue, len( ::cText ) ) ) == ::cText
               exit
            endif
            ::DbSkip()
         enddo
      endif
      if ! ::Eof()
         ::nRow := ( cWorkArea )->( RecNo() )
      endif
      ::DbGoTo( _RecNo )
      Return 0
   endcase

Return ::Super:Events( hWnd, nMsg, wParam, lParam )

*------------------------------------------------------------------------------*
METHOD Skip_db ( lWrs ) CLASS TPBrowse
*------------------------------------------------------------------------------*
local _skip:=if( lWrs>0,1,-1),cWorkArea := ::WorkArea
local _DbCondition := ::DbCondition
local _wardbpom := ::AddDbCon
local _fpomdb := ::DbFunc

do while lWrs <> 0
  (cWorkArea)->(DbSkip(_skip))
   if (cWorkArea)->(eof()).or.(cWorkArea)->(bof()).or.!(&_DbCondition)
    exit
  endif
  if !empty(_wardbpom)
    if !empty(_fpomdb)
      do &_fpomdb
    endif
    if !(&_wardbpom)
	  loop
	endif
  endif
  lWrs = lWrs - _skip
endd
retu Self

*------------------------------------------------------------------------------*
METHOD DbFirstRow ( ) CLASS TPBrowse
*------------------------------------------------------------------------------*
local cWorkArea := ::WorkArea
local _DbCondition := ::DbCondition
local _wardbpom := ::AddDbCon
local _seekdb := ::Seek_db
local _fpomdb := ::DbFunc

if empty(_seekdb)
  (cWorkArea)->(DbGoTop())
 else
  set softseek on
  (cWorkArea)->(DbSeek(_seekdb))
  set softseek off
endif
if !empty(_wardbpom)
  if !empty(_fpomdb)
    do &_fpomdb
  endif
  if !&_wardbpom
    ::Skip_db(1)
  endif
endif
::Bof := .F.
::Eof := .F.

retu Self

*------------------------------------------------------------------------------*
METHOD DbLastRow ( ) CLASS TPBrowse
*------------------------------------------------------------------------------*
local cWorkArea := ::WorkArea
local _DbCondition := ::DbCondition
local _wardbpom := ::AddDbCon
local _seek1db := ::Seek1_db
local _fpomdb := ::DbFunc

if empty(_seek1db)
  (cWorkArea)->(DbGoBottom())
 else
  set softseek on
  (cWorkArea)->(DbSeek(_seek1db))
  set softseek off

  if (cWorkArea)->(eof()).or.!(&_DbCondition)
    ::Skip_db(-1)
  endif
endif
if !empty(_wardbpom)
  if !empty(_fpomdb)
    do &_fpomdb
  endif
  if !(&_wardbpom)
    ::Skip_db(-1)
  endif
endif
retu Self

*------------------------------------------------------------------------------*
METHOD GetBarCode ( ) CLASS TPBrowse
*------------------------------------------------------------------------------*
retu ::BarCode
