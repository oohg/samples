#Include "Agenda.ch"
#INCLUDE "Common.CH"
#Include "Fileio.CH"
#Include "oohg.CH"
/*
		oArea	    :=	Alias()
		nValorCombo :=	Registro que Dever  Ser Posicionado
		cCodigo     :=	Codigo a Ser Pesquisado
		aCombo1     :=	Combo de Todos os Registros
		aCombo2     :=	Combo de Todos os Registros guardando o Recno
*/
Function GnEncheTabela(oArea,nValorCombo,cCodigo,aCombo1,aCombo2,cVar)
	 Local nPos	:= 0
	 aCombo1	:= {}
	 aCombo2	:= {}
	 (oArea)->(DBSetOrder(2))
	 (oArea)->(DBGoTop())
	 Do While ! (oArea)->(Eof())
	    nPos += 1
	    If (oArea)->Codigo == cCodigo ; nValorCombo := nPos ; Endif
	    Aadd(aCombo1,(oArea)->Descricao)
	    Aadd(aCombo2,(oArea)->Codigo   )
	    (oArea)->(DBSkip())
	 EndDo
	 Return Nil
/*
*/
Function BloqueiaRegistroNaRede( marea )
	 Local op := 0
	 Do While ! (marea)->(RLock())
	    If ! MSGRetryCancel("Registro em Uso na Rede Tenta Acesso??","Controle de Lotes")
	       Return .F.
	    EndIf
	 EndDo
	 Return .T.
/*
*/
Function GeraCodigo( oArea , ordem , Tamanho )
	 Local regist	:= (oArea)->(Recno())
	 Local ord	:= (oArea)->(IndexOrd())
	 Local cdg	:= 0
	 (oArea)->(DBSetOrder( ordem ))
	 (oArea)->(DBGoBottom())
	 cdg := StrZero( Val ( (oArea)->CODIGO ) + 1 , Tamanho )
	 If Val(cdg) == 0
	    MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
			   PadC("*** Erro ao Gerar Codigo em "+oArea+" ***",70)+QUEBRA+;
			   PadC("*** Codigo Gerado EM BRANCO ***",70)+QUEBRA+;
			   PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
			   PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
			   PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
	    RELEASE WINDOW ALL
	 Endif
	 If (oArea)->(LastRec()) > 1 .And. Val(cdg) == 1
	    MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
			   PadC("*** Erro Detectado ao Gravar em "+oArea+" ***",70)+QUEBRA+;
			   PadC("*** Codigo Gerado Invalido!! ***",70)+QUEBRA+;
			   PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
			   PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
			   PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
	    RELEASE WINDOW ALL
	 Endif
	 (oArea)->(DBSetOrder( ord ) )
	 (oArea)->(DBGoTo( regist )  )
	 Return( cdg )
/*
*/
Function GravouCodigoCorretamente( cArea , mCODIGO , nIndex )
	 Local nInd := (cArea)->(IndexOrd())
	 Local lRet := .T.
	 (cArea)->(DBSetOrder(nIndex))
	 If ! (cArea)->(DBSeek(mCODIGO))
	    MSGExclamation(PadC("ATENCAO",70)+QUEBRA+;
			   PadC("*** Registro nÆo incluido em "+cArea+" ***",70)+QUEBRA+;
			   PadC("Provavelmente existem indices ou Base de Dado Corrompida!!",70)+QUEBRA+;
			   PadC("Efetue a Manutencao do Sistema Antes de qualquer outra Operacao!!",70)+QUEBRA+;
			   PadC("*** Sistema Sera Finalizado!! ***",70),SISTEMA)
	    RELEASE WINDO ALL
	 EndIf
	 (cArea)->(DBSetOrder(nInd))
	 Return lRet
/*
*/
Function PGeneric(  oArea , oOrd   ,  oVar ,  oCampo )
	 Local	nord	   := (oArea)->(IndexOrd () )
	 Local	Oreg	   := (oArea)->(RECNO() )
	 Private  oNome
	 (oArea)->(DBSetOrder( oOrd ) )
	 (oArea)->(DBSeek( oVar ) )
	 oNome := '{ ||' + oArea + '->' + oCampo + '}'
	 oNome := &oNome
	 oNome := Eval( oNome )
	 (oArea)->(DBSetOrder( nord ) )
	 (oArea)->(DBGoTo( oReg ) )
	 Return( oNome )
