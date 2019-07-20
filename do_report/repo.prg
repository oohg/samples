#include 'oohg.ch'

function main()
       declare window form_1
       define window form_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 400 ;
		TITLE 'hola' ; 
         main

       @ 40,10 button b_2 caption 'Do External Report (.rpt)' action testrepo() WIDTH 150 

       end window
       activate window form_1
return

function testrepo()
       wempresa:='sistemas c.v.c'
       use mtiempo 
       index on usuario to lista
       go top

// uncomment the next line to generate a PDF
// _OOHG_PrintLibrary := "PDFPRINT"
       DO REPORT FORM repdemo
	use
return

