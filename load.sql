
.separator '^'

.print 'importing FD_GROUP.txt'
.import 'FD_GROUP.txt' fd_group

update fd_group set 
    FdGrp_Cd=trim(FdGrp_Cd,'~'),
    FdGrp_Desc=trim(FdGrp_Desc,'~')
    ;


.print 'importing LANGUAL.txt'
.import 'LANGUAL.txt' langual

update langual set 
    NDB_No=trim(NDB_No,'~'),
    Factor_Code=trim(Factor_Code,'~')
    ;


.print 'importing LANGDESC.txt'
.import 'LANGDESC.txt' langdesc

update langdesc set 
    Factor_Code=trim(Factor_Code,'~'),
    Description=trim(Description,'~')
    ;


.print 'importing FOOD_DES.txt'
.import 'FOOD_DES.txt' food_des

update food_des set 
    NDB_No=trim(NDB_No,'~'),
    FdGrp_Cd=trim(FdGrp_Cd,'~'),
    Long_Desc=trim(Long_Desc,'~'),
    Shrt_Desc=trim(Shrt_Desc,'~'),
    ComName=trim(ComName,'~'),
    ManufacName=trim(ManufacName,'~'),
    Survey=trim(Survey,'~'),
    Ref_desc=trim(Ref_desc,'~'),
    SciName=trim(Ref_desc,'~')
    ;


.print 'importing NUT_DATA.txt'
.import 'NUT_DATA.txt' nut_data

update nut_data set 
    NDB_No=trim(NDB_No,'~'),
    Nutr_No=trim(Nutr_No,'~'),
    Src_Cd=trim(Src_Cd,'~'),
    Deriv_Cd=trim(Deriv_Cd,'~'),
    Ref_NDB_No=trim(Ref_NDB_No,'~'),
    Add_Nutr_Mark=trim(Add_Nutr_Mark,'~'),
    Stat_cmt=trim(Stat_cmt,'~'),
    CC=trim(CC,'~')
    ;


.print 'importing NUTR_DEF.txt'
.import 'NUTR_DEF.txt' nutr_def

update nutr_def set 
    Nutr_No=trim(Nutr_No,'~'),
    Units=trim(Units,'~'),
    Tagname=trim(Tagname,'~'),
    NutrDesc=trim(NutrDesc,'~'),
    Num_Dec=trim(Num_Dec,'~'),
    SR_Order=trim(SR_Order,'~')
    ;


.print 'importing SRC_CD.txt'
.import 'SRC_CD.txt' src_cd

update src_cd set 
    Src_Cd=trim(Src_Cd,'~'),
    SrcCd_Desc=trim(SrcCd_Desc,'~')
    ;


.print 'importing DERIV_CD.txt' 
.import 'DERIV_CD.txt' deriv_cd

update deriv_cd set 
    Deriv_Cd=trim(Deriv_Cd,'~'),
    Deriv_Desc=trim(Deriv_Desc,'~')
    ;


.print 'importing WEIGHT.txt'
.import 'WEIGHT.txt' weight

update weight set 
    NDB_No=trim(NDB_No,'~'),
    Seq=trim(Seq,'~'),
    Msre_Desc=trim(Msre_Desc,'~')
    ;


.print 'importing FOOTNOTE.txt'
.import 'FOOTNOTE.txt' footnote

.print 'updating FOOTNOTE.txt'
update footnote set
    NDB_No=trim(NDB_No,'~'),
    Footnt_No=trim(Footnt_No,'~'),
    Footnt_Typ=trim(Footnt_Typ,'~'),
    Nutr_No=trim(Nutr_No,'~'),
    Footnt_Txt=trim(Footnt_Txt,'~')
    ;


.print 'importing DATSRCLN.txt'
.import 'DATSRCLN.txt' datsrcln

update datsrcln set 
    NDB_No=trim(NDB_No,'~'),
    Nutr_No=trim(Nutr_No,'~'),
    DataSrc_ID=trim(DataSrc_ID,'~')
    ;


.print 'importing DATA_SRC.txt'
.import 'DATA_SRC.txt' data_src

.print 'updating data_src'
update data_src set
    DataSrc_ID=trim(DataSrc_ID,'~'),
    Authors=trim(Authors,'~'),
    Title=trim(Title,'~'),
    Year=trim(Year,'~'),
    Journal=trim(Journal,'~'),
    Vol_City=trim(Vol_City,'~'),
    Issue_State=trim(Issue_State,'~'),
    Start_Page=trim(Start_Page,'~'),
    End_Page=trim(End_Page,'~')
    ;

.print 'vacuum'
vacuum;

.print 'load complete'

/*
-- for reviewing data loads ok
.mode column
select * from fd_group limit 5;
select * from langual  limit 5;
select * from langdesc limit 5;
select * from food_des limit 5;
select * from nut_data limit 5;
select * from nutr_def limit 5;
select * from src_cd   limit 5;
select * from deriv_cd limit 5;
select * from weight   limit 5;
select * from footnote limit 5;
select * from datsrcln limit 5;
select * from data_src limit 5;
*/
