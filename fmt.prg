/*
TEST ONLY !!!!!!!!!!!!!!!

Testing over OOHG samples.
*/
#include "directry.ch"
#include "inkey.ch"
#include "hbclass.ch"

FUNCTION Main( cParam )

   LOCAL nKey := 0, nContYes := 0, nContNo := 0

   IF cParam == NIL .OR. cParam != "BACKUP_IS_OK"
      ? "Test only. It is dangerous to use without backup source code first"
      QUIT
   ENDIF
   SetMode( 40, 100 )
   CLS
   Inkey(0)
   FormatDir( ".\", @nKey, @nContYes, @nContNo )

   RETURN NIL

STATIC FUNCTION FormatDir( cPath, nKey, nContYes, nContNo )

   LOCAL oFiles, oElement

   oFiles := Directory( cPath + "*.*", "D" )
   FOR EACH oElement IN oFiles
      DO CASE
      CASE "D" $ oElement[ F_ATTR ] .AND. oElement[ F_NAME ] == "."
      CASE "D" $ oElement[ F_ATTR ] .AND. oElement[ F_NAME ] == ".."
      CASE "D" $ oELement[ F_ATTR ]
         FormatDir( cPath + oElement[ F_NAME ] + "\", @nKey, @nContYes, @nContNo )
      CASE Upper( Right( oElement[ F_NAME ], 4 ) ) == ".PRG"
         FormatFile( cPath + oElement[ F_NAME ], @nContYes, @nContNo )
      ENDCASE
      nKey := iif( nKey == 27, nKey, Inkey() )
      IF nKey == K_ESC
         EXIT
      ENDIF
   NEXT

   RETURN NIL

STATIC FUNCTION FormatFile( cFile, nContYes, nContNo )

   LOCAL cTxt, cTxtAnt

   cTxtAnt := MemoRead( cFile )
   cTxt := cTxtAnt
   FormatBasic( @cTxt )
   FormatSource( @cTxt )
   FormatBlankLine( @cTxt, cFile )
   // save if changed
   IF ! cTxt == cTxtAnt
      nContYes += 1
      ? nContYes, nContNo, "Formatted " + cFile
      //MemoEdit( cTxt, 1, 1, 39, 99, .T. )
      //IF LastKey() != K_ESC
      hb_MemoWrit( cFile, cTxt )
      //ENDIF
   ELSE
      nContNo += 1
   ENDIF

   RETURN NIL

STATIC FUNCTION FormatBasic( cTxt )

   // TAB
   cTxt := StrTran( cTxt, Chr(9), Space(3) )
   // Windows CRLF
   cTxt := StrTran( cTxt, hb_Eol(), Chr(13) )
   cTxt := StrTran( cTxt, Chr(10), Chr(13) )
   cTxt := StrTran( cTxt, Chr(13), hb_Eol() )
   // Blank spaces at end of line
   DO WHILE " " + hb_Eol() $ cTxt
      cTxt := StrTran( cTxt, " " + hb_Eol(), hb_Eol() )
   ENDDO
   // max 2 blank lines
   DO WHILE Replicate( hb_Eol() , 3 ) $ cTxt
      cTxt := StrTran( cTxt, Replicate( hb_Eol(), 3 ), Replicate( hb_Eol(), 2 ) )
   ENDDO

   RETURN NIL

FUNCTION FormatSource( cTxt )

   LOCAL aTxtList, oElement, oConfig := FormatClass():New()

   aTxtList := hb_regExSplit( hb_Eol(), cTxt )
   // one blank line at end of file
   DO WHILE Len( aTxtList ) > 1 .AND. Empty( aTxtList[ Len( aTxtList ) ] )
      aSize( aTxtList, Len( aTxtList ) - 1 )
   ENDDO
   AAdd( aTxtList, "" )
   // more
   FOR EACH oElement IN aTxtList
      FormatIndent( @oElement, @oConfig )
   NEXT
   cTxt := ""
   FOR EACH oElement IN aTxtList
      cTxt += oElement + hb_Eol()
   NEXT

   RETURN NIL

STATIC FUNCTION FormatIndent( cTxt, oConfig )

   LOCAL cTextLower

   LOCAL acGo    := { "for ", "do case", "if ", "do while ", "begin", "procedure", "func ", "proc ", ;
      "function", "class", "create class", "static proc", "static func", "define window", ;
      "define toolbar", "define statusbar", "define tab", "with object", "page ", "node ", ;
      "define splitbox", "try", "define menu", "define main menu", "define button", ;
      "case ", "else", "catch", "popup ", "define page", "define popup", "define label", "recover", ;
      "define checkbox", "define image", "define combobox", "define textbox", "define spinner", ;
      "define browse", "define context", "define internal", "define activex", "define checklist", ;
      "define grid", "method ", "define listbox", "define datepicker", "define slider", "define tree", ;
      "define frame", "define editbox", "define radiogroup", "switch", "while ", "#ifdef", "#else", "#ifndef" }
   LOCAL acRet   := { "next", "endcase", "endif", "end", "enddo", "endclass", "case ", "else", "catch", "method", ;
      "#endif", "#else", "recover" }
   LOCAL nIdent2 := 0, oElement

   cTextLower := AllTrim( Lower( cTxt ) )
   IF "#" + "pragma" $ cTextLower // to do not consider this source code
      IF "begindump" $ cTextLower
         oConfig:lFormat := .F. // begin c code, turn format OFF
      ENDIF
      IF "enddump" $ cTextLower
         oConfig:lFormat := .T. // end c code, turn format ON
      ENDIF

      RETURN NIL
   ENDIF
   IF ! oConfig:lFormat

      RETURN NIL
   ENDIF
   IF Left( cTextLower, 2 ) == "/*" .AND. ! "*/" $ cTextLower
      oConfig:lComment := .T. // begin comment code
   ENDIF
   IF Left( cTextLower, 2 ) == "*/"
      oConfig:lComment := .F. // end comment code
   ENDIF
   IF Right( cTextLower, 2 ) == "*/" .AND. oConfig:lComment
      oConfig:lComment := .F.
   ENDIF
   // line continuation, make ident
   IF oConfig:lContinue .AND. ! oConfig:lComment
      nIdent2 += 1
   ENDIF
   // line continuation, without comment, will ident next
   IF ! ( Left( cTextLower, 1 ) == "*" .OR. Left( cTextLower, 2 ) == "//" .OR. oConfig:lComment )
      oConfig:lContinue := Right( cTextLower, 1 ) == ";"
   ENDIF
   // return change ident, this prevents when return is inside endif/endcase/others
   IF ! oConfig:lReturn .AND. ! oConfig:lComment
      FOR EACH oElement IN acRet
         IF Left( cTextLower, Len( oElement ) ) == oElement .OR. cTextLower == Trim( oElement )
            oConfig:nIdent -= 1
            EXIT
         ENDIF
      NEXT
   ENDIF
   IF oConfig:nIdent + nIdent2 > 0
      IF Empty( cTxt )
         cTxt := ""
      ELSE
         cTxt := Space( ( oConfig:nIdent + nIdent2 ) * 3 ) + AllTrim( cTxt )
      ENDIF
   ENDIF
   IF oConfig:lComment

      RETURN NIL
   ENDIF
   // check if command will cause ident
   FOR EACH oElement IN acGo
      IF Left( cTextLower, Len( oElement ) ) == oElement
         oConfig:nIdent += 1
         EXIT
      ENDIF
   NEXT
   IF Left( cTextLower, 6 ) == "return"
      oConfig:nIdent -= 1
      oConfig:lReturn := .T.
   ELSE
      oConfig:lReturn := .F.
   ENDIF
   // prevent negative number
   IF oConfig:nIdent < 0
      oConfig:nIdent := 0
   ENDIF

   RETURN NIL

STATIC FUNCTION FormatBlankLine( cTxt )

   LOCAL cTxtLine, nCont := 1, oConfig := FormatClass():New()

   aTxtList := hb_RegExSplit( hb_Eol(), cTxt )
   cTxt  := ""
   DO WHILE nCont < Len( aTxtList )
      cTxtLine := Lower( AllTrim( aTxtList[ nCont ] ) )
      DO CASE
      CASE "#pragma" $ cTxtLine .AND. "begindump" $ cTxtLine  ; oConfig:lCCode   := .T.
      CASE "%pragma" $ cTxtLine .AND. "enddump" $ cTxtLine    .AND. oConfig:lCCode ; oConfig:lCCode   := .F.
      CASE Left( cTxtLine, 2 ) == "/*" .AND. "*/" $ cTxtLine
      CASE Left( cTxtLine, 2 ) == "/*"                        ; oConfig:lComment := .T.
      CASE "*/" $ cTxtLine .AND. oConfig:lComment; oConfig:lComment := .F.
      CASE Left( cTxtLine, 2 ) == "//" .OR. Left( cTxtLine, 1 ) == "*"
      CASE Empty( cTxtLine ) ; nCont += 1; LOOP
      CASE Left( cTxtLine, 11 ) == "static proc"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 11 ) == "static func"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 4 ) == "proc"; cTxt  += hb_Eol()
      CASE Left( cTxtLine, 4 ) == "func"; cTxt  += hb_Eol()
      CASE Left( cTxtLine, 5 ) == "class"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 12 ) == "create class"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 8 ) == "endclass"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 6 ) == "method"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 6 ) == "return"; cTxt += hb_Eol()
      ENDCASE
      cTxt += aTxtList[ nCont ] + hb_Eol()
      DO CASE
      CASE Right( cTxtLine, 1 ) == ";"
      CASE Left( cTxtLine, 11 ) == "static proc"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 11 ) == "static func"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 4 ) == "proc"; cTxt  += hb_Eol()
      CASE Left( cTxtLine, 4 ) == "func"; cTxt  += hb_Eol()
      CASE Left( cTxtLine, 5 ) == "class"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 12 ) == "create class"; cTxt += hb_Eol()
      CASE Left( cTxtLine, 5 ) == "local" ; cTxt += hb_Eol()
      ENDCASE
      nCont += 1
   ENDDO

   RETURN NIL

CREATE CLASS FormatClass

   VAR nIdent      INIT 0
   VAR lFormat     INIT .T.
   VAR lContinue   INIT .F.
   VAR lReturn     INIT .F.
   VAR lComment    INIT .F.
   VAR lCCode      INIT .F.

   ENDCLASS
