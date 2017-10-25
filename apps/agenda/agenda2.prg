/*
* Agenda de Contatos
* Humberto Fornazier - Agosto/2002
* hfornazier@brfree.com.br
*
* xHarbour Compiler Build 0.73.5 (SimpLex )
* Copyright 1999-2002, http://www.xharbour.org https://harbour.github.io/
*
* MINIGUI - Harbour Win32 GUI library - Release 35
* Copyright 2002 Roberto Lopez <roblez@ciudad.com.ar>
* http://www.geocities.com/harbour_minigui/
*/
#include "Agenda.ch"
#include "Inkey.ch"
#include "oohg.ch"
*#include "hbprint.ch"

DECLARE WINDOW Form_Agenda

* Procedure Agenda2                           *

PROCEDURE Agenda2()

   PRIVATE lNovo       := .F.
   PRIVATE CodigoAlt   := ""
   PRIVATE aTipos      := {}
   PRIVATE ComboTipos  := {}

   DEFINE WINDOW Form_Agenda      ;
         AT 05,05         ;
         WIDTH   425         ;
         HEIGHT 460         ;
         TITLE "Agenda"                 ;
         MODAL            ;
         NOSIZE

      @ 010,010 GRID Grid_Agenda   ;
         WIDTH  398         ;
         HEIGHT 331         ;
         HEADERS {"Código","Nome"}    ;
         WIDTHS  {80,315}      ;
         FONT "Arial" SIZE 09         ;
         ON DBLCLICK { || Bt_Novo_Agenda(2) }

      @ 357,011 LABEL  Label_Pesq_Nome    ;
         VALUE "Nome para Pesquisa: "        ;
         WIDTH 125             ;
         HEIGHT 27             ;
         FONT "Arial" SIZE 09

      @ 353,147 TEXTBOX PesqAgenda     ;
         WIDTH 258             ;
         TOOLTIP "Nome para Pesquisa"        ;
         MAXLENGTH 40 UPPERCASE       ;
         ON CHANGE { || Pesquisa_Agenda() }

      @ 397,011 BUTTON Agenda_Novo     ;
         CAPTION '&Novo'             ;
         ACTION { || Bt_Novo_Agenda(1)};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,111 BUTTON Agenda_Editar    ;
         CAPTION '&Editar'           ;
         ACTION { || Bt_Novo_Agenda(2)};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,211 BUTTON Agenda_Excluir    ;
         CAPTION 'E&xcluir'          ;
         ACTION { || Bt_Agenda_Excluir()};
         FONT "MS Sans Serif" SIZE 09 FLAT

      @ 397,311 BUTTON Agenda_Sair      ;
         CAPTION '&Sair'              ;
         ACTION Form_Agenda.Release ;
         FONT "MS Sans Serif" SIZE 09 FLAT

   END WINDOW

   AgendaOpen()
   GenericOpen("Tipos")

   Agenda->(DBSetOrder(2))
   Pesquisa_Agenda()
   Form_Agenda.PesqAgenda.SetFocus
   CENTER   WINDOW Form_Agenda

   ACTIVATE WINDOW Form_Agenda

   RETURN NIL

