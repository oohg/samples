/*
 * Windows Metrics Sample n° 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to get the current decimal separator.
 *
 * Visit us at https://github.com/oohg/samples
 *
 */

#include "oohg.ch"

Function Main

   MsgInfo( "Decimal separator is " + GetDecimalSeparator(), "Info" )

Return Nil

#pragma BEGINDUMP

#include "hbapi.h"
#include "hbvm.h"
#include "hbstack.h"
#include <windows.h>

/*
Constants defined in winnls.h
See https://msdn.microsoft.com/en-us/library/windows/desktop/dd464799(v=vs.85).aspx

LOCALE_ILANGUAGE              LANGID in hexadecimal digits
LOCALE_SLANGUAGE              Full localized name of the language
LOCALE_SENGLANGUAGE           Full English U.S. name of the language ISO Standard 639
LOCALE_SABBREVLANGNAME        Abbreviated name of the language, ISO Standard 639
LOCALE_SNATIVELANGNAME        Native name of the language
LOCALE_ICOUNTRY               Country code, based on international phone codes
LOCALE_SCOUNTRY               The full localized name of the country.
LOCALE_SENGCOUNTRY            The full English U.S. name of the country.
LOCALE_SABBREVCTRYNAME        Abbreviated name of the country ISO Standard 3166.
LOCALE_SNATIVECTRYNAME        Native name of the country.
LOCALE_IDEFAULTLANGUAGE       LANGID for the principal language spoken in this locale.
LOCALE_IDEFAULTCOUNTRY        Country code for the principal country in this locale.
LOCALE_IDEFAULTCODEPAGE       OEM code page associated with the country.
LOCALE_SLIST                  Characters used to separate list items.
LOCALE_IMEASURE               0 for metric system (S.I.) and 1 for the U.S.
LOCALE_SDECIMAL               decimal separator
LOCALE_STHOUSAND              thousand separator
LOCALE_SGROUPING              Sizes for each group of digits to the left of the decimal.
LOCALE_IDIGITS                number of fractional digits
LOCALE_ILZERO                 0 means use no leading zeros; 1 means use leading zeros.
LOCALE_SNATIVEDIGITS          Ten characters equivalent of the ASCII 0-9.
LOCALE_SCURRENCY              local monetary symbol
LOCALE_SINTLSYMBOL            International monetary symbol ISO 4217.
LOCALE_SMONDECIMALSEP         monetary decimal separator
LOCALE_SMONTHOUSANDSEP        monetary thousand separator
LOCALE_SMONGROUPING           monetary grouping
LOCALE_ICURRDIGITS            # local monetary digits
LOCALE_IINTLCURRDIGITS        # intl monetary digits
LOCALE_ICURRENCY              positive currency mode
LOCALE_INEGCURR               negative currency mode
LOCALE_SDATE                  date separator
LOCALE_STIME                  time separator
LOCALE_SSHORTDATE             short date format string
LOCALE_SLONGDATE              long date format string
LOCALE_STIMEFORMAT            time format string
LOCALE_IDATE                  short date format, 0 M–D–Y,1 D–M–Yr,2 Y–M–D
LOCALE_ILDATE                 long date format, 0 M–D–Y,1 D–M–Y,2 Y–M–D
LOCALE_ITIME                  time format, 0 AM/PM 12-hr format, 1 24-hr format
LOCALE_ICENTURY               Use full 4-digit century, 0 Two digit.1 Full century
LOCALE_ITLZERO                leading zeros in time field, 0 No , 1 yes
LOCALE_IDAYLZERO              leading zeros in day field, 0 No , 1 yes
LOCALE_IMONLZERO              leading zeros in month field, 0 No , 1 yes
LOCALE_S1159                  AM designator
LOCALE_S2359                  PM designator
LOCALE_SDAYNAME1              long name for Monday
LOCALE_SDAYNAME2              long name for Tuesday
LOCALE_SDAYNAME3              long name for Wednesday
LOCALE_SDAYNAME4              long name for Thursday
LOCALE_SDAYNAME5              long name for Friday
LOCALE_SDAYNAME6              long name for Saturday
LOCALE_SDAYNAME7              long name for Sunday
LOCALE_SABBREVDAYNAME1        abbreviated name for Monday
LOCALE_SABBREVDAYNAME2        abbreviated name for Tuesday
LOCALE_SABBREVDAYNAME3        abbreviated name for Wednesday
LOCALE_SABBREVDAYNAME4        abbreviated name for Thursday
LOCALE_SABBREVDAYNAME5        abbreviated name for Friday
LOCALE_SABBREVDAYNAME6        abbreviated name for Saturday
LOCALE_SABBREVDAYNAME7        abbreviated name for Sunday
LOCALE_SMONTHNAME1            long name for January
LOCALE_SMONTHNAME2            long name for February
LOCALE_SMONTHNAME3            long name for March
LOCALE_SMONTHNAME4            long name for April
LOCALE_SMONTHNAME5            long name for May
LOCALE_SMONTHNAME6            long name for June
LOCALE_SMONTHNAME7            long name for July
LOCALE_SMONTHNAME8            long name for August
LOCALE_SMONTHNAME9            long name for September
LOCALE_SMONTHNAME10           long name for October
LOCALE_SMONTHNAME11           long name for November
LOCALE_SMONTHNAME12           long name for December
LOCALE_SABBREVMONTHNAME1      abbreviated name for January
LOCALE_SABBREVMONTHNAME2      abbreviated name for February
LOCALE_SABBREVMONTHNAME3      abbreviated name for March
LOCALE_SABBREVMONTHNAME4      abbreviated name for April
LOCALE_SABBREVMONTHNAME5      abbreviated name for May
LOCALE_SABBREVMONTHNAME6      abbreviated name for June
LOCALE_SABBREVMONTHNAME7      abbreviated name for July
LOCALE_SABBREVMONTHNAME8      abbreviated name for August
LOCALE_SABBREVMONTHNAME9      abbreviated name for September
LOCALE_SABBREVMONTHNAME10     abbreviated name for October
LOCALE_SABBREVMONTHNAME11     abbreviated name for November
LOCALE_SABBREVMONTHNAME12     abbreviated name for December
LOCALE_SABBREVMONTHNAME13     Native abbreviated name for 13th month, if it exists.
*/

HB_FUNC( GETDECIMALSEPARATOR )
{
   LPTSTR cText;

   cText = ( LPTSTR ) hb_xgrab( 128 );

//   GetLocaleInfo( GetSystemDefaultLCID(), LOCALE_SDECIMAL, cText, 128 );
   GetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, cText, 128 );

   hb_retc( cText );
   hb_xfree( cText );
}

#pragma ENDDUMP

/*
 * EOF
 */
