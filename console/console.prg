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
   __Run( "Pause" )

RETURN .t.

/*
 * Build with
 *
 *   COMPILE console /C
 *
 */
