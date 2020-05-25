/*
 * $Id: i_pbrowse.ch
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


#command @ <row>, <col> PBROWSE [ <x> ] NAVIGATEBYCELL ;
   => ;
      @ <row>, <col> PBROWSE [ <x> ]

#command @ <row>, <col> PBROWSE <name> ;
      [ <dummy01: OF, PARENT> <parent> ] ;
      [ OBJ <obj> ] ;
      [ WIDTH <w> ] ;
      [ HEIGHT <h> ] ;
      [ HEADERS <headers> ] ;
      [ WIDTHS <widths> ] ;
      [ WORKAREA <workarea> ] ;
      [ FIELDS <Fields> ] ;
      [ INPUTMASK <Picture> ] ;
      [ VALUE <value> ] ;
      [ FONT <fontname> ] ;
      [ SIZE <fontsize> ] ;
      [ <bold: BOLD> ] ;
      [ <italic: ITALIC> ] ;
      [ <underline: UNDERLINE> ] ;
      [ <strikeout: STRIKEOUT> ] ;
      [ TOOLTIP <tooltip> ] ;
      [ BACKCOLOR <backcolor> ] ;
      [ DYNAMICBACKCOLOR <dynamicbackcolor> ] ;
      [ DYNAMICFORECOLOR <dynamicforecolor> ] ;
      [ FONTCOLOR <fontcolor> ] ;
      [ <dummy02: ONGOTFOCUS, ON GOTFOCUS> <gotfocus> ] ;
      [ <dummy03: ONCHANGE, ON CHANGE> <change> ] ;
      [ <dummy04: ONLOSTFOCUS, ON LOSTFOCUS> <lostfocus> ] ;
      [ <dummy05: ONDBLCLICK, ON DBLCLICK> <dblclick> ] ;
      [ <dummy06: ACTION, ONCLICK, ON CLICK> <click> ] ;
      [ <edit: EDIT> ] ;
      [ <inplace: INPLACE> ] ;
      [ <append: APPEND> ] ;
      [ <dummy07: ONHEADCLICK, ON HEADCLICK> <aHeadClick> ] ;
      [ <dummy08: WHEN, COLUMNWHEN> <aWhenFields> ] ;
      [ <dummy20: VALID, COLUMNVALID> <aValidFields> ] ;
      [ VALIDMESSAGES <aValidMessages> ] ;
      [ READONLY <aReadOnly> ] ;
      [ <lock: LOCK> ] ;
      [ <delete: DELETE> ] ;
      [ <style: NOLINES> ] ;
      [ IMAGE <aImage> ] ;
      [ JUSTIFY <aJust> ] ;
      [ <novscroll: NOVSCROLL> ] ;
      [ HELPID <helpid> ] ;
      [ <break: BREAK> ] ;
      [ <rtl: RTL> ] ;
      [ <dummy09: ONAPPEND, ON APPEND> <onappend> ] ;
      [ <dummy10: ONEDITCELL, ON EDITCELL> <editcell> ] ;
      [ COLUMNCONTROLS <editcontrols> ] ;
      [ REPLACEFIELD <replacefields> ] ;
      [ SUBCLASS <subclass> ] ;
      [ <reccount: RECCOUNT> ] ;
      [ COLUMNINFO <columninfo> ] ;
      [ <noshowheaders: NOHEADERS> ] ;
      [ <dummy11: ONENTER, ON ENTER> <enter> ] ;
      [ <disabled: DISABLED> ] ;
      [ <notabstop: NOTABSTOP> ] ;
      [ <invisible: INVISIBLE> ] ;
      [ <descending: DESCENDING> ] ;
      [ DELETEWHEN <bWhenDel> ] ;
      [ DELETEMSG <DelMsg> ] ;
      [ <dummy12: ONDELETE, ON DELETE> <onDelete> ] ;
      [ HEADERIMAGES <aHeaderImages> ] ;
      [ IMAGESALIGN <aImgAlign> ] ;
      [ <fullmove: FULLMOVE> ] ;
      [ SELECTEDCOLORS <aSelectedColors> ] ;
      [ EDITKEYS <aEditKeys> ] ;
      [ <forcerefresh: FORCEREFRESH> ] ;
      [ <norefresh: NOREFRESH> ] ;
      [ <bffr: DOUBLEBUFFER, SINGLEBUFFER> ] ;
      [ <focus: NOFOCUSRECT, FOCUSRECT> ] ;
      [ <plm: PAINTLEFTMARGIN> ] ;
      [ <sync: SYNCHRONIZED, UNSYNCHRONIZED> ] ;
      [ <fixedcols: FIXEDCOLS> ] ;
      [ <nodelmsg: NODELETEMSG> ] ;
      [ <updall: UPDATEALL> ] ;
      [ <dummy13: ONABORTEDIT, ON ABORTEDIT> <abortedit> ] ;
      [ <fixedwidths: FIXEDWIDTHS> ] ;
      [ <blocks: FIXEDBLOCKS, DYNAMICBLOCKS> ] ;
      [ BEFORECOLMOVE <bBefMov> ] ;
      [ AFTERCOLMOVE <bAftMov> ] ;
      [ BEFORECOLSIZE <bBefSiz> ] ;
      [ AFTERCOLSIZE <bAftSiz> ] ;
      [ BEFOREAUTOFIT <bBefAut> ] ;
      [ <excel: EDITLIKEEXCEL> ] ;
      [ <buts: USEBUTTONS> ] ;
      [ <upcol: UPDATECOLORS> ] ;
      [ <edtctrls: FIXEDCONTROLS, DYNAMICCONTROLS> ] ;
      [ <dummy14: ONHEADRCLICK, ON HEADRCLICK> <bheadrclick> ] ;
      [ <nomodal: NOMODALEDIT> ] ;
      [ <extdbl: EXTDBLCLICK> ] ;
      [ <silent: SILENT> ] ;
      [ <alta: ENABLEALTA, DISABLEALTA> ] ;
      [ <noshow: NOSHOWALWAYS> ] ;
      [ <none: NONEUNSELS, IGNORENONE> ] ;
      [ <cbe: CHANGEBEFOREEDIT> ] ;
      [ <dummy15: ONRCLICK, ON RCLICK> <rclick> ] ;
      [ <checkboxes: CHECKBOXES> ] ;
      [ <dummy16: ONCHECKCHANGE, ON CHECKCHANGE> <checkchange> ] ;
      [ <dummy17: ONROWREFRESH, ON ROWREFRESH> <rowrefresh> ] ;
      [ DEFAULTVALUES <aDefVal> ] ;
      [ <dummy18: ONEDITCELLEND, ON EDITCELLEND> <editend> ] ;
      [ <efv: EDITFIRSTVISIBLE> ] ;
      [ <dummy19: ONBEFOREEDITCELL, ON BEFOREEDITCELL> <beforedit> ] ;
   => ;
      [ <obj> := ] _OOHG_SelectSubClass( TPBrowse(), [ <subclass>() ] ): ;
            Define( <(name)>, <(parent)>, <col>, <row>, <w>, <h>, <headers>, ;
            <widths>, <Fields>, <value>, <fontname>, <fontsize>, <tooltip>, ;
            <{change}>, <{dblclick}>, <aHeadClick>, <{gotfocus}>, ;
            <{lostfocus}>, <(workarea)>, <.delete.>, <.style.>, <aImage>, ;
            <aJust>, <helpid>, <.bold.>, <.italic.>, <.underline.>, ;
            <.strikeout.>, <.break.>, <backcolor>, <fontcolor>, <.lock.>, ;
            <.inplace.>, <.novscroll.>, <.append.>, <aReadOnly>, ;
            <aValidFields>, <aValidMessages>, <.edit.>, <dynamicbackcolor>, ;
            <aWhenFields>, <dynamicforecolor>, <Picture>, <.rtl.>, ;
            <{onappend}>, <{editcell}>, <editcontrols>, <replacefields>, ;
            <.reccount.>, <columninfo>, ! <.noshowheaders.>, <{enter}>, ;
            <.disabled.>, <.notabstop.>, <.invisible.>, <.descending.>, ;
            <{bWhenDel}>, <DelMsg>, <{onDelete}>, <aHeaderImages>, ;
            <aImgAlign>, <.fullmove.>, <aSelectedColors>, <aEditKeys>, ;
            IIF( <.forcerefresh.>, 0, IIF( <.norefresh.>, 1, NIL ) ), ;
            IIF( Upper( #<bffr> ) == "DOUBLEBUFFER", .T., ;
            IIF( Upper( #<bffr> ) == "SINGLEBUFFER", .F., .T. ) ), ;
            IIF( Upper( #<focus> ) == "NOFOCUSRECT", .F., ;
            IIF( Upper( #<focus> ) == "FOCUSRECT", .T., NIL ) ), ;
            <.plm.>, IIF( Upper( #<sync> ) == "UNSYNCHRONIZED", .F., ;
            IIF( Upper( #<sync> ) == "SYNCHRONIZED", .T., NIL ) ), ;
            <.fixedcols.>, <.nodelmsg.>, <.updall.>, <{abortedit}>, <{click}>, ;
            <.fixedwidths.>, IIF( Upper( #<blocks> ) == "FIXEDBLOCKS", .T., ;
            IIF( Upper( #<blocks> ) == "DYNAMICBLOCKS", .F., NIL ) ), ;
            <{bBefMov}>, <{bAftMov}>, <{bBefSiz}>, <{bAftSiz}>, <{bBefAut}>, ;
            <.excel.>, <.buts.>, <.upcol.>, ;
            IIF( Upper( #<edtctrls> ) == "FIXEDCONTROLS", .T., ;
            IIF( Upper( #<edtctrls> ) == "DYNAMICCONTROLS", .F., NIL ) ), ;
            <{bheadrclick}>, <.extdbl.>, <.nomodal.>, <.silent.>, ;
            ! Upper( #<alta> ) == "DISABLEALTA", <.noshow.>, ;
            Upper( #<none> ) == "NONEUNSELS", <.cbe.>, <{rclick}>, ;
            <.checkboxes.>, <{checkchange}>, <{rowrefresh}>, <aDefVal>, ;
            <{editend}>, ! <.efv.>, <{beforedit}> )
