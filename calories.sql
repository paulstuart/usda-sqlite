
-- calories per gram
drop view if exists calories;
create view calories as 
    select 
        f.NDB_No,
        -- (c.Nutr_Val / 100.00) as calories,
        c.Nutr_Val  as calories,
        --c.Nutr_No,
        f.Long_Desc as name
    from food_des f
    left outer join nut_data c on f.NDB_No = c.NDB_No
      and c.Nutr_No = 208 -- Energy in KJ
      ;

 select * from calories limit 5;
-- .exit

-- protein per 100 grams
drop view if exists protein;
create view protein as 
    select 
        f.NDB_No,
        f.FdGrp_Cd as grp,
        c.Nutr_Val as protein,
        --c.Nutr_No,
        f.Long_Desc as name
    from food_des f
    left outer join nut_data c on f.NDB_No = c.NDB_No
      and c.Nutr_No = 203 -- Protein
      ;

/*
select * from protein 
    -- where name like '%chicken%nuggets%'
    order by protein desc
limit 20;
*/

drop view if exists density;
create view density as
with calculated as (
  select 
    c.NDB_No, 
    -- (100.00 / c.calories) as ratio,
    -- round(100 * p.protein / c.calories, 2) as ratio, 
    round(p.protein / c.calories, 2) as ratio, 
    -- round(p.protein / c.calories, 2) as ratio, 
    -- round(c.calories / p.protein , 2) as ratio, 
    p.protein, 
    -- ceil(c.calories * 100) as calories, 
    c.calories,
    c.name 
  from calories c
  left join protein p on c.NDB_No = p.NDB_No
)
  select * from calculated
  ;

select * from density 
    -- where name like '%chicken%nuggets%'
    order by ratio desc
limit 20;

drop view if exists vegan_groups;
create view vegan_groups as
  select 
    '0200', 
    '1100', 
    '1200', 
    '1600',
    '2000'
  ;

select * from vegan_groups;

drop view if exists non_vegan_groups;
create view non_vegan_groups as
  select 
    '0100', 
    '0500', 
    '0700', 
    '1000',
    '1300',
    '1500',
    '1600',
  ;


/*
FdGrp_Cd	FdGrp_Desc
0100	Dairy and Egg Products
0200	Spices and Herbs
0300	Baby Foods
0400	Fats and Oils
0500	Poultry Products
0600	Soups, Sauces, and Gravies
0700	Sausages and Luncheon Meats
0800	Breakfast Cereals
0900	Fruits and Fruit Juices
1000	Pork Products
1100	Vegetables and Vegetable Products
1200	Nut and Seed Products
1300	Beef Products
1400	Beverages
1500	Finfish and Shellfish Products
1600	Legumes and Legume Products
1700	Lamb, Veal, and Game Products
1800	Baked Products
1900	Sweets
2000	Cereal Grains and Pasta
2100	Fast Foods
2200	Meals, Entrees, and Side Dishes
2500	Snacks
3500	American Indian/Alaska Native Foods
3600	Restaurant Foods
*/