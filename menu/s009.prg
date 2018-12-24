/*
 * Menu Sample n° 9
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

PROCEDURE MAIN

LOCAL aMenu, oWnd, oList

   DEFINE WINDOW MAIN OBJ oWnd



      DEFINE MAIN MENU 

         POPUP "Menu"

            POPUP "1. Principal 1"

               POPUP "1. Subopcion 1.1"

                  ITEM "1. Subopcion 1.1.1" ACTION MsgInfo( "Subopcion 1.1.1" )

                  ITEM "2. Subopcion 1.1.2" ACTION MsgInfo( "Subopcion 1.1.2" )

                  ITEM "3. Subopcion 1.1.3" ACTION MsgInfo( "Subopcion 1.1.3" )

                  ITEM "4. Subopcion 1.1.4" ACTION MsgInfo( "Subopcion 1.1.4" )

                  ITEM "5. Subopcion 1.1.5" ACTION MsgInfo( "Subopcion 1.1.5" )

               END POPUP

               POPUP "2. Subopcion 1.2"

                  ITEM "1. Subopcion 1.2.1" ACTION MsgInfo( "Subopcion 1.2.1" )

                  ITEM "2. Subopcion 1.2.2" ACTION MsgInfo( "Subopcion 1.2.2" )

                  ITEM "3. Subopcion 1.2.3" ACTION MsgInfo( "Subopcion 1.2.3" )

                  ITEM "4. Subopcion 1.2.4" ACTION MsgInfo( "Subopcion 1.2.4" )

                  ITEM "5. Subopcion 1.2.5" ACTION MsgInfo( "Subopcion 1.2.5" )

               END POPUP

               POPUP "3. Subopcion 1.3"

                  ITEM "1. Subopcion 1.3.1" ACTION MsgInfo( "Subopcion 1.3.1" )

                  ITEM "2. Subopcion 1.3.2" ACTION MsgInfo( "Subopcion 1.3.2" )

                  ITEM "3. Subopcion 1.3.3" ACTION MsgInfo( "Subopcion 1.3.3" )

                  ITEM "4. Subopcion 1.3.4" ACTION MsgInfo( "Subopcion 1.3.4" )

                  ITEM "5. Subopcion 1.3.5" ACTION MsgInfo( "Subopcion 1.3.5" )

               END POPUP

               POPUP "4. Subopcion 1.4"

                  ITEM "1. Subopcion 1.4.1" ACTION MsgInfo( "Subopcion 1.4.1" )

                  ITEM "2. Subopcion 1.4.2" ACTION MsgInfo( "Subopcion 1.4.2" )

                  ITEM "3. Subopcion 1.4.3" ACTION MsgInfo( "Subopcion 1.4.3" )

                  ITEM "4. Subopcion 1.4.4" ACTION MsgInfo( "Subopcion 1.4.4" )

                  ITEM "5. Subopcion 1.4.5" ACTION MsgInfo( "Subopcion 1.4.5" )

               END POPUP

               POPUP "5. Subopcion 1.5"

                  ITEM "1. Subopcion 1.5.1" ACTION MsgInfo( "Subopcion 1.5.1" )

                  ITEM "2. Subopcion 1.5.2" ACTION MsgInfo( "Subopcion 1.5.2" )

                  ITEM "3. Subopcion 1.5.3" ACTION MsgInfo( "Subopcion 1.5.3" )

                  ITEM "4. Subopcion 1.5.4" ACTION MsgInfo( "Subopcion 1.5.4" )

                  ITEM "5. Subopcion 1.5.5" ACTION MsgInfo( "Subopcion 1.5.5" )

               END POPUP

            END POPUP

            POPUP "2. Principal 2"

               POPUP "1. Subopcion 2.1"

                  ITEM "1. Subopcion 2.1.1" ACTION MsgInfo( "Subopcion 2.1.1" )

                  ITEM "2. Subopcion 2.1.2" ACTION MsgInfo( "Subopcion 2.1.2" )

                  ITEM "3. Subopcion 2.1.3" ACTION MsgInfo( "Subopcion 2.1.3" )

                  ITEM "4. Subopcion 2.1.4" ACTION MsgInfo( "Subopcion 2.1.4" )

                  ITEM "5. Subopcion 2.1.5" ACTION MsgInfo( "Subopcion 2.1.5" )

               END POPUP

               POPUP "2. Subopcion 2.2"

                  ITEM "1. Subopcion 2.2.1" ACTION MsgInfo( "Subopcion 2.2.1" )

                  ITEM "2. Subopcion 2.2.2" ACTION MsgInfo( "Subopcion 2.2.2" )

                  ITEM "3. Subopcion 2.2.3" ACTION MsgInfo( "Subopcion 2.2.3" )

                  ITEM "4. Subopcion 2.2.4" ACTION MsgInfo( "Subopcion 2.2.4" )

                  ITEM "5. Subopcion 2.2.5" ACTION MsgInfo( "Subopcion 2.2.5" )

               END POPUP

               POPUP "3. Subopcion 2.3"

                  ITEM "1. Subopcion 2.3.1" ACTION MsgInfo( "Subopcion 2.3.1" )

                  ITEM "2. Subopcion 2.3.2" ACTION MsgInfo( "Subopcion 2.3.2" )

                  ITEM "3. Subopcion 2.3.3" ACTION MsgInfo( "Subopcion 2.3.3" )

                  ITEM "4. Subopcion 2.3.4" ACTION MsgInfo( "Subopcion 2.3.4" )

                  ITEM "5. Subopcion 2.3.5" ACTION MsgInfo( "Subopcion 2.3.5" )

               END POPUP

               POPUP "4. Subopcion 2.4"

                  ITEM "1. Subopcion 2.4.1" ACTION MsgInfo( "Subopcion 2.4.1" )

                  ITEM "2. Subopcion 2.4.2" ACTION MsgInfo( "Subopcion 2.4.2" )

                  ITEM "3. Subopcion 2.4.3" ACTION MsgInfo( "Subopcion 2.4.3" )

                  ITEM "4. Subopcion 2.4.4" ACTION MsgInfo( "Subopcion 2.4.4" )

                  ITEM "5. Subopcion 2.4.5" ACTION MsgInfo( "Subopcion 2.4.5" )

               END POPUP

               POPUP "5. Subopcion 2.5"

                  ITEM "1. Subopcion 2.5.1" ACTION MsgInfo( "Subopcion 2.5.1" )

                  ITEM "2. Subopcion 2.5.2" ACTION MsgInfo( "Subopcion 2.5.2" )

                  ITEM "3. Subopcion 2.5.3" ACTION MsgInfo( "Subopcion 2.5.3" )

                  ITEM "4. Subopcion 2.5.4" ACTION MsgInfo( "Subopcion 2.5.4" )

                  ITEM "5. Subopcion 2.5.5" ACTION MsgInfo( "Subopcion 2.5.5" )

               END POPUP

            END POPUP

            POPUP "3. Principal 3"

               POPUP "1. Subopcion 3.1"

                  ITEM "1. Subopcion 3.1.1" ACTION MsgInfo( "Subopcion 3.1.1" )

                  ITEM "2. Subopcion 3.1.2" ACTION MsgInfo( "Subopcion 3.1.2" )

                  ITEM "3. Subopcion 3.1.3" ACTION MsgInfo( "Subopcion 3.1.3" )

                  ITEM "4. Subopcion 3.1.4" ACTION MsgInfo( "Subopcion 3.1.4" )

                  ITEM "5. Subopcion 3.1.5" ACTION MsgInfo( "Subopcion 3.1.5" )

               END POPUP

               POPUP "2. Subopcion 3.2"

                  ITEM "1. Subopcion 3.2.1" ACTION MsgInfo( "Subopcion 3.2.1" )

                  ITEM "2. Subopcion 3.2.2" ACTION MsgInfo( "Subopcion 3.2.2" )

                  ITEM "3. Subopcion 3.2.3" ACTION MsgInfo( "Subopcion 3.2.3" )

                  ITEM "4. Subopcion 3.2.4" ACTION MsgInfo( "Subopcion 3.2.4" )

                  ITEM "5. Subopcion 3.2.5" ACTION MsgInfo( "Subopcion 3.2.5" )

               END POPUP

               POPUP "3. Subopcion 3.3"

                  ITEM "1. Subopcion 3.3.1" ACTION MsgInfo( "Subopcion 3.3.1" )

                  ITEM "2. Subopcion 3.3.2" ACTION MsgInfo( "Subopcion 3.3.2" )

                  ITEM "3. Subopcion 3.3.3" ACTION MsgInfo( "Subopcion 3.3.3" )

                  ITEM "4. Subopcion 3.3.4" ACTION MsgInfo( "Subopcion 3.3.4" )

                  ITEM "5. Subopcion 3.3.5" ACTION MsgInfo( "Subopcion 3.3.5" )

               END POPUP

               POPUP "4. Subopcion 3.4"

                  ITEM "1. Subopcion 3.4.1" ACTION MsgInfo( "Subopcion 3.4.1" )

                  ITEM "2. Subopcion 3.4.2" ACTION MsgInfo( "Subopcion 3.4.2" )

                  ITEM "3. Subopcion 3.4.3" ACTION MsgInfo( "Subopcion 3.4.3" )

                  ITEM "4. Subopcion 3.4.4" ACTION MsgInfo( "Subopcion 3.4.4" )

                  ITEM "5. Subopcion 3.4.5" ACTION MsgInfo( "Subopcion 3.4.5" )

               END POPUP

               POPUP "5. Subopcion 3.5"

                  ITEM "1. Subopcion 3.5.1" ACTION MsgInfo( "Subopcion 3.5.1" )

                  ITEM "2. Subopcion 3.5.2" ACTION MsgInfo( "Subopcion 3.5.2" )

                  ITEM "3. Subopcion 3.5.3" ACTION MsgInfo( "Subopcion 3.5.3" )

                  ITEM "4. Subopcion 3.5.4" ACTION MsgInfo( "Subopcion 3.5.4" )

                  ITEM "5. Subopcion 3.5.5" ACTION MsgInfo( "Subopcion 3.5.5" )

               END POPUP

            END POPUP

            POPUP "4. Principal 4"

               POPUP "1. Subopcion 4.1"

                  ITEM "1. Subopcion 4.1.1" ACTION MsgInfo( "Subopcion 4.1.1" )

                  ITEM "2. Subopcion 4.1.2" ACTION MsgInfo( "Subopcion 4.1.2" )

                  ITEM "3. Subopcion 4.1.3" ACTION MsgInfo( "Subopcion 4.1.3" )

                  ITEM "4. Subopcion 4.1.4" ACTION MsgInfo( "Subopcion 4.1.4" )

                  ITEM "5. Subopcion 4.1.5" ACTION MsgInfo( "Subopcion 4.1.5" )

               END POPUP

               POPUP "2. Subopcion 4.2"

                  ITEM "1. Subopcion 4.2.1" ACTION MsgInfo( "Subopcion 4.2.1" )

                  ITEM "2. Subopcion 4.2.2" ACTION MsgInfo( "Subopcion 4.2.2" )

                  ITEM "3. Subopcion 4.2.3" ACTION MsgInfo( "Subopcion 4.2.3" )

                  ITEM "4. Subopcion 4.2.4" ACTION MsgInfo( "Subopcion 4.2.4" )

                  ITEM "5. Subopcion 4.2.5" ACTION MsgInfo( "Subopcion 4.2.5" )

               END POPUP

               POPUP "3. Subopcion 4.3"

                  ITEM "1. Subopcion 4.3.1" ACTION MsgInfo( "Subopcion 4.3.1" )

                  ITEM "2. Subopcion 4.3.2" ACTION MsgInfo( "Subopcion 4.3.2" )

                  ITEM "3. Subopcion 4.3.3" ACTION MsgInfo( "Subopcion 4.3.3" )

                  ITEM "4. Subopcion 4.3.4" ACTION MsgInfo( "Subopcion 4.3.4" )

                  ITEM "5. Subopcion 4.3.5" ACTION MsgInfo( "Subopcion 4.3.5" )

               END POPUP

               POPUP "4. Subopcion 4.4"

                  ITEM "1. Subopcion 4.4.1" ACTION MsgInfo( "Subopcion 4.4.1" )

                  ITEM "2. Subopcion 4.4.2" ACTION MsgInfo( "Subopcion 4.4.2" )

                  ITEM "3. Subopcion 4.4.3" ACTION MsgInfo( "Subopcion 4.4.3" )

                  ITEM "4. Subopcion 4.4.4" ACTION MsgInfo( "Subopcion 4.4.4" )

                  ITEM "5. Subopcion 4.4.5" ACTION MsgInfo( "Subopcion 4.4.5" )

               END POPUP

               POPUP "5. Subopcion 4.5"

                  ITEM "1. Subopcion 4.5.1" ACTION MsgInfo( "Subopcion 4.5.1" )

                  ITEM "2. Subopcion 4.5.2" ACTION MsgInfo( "Subopcion 4.5.2" )

                  ITEM "3. Subopcion 4.5.3" ACTION MsgInfo( "Subopcion 4.5.3" )

                  ITEM "4. Subopcion 4.5.4" ACTION MsgInfo( "Subopcion 4.5.4" )

                  ITEM "5. Subopcion 4.5.5" ACTION MsgInfo( "Subopcion 4.5.5" )

               END POPUP

            END POPUP

         END POPUP

      END MENU



      aMenu := {}

      AADD( aMenu, { "1", "1. Principal 1", { || Submenu( "1", oWnd, 20, 20, oList ) }  } )

      AADD( aMenu, { "2", "2. Principal 2", { || Submenu( "2", oWnd, 30, 20, oList ) }  } )

      AADD( aMenu, { "3", "3. Principal 3", { || Submenu( "3", oWnd, 40, 20, oList ) }  } )

      AADD( aMenu, { "4", "4. Principal 4", { || Submenu( "4", oWnd, 50, 20, oList ) }  } )

      oList := GeneraMenu( 10, 10, oWnd, aMenu, nil )



   END WINDOW

   ACTIVATE WINDOW MAIN

RETURN





FUNCTION GeneraMenu( nY, nX, oWnd, aMenu, oOldMenu )

LOCAL aItems, oList

   aItems := ARRAY( LEN( aMenu ) )

   AEVAL( aMenu, { |a,i| aItems[ i ] := a[ 2 ] } )

   @ nY,nX LISTBOX 0 OF ( oWnd ) WIDTH 200 HEIGHT 100 ;
           OBJ oList ITEMS aItems VALUE 1 ;
           ON DBLCLICK Ejecuta( oList, oList:Value, aMenu, oOldMenu )

   oList:SetKey( VK_RETURN, 0, { || Ejecuta( oList, oList:Value, aMenu, oOldMenu ) } )

   oList:SetKey( VK_SPACE,  0, { || Ejecuta( oList, oList:Value, aMenu, oOldMenu ) } )

   IF ! oOldMenu == nil

      oOldMenu:Enabled := .F.

      oList:SetKey( VK_ESCAPE, 0, { || oList:Release() , oOldMenu:Enabled := .T. , oOldMenu:SetFocus() } )

   ENDIF

   AEVAL( aMenu, { |a,i| TeclaMenu( i, oList, aMenu, oOldMenu ) , a } )

   oList:SetFocus()

RETURN oList



PROCEDURE Ejecuta( oList, nOpcion, aMenu, oOldMenu )

   IF nOpcion >= 1 .AND. nOpcion <= LEN( aMenu )

      EVAL( aMenu[ nOpcion ][ 3 ] )

   ENDIF

RETURN



PROCEDURE TeclaMenu( nPos, oList, aMenu, oOldMenu )

LOCAL aKey

   aKey := _DetermineKey( aMenu[ nPos ][ 1 ] )

   oList:SetKey( aKey[ 1 ], aKey[ 2 ], { || oList:Value := nPos , Ejecuta( oList, nPos, aMenu, oOldMenu ) } )

RETURN



PROCEDURE SubMenu( cOpcion, oWnd, nY, nX, oOldMenu )

LOCAL aMenu, I, aList

   aList := { nil }

   aMenu := {}

   FOR I := 1 TO 5

      SubMenuItem( aMenu, STR( I, 1 ), cOpcion, oWnd, nY + ( ( I + 1 ) * 10 ), nX + 10, aList )

   NEXT

   aList[ 1 ] := GeneraMenu( nY, nX, oWnd, aMenu, oOldMenu )

RETURN



PROCEDURE SubMenuItem( aMenu, cItem, cOpcion, oWnd, nY, nX, aList )

   IF LEN( cOpcion ) > 4

      AADD( aMenu, { cItem, cItem + ". Subopcion " + cOpcion + "." + cItem, { || MsgInfo( cOpcion + "." + cItem ) } } )

   ELSE

      AADD( aMenu, { cItem, cItem + ". Subopcion " + cOpcion + "." + cItem, { || Submenu( cOpcion + "." + cItem, oWnd, nY, nX, aList[ 1 ] ) } } )

   ENDIF

RETURN

