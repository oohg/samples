#include "Agenda.ch"
#include "Common.CH"
#include "Fileio.CH"
#include "oohg.CH"
/*
      oArea       :=   Alias()
      nValorCombo :=   Registro que Dever  Ser Posicionado
      cCodigo     :=   Codigo a Ser Pesquisado
      aCombo1     :=   Combo de Todos os Registros
      aCombo2     :=   Combo de Todos os Registros guardando o Recno
*/

FUNCTION GnEncheTabela(oArea,nValorCombo,cCodigo,aCombo1,aCombo2,cVar)

   LOCAL nPos   := 0

   aCombo1   := {}
   aCombo2   := {}
   (oArea)->(DBSetOrder(2))
   (oArea)->(DBGoTop())
   DO WHILE ! (oArea)->(Eof())
      nPos += 1
      IF (oArea)->Codigo == cCodigo ; nValorCombo := nPos ; Endif
         Aadd(aCombo1,(oArea)->Descricao)
         Aadd(aCombo2,(oArea)->Codigo   )
         (oArea)->(DBSkip())
      ENDDO

      RETURN NIL

   FUNCTION BloqueiaRegistroNaRede( marea )

      LOCAL op := 0

      DO WHILE ! (marea)->(RLock())
         IF ! MSGRetryCancel("Registro em Uso na Rede Tenta Acesso??","Controle de Lotes")

            RETURN .F.
         ENDIF
      ENDDO

      RETURN .T.

   FUNCTION GeraCodigo( oArea , ordem , Tamanho )

      LOCAL regist   := (oArea)->(Recno())
      LOCAL ord   := (oArea)->(IndexOrd())
      LOCAL cdg   := 0

      (oArea)->(DBSetOrder( ordem ))
      (oArea)->(DBGoBottom())
      cdg := StrZero( Val ( (oArea)->CODIGO ) + 1 , Tamanho )
      IF Val(cdg) == 0
         MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
            PadC("*** Erro ao Gerar Codigo em "+oArea+" ***",70)+QUEBRA+;
            PadC("*** Codigo Gerado EM BRANCO ***",70)+QUEBRA+;
            PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
            PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
            PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
         RELEASE WINDOW ALL
      ENDIF
      IF (oArea)->(LastRec()) > 1 .And. Val(cdg) == 1
         MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
            PadC("*** Erro Detectado ao Gravar em "+oArea+" ***",70)+QUEBRA+;
            PadC("*** Codigo Gerado Invalido!! ***",70)+QUEBRA+;
            PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
            PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
            PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
         RELEASE WINDOW ALL
      ENDIF
      (oArea)->(DBSetOrder( ord ) )
      (oArea)->(DBGoTo( regist )  )

      RETURN( cdg )

   FUNCTION GravouCodigoCorretamente( cArea , mCODIGO , nIndex )

      LOCAL nInd := (cArea)->(IndexOrd())
      LOCAL lRet := .T.

      (cArea)->(DBSetOrder(nIndex))
      IF ! (cArea)->(DBSeek(mCODIGO))
         MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
            PadC("*** Registro nÆo incluido em "+cArea+" ***",70)+QUEBRA+;
            PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
            PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
            PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
         RELEASE WINDO ALL
      ENDIF
      (cArea)->(DBSetOrder(nInd))

      RETURN lRet

   FUNCTION PGeneric(  oArea , oOrd   ,  oVar ,  oCampo )

      LOCAL   nord      := (oArea)->(IndexOrd () )
      LOCAL   Oreg      := (oArea)->(RECNO() )

      PRIVATE  oNome

      (oArea)->(DBSetOrder( oOrd ) )
      (oArea)->(DBSeek( oVar ) )
      oNome := '{ ||' + oArea + '->' + oCampo + '}'
      oNome := &oNome
      oNome := Eval( oNome )
      (oArea)->(DBSetOrder( nord ) )
      (oArea)->(DBGoTo( oReg ) )

      RETURN( oNome )

   FUNCTION GetIni( cSecao, cVariavel, cDefault, cArquivo )

      LOCAL hArq
      LOCAL lcSecao := "[" + AllTrim( cSecao ) + "]"
      LOCAL linha
      LOCAL achousecao := .F.
      LOCAL achouvar   := .F.
      LOCAL procura
      LOCAL cArq
      LOCAL nLinhas
      LOCAL nContador  := 0

      IF ! File( cArquivo )
         hArq := FCreate( cArquivo )
      ELSE
         hArq := FOpen( cArquivo, FO_READ + FO_SHARED )
      ENDIF

      IF FError() != 0
         Alert( "Erro na leitura de arquivo INI. DOS ERRO: " +;
            Str( FError(), 2, 0 ) )
         RETURN ""
      ENDIF

      FClose( hArq )

      procura := Upper( AllTrim( lcSecao ) )

      cArq    := MemoRead( cArquivo )
      nLinhas := MlCount( cArq )

      DO WHILE nContador <= nLinhas

         nContador += 1

         linha := AllTrim( Upper( MemoLine( cArq , , nContador ) ) )

         linha := StrTran( linha, Chr(10), "" )
         linha := StrTran( linha, Chr(13), "" )

         IF linha == procura .AND. ! achousecao

            procura := Upper( AllTrim( cVariavel ) )

            achousecao := .T.
         ELSEIF   ( procura + "=" ) == SubStr( linha, 1, Len( procura ) + 1 );
               .AND. achousecao .AND. ! achouvar
            achouvar   := .T.
            EXIT
         ELSEIF ( "[" $ linha .AND. "]" $ linha ) .AND. achousecao
            EXIT
         ENDIF
      ENDDO

      RETURN Iif( ! achouvar, cDefault, Right( linha, Len( linha ) - At( "=", linha ) ) )

   FUNCTION WriteIni( cSecao, cVariavel, cValor, cArquivo )

      LOCAL hArq
      LOCAL lcSecao := "[" + AllTrim( cSecao ) + "]"
      LOCAL Conteudo
      LOCAL achousecao := .F.
      LOCAL achouvar   := .F.
      LOCAL procura
      LOCAL cArq
      LOCAL nLinhas
      LOCAL nContador  := 0
      LOCAL vargrav     :=  Lower( AllTrim( cVariavel ) ) + "=" +;
            AllTrim( cValor ) + Chr( 13 ) + Chr( 10 )
      LOCAL ponteiro
      LOCAL pontvar
      LOCAL pontfim
      LOCAL linha
      LOCAL i
      LOCAL armou   := .F.
      LOCAL disparou := .F.
      LOCAL letra

      IF ! File( cArquivo )
         hArq := FCreate( cArquivo )
      ELSE
         hArq := FOpen( cArquivo, FO_READ + FO_SHARED )
      ENDIF

      IF FError() # 0
         Alert( "Erro na leitura de arquivo INI. DOS ERRO: " +;
            Str( FError(), 2, 0 ) )

         RETURN ""
      ENDIF

      FClose( hArq )

      procura := Upper( AllTrim( lcSecao ) )

      conteudo := MemoRead( cArquivo )

      ponteiro := At( procura, Upper( conteudo ) )

      IF ponteiro == 0
         conteudo := conteudo + Chr( 13 ) + Chr( 10 ) + procura + Chr( 13 ) +;
            Chr( 10 ) + vargrav
      ELSEIF ( pontvar := At(Upper(AllTrim(cVariavel)), Upper(conteudo)) ) == 0
         conteudo := Left( conteudo, ponteiro + Len( lcSecao ) + 1 ) + vargrav +;
            Right( conteudo, Len(conteudo) - (1+ponteiro+Len(lcSecao)))
      ELSE
         FOR i := pontvar To Len( conteudo )
            letra := SubStr( conteudo, i, 1 )
            IF letra == Chr( 13 )
               armou := .T.
            ELSEIF letra == Chr( 10 ) .AND. armou
               disparou := .T.
            ENDIF
            IF disparou
               pontfim := i
               EXIT
            ENDIF
         NEXT
         pontfim  := Iif( ! disparou, Len( conteudo ), pontfim )
         letra    := SubStr( conteudo, pontvar,;
            ( pontfim - pontvar ) + 1 )
         conteudo := SubStr( conteudo, 1, pontvar - 1 ) + ;
            vargrav + SubStr( conteudo, pontfim + 1, Len( conteudo ) )
      ENDIF

      MemoWrit( cArquivo, StrTran( conteudo, Chr(26), "" ) )

      RETURN NIL

   FUNCTION SvAmb()

      LOCAL Local1 := {}

      Aadd(Local1,Alias())
      Aadd(Local1,Indexord())
      Aadd(Local1,Recno())

      RETURN Local1

   FUNCTION RtAmb(Arg1)

      IF Arg1[1] != Nil .And. Select(Arg1[1]) != 0
         SELECT(Arg1[1])
         IF Arg1[2] != 0
            (Arg1[1])->(DBSetOrder(Arg1[2]))
         ENDIF
         IF Arg1[3] != 0
            (Arg1[1])->(DBGoTo(Arg1[3]))
         ENDIF
      ENDIF

      RETURN NIL
