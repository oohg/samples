/*
 * Windows Api Sample # 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display file or folder long paths
 * in a compact way by replacing some chars with ellipses.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   AutoMsgBox( _GetCompactPath( "C:\OOHG_Samples\English\Samples\ClientAdjust\GetCompactPath", 32 ) )

   RETURN NIL

/*
 * EOF
 */
