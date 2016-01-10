
drop view if exists food;
create view food as
  select f.*, g.FdGrp_Desc
   from food_des f
   LEFT OUTER JOIN fd_group g on g.FdGrp_Cd = f.FdGrp_Cd
;

drop view if exists nutrients;
create view nutrients as
  select n.*, Units, Tagname, NutrDesc, Num_Dec, SR_Order 
    from nut_data n
    LEFT OUTER JOIN nutr_def d on d.Nutr_No = n.Nutr_No
;

drop view if exists nutrition;
create view nutrition as
  select f.*, 
    Nutr_No,
    Nutr_Val,
    Num_Data_Pts,
    Std_Error,
    Src_Cd,
    Deriv_Cd,
    Ref_NDB_No,
    Add_Nutr_Mark,
    Num_Studies,
    Min,
    Max,
    DF,
    Low_EB,
    Up_EB,
    Stat_cmt,
    AddMod_Date,
    CC,
    Units, Tagname, NutrDesc, Num_Dec, SR_Order
   from food f
   LEFT OUTER JOIN nutrients n on n.NDB_No = f.NDB_No
;

