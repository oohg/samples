#include "Inkey.ch"
#include "oohg.ch"
/*
*
*  Esta função é muito Interessante
*  Caso seu sistema possua Tabelas Apenas com os campos (   CODIGO e DESCRICAO   )
*  Basta informar no MENU o seguinte:
*
*  CadastroGenerico( NomeDatabela , Titulo ) onde:
*
*  NomeDaTabela == Nome da Tabela que você Deseja Manipular
*  Titulo       == Título que irá aparecer no Formulário
*
*  Exemplo: CadastroGenerico( "Grupos" , "Grupos de Clientes" )
*  Assim será criado/aberto cadastro de Grupos com os campos código e descrição
*  e serão criados os índices 1 e 2 , codigo e Descricao, respectivamente
*  Para manipular a tabela o Alias é o mesmo utilizado na Variável >>  NomeDatabela <<
*
*  Para Somente abrir a tabela use a Função  GenericOpen( "Grupos" )
*
*  Neste exemplo (Grupos) o alias será Grupos. 
*  Grupos->Codigo ou Grupos->Descricao ou Grupos->(DBAppend()) ou Grupos->(DBSeek()), etc...
*
*
*/
*------------------------------------------------------------------------------*
* Procedure CadastroGenerico | Cadastro Das Tabelas do Sistema 	              *
*------------------------------------------------------------------------------*
Procedure CadastroGenerico( oArea , oTitulo )
	  Local CodigoAlt := 0
	 
	  Private cArea   := oArea
	  Private cTitulo := oTitulo
	  Private lNovo   := .F.

	  GenericOpen( oArea )	 

	  (cArea)->(DBSetOrder(2))  

	  DEFINE WINDOW Grid_Padrao;
		 AT 05,05              ; 
		 WIDTH	425            ;
		 HEIGHT 460            ;
		 TITLE cTitulo         ;
		 MODAL                 ;
		 NOSIZE

		 @ 010,010 GRID Grid_1P;
		   WIDTH  400          ;
		   HEIGHT 329          ;
		   HEADERS {"Código","Descrição"};
		   WIDTHS  {60,333}    ;
		   VALUE 1             ;
		   FONT "Arial" SIZE 09;
		   ON DBLCLICK { || Bt_Novo_Generic(2) }

		   @ 357,011 LABEL  Label_Pesq_Generic	 ;
		     VALUE "Pesquisa "                   ;
		     WIDTH 70				 ;
		     HEIGHT 20				 ;
		     FONT "Arial" SIZE 09

		   @ 353,085 TEXTBOX PesqGeneric	 ;
		     WIDTH 326				 ;
		     TOOLTIP "Digite a Descrição para Pesquisa"   ;
		     MAXLENGTH 40 UPPERCASE		 ;
		     ON CHANGE { || Pesquisa_Generic() }

		   @ 397,011 BUTTON Generic_Novo	    ;
			     CAPTION '&Novo'                ;
			     ACTION { || Bt_Novo_Generic(1)};
			     FONT "MS Sans Serif" SIZE 09 FLAT

		   @ 397,111 BUTTON Generic_Editar	  ;
			     CAPTION '&Editar'           ;
			     ACTION { || Bt_Novo_Generic(2)};
			     FONT "MS Sans Serif" SIZE 09 FLAT

		   @ 397,211 BUTTON Generic_Excluir	 ;
			     CAPTION 'E&xcluir'          ;
			     ACTION { || Bt_Excluir_Generic()};
			     FONT "MS Sans Serif" SIZE 09 FLAT

		   @ 397,311 BUTTON Generic_Sair	    ;
			     CAPTION '&Sair'                ;
			     ACTION { || Bt_Generic_Sair() };
			     FONT "MS Sans Serif" SIZE 09 FLAT

	  END WINDOW

      Grid_Padrao.Grid_1P.SetFocus  
      Renova_Pesquisa_Generic(" ")

	  CENTER   WINDOW Grid_Padrao
	  ACTIVATE WINDOW Grid_Padrao

	  Return Nil

