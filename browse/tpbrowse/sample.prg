/*
 * sample.prg,v 1.2 2018/12/03 11:09 Jacek Pospischil
 */

#include 'oohg.ch'
#include 'i_pbrowse.ch'
//#include 'h_pbrowse.prg'   // uncomment this line to build with COMPILE.BAT, comment out to build with BUILDAPP.BAT or HBMK2.

REQUEST DBFCDX

function Main()
set dele on
set date ansi
set century on
set epoch to 1980
set navigation extended

RDDSETDEFAULT("DBFCDX")

if file('dbsample.dbf')
  dele file dbsample.dbf
endi
sele 1
dbcreate('dbsample',{{'Index1','C',5,0},{'Index2','C',1,0},{'Name','C',30,0},{'Group1','C',2,0},{'Group2','C',3,0},{'Comment','C',20,0},{'Ean','C',13,0}})
use dbsample
inde on index1+index2 tag sample01 to dbsample
inde on upper(name) tag sample02 to dbsample
inde on group1 tag sample03 to dbsample
inde on group2 tag sample04 to dbsample
inde on ean tag sample05 to dbsample
clos data
use dbsample 
set inde to dbsample
ins_sampl('A0014','2','LG 43UK6400','43','4K','?','5900446011323')
ins_sampl('A0003','1','Samsung UE55NU70','55','4K','','5904215129660')
ins_sampl('A0001','2','Samsung UE50NU','50','4K','???','5904215129677')
ins_sampl('A0001','2','Philips 49PFS5302/12','49','FHD','*','5905256010047')
ins_sampl('A0013','5','Samsung UE55NU60','55','4K','','5905256010061')
ins_sampl('A0001','1','Hyundai ULV50TS292SMART','50','4K','','5905256010078')
ins_sampl('A0014','1','Samsung UE40J5200','40','FHD','FullHD','5905256010085')
ins_sampl('A0012','5','Sony KD55X','55','4K','','5905256010139')
ins_sampl('A0012','2','Manta 19LHN','19','HD','','5905256010207')
ins_sampl('A0012','3','Manta LED220Q7','22','HD','*','5905256010252')
ins_sampl('A0013','1','Lin 24LHDD','24','HD','','5905256020015')
ins_sampl('A0012','1','Hitachi 24HB4C05','24','HD','','5905256020022')
ins_sampl('A0012','4','Blaupunkt BLA-236/207O-GB-3B-EGBQP-EU','23','HD','','5905256020039')
ins_sampl('A0011','2','Lin 32LHD1510','32','HD','?','5905256020053')
ins_sampl('A0011','1','Sharp LC-24CHF4012E','24','HD','','5905256020060')
ins_sampl('A0011','3','Thomson 22FB3113','22','HD','','5905256020138')
ins_sampl('A0013','2','Philips 24PFT4022/12N','24','HD','?','5900017355009')
ins_sampl('A0001','3','Hyundai HLP24T370','24','HD','','5905256030014')
ins_sampl('A0002','2','Blaupunkt BLA-32/148O-GB-11B-EGBQP-EU','32','HD','','5905256030021')
ins_sampl('A0002','1','Thomson 32HD3101','32','HD','Price 200','5905256030038')
ins_sampl('A0013','3','Toshiba 32W1733DG','32','HD','','5905256030045')
ins_sampl('A0010','4','Philips 24PHH4000/88','24','HD','','5905256060011')
ins_sampl('A0010','3','Sharp LC-24CHG6002E','24','HD','','5905256060035')
ins_sampl('A0010','2','Hitachi 32HB4T01','24','HD','','5905256060042')
ins_sampl('A0010','1','Blauberg LFS4005','40','FHD','','5905256080040')
ins_sampl('A0020','2','LG 32LK500B','32','HD','','5905256080064')
ins_sampl('A0020','1','Lin 43LFHD1800','43','FHD','','5905256130035')
ins_sampl('A0020','3','Samsung UE32J5000','32','FHD','','5905256140027')
ins_sampl('A0021','1','Blaupunkt BLA-40/138O-GB-11B4-FEGBQP-EU','40','FHD','*','5905256150033')
ins_sampl('A0013','4','Philips 24PFS5231/12','24','FHD','','5905256160032')
ins_sampl('A0021','2','LG 43UJ6307','43','4K','','5905256280013 ')

