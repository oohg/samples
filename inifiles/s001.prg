/*
 * INI Files Sample # 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to save/load a DBF's structure
 * to/from an INI file.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "dbstruct.ch"

FUNCTION Main

   LOCAL aStruc, i, cSection, nCount, cName, cType, nLength, nDecimals

   // We want numbers written without decimals
   SET DECIMALS TO 0

   /* To load aStruc from a DBF, use
   USE table
   aStruc := table->( DBSTRUCT() )
   */

   aStruc := { {'CODE', "C", 3, 0}, {'DESCRIP', "C", 55, 0} }

   /*
   This code saves the DBF structure to an INI file
   */
   ERASE table.ini

   BEGIN INI FILE "table.ini"
      SET SECTION "FIELDS" ENTRY "COUNT" TO LEN( aStruc )

      FOR i := 1 to LEN( aStruc )
         cSection := "Field #" + ltrim( str( i ) )

         SET SECTION cSection ENTRY "NAME"     TO aStruc[ i, DBS_NAME ]
         SET SECTION cSection ENTRY "TYPE"     TO aStruc[ i, DBS_TYPE ]
         SET SECTION cSection ENTRY "LENGTH"   TO aStruc[ i, DBS_LEN ]
         SET SECTION cSection ENTRY "DECIMALS" TO aStruc[ i, DBS_DEC ]
      NEXT i
   END INI

   /*
   This code loads the DBF structure from an INI file
   */
   BEGIN INI FILE "table.ini"
      /*
      This sentences are needed to load data in the right type
      */
      nCount := 0
      cName := ""
      cType := ""
      nLength := 0
      nDecimals := 0

      GET nCount SECTION "FIELDS" ENTRY "COUNT" DEFAULT 0

      aStruc := ARRAY( nCount )

      FOR i := 1 to nCount
         cSection := "FIELD #" + LTRIM( STR( i, 19, 0 ) )

         GET cName     SECTION cSection ENTRY "NAME"     DEFAULT ""
         GET cType     SECTION cSection ENTRY "TYPE"     DEFAULT ""
         GET nLength   SECTION cSection ENTRY "LENGTH"   DEFAULT 0
         GET nDecimals SECTION cSection ENTRY "DECIMALS" DEFAULT 0

         aStruc[ i ] := { cName, cType, nLength, nDecimals }
      NEXT i
   END INI

   /* To create a DBF from aStruc, use
   DBCREATE( "table", aStruc )
   */

RETURN NIL

/*
 * EOF
 */