/*
*/
Function Bt_Novo_Generic(nTipo)
	 Local nColuna	    := 1
	 Local nReg	    := PegaValorDaColuna( "Grid_1P" , "Grid_Padrao" , nColuna )
	 Local cStatus	    := Iif(nTipo==1,"Incluindo Registro","Alterando Registro")

	 lNovo		    := Iif(nTipo==1,.T.,.F.)

	 If nTipo == 2	    && Editar/Alterar
	    If Empty(nReg)
	      MsgExclamation("Nenhum Registro Informado para Edição!!",SISTEMA)
	      Return Nil
	    Else	    && Incluir Novo
	      (cArea)->(DBSetOrder(1))
	      If ! (cArea)->(DBSeek(nReg))
             MSGINFO("Erro de Pesquisa!!")
             Return NIl	   
	      EndIf
	      CodigoAlt := (cArea)->Codigo
	    EndIf
	 EndIf

	 DEFINE WINDOW Novo_Generic;
		AT 10,10		       ;
		WIDTH  590             ;
		HEIGHT 129             ;
		TITLE cTitulo		   ;
		MODAL			       ;
		NOSIZE			       

		DEFINE STATUSBAR		
			STATUSITEM "Manutenção no "+cTitulo
		END STATUSBAR

		       @003,005 FRAME Group_Generic_1 WIDTH 370 HEIGHT 75

		       *------------------------------------------ Campo Codigo
		       @014,020 LABEL  Label_Gen_Codigo    ;
				VALUE "Código"             ;
				WIDTH  70		   ;
				HEIGHT 15		   ;
				FONT "MS Sans Serif" SIZE 8 BOLD

		       @010,100 TEXTBOX  Generic_Codigo  ;
				WIDTH 50		 ;
				FONT "Arial" Size 9      ;
				TOOLTIP "Digite o C¢digo";
				MAXLENGTH 04 UPPERCASE	 ;
				ON LOSTFOCUS { || ChangeGenericCodigo() }

		       *----------------------------------------------- Campo Descricao
		       @044,020 LABEL  Label_Gen_Descricao;
				VALUE "Descrição"        ;
				WIDTH  80		 ;
				HEIGHT 19		 ;
				FONT "MS Sans Serif" SIZE 8 BOLD

		       @040,100 TEXTBOX  Generic_Descricao;
				WIDTH 250		  ;
				FONT "Arial" Size 9       ;
				TOOLTIP "Digite a Descrição";
				MAXLENGTH 30 UPPERCASE;
                ON ENTER Novo_Generic.Generic_Salvar.SetFocus 
	  
               @003,380 FRAME Group_Generic_6 WIDTH 200 HEIGHT 75

		       @10,390 BUTTON Generic_Salvar	;
				CAPTION "&Salvar"            ;
				ACTION { || Bt_Salvar_Generic() } ;
				WIDTH  180		     ;
				HEIGHT	25		     ;
				FONT "MS Sans Serif" SIZE 8 FLAT

		       @40,390 BUTTON Generic_Sair	  ;
				CAPTION "&Cancelar"              ;
				ACTION Novo_Generic.release ;
				WIDTH  180		     ;
				HEIGHT	25		     ;
				FONT "MS Sans Serif" SIZE 8 FLAT

	 END WINDOW

	 If ! lNovo

	    Novo_Generic.Generic_Codigo.Value 	:= AllTrim((cArea)->Codigo)  
	    Novo_Generic.Generic_Descricao.Value := AllTrim((cArea)->Descricao)

	 EndIf

	 Novo_Generic.Statusbar.Item(1) := "        "+cStatus 
	 DISABLE CONTROL Generic_Codigo OF Novo_Generic

	 (cArea)->(DBSetOrder(2))
	 Novo_Generic.Generic_Descricao.SetFocus  

	 CENTER   WINDOW Novo_Generic
	 ACTIVATE WINDOW Novo_Generic

	 lNovo := .F.
	 Return NIL


