/*
 * Windows Api Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display long file or folder paths
 * in a compact way by replacing some chars with ellipses.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   AutoMsgBox( _GetCompactPath( "C:\OOHG_Samples\English\Samples\ClientAdjust\GetCompactPath", 32 ) )

RETURN Nil

/*
 * EOF
 */
