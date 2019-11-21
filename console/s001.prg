/*
 * Console Sample #1
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

   ? "Console Mode Sample"
   ? " "
   ? "Running with " + Version()
   ? " "
   ? "         and " + HB_Compiler()
   ? " "
   ? " "
   ? "       GT is " + hb_GtVersion()
   ? " "
   __Run( "Pause" )

RETURN .t.

/*
 * Build with
 *
 *   COMPILE console /C
 * or
 *   BUILDAPP console -GTWIN
 */