/*
*/
Function Bt_Excluir_Generic()
	 Local nColuna	   := 1
	 Local nReg	   := PegaValorDaColuna( "Grid_1P" , "Grid_Padrao" , nColuna )
	 Local cNome	   := ""
	 Local cUltimaPesq := Upper(AllTrim(  Grid_Padrao.PesqGeneric.Value   ))

	 cUltimaPesq := Iif( ! Empty(cUltimaPesq) , cUltimaPesq , AlLTrim(cNome) )

	 If Empty(nReg)
	    MsgExclamation("Nenhum Registro Informado para Edição!!",SISTEMA)
	    Return Nil
	  Else
	    (cArea)->(DBSetOrder(1))
	    If ! (cArea)->(DBSeek(nReg))
	       MSGINFO("Erro de Pesquisa!!")
	       Return Nil
	    EndIf
	    If MsgYesNo("Excluir "+AllTrim( (cArea)->Descricao )+" ??",SISTEMA)
	       If BloqueiaRegistroNaRede( cArea )
		  (cArea)->(DBDelete())
		  (cArea)->(DBUnlock())
		  Renova_Pesquisa_Generic(cUltimaPesq)
	       EndIf
	    EndIf
	 EndIf
	 Return Nil

/*
*/
Function Pesquisa_Generic()
	 Local cPesq			             := Upper(AllTrim( Grid_Padrao.PesqGeneric.Value ))
	 Local nTamanhoNomeParaPesquisa      := Len(cPesq)
	 Local nQuantRegistrosProcessados    := 0
	 Local nQuantMaximaDeRegistrosNoGrid := 30

	 (cArea)->(DBSetOrder(2))
	 (cArea)->(DBSeek(cPesq))
	 DELETE ITEM ALL FROM Grid_1P OF Grid_Padrao
	 Do While ! (cArea)->(Eof())
	    if Substr( (cArea)->Descricao,1,nTamanhoNomeParaPesquisa) == cPesq
	       nQuantRegistrosProcessados += 1
	       if nQuantRegistrosProcessados > nQuantMaximaDeRegistrosNoGrid
              EXIT
	       EndIf
	       If Empty( (cArea)->Descricao )
		      MSGBOX("Existe Descrição em Branco Nesta Tabela") 	       
	       Endif
	       ADD ITEM { (cArea)->Codigo,(cArea)->Descricao} TO Grid_1P OF Grid_Padrao
  	    ElseIf Substr( (cArea)->Descricao,1,nTamanhoNomeParaPesquisa) > cPesq
           EXIT
	    Endif
	    (cArea)->(DBSkip())
	 EndDo
	 Grid_Padrao.PesqGeneric.SetFocus  
	 Return Nil

/*
*/
Function Renova_Pesquisa_Generic(cNome)
	 Grid_Padrao.PesqGeneric.Value := Substr(AllTrim(cNome),1,10)
	 Grid_Padrao.PesqGeneric.SetFocus
	 Pesquisa_Generic()
	 Return Nil
/*
*/
Function ChangeGenericCodigo()
	 Local Nr := (cArea)->(Recno())
	 Local Nc := StrZero( Val( Novo_Generic.Generic_Codigo.Value   ) , 04 )
	 Novo_Generic.Generic_Codigo.Value := Nc 
	 (cArea)->(DBSetOrder(1))
	 If (cArea)->(DBSeek(Nc))
	    If lNovo
	       MsgInfo(PadC('Código já Existe para Descrição',70)+QUEBRA+;
		       PadC(AllTrim( (cArea)->Descricao ),70)+QUEBRA,SISTEMA)
	       Novo_Generic.Generic_Codigo.Value :=  "" 
	       Novo_Generic.Generic_Codigo.SetFocus  
	    Else
	       If Nc != CodigoAlt
		  MsgInfo(PadC('Código já Existe para Descrição',70)+QUEBRA+;
			  PadC(AllTrim( (cArea)->Descricao),70)+QUEBRA,SISTEMA)
			  Novo_Generic.Generic_Codigo.Value := "" 
			  Novo_Generic.Generic_Codigo.SetFocus 
	       EndIf
            EndIf
	 EndIf
	 (cArea)->(DBSetOrder(2))
	 (cArea)->(DBGoTo(Nr))
	 Return Nil

