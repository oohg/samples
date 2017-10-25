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
* Procedure CadastroGenerico | Cadastro Das Tabelas do Sistema                  *

PROCEDURE CadastroGenerico( oArea , oTitulo )

   LOCAL CodigoAlt := 0

   PRIVATE cArea   := oArea
   PRIVATE cTitulo := oTitulo
   PRIVATE lNovo   := .F.

   GenericOpen( oArea )

   (cArea)->(DBSetOrder(2))

   DEFINE WINDOW Grid_Padrao;
         AT 05,05              ;
         WIDTH   425            ;
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

      @ 357,011 LABEL  Label_Pesq_Generic    ;
         VALUE "Pesquisa "                   ;
         WIDTH 70             ;
         HEIGHT 20             ;
         FONT "Arial" SIZE 09

      @ 353,085 TEXTBOX PesqGeneric    ;
         WIDTH 326             ;
         TOOLTIP "Digite a Descrição para Pesquisa"   ;
         MAXLENGTH 40 UPPERCASE       ;
         ON CHANGE { || Pesquisa_Generic() }

      @ 397,011 BUTTON Generic_Novo       ;
         CAPTION '&Novo'                ;
         ACTION { || Bt_Novo_Generic(1)};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,111 BUTTON Generic_Editar     ;
         CAPTION '&Editar'           ;
         ACTION { || Bt_Novo_Generic(2)};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,211 BUTTON Generic_Excluir    ;
         CAPTION 'E&xcluir'          ;
         ACTION { || Bt_Excluir_Generic()};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,311 BUTTON Generic_Sair       ;
         CAPTION '&Sair'                ;
         ACTION { || Bt_Generic_Sair() };
         FONT "MS Sans Serif" SIZE 09 FLAT

   END WINDOW

   Grid_Padrao.Grid_1P.SetFocus
   Renova_Pesquisa_Generic(" ")

   CENTER   WINDOW Grid_Padrao
   ACTIVATE WINDOW Grid_Padrao

   RETURN NIL

FUNCTION Bt_Novo_Generic(nTipo)

   LOCAL nColuna       := 1

   LOCAL nReg       := PegaValorDaColuna( "Grid_1P" , "Grid_Padrao" , nColuna )

   LOCAL cStatus       := Iif(nTipo==1,"Incluindo Registro","Alterando Registro")

   lNovo          := Iif(nTipo==1,.T.,.F.)

   IF nTipo == 2       && Editar/Alterar
      IF Empty(nReg)
         MsgExclamation("Nenhum Registro Informado para Edição!!",SISTEMA)

         RETURN NIL
      ELSE       && Incluir Novo
         (cArea)->(DBSetOrder(1))
         IF ! (cArea)->(DBSeek(nReg))
            MSGINFO("Erro de Pesquisa!!")

            RETURN NIL
         ENDIF
         CodigoAlt := (cArea)->Codigo
      ENDIF
   ENDIF

   DEFINE WINDOW Novo_Generic;
         AT 10,10             ;
         WIDTH  590             ;
         HEIGHT 129             ;
         TITLE cTitulo         ;
         MODAL                ;
         NOSIZE

      DEFINE STATUSBAR
         STATUSITEM "Manutenção no "+cTitulo
      END STATUSBAR

      @003,005 FRAME Group_Generic_1 WIDTH 370 HEIGHT 75

      *------------------------------------------ Campo Codigo
      @014,020 LABEL  Label_Gen_Codigo    ;
         VALUE "Código"             ;
         WIDTH  70         ;
         HEIGHT 15         ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @010,100 TEXTBOX  Generic_Codigo  ;
         WIDTH 50       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o C¢digo";
         MAXLENGTH 04 UPPERCASE    ;
         ON LOSTFOCUS { || ChangeGenericCodigo() }

      *----------------------------------------------- Campo Descricao
      @044,020 LABEL  Label_Gen_Descricao;
         VALUE "Descrição"        ;
         WIDTH  80       ;
         HEIGHT 19       ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @040,100 TEXTBOX  Generic_Descricao;
         WIDTH 250        ;
         FONT "Arial" Size 9       ;
         TOOLTIP "Digite a Descrição";
         MAXLENGTH 30 UPPERCASE;
         ON ENTER Novo_Generic.Generic_Salvar.SetFocus

      @003,380 FRAME Group_Generic_6 WIDTH 200 HEIGHT 75

      @10,390 BUTTON Generic_Salvar   ;
         CAPTION "&Salvar"            ;
         ACTION { || Bt_Salvar_Generic() } ;
         WIDTH  180           ;
         HEIGHT   25           ;
         FONT "MS Sans Serif" SIZE 8 FLAT

      @40,390 BUTTON Generic_Sair     ;
         CAPTION "&Cancelar"              ;
         ACTION Novo_Generic.release ;
         WIDTH  180           ;
         HEIGHT   25           ;
         FONT "MS Sans Serif" SIZE 8 FLAT

   END WINDOW

   IF ! lNovo

      Novo_Generic.Generic_Codigo.Value    := AllTrim((cArea)->Codigo)
      Novo_Generic.Generic_Descricao.Value := AllTrim((cArea)->Descricao)

   ENDIF

   Novo_Generic.Statusbar.Item(1) := "        "+cStatus
   DISABLE CONTROL Generic_Codigo OF Novo_Generic

   (cArea)->(DBSetOrder(2))
   Novo_Generic.Generic_Descricao.SetFocus

   CENTER   WINDOW Novo_Generic
   ACTIVATE WINDOW Novo_Generic

   lNovo := .F.

   RETURN NIL