FUNCTION Bt_Novo_Agenda(nTipo)

   LOCAL aAmbiente    := SvAmb()

   LOCAL nColuna       := 1

   LOCAL nReg       := PegaValorDaColuna( "Grid_Agenda" , "Form_Agenda" , nColuna)

   LOCAL nLinha1       := 0

   LOCAL VlComboTipos := 1

   LOCAL cTitulo       := Iif(nTipo==1,"Agenda = Incluindo Novo Registro","Agenda = Alterando Registro")

   aTipos         := {}
   ComboTipos     := {}

   lNovo          := Iif(nTipo==1,.T.,.F.)

   IF nTipo == 2       && Editar/Alterar
      IF Empty(nReg)
         MsgExclamation("Nenhum Registro Informado para Edição!!",SISTEMA)

         RETURN NIL
      ELSE       && Incluir Novo
         Agenda->(DBSetOrder(1))
         IF ! Agenda->(DBSeek(nReg))
            MSGINFO("Erro de Pesquisa!!")
         ENDIF
         CodigoAlt := Agenda->Codigo
      ENDIF
   ENDIF

   GnEncheTabela( "Tipos" , @VlComboTipos , Agenda->Tipo , @ComboTipos , @aTipos )

   DEFINE WINDOW Novo_Agenda      ;
         AT 10,10         ;
         WIDTH  475         ;
         HEIGHT 420         ;
         TITLE cTitulo         ;
         MODAL            ;
         NOSIZE

      DEFINE STATUSBAR
         STATUSITEM "Manutenção no Cadastro dos Contatos"
      END STATUSBAR

      @002,005 FRAME Group_Agenda_1 WIDTH 460 HEIGHT 160

      *------------------------------------------ Codigo
      @014,020 LABEL  Label_Agenda_Codigo ;
         VALUE "Código    "         ;
         WIDTH  70         ;
         HEIGHT 15         ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @010,100 TEXTBOX  Agenda_Codigo    ;
         WIDTH 50       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Codigo";
         MAXLENGTH 10 UPPERCASE

      *------------------------------------------------- Tipo
      @014,210 LABEL Label_Agenda_Tipo    ;
         VALUE "Tipo"      ;
         WIDTH 80      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @010,250 COMBOBOX Combo_Tipos    ;
         ITEMS ComboTipos  ;
         VALUE VlComboTipos ;
         WIDTH 200       ;
         FONT "Arial" SIZE 9      ;
         TOOLTIP "Tipo de Contato"

      *----------------------------------------------- Nome do Contato
      @044,020 LABEL  Label_Agenda_Nome ;
         VALUE "Nome    "         ;
         WIDTH  80       ;
         HEIGHT 19       ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @040,100 TEXTBOX  Agenda_Nome     ;
         WIDTH 350       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Nome do Contato";
         MAXLENGTH 40 UPPERCASE    ;
         ON LOSTFOCUS { || Alu_Habilita_Tecla() };
         ON ENTER Novo_Agenda.Agenda_Endereco.SetFocus

      *------------------------------------------------- Endereço
      @074,020 LABEL Label_Agenda_Endereco ;
         VALUE "Endereço"      ;
         WIDTH 80      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @070,100 TEXTBOX  Agenda_Endereco    ;
         WIDTH 350       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Endereço do Contato";
         MAXLENGTH 40 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Bairro.SetFocus

      *------------------------------------------------- Bairro
      @104,020 LABEL Label_Agenda_Bairro;
         VALUE "Bairro"      ;
         WIDTH 80      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @100,100 TEXTBOX  Agenda_Bairro     ;
         WIDTH 220    ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Bairro do Contato";
         MAXLENGTH 30 UPPERCASE   ;
         ON ENTER Novo_Agenda.Agenda_Cep.SetFocus

      *------------------------------------------------- Cep
      @104,330 LABEL Label_Agenda_Cep;
         VALUE "Cep"      ;
         WIDTH 50      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @100,370 TEXTBOX  Agenda_Cep     ;
         WIDTH 80    ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Cep do Contato";
         MAXLENGTH 09 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Cidade.SetFocus

      *------------------------------------------------- Cidade
      @134,020 LABEL Label_Agenda_Cidade;
         VALUE "Cidade"      ;
         WIDTH 80      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @130,100 TEXTBOX  Agenda_Cidade      ;
         WIDTH 220       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite a Cidade do Contato";
         MAXLENGTH 30 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Estado.SetFocus

      *------------------------------------------------- Estado
      @134,330 LABEL Label_Agenda_Estado;
         VALUE "UF"      ;
         WIDTH 50      ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" Size 8 BOLD

      @130,370 TEXTBOX  Agenda_Estado     ;
         WIDTH 40    ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Estado do Contato";
         MAXLENGTH 02 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Fone1.SetFocus

      @165,005 FRAME Group_Agenda_2 WIDTH 460 HEIGHT 100

      *------------------------------------------ Fone #1
      @174,020 LABEL  Label_Agenda_Fone1;
         VALUE "Telefone #1";
         WIDTH  70         ;
         HEIGHT 15         ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @170,100 TEXTBOX  Agenda_Fone1 ;
         WIDTH 80       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Telefone #1 do Contato";
         MAXLENGTH 10 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Fone2.SetFocus

      *------------------------------------------ Fone #1
      @174,290 LABEL  Label_Agenda_Fone2;
         VALUE "Telefone #2";
         WIDTH  70         ;
         HEIGHT 15         ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @170,370 TEXTBOX  Agenda_Fone2 ;
         WIDTH 80       ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o Telefone #2 do Contato";
         MAXLENGTH 10 UPPERCASE;
         ON ENTER Novo_Agenda.Agenda_Email.SetFocus

      @204,020 LABEL  Label_Agenda_Email ;
         VALUE "Email   "         ;
         WIDTH  80 ;
         HEIGHT 19       ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @200,100 TEXTBOX  Agenda_Email ;
         WIDTH 350 ;
         FONT "Arial" Size 9      ;
         TOOLTIP "Digite o E-Mail do Contato";
         MAXLENGTH 40 LOWERCASE;
         ON ENTER Novo_Agenda.Agenda_Nascto.SetFocus

      *--------------------------------------------- Data de Nascto
      @234,020 LABEL Label_Agenda_Nascto;
         VALUE "Nascto"   ;
         WIDTH 80       ;
         HEIGHT 27       ;
         FONT "MS Sans Serif" SIZE 8 BOLD

      @230,100 DATEPICKER Agenda_Nascto  ;
         VALUE Agenda->Nascto    ;
         FONT "arial" Size 9      ;
         TOOLTIP 'Data de Nascimento do Contato'

      @270,005 FRAME Group_Alunos_3 WIDTH 460 HEIGHT 048  ;

      @283,020 BUTTON Agenda_Salvar       ;
         CAPTION "&Salvar"            ;
         ACTION { || Bt_Salvar_Agenda() } ;
         FONT "MS Sans Serif" SIZE 8 FLAT

      @283,350 BUTTON Agenda_Sair         ;
         CAPTION "Sai&r"              ;
         ACTION Novo_Agenda.release ;
         FONT "MS Sans Serif" SIZE 8 FLAT

      @322,005 FRAME Group_Agenda_4 WIDTH 460 HEIGHT 048

      @335,020 BUTTON Agenda_Primeiro    ;
         CAPTION "&Primeiro"               ;
         ACTION { || Navegar_Agenda(1) } ;
         FONT "Arial" SIZE 8 FLAT

      @335,130 BUTTON  Agenda_Anterior   ;
         CAPTION "&Anterior"               ;
         ACTION { || Navegar_Agenda(2) };
         FONT "Arial" SIZE 8 FLAT

      @335,240 BUTTON  Agenda_Proximo    ;
         CAPTION "Pro&ximo"               ;
         ACTION { || Navegar_Agenda(3) } ;
         FONT "Arial" SIZE 8 FLAT

      @335,350 BUTTON  Agenda_Ultimo      ;
         CAPTION "&Ultimo"                 ;
         ACTION { || Navegar_Agenda(4) } ;
         FONT "Arial" SIZE 8 FLAT

   END WINDOW

   DISABLE CONTROL Agenda_Codigo OF Novo_Agenda

   IF ! lNovo

      ENABLE CONTROL Agenda_Primeiro OF Novo_Agenda
      ENABLE CONTROL Agenda_Anterior OF Novo_Agenda
      ENABLE CONTROL Agenda_Proximo  OF Novo_Agenda
      ENABLE CONTROL Agenda_Ultimo   OF Novo_Agenda

      AgendaPush()

   ELSE

      DISABLE CONTROL Agenda_Primeiro OF Novo_Agenda
      DISABLE CONTROL Agenda_Anterior OF Novo_Agenda
      DISABLE CONTROL Agenda_Proximo  OF Novo_Agenda
      DISABLE CONTROL Agenda_Ultimo   OF Novo_Agenda
      DISABLE CONTROL Agenda_Salvar   OF Novo_Agenda

   ENDIF

   Agenda->(DBSetOrder(2))
   Novo_Agenda.Agenda_Nome.SetFocus
   CENTER   WINDOW Novo_Agenda
   ACTIVATE WINDOW Novo_Agenda
   lNovo := .F.

   RETURN NIL

