
DYNAMIC QOUT
DYNAMIC ALERT

FUNCTION SomeFunc( cMsg )
   LOCAL nI := 0

   ? "Hello I'm SomeFunc from 'somedll.dll'"
   Alert( cMsg )

   FOR nI = 1 TO 10
      ? "Step: ", nI
   NEXT

RETURN .T.
