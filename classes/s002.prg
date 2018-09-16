#include "minigui.ch"

*************
FUNCTION Main
*************
Local nTempo_espera := 10        //Tempo a ser esperado ate chamar a funcao

Local cNome_funcao := "LOGOFF()" //nome da funcao a ser chamada quando
                                //chegar no tempo de espera

Local lTimerContinua := .f.      //se apos executar a funcao , continua monitorando
                                //a inatividade do mouse e teclado.

define window sample at 0,0 width 640 height 480 ;
  title "Teste de teclado e mouse" ;
  main ;
  on init tinativo():new(thiswindow.name, nTempo_espera, cNome_funcao, lTimerContinua)

 @12, 10 LABEL Label_1 VALUE "Text_1" width 80 RIGHTALIGN

 @10, 95 TEXTBOX Text_1 ;
   VALUE 10 ;
   NUMERIC

 @42, 10 LABEL Label_2 VALUE "Text_2" width 80 RIGHTALIGN

 @40, 95 TEXTBOX Text_2 ;
   VALUE 20 ;
   NUMERIC

 @72, 10 LABEL Label_3 VALUE "Text_3" width 80 RIGHTALIGN

 @70, 95 TEXTBOX Text_3 ;
   VALUE 30 ;
   NUMERIC

end window
sample.Text_1.setfocus
center window sample
activate window sample

RETURN Nil


FUNCTION logoff

MsgExclamation("AQUI ENTRA SUA FUNCAO DE LOGOFF !","AVISO")

sample.release

RETURN Nil


*****TINATIVO.PRG
*****************************************
* CLASSE PARA DETECTAR SE O SISTEMA ESTA
* INATIVO POR (N) SEGUNDOS, E SE ESTIVER,
* CHAMA UMA FUNCAO (PODE SER UMA FUNCAO
* DE LOGOFF , DESCANSO DE TELA , ETC..)
*****************************************
* AUTOR DA FUNÈCO ORIGINAL :
* POMPEO (GUARATINGUETA)
* MIGRAÈCO DA FUNÈCO PARA CLASSE:
* WILLIAM DE BRITO ADAMI
*****************************************
#include "hbclass.ch"

CLASS TINATIVO

DATA nTimeInpAntes
DATA nTimeInpDepois
DATA cTimeAtu
DATA nTempo
DATA cParentForm
DATA cTimerTime
DATA cFunc
DATA lContinuar

METHOD New( cForm, nTime, cFuncao, lContinua ) CONSTRUCTOR

METHOD ver_tempo()

ENDCLASS


*****************************************
METHOD New(cForm, ntime, cFuncao, lContinua) CLASS TINATIVO
*****************************************
::cfunc:=cfuncao
::ntempo:=ntime
::lContinuar:=lContinua
::cParentForm:=cForm
::cTimerTime := 'InactiveTimer'
TTimer():Define( ::cTimerTime , ::cParentForm , 1000 , {|| ::VER_TEMPO() } )
::cTimeAtu := TIME()
::nTimeInpAntes := getInputState() // 0 = erro

return self


*****************************************
METHOD VER_TEMPO CLASS TINATIVO
*****************************************
LOCAL aux
::nTimeInpDepois := getInputState()
if ::nTimeInpDepois - ::nTimeInpAntes > 0
  ::nTimeInpAntes := getInputState()
  ::cTimeAtu := TIME()
endif


if CONVTIME(TIME()) - CONVTIME(::cTimeAtu) > ::ntempo

  setproperty( ::cParentForm , ::cTimerTime , 'Enabled', .f. )
  aux := ::cfunc

  // aqui executa a funcao
  &aux

  if ::lContinuar
     setproperty( ::cParentForm , ::cTimerTime , 'Enabled', .t. )
     ::cTimeAtu := TIME()
  endif

endif

return NIL


*****************************************
STATIC FUNCTION CONVTIME(ZZ)
*****************************************
RETURN (VAL(LEFT(ZZ,2))*360)+(VAL(SUBSTR(ZZ,4,2))*60)+VAL(RIGHT(ZZ,2))


//----------------------------------------------------------------------

#pragma BEGINDUMP

#include "windows.h"
#include "hbapi.h"

typedef BOOL ( WINAPI * GETLASTINPUTINFO ) ( PLASTINPUTINFO );

HB_FUNC( GETINPUTSTATE )
{
  HINSTANCE handle = LoadLibrary("user32.dll");

  if( handle )
  {
     GETLASTINPUTINFO pFunc;

     pFunc = (GETLASTINPUTINFO) GetProcAddress( handle, "GetLastInputInfo" );

     if( pFunc )
     {
        LASTINPUTINFO lpi;

        lpi.cbSize = sizeof( LASTINPUTINFO );

        if( pFunc( &lpi ) )
        {
           hb_retni( lpi.dwTime );
        }
        else
        {
           hb_retni( 0 );
        }
     }
     else
     {
        hb_retni( 0 );
     }

     FreeLibrary( handle);
  }
  else
  {
     hb_retni( 0 );
  }
}

#pragma ENDDUMP