FUNCTION Bt_Agenda_Excluir()

   LOCAL nOrd      := Agenda->(IndexOrd())

   LOCAL nColuna      := 1

   LOCAL nReg       := PegaValorDaColuna( "Grid_Agenda" , "Form_Agenda" , nColuna)

   LOCAL cNome      := ""

   LOCAL cUltimaPesq := Upper( AllTrim ( Form_Agenda.PesqAgenda.Value ))

   cUltimaPesq := Iif( ! Empty(cUltimaPesq) , cUltimaPesq , AlLTrim(cNome) )

   IF Empty(nReg)
      MsgExclamation("Nenhum Registro Informado para Exclusão!!",SISTEMA)

      RETURN NIL
   ELSE
      Agenda->(DBSetOrder(1))
      IF ! Agenda->(DBSeek(nReg))
         MSGINFO("Erro de Pesquisa!!")

         RETURN NIL
      ENDIF
      IF MsgYesNo("Excluir Contato "+AllTrim(Agenda->Nome)+" ??",SISTEMA)
         IF BloqueiaRegistroNaRede("Agenda")
            Agenda->(DBDelete())
            Agenda->(DBUnlock())
            Agenda->(DBSetOrder(nOrd))
            Renova_Pesquisa_Agenda(cUltimaPesq)
         ENDIF
      ENDIF
   ENDIF

   RETURN NIL

