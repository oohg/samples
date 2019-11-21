/*
 * Console Sample #2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how build and run a console program.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

REQUEST HB_GT_WIN_DEFAULT

FUNCTION Main()

	SetMode( 25, 80 )

   CLS

	@ 10, 10 say 'Hello'

	alert( 'Hello' )

RETURN NIL

/*
 * Build with
 *
 *   COMPILE hello /C
 * or
 *   BUILDAPP hello -GTWIN
 */