DEFINE WINDOW Form_1;
   AT 0, 0 ;
   title 'Browse : barcode scanning and search';
   WIDTH 800 ;
   HEIGHT 610 ;
   NOMAXIMIZE ;
   NOSIZE;
   MAIN;
   on init iniprog();
   on interactiveclose exitprog()
   
   @0,25 frame _frm1;
      WIDTH 733 ;
      HEIGHT 25 ;
      TRANSPARENT
   @25,25 PBROWSE browse_1 obj _brw;
      WIDTH 751 ;
      HEIGHT 504 ;
      HEADERS {'Index','Name', 'Group1','Group2','Comment','EAN'};
      WIDTHS { 80,260,60,60,150,120 };
      WORKAREA 'DBSAMPLE';
      FIELDS {'DBSAMPLE->index1+"-"+DBSAMPLE->index2', 'DBSAMPLE->name','DBSAMPLE->group1','DBSAMPLE->group2','DBSAMPLE->comment','DBSAMPLE->ean'};
 	  on gotfocus {||_lbrw:visible:=.t.};
	  on lostfocus {||_lbrw:visible:=.f.};
      inplace;
      dynamicblocks
	  _brw:aHeadClick = {{||_brw:setfocus(),sort_brw(1)},{||_brw:setfocus(),sort_brw(2)},{||_brw:setfocus(),sort_brw(3)},{||_brw:setfocus(),sort_brw(4)},nil,{||_brw:setfocus(),sort_brw(5)}}
	  _brw:aSearch := {{1,7,'@R A9999-9',.t.,''},{2,30,repl('X',30),.f.,'upper'},{3,2,'99',.f.,''},{4,3,'XXX',.t.,''},{0,0,'',.f.,''},{5,13,repl('9',13),.f.,''}}
   @529,25 label lab1 obj _lbrw width 733 heigh 25 value 'F1 search       F2 last scanned barcode       Esc exit' fontcolor {0,0,0} backcolor {255,255,255} font "ARIAL" size 10 centeralign vcenteralign
// @555,320 button but width 120 height 25 caption 'Search' action (_brw:setfocus(),_brw:DbSearch())
	  on key escape action {||exitprog(),FORM_1.release}
END WINDOW   
CENTER WINDOW Form_1
ACTIVATE WINDOW Form_1

quit
************************************************************************************************************
func iniprog
sele DBSAMPLE
set order to 1
go top
*
* example for set filter
*
*_brw:AddDbCon := 'DBSAMPLE->comment="*"'

_brw:ActiveBarCode:=.t.
_brw:allowmovecolumn=.f.
_brw:allowchangesize=.f.
_brw:BarCodeFunc := 'search_ean'
*
* all records
*
_brw:DbCondition:='.t.'
_brw:Seek_db:=''
_brw:Seek1_db:=''
*
* example for a limited list of records
*
* _brw:DbCondition:='DBSAMPLE->index1+DBSAMPLE->index2="A0010"'
* _brw:Seek_db:='A0010'
* _brw:Seek1_db:='A0011'
*
_brw:DYNAMICFORECOLOR := { nil, {255,255,255} }
_brw:DYNAMICBACKCOLOR := { nil, {150,150,150} }
_brw:SetSelectedColors({{0,0,0},{168,203,219},{0,0,0},{208,243,249}},.t.)
_brw:DbFunc := ''
_brw:SetKey(VK_F1,0,{||_brw:DbSearch()} )
_brw:SetKey(VK_F2,0,{||MsgInfo(_brw:GetBarCode())} )
_brw:Home()
_brw:setfocus()
retu nil
***********************************************************************************************************
func search_ean
local _bcode,_rek,_ree,_als,_ine,_ink,_zwr,_wrn,_wra
_bcode:=_brw:GetBarCode()
_wrn=_brw:DbCondition
_wra=_brw:AddDbCon
_fna=_brw:DbFunc
_zwr=0
_als=alias()
sele DBSAMPLE
_rek=recno()
_ink=indexord()
set order to 5
seek _bcode
if eof()
  go _rek
  set order to _ink
  retu 0
endi
if !(&_wrn) .or. !DbAddCon(_wra,_fna)
  go _rek
  set order to _ink
  retu -1
endi
_zwr=recno()
go _rek
set order to _ink
retu _zwr
************************************************************************************************************
func exitprog
clos data
if file('dbsample.dbf')
  ERASE dbsample.dbf
endi
if file('dbsample.cdx')
  ERASE dbsample.cdx
endi

retu .t.
************************************************************************************************************
func ins_sampl
para idx1,idx2,nm,g1,g2,cm,en
sele DBSAMPLE
appe blan
repl index1 with idx1,index2 with idx2,name with nm,group1 with g1,group2 with g2,comment with cm,ean with en
retu nil