FUNCTION Bt_Salvar_Agenda()

   LOCAL cCodigo

   LOCAL cPesq   := AllTrim( Form_Agenda.PesqAgenda.Value )

   LOCAL nPosTipo   := Novo_Agenda.Combo_Tipos.Value

   IF Empty( Novo_Agenda.Agenda_Nome.Value )
      PlayExclamation()
      MSGINFO("Nome do Contato não Informado !!","Operação Inválida")
      Novo_Agenda.Agenda_Nome.SetFocus

      RETURN NIL
   ENDIF

   IF lNovo
      lNovo    := .F.
      cCodigo  := GeraCodigo("Agenda"  , 1 , 04 )
      Agenda->(DBAppend())
      Agenda->Codigo      := cCodigo
      Agenda->Nome        := Novo_Agenda.Agenda_Nome.Value
      Agenda->Endereco    := Novo_Agenda.Agenda_Endereco.Value
      Agenda->Bairro      := Novo_Agenda.Agenda_Bairro.Value
      Agenda->Cep         := Novo_Agenda.Agenda_Cep.Value
      Agenda->Cidade      := Novo_Agenda.Agenda_Cidade.Value
      Agenda->Estado      := Novo_Agenda.Agenda_Estado.Value
      Agenda->Fone1       := Novo_Agenda.Agenda_Fone1.Value
      Agenda->Fone2       := Novo_Agenda.Agenda_Fone2.Value
      Agenda->Email       := Novo_Agenda.Agenda_Email.Value
      Agenda->Nascto      := Novo_Agenda.Agenda_Nascto.Value
      Agenda->Tipo       := aTipos[nPosTipo]
      GravouCodigoCorretamente( "Agenda",cCodigo,1)
      MSGExclamation("Registro Incluído no Cadastro!!",SISTEMA)
      Novo_Agenda.Release
      Renova_Pesquisa_Agenda(Substr(Agenda->Nome,1,10))
   ELSE
      Agenda->(DBSetOrder(1))
      IF ! Agenda->(DBSeek(CodigoAlt))
         MsgExclamation("ERRO-G01 # Contato não Localizado para Alteração!!",SISTEMA)
      ELSE
         IF BloqueiaRegistroNaRede("Agenda")
            Agenda->Nome     := Novo_Agenda.Agenda_Nome.Value
            Agenda->Endereco := Novo_Agenda.Agenda_Endereco.Value
            Agenda->Bairro   := Novo_Agenda.Agenda_Bairro.Value
            Agenda->Cep      := Novo_Agenda.Agenda_Cep.Value
            Agenda->Cidade   := Novo_Agenda.Agenda_Cidade.Value
            Agenda->Estado   := Novo_Agenda.Agenda_Estado.Value
            Agenda->Fone1    := Novo_Agenda.Agenda_Fone1.Value
            Agenda->Fone2    := Novo_Agenda.Agenda_Fone2.Value
            Agenda->Email    := Novo_Agenda.Agenda_Email.Value
            Agenda->Nascto   := Novo_Agenda.Agenda_Nascto.Value
            Agenda->Tipo     := aTipos[nPosTipo]
            Agenda->(DBUnlock())
            MsgINFO("Registro Alterado!!",SISTEMA)
            Renova_Pesquisa_Agenda(Substr(Agenda->Nome,1,10))
         ENDIF
      ENDIF
   ENDIF

   RETURN NIL