FUNCTION Bt_Excluir_Generic()

   LOCAL nColuna      := 1

   LOCAL nReg      := PegaValorDaColuna( "Grid_1P" , "Grid_Padrao" , nColuna )

   LOCAL cNome      := ""

   LOCAL cUltimaPesq := Upper(AllTrim(  Grid_Padrao.PesqGeneric.Value   ))

   cUltimaPesq := Iif( ! Empty(cUltimaPesq) , cUltimaPesq , AlLTrim(cNome) )

   IF Empty(nReg)
      MsgExclamation("Nenhum Registro Informado para Edição!!",SISTEMA)

      RETURN NIL
   ELSE
      (cArea)->(DBSetOrder(1))
      IF ! (cArea)->(DBSeek(nReg))
         MSGINFO("Erro de Pesquisa!!")

         RETURN NIL
      ENDIF
      IF MsgYesNo("Excluir "+AllTrim( (cArea)->Descricao )+" ??",SISTEMA)
         IF BloqueiaRegistroNaRede( cArea )
            (cArea)->(DBDelete())
            (cArea)->(DBUnlock())
            Renova_Pesquisa_Generic(cUltimaPesq)
         ENDIF
      ENDIF
   ENDIF

   RETURN NIL

FUNCTION Pesquisa_Generic()

   LOCAL cPesq                      := Upper(AllTrim( Grid_Padrao.PesqGeneric.Value ))

   LOCAL nTamanhoNomeParaPesquisa      := Len(cPesq)

   LOCAL nQuantRegistrosProcessados    := 0

   LOCAL nQuantMaximaDeRegistrosNoGrid := 30

   (cArea)->(DBSetOrder(2))
   (cArea)->(DBSeek(cPesq))
   DELETE ITEM ALL FROM Grid_1P OF Grid_Padrao
   DO WHILE ! (cArea)->(Eof())
      IF Substr( (cArea)->Descricao,1,nTamanhoNomeParaPesquisa) == cPesq
         nQuantRegistrosProcessados += 1
         IF nQuantRegistrosProcessados > nQuantMaximaDeRegistrosNoGrid
            EXIT
         ENDIF
         IF Empty( (cArea)->Descricao )
            MSGBOX("Existe Descrição em Branco Nesta Tabela")
         ENDIF
         ADD ITEM { (cArea)->Codigo,(cArea)->Descricao} TO Grid_1P OF Grid_Padrao
      ELSEIF Substr( (cArea)->Descricao,1,nTamanhoNomeParaPesquisa) > cPesq
         EXIT
      ENDIF
      (cArea)->(DBSkip())
   ENDDO
   Grid_Padrao.PesqGeneric.SetFocus

   RETURN NIL

FUNCTION Renova_Pesquisa_Generic(cNome)

   Grid_Padrao.PesqGeneric.Value := Substr(AllTrim(cNome),1,10)
   Grid_Padrao.PesqGeneric.SetFocus
   Pesquisa_Generic()

   RETURN NIL

FUNCTION ChangeGenericCodigo()

   LOCAL Nr := (cArea)->(Recno())

   LOCAL Nc := StrZero( Val( Novo_Generic.Generic_Codigo.Value   ) , 04 )

   Novo_Generic.Generic_Codigo.Value := Nc
   (cArea)->(DBSetOrder(1))
   IF (cArea)->(DBSeek(Nc))
      IF lNovo
         MsgInfo(PadC('Código já Existe para Descrição',70)+QUEBRA+;
            PadC(AllTrim( (cArea)->Descricao ),70)+QUEBRA,SISTEMA)
         Novo_Generic.Generic_Codigo.Value :=  ""
         Novo_Generic.Generic_Codigo.SetFocus
      ELSE
         IF Nc != CodigoAlt
            MsgInfo(PadC('Código já Existe para Descrição',70)+QUEBRA+;
               PadC(AllTrim( (cArea)->Descricao),70)+QUEBRA,SISTEMA)
            Novo_Generic.Generic_Codigo.Value := ""
            Novo_Generic.Generic_Codigo.SetFocus
         ENDIF
      ENDIF
   ENDIF
   (cArea)->(DBSetOrder(2))
   (cArea)->(DBGoTo(Nr))

   RETURN NIL

