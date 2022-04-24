/*
 * CURL Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to get CURL's version.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#require "hbcurl"

FUNCTION Main

   MsgInfo( curl_version() )

   RETURN NIL

/*
 * EOF
 */