FUNCTION Pesquisa_Agenda()

   LOCAL cPesq                   := Upper ( AllTrim ( Form_Agenda.PesqAgenda.Value ) )

   LOCAL nTamanhoNomeParaPesquisa      := Len(cPesq)

   LOCAL nQuantRegistrosProcessados    := 0

   LOCAL nQuantMaximaDeRegistrosNoGrid := 30

   Agenda->(DBSetOrder(2))
   Agenda->(DBSeek(cPesq))
   DELETE ITEM ALL FROM Grid_Agenda OF Form_Agenda
   DO WHILE ! Agenda->(Eof())
      IF Substr(Agenda->Nome,1,nTamanhoNomeParaPesquisa) == cPesq
         nQuantRegistrosProcessados += 1
         IF nQuantRegistrosProcessados > nQuantMaximaDeRegistrosNoGrid
            EXIT
         ENDIF
         ADD ITEM {Agenda->Codigo,Agenda->Nome} TO Grid_Agenda OF Form_Agenda
      ELSEIF Substr(Agenda->Nome,1,nTamanhoNomeParaPesquisa) > cPesq
         EXIT
      ENDIF
      Agenda->(DBSkip())
   ENDDO
   *    Form_Agenda.Novo_Agenda.SetFocus

   RETURN NIL

FUNCTION Renova_Pesquisa_Agenda(cNome)

   Form_Agenda.PesqAgenda.Value :=  Substr(AllTrim(cNome),1,10)
   Form_Agenda.PesqAgenda.SetFocus
   Pesquisa_Agenda()

   RETURN NIL

FUNCTION PegaValorDaColuna( xObj, xForm, nCol)

   LOCAL nPos := GetProperty ( xForm , xObj , 'Value' )

   LOCAL aRet := GetProperty ( xForm , xObj , 'Item' , nPos )

   RETURN aRet[nCol]

FUNCTION Navegar_Agenda(nOp)

   LOCAL i    := 0

   LOCAL nReg := Agenda->(Recno())

   Agenda->(DBSetOrder(2))
   Agenda->(DBGoTo(nReg))

   IF   nOp == 1      && Primeiro Registro
      Agenda->(DBGoTop())
   ELSEIF nOp == 2      && Registro Anterior
      Agenda->(DBSkip(-1))
   ELSEIF nOp == 3      && Proximo Registro
      Agenda->(DBSkip())
   ELSEIF nOp == 4      && Ultimo Registro
      Agenda->(DBGoBottom())
   ENDIF

   IF Agenda->(Eof())
      Agenda->(DBSkip(-1))
   ENDIF

   AgendaPush()

   RETURN NIL

FUNCTION AgendaPush()

   Novo_Agenda.Agenda_Codigo.Value   := Agenda->Codigo
   Novo_Agenda.Agenda_Nome.Value     := AllTrim(Agenda->Nome)
   Novo_Agenda.Agenda_Endereco.Value := AllTrim(Agenda->Endereco)
   Novo_Agenda.Agenda_Bairro.Value   := AllTrim(Agenda->Bairro)
   Novo_Agenda.Agenda_Cep.Value      := AllTrim(Agenda->Cep)
   Novo_Agenda.Agenda_Cidade.Value   := AllTrim(Agenda->Cidade)
   Novo_Agenda.Agenda_Estado.Value   := AllTrim(Agenda->Estado)
   Novo_Agenda.Agenda_Fone1.Value    := AllTrim(Agenda->Fone1)
   Novo_Agenda.Agenda_Fone2.Value    := AllTrim(Agenda->Fone2)
   Novo_Agenda.Agenda_Email.Value    := AllTrim(Agenda->Email)
   Novo_Agenda.Agenda_Nascto.Value   := Agenda->Nascto

   FOR i := 1 To Len(aTipos)
      IF aTipos[i] == Agenda->Tipo
         Novo_Agenda.Combo_Tipos.Value := i
         EXIT
      ENDIF
   NEXT

   RETURN NIL

