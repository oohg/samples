/*
 * Windows Api Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to display Windows version.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   SetOneArrayItemPerLine( .T. )

   AutoMsgBox( WindowsVersion() )

   RETURN NIL

/*
 * EOF
 */