FUNCTION Navegar_Generic(nOp)

   LOCAL i    := 0

   LOCAL nReg := (cArea)->(Recno())

   (cArea)->(DBSetOrder(2))
   (cArea)->(DBGoTo(nReg))

   IF   nOp == 1      && Primeiro Registro
      (cArea)->(DBGoTop())
   ELSEIF nOp == 2      && Registro Anterior
      (cArea)->(DBSkip(-1))
   ELSEIF nOp == 3      && Proximo Registro
      (cArea)->(DBSkip())
   ELSEIF nOp == 4      && Ultimo Registro
      (cArea)->(DBGoBottom())
   ENDIF

   IF (cArea)->(Eof())
      (cArea)->(DBSkip(-1))
   ENDIF

   Novo_Generic.Generic_Codigo.Value     := AllTrim((cArea)->Codigo     )
   Novo_Generic.Generic_Descricao.Value  := AllTrim((cArea)->Descricao )

   RETURN NIL

FUNCTION Bt_Salvar_Generic()

   LOCAL cCodigo

   LOCAL cPesq   := AllTrim( Grid_Padrao.PesqGeneric.Value )

   IF Empty( Novo_Generic.Generic_Descricao.Value )
      PlayExclamation()
      MSGINFO("Descrição não Informada !!","Operação Inválida")
      Novo_Generic.Generic_Descricao.SetFocus

      RETURN NIL
   ENDIF

   IF lNovo
      lNovo    := .F.
      cCodigo  := GeraCodigo( cArea  , 1 , 04 )
      (cArea)->(DBAppend())
      (cArea)->Codigo   := cCodigo
      (cArea)->Descricao   :=  Novo_Generic.Generic_Descricao.Value
      GravouCodigoCorretamente( cArea , cCodigo , 1 )
      PlayExclamation()
      MSGExclamation("Inclusão Efetivada no "+cTitulo,SISTEMA)
      Novo_Generic.Release
      Renova_Pesquisa_Generic(Substr( (cArea)->Descricao,1,10))
   ELSE
      (cArea)->(DBSetOrder(1))
      IF ! (cArea)->(DBSeek(CodigoAlt))
         PlayExclamation()
         MsgExclamation("ERRO-G01 # Código não Localizado para Alteração!!",SISTEMA)
      ELSE
         IF BloqueiaRegistroNaRede( cArea )
            (cArea)->Descricao  :=  Novo_Generic.Generic_Descricao.Value
            (cArea)->(DBUnlock())
            MsgINFO("Registro Alterado!!",SISTEMA)
            Novo_Generic.release
            Renova_Pesquisa_Generic(Substr( (cArea)->Descricao,1,10))
         ENDIF
      ENDIF
   ENDIF

   RETURN NIL

FUNCTION Bt_Generic_Sair()

   (cArea)->(DBCloseArea())
   Grid_Padrao.Release

   FUNCTION GenericOpen( oArea , cAlias )

      LOCAL nArea   := Select( oArea )

      LOCAL aarq    := {}

      LOCAL xBase   := DiskName()+":\"+CurDir()+"\BASE\"

      LOCAL ArqBase := xBase + oArea + ".DBF"

      IF nArea == 0
         IF ! FILE( (ArqBase) )
            Aadd( aarq , { 'CODIGO'      , 'C' , 04 , 0 } )
            Aadd( aarq , { 'DESCRICAO'   , 'C' , 30 , 0 } )
            DBCreate     ( (ArqBase)     , aarq   )
         ENDIF
         USE (ArqBase) Alias (oArea) new shared
         IF ! File( xBase + oArea + '1.ntx' )
            INDEX on Codigo    to (xBase)+oArea+"1"
         ENDIF
         IF ! File( xBase + oArea + '2.ntx' )
            INDEX on Descricao to (xBase)+oArea+"2"
         ENDIF
         (oArea)->(DBCLearIndex())
         (oArea)->(DBSetIndex( xBase + oArea + '1'))
         (oArea)->(DBSetIndex( xBase + oArea + '2'))
      ENDIF

      RETURN NIL
