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
 *
 */
