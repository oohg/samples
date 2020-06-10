

FUNCTION Main()
   LOCAL hLib := hb_libLoad( "somedll.dll" )
   LOCAL symbol

   HB_SYMBOL_UNUSED( hLib )

   SetMode( 25, 80 )
   Scroll()

   // This is the first way to call the functions
   ? &( "SomeFunc" )( "Hello from 'some.dll' #1" )

   // This is the second way to call the functions
   symbol := &( "@SOMEFUNC()" )
   ? symbol:Exec( "Hello from 'some.dll' #2" )

RETURN NIL