/*
*/
Function Navegar_Generic(nOp)
	 Local i    := 0
	 Local nReg := (cArea)->(Recno())

	 (cArea)->(DBSetOrder(2))
	 (cArea)->(DBGoTo(nReg))

	 If	nOp == 1      && Primeiro Registro
		(cArea)->(DBGoTop())
	 ElseIf nOp == 2      && Registro Anterior
		(cArea)->(DBSkip(-1))
	 ElseIf nOp == 3      && Proximo Registro
		(cArea)->(DBSkip())
	 ElseIf nOp == 4      && Ultimo Registro
		(cArea)->(DBGoBottom())
	 EndIf

	 If (cArea)->(Eof())
	    (cArea)->(DBSkip(-1))
	 Endif

	 Novo_Generic.Generic_Codigo.Value     := AllTrim((cArea)->Codigo	  )
	 Novo_Generic.Generic_Descricao.Value  := AllTrim((cArea)->Descricao )

	 Return Nil

/*
*/
Function Bt_Salvar_Generic()
	 Local cCodigo
	 Local cPesq	:= AllTrim( Grid_Padrao.PesqGeneric.Value )

	 If Empty( Novo_Generic.Generic_Descricao.Value )
	    PlayExclamation()
	    MSGINFO("Descrição não Informada !!","Operação Inválida")
	    Novo_Generic.Generic_Descricao.SetFocus 
	    Return Nil
	 EndIf

	 If lNovo	  
	    lNovo    := .F.
	    cCodigo  := GeraCodigo( cArea  , 1 , 04 )
	    (cArea)->(DBAppend())
	    (cArea)->Codigo	:= cCodigo
	    (cArea)->Descricao	:=  Novo_Generic.Generic_Descricao.Value
	    GravouCodigoCorretamente( cArea , cCodigo , 1 )
	    PlayExclamation()
	    MSGExclamation("Inclusão Efetivada no "+cTitulo,SISTEMA)
	    Novo_Generic.Release
	    Renova_Pesquisa_Generic(Substr( (cArea)->Descricao,1,10))
	 Else	         
	    (cArea)->(DBSetOrder(1))
	    If ! (cArea)->(DBSeek(CodigoAlt))
	       PlayExclamation()
	       MsgExclamation("ERRO-G01 # Código não Localizado para Alteração!!",SISTEMA)
	    Else
           If BloqueiaRegistroNaRede( cArea )
              (cArea)->Descricao  :=  Novo_Generic.Generic_Descricao.Value
              (cArea)->(DBUnlock())
              MsgINFO("Registro Alterado!!",SISTEMA)
              Novo_Generic.release
              Renova_Pesquisa_Generic(Substr( (cArea)->Descricao,1,10))
           EndIf
       EndIf
	 EndIf
	 Return Nil
/*
*/
Function Bt_Generic_Sair()
         (cArea)->(DBCloseArea())
         Grid_Padrao.Release

/*
*/
Function GenericOpen( oArea , cAlias )
		 Local nArea   := Select( oArea )
		 Local aarq    := {}
         Local xBase   := DiskName()+":\"+CurDir()+"\BASE\"
         Local ArqBase := xBase + oArea + ".DBF"   	 
		 If nArea == 0		 
            If ! FILE( (ArqBase) )
                 Aadd( aarq , { 'CODIGO'      , 'C' , 04 , 0 } )
                 Aadd( aarq , { 'DESCRICAO'   , 'C' , 30 , 0 } )                
                 DBCreate     ( (ArqBase)     , aarq   )
            EndIf     							  
		    Use (ArqBase) Alias (oArea) new shared
		    If ! File( xBase + oArea + '1.ntx' )
               Index on Codigo    to (xBase)+oArea+"1"
		    Endif
		    If ! File( xBase + oArea + '2.ntx' )
               Index on Descricao to (xBase)+oArea+"2"
		    Endif
		    (oArea)->(DBCLearIndex())
		    (oArea)->(DBSetIndex( xBase + oArea + '1'))
		    (oArea)->(DBSetIndex( xBase + oArea + '2'))
		 Endif
         Return Nil     