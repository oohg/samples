#include "oohg.ch"
PROCEDURE main()
LOCAL oSoapClient

IF ! Empty( oSoapClient := win_oleCreateObject( "MSSOAP.SoapClient30" ) )

   oSoapClient:msSoapInit( "http://www.dataaccess.com/webservicesserver/textcasing.wso?WSDL" )

   msginfo(oSoapClient:InvertStringCase( "lower UPPER" ))
ELSE
   msginfo("Error: SOAP Toolkit 3.0 not available."+win_oleErrorText())
ENDIF

RETURN