/*
*/
Function GetIni( cSecao, cVariavel, cDefault, cArquivo )
	 Local hArq
	 Local lcSecao := "[" + AllTrim( cSecao ) + "]"
	 Local linha
	 Local achousecao := .F.
	 Local achouvar   := .F.
	 Local procura
	 Local cArq
	 Local nLinhas
	 Local nContador  := 0

	 If ! File( cArquivo )
	    hArq := FCreate( cArquivo )
	 Else
	    hArq := FOpen( cArquivo, FO_READ + FO_SHARED )
	 EndIf

	 If FError() != 0
	    Alert( "Erro na leitura de arquivo INI. DOS ERRO: " +;
		   Str( FError(), 2, 0 ) )
	    Return ""
	 EndIf

	 FClose( hArq )

	 procura := Upper( AllTrim( lcSecao ) )
	 cArq	 := MemoRead( cArquivo )
	 nLinhas := MlCount( cArq )

	 Do While nContador <= nLinhas

	    nContador += 1

	    linha := AllTrim( Upper( MemoLine( cArq , , nContador ) ) )

	    linha := StrTran( linha, Chr(10), "" )
	    linha := StrTran( linha, Chr(13), "" )

	    If linha == procura .AND. ! achousecao
	       procura := Upper( AllTrim( cVariavel ) )
	       achousecao := .T.
	    ElseIf   ( procura + "=" ) == SubStr( linha, 1, Len( procura ) + 1 );
		     .AND. achousecao .AND. ! achouvar
	       achouvar   := .T.
	       Exit
	    ElseIf ( "[" $ linha .AND. "]" $ linha ) .AND. achousecao
	       Exit
	    EndIf
	 EndDo
	 Return Iif( ! achouvar, cDefault, Right( linha, Len( linha ) - At( "=", linha ) ) )

/*
*/
Function WriteIni( cSecao, cVariavel, cValor, cArquivo )
	 Local hArq
	 Local lcSecao := "[" + AllTrim( cSecao ) + "]"
	 Local Conteudo
	 Local achousecao := .F.
	 Local achouvar   := .F.
	 Local procura
	 Local cArq
	 Local nLinhas
	 Local nContador  := 0
	 Local vargrav	  :=  Lower( AllTrim( cVariavel ) ) + "=" +;
			      AllTrim( cValor ) + Chr( 13 ) + Chr( 10 )
	 Local ponteiro
	 Local pontvar
	 Local pontfim
	 Local linha
	 Local i
	 Local armou	:= .F.
	 Local disparou := .F.
	 Local letra

	 If ! File( cArquivo )
	    hArq := FCreate( cArquivo )
	 Else
	    hArq := FOpen( cArquivo, FO_READ + FO_SHARED )
	 EndIf

	 If FError() # 0
	    Alert( "Erro na leitura de arquivo INI. DOS ERRO: " +;
		   Str( FError(), 2, 0 ) )
	    Return ""
	 EndIf

	 FClose( hArq )

	 procura := Upper( AllTrim( lcSecao ) )

	 conteudo := MemoRead( cArquivo )

	 ponteiro := At( procura, Upper( conteudo ) )

	 If ponteiro == 0
	    conteudo := conteudo + Chr( 13 ) + Chr( 10 ) + procura + Chr( 13 ) +;
			Chr( 10 ) + vargrav
	 ElseIf ( pontvar := At(Upper(AllTrim(cVariavel)), Upper(conteudo)) ) == 0
	    conteudo := Left( conteudo, ponteiro + Len( lcSecao ) + 1 ) + vargrav +;
			Right( conteudo, Len(conteudo) - (1+ponteiro+Len(lcSecao)))
	 Else
	    For i := pontvar To Len( conteudo )
	       letra := SubStr( conteudo, i, 1 )
	       If letra == Chr( 13 )
		  armou := .T.
	       ElseIf letra == Chr( 10 ) .AND. armou
		  disparou := .T.
	       EndIf
	       If disparou
		  pontfim := i
		  Exit
	       EndIf
	    Next
	    pontfim  := Iif( ! disparou, Len( conteudo ), pontfim )
	    letra    := SubStr( conteudo, pontvar,;
				( pontfim - pontvar ) + 1 )
	    conteudo := SubStr( conteudo, 1, pontvar - 1 ) + ;
			vargrav + SubStr( conteudo, pontfim + 1, Len( conteudo ) )
	 EndIf

	 MemoWrit( cArquivo, StrTran( conteudo, Chr(26), "" ) )

	 Return Nil

/*
*/
Function SvAmb()
	 Local Local1 := {}
	 Aadd(Local1,Alias())
	 Aadd(Local1,Indexord())
	 Aadd(Local1,Recno())
	 Return Local1
/*
*/
Function RtAmb(Arg1)
	 If Arg1[1] != Nil .And. Select(Arg1[1]) != 0
	    Select(Arg1[1])
	    If Arg1[2] != 0
	       (Arg1[1])->(DBSetOrder(Arg1[2]))
	    Endif
	    If Arg1[3] != 0
	       (Arg1[1])->(DBGoTo(Arg1[3]))
	    Endif
	 Endif
	 Return Nil