FUNCTION Alu_Habilita_Tecla()

   ENABLE CONTROL Agenda_Salvar OF Novo_Agenda

   RETURN NIL

FUNCTION Relatorio_Contatos()

   PlayExclamation()
   MsgExclamation("Rotina sera Implementada na Pr¢xima VersÆo!!",SISTEMA)

   RETURN NIL

FUNCTION Bt_Implementar()

   PlayExclamation()
   MsgExclamation("Rotina sera Implementada na Pr¢xima VersÆo!!",SISTEMA)

   RETURN NIL

FUNCTION AgendaOpen()

   LOCAL nArea   := Select( 'Agenda' )

   LOCAL aarq    := {}

   LOCAL xBase   := DiskName()+":\"+CurDir()+"\BASE\"

   LOCAL ArqBase := xBase + "Agenda.DBF"

   IF nArea == 0
      IF ! FILE( (ArqBase) )
         Aadd( aArq , { 'CODIGO'     , 'C' , 04 , 0 } )
         Aadd( aArq , { 'NOME '      , 'C' , 40 , 0 } )
         Aadd( aArq , { 'ENDERECO'   , 'C' , 40 , 0 } )
         Aadd( aArq , { 'BAIRRO'     , 'C' , 25 , 0 } )
         Aadd( aArq , { 'CEP'        , 'C' ,  8 , 0 } )
         Aadd( aArq , { 'CIDADE'     , 'C' , 25 , 0 } )
         Aadd( aArq , { 'ESTADO'     , 'C' ,  2 , 0 } )
         Aadd( aArq , { 'NASCTO'     , 'D' ,  8 , 0 } )
         Aadd( aArq , { 'FONE1'      , 'C' , 10 , 0 } )
         Aadd( aArq , { 'FONE2'      , 'C' , 10 , 0 } )
         Aadd( aArq , { 'TIPO'       , 'C' , 04 , 0 } )
         Aadd( aArq , { 'EMAIL'      , 'C' , 40 , 0 } )
         DBCreate     ( (ArqBase)     , aarq  )
         **** Cria 10 Registros na Instalação
         USE (ArqBase) Alias Agenda new shared
         Agenda->(DBAppend())
         Agenda->Codigo := "0001"
         Agenda->Nome   := "WENDEL SANTOS"
         Agenda->(DBAppend())
         Agenda->Codigo := "0002"
         Agenda->Nome   := "HUMBERTO SANTIAGO"
         Agenda->(DBAppend())
         Agenda->Codigo := "0003"
         Agenda->Nome   := "JULIA SOARES CAMARGOS"
         Agenda->(DBAppend())
         Agenda->Codigo := "0004"
         Agenda->Nome   := "GETULIO VIEIRA SOUTO"
         Agenda->(DBAppend())
         Agenda->Codigo := "0005"
         Agenda->Nome   := "MATHEUS CARDOSO NEVES"
         Agenda->(DBAppend())
         Agenda->Codigo := "0006"
         Agenda->Nome   := "LUCIA HELENA MEIRELES"
         Agenda->(DBAppend())
         Agenda->Codigo := "0007"
         Agenda->Nome   := "NEWTON JORGE AMARAL"
         Agenda->(DBAppend())
         Agenda->Codigo := "0008"
         Agenda->Nome   := "PAULO DE SOUZA"
         Agenda->(DBAppend())
         Agenda->Codigo := "0009"
         Agenda->Nome   := "ROSA MATHIAS DE SOUZA"
         Agenda->(DBAppend())
         Agenda->Codigo := "0010"
         Agenda->Nome   := "CARLOS DUILIO SAMPAIO"
         Agenda->(DBCloseArea())
      ENDIF
      USE (ArqBase) Alias Agenda new shared
      IF ! File( xBase+'Agenda1.ntx' )
         INDEX on Codigo to (xBase)+"Agenda1"
      ENDIF
      IF ! File( xBase+'Agenda2.ntx' )
         INDEX on Nome   to (xBase)+"Agenda2"
      ENDIF
      Agenda->(DBCLearIndex())
      Agenda->(DBSetIndex( xBase+'Agenda1'))
      Agenda->(DBSetIndex( xBase+'Agenda2'))
   ENDIF

   RETURN NIL
