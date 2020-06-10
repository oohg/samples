/*
 * Classes Sample 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Based on a contribution by Teo (user tfonfouge)
 * published at harbour-users@googlegroups.com
 *
 * Build with: COMPILE s003 /C
 *
 * This sample shows how Determine the DATAs, METHODs and INLINEs
 * of a given class. See functions DoMethod, _OOHG_HasMethod and
 * _OOHG_HasData in source/h_controlmisc.prg
 *
 * To distinguish a DATA from a METHOD with or without SETGET
 * follow this rules:
 *
 * DATA: xyz is a DATA when the List of DATAs contains items xyz
 * ('get' message) and _xyz ('set' message).
 *
 * METHOD with SETGET: xyz is a METHOD with SETGET when the list
 * of METHODs contains items xyz and _xyz.
 *
 * INLINE or METHOD without SETGET: xyz is a METHOD without
 * SETGET when the list of METHODs contains item xyz and not
 * contains item _xyz.
 *
 * NOTES:
 *
 * When the List of DATAs contains item _xyz but not contains
 * item xyz, in the parent class xyz is a DATA and in the class
 * is a METHOD without SETGET.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
REQUEST HB_GT_WIN_DEFAULT
#include "hbclass.ch"
#include "hboo.ch"

FUNCTION Main()

   LOCAL obj, aObjs, itm

   aObjs := { MyClass1():New(), MyClass2():New() }

   FOR EACH obj IN aObjs
      ? obj:ClassName
      ? "nNumber( 3 ) = ", obj:nNumber( 3 )
      FOR EACH itm IN __objGetMsgType( obj, ;
                                       HB_OO_MSG_DATA, ;
                                       HB_OO_CLSTP_EXPORTED, ;
                                       .F. )
         ? "Data:", itm
      NEXT
      FOR EACH itm IN __objGetMsgType( obj, ;
                                       HB_OO_MSG_METHOD, ;
                                       HB_OO_CLSTP_EXPORTED, ;
                                       .F. )
         ? "Method:", itm
      NEXT
      FOR EACH itm IN __objGetMsgType( obj, ;
                                       HB_OO_MSG_INLINE, ;
                                       HB_OO_CLSTP_EXPORTED, ;
                                       .F. )
         ? "Inline:", itm
      NEXT
      ?
   NEXT

   RETURN NIL


CLASS MyClass1

   DATA _otherData
   DATA cText         INIT "Default Text"
   DATA nNumber       INIT 0
   DATA Prot1         PROTECTED

   METHOD _Now()      INLINE Date()
   METHOD _Tomorrow() INLINE ::_Now() + 1

   ENDCLASS


CLASS MyClass2 FROM MyClass1

   DATA aValues       INIT {0,1,2,3,4}
   DATA cTime         INIT time()

   METHOD cText       SETGET
   METHOD nNumber

   ENDCLASS

METHOD cText( cNewText ) CLASS MyClass2

   RETURN iif( empty( cNewText ), ::cTime, ::cTime := time() )

METHOD nNumber( nItem ) CLASS MyClass2

   RETURN ::aValues[ nItem ] := nItem * 2


STATIC FUNCTION __objGetMsgType( obj, msgType, msgScope, filtSuper )

   LOCAL itm, aClsSel, a := {}

   IF msgScope == NIL
      msgScope := 0
   ENDIF

   aClsSel := obj:ClassSel( HB_MSGLISTPURE, msgScope, .T. )

   FOR EACH itm IN aClsSel
      IF ! filtSuper .OR. hb_bitAnd( itm[ HB_OO_DATA_SCOPE ], HB_OO_CLSTP_SUPER ) == 0
         IF msgType == NIL .OR. itm[ HB_OO_DATA_TYPE ] == msgType
            AAdd( a, itm[ HB_OO_DATA_SYMBOL ] )
         ENDIF
      ENDIF
   NEXT

   RETURN a

/*
 * EOF
 */
