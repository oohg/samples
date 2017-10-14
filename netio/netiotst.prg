/*
 * $Id: netiotst.prg 12384 2009-09-01 07:48:44Z druzus $
 */

/*
 * Harbour Project source code:
 *    demonstration/test code for alternative RDD IO API which uses own
 *    very simple TCP/IP file server.
 *
 * Copyright 2009 Przemyslaw Czerpak <druzus / at / priv.onet.pl>
 * www - http://www.harbour-project.org
 *
 */

#include "oohg.ch"

#define DBNAME    "net:127.0.0.1:2941:data/tests"
//// if you want test in other terminal then put the server address here.
request DBFCDX

proc main()
   local f
   set exclusive off
   set deleted on
   rddSetDefault( "DBFCDX" )

  hb_inetInit()

   f:=netio_connect()

   createdb( DBNAME )
   testdb( DBNAME )


return

procedure createdb( cName )
   local n


   dbCreate( cName, {{"F1", "C", 20, 0},;
                     {"F2", "C",  4, 0},;
                     {"F3", "N", 10, 2},;
                     {"F4", "D",  8, 0}} )
   use (cName)
n:=0
   while n<100
      append blank
      n := recno() ////- 1
      replace F1 with chr( 65 + hb_random( 25 )   ) + " " + time()
      replace F2 with  field->F1
      replace f3 with  n / 100
      replace F4 with  date()
   enddo
   index on field->F1 tag T1
   index on field->F3 tag T3
   index on field->F4 tag T4
   close
  /// ?
return

proc testdb( cName )
   local i, j
   use (cName)
   for i:=1 to ordCount()
      ordSetFocus( i )
///      ? i, "name:", ordName(), "key:", ordKey(), "keycount:", ordKeyCount()
   next
   ordSetFocus( 1 )
   dbgotop()
   while !eof()
      if ! field->F1 == field->F2
      endif
      dbSkip()
   enddo
   i := row()
   j := col()
   dbgotop()
   browse_gui()
   edit extended workarea tests
   close
return


function browse_gui ()     

define window form_1 at 0,0 width 640 height 480 main title "Netio Client Demo"

@ 10,10  button button_1 caption "exit" action {|| form_1.release }
@ 10,200 button button_2 caption "abm" action { || otroabm() }

@ 50,10  browse browse_1 width 600 height 280 workarea tests edit append delete inplace lock headers {"f1","f2","f3","f4"} fields { "f1" ," f2" ,"f3" ," f4" }

end window

center window form_1
activate window form_1

return nil
function otroabm()
edit extended workarea tests
return nil
