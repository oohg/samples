/*
 * To build, use:
 *  SET HG_ADDLIBS_TEMP=%HG_ADDLIBS%
 *  SET HG_ADDLIBS=%HG_ADDLIBS% -lrddleto
 *  COMPILE demo
 *  SET HG_ADDLIBS=%HG_ADDLIBS_TEMP%
 */

#include "oohg.ch"

Function Main
Local cTable, arr
Local i, n1, n2

REQUEST LETO
RDDSETDEFAULT( "LETO" )

set language to spanish

cTable := "//192.168.0.10:2812/ciro.dbf"

arr := { { "FirstName", "C", 20, 0 }, ;
{ "LastName", "C", 20, 0 }, ;
{ "Age", "N", 3, 0 }, ;
{ "Date", "D", 8, 0 }, ;
{ "Rate", "N", 6, 2 }, ;
{ "Student", "L", 1, 0 } }

dbCreate( cTable, arr )
use (cTable) alias letoex

for i := 1 to 100
append blank
n1 := hb_RandomInt( 80 )
n2 := hb_RandomInt( 50 )
replace Age with n1, Date with Date() - 365*n2 + n1, Rate with 56.5 - n1/2
replace FirstName with "A"+Chr(64+n2)+Padl(i,10,'0'), LastName with "B"+Chr(70+n2)+Padl(i,12,'0'), Student with ( (field->Age % 2) == 1 )
next

go top

edit workarea letoex


Return Nil

