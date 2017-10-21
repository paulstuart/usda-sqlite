
-- Food Descriptions 

drop table if exists food_des;
create table food_des (
    NDB_No char(5) primary key, -- 5-digit Nutrient Databank number that uniquely identifies a food item. 
                                -- If this field is defined as numeric, the leading zero will be lost.
    FdGrp_Cd char(4),           -- 4-digit code indicating food group to which a food item belongs.
    Long_Desc varchar(200),     -- description of food item
    Shrt_Desc varchar(60),      -- abbreviated description of food item. 
                                -- Generated from the 200-character description using abbreviations in Appendix A. 
                                -- If short description is longer than 60 characters, additional abbreviations are made.
    ComName varchar(100),       -- Other names commonly used to describe a food, including local or regional names for various foods, 
                                -- for example, “soda” or “pop” for “carbonated beverages.”
    ManufacName varchar(65),    -- Indicates the company that manufactured the product, when appropriate
    Survey char(1),             -- Indicates if the food item is used in the USDA Food and Nutrient Database for Dietary Studies (FNDDS) 
                                -- and thus has a complete nutrient profile for the 65 FNDDS nutrients.
    Ref_desc varchar(135),      -- Description of inedible parts of a food item (refuse), such as seeds or bone
    Refuse number,              -- Percentage of refuse
    SciName text,               -- Scientific name of the food item. Given for the least processed form of the food (usually raw), if applicable.
    N_Factor number,            -- Factor for converting nitrogen to protein
    Pro_Factor number,          -- Factor for calculating calories from protein
    Fat_Factor number,          -- Factor for calculating calories from fat
    CHO_Factor number           -- Factor for calculating calories from carbohydrate
);

DROP INDEX IF EXISTS food_des_ComName;
CREATE INDEX food_des_ComName on food_des(ComName);

DROP INDEX IF EXISTS food_des_SciName;
CREATE INDEX food_des_SciName on food_des(SciName);


-- Food Groups

drop table if exists fd_group;
create table fd_group (
    FdGrp_Cd char(4) primary key,   -- 4-digit code identifying a food group. Only the first 2 digits are currently assigned. 
                                    -- In the future, the last 2 digits may be used. Codes may not be consecutive.
    FdGrp_Desc varchar(60)          -- Name of food group
);

-- Support to the Food Description and contains the factors from the LanguaL Thesaurus used to code a particular food.

drop table if exists langual;
create table langual (
    NDB_No char(5),         -- 5-digit Nutrient Databank number that uniquely identifies a food item.
    Factor_Code varchar(5)  -- The LanguaL factor from the Thesaurus.
);


-- LanguaL Factors Descriptions
-- Support the LanguaL Factor file and contains the descriptions for only those factors used in coding the selected food items codes in this release of SR.

drop table if exists langdesc;
create table langdesc (
    Factor_Code char(5),        -- The LanguaL factor from the Thesaurus. 
                                -- Only those codes used to factor the foods contained in the LanguaL Factor file are included
    Description varchar(140)    -- The description of the LanguaL Factor Code from the thesaurus.
);

-- Nutrient Data 
-- nutrient values and information about the values, including expanded statistical information.

drop table if exists nut_data;
create table nut_data (
    NDB_No char(5),         -- 5-digit Nutrient Databank number that uniquely identifies a food item.
    Nutr_No char(3),        -- Unique 3-digit identifier code for a nutrient.
    Nutr_Val number,        -- Amount in 100 grams, edible portion
    Num_Data_Pts number,    -- Number of data points is the number of analyses used to calculate the nutrient value. 
                            -- If the number of data points is 0, the value was calculated or imputed.
    Std_Error number,       -- Standard error of the mean. Null if cannot be calculated. 
                            -- The standard error is also not given if the number of data points is less than three.
    Src_Cd char(2),         -- Code indicating type of data.
    Deriv_Cd char(4),       -- Data Derivation Code giving specific information on how the value is determined. 
                            -- This field is populated only for items added or updated starting with SR14. 
                            -- This field may not be populated if older records were used in the calculation of the mean value.
    Ref_NDB_No char(5),     -- NDB number of the item used to calculate a missing value. 
                            -- Populated only for items added or updated starting with SR14.
    Add_Nutr_Mark char(1),  -- Indicates a vitamin or mineral added for fortification or enrichment. 
                            -- This field is populated for ready-to-eat breakfast cereals and many brand-name hot cereals in food group 08.
    Num_Studies number,     -- Number of studies.
    Min number,             -- Minimum value.
    Max number,             -- Maximum value.
    DF number,              -- Degrees of freedom.
    Low_EB number,          -- Lower 95% error bound.
    Up_EB number,           -- Upper 95% error bound.
    Stat_cmt char(10),      -- Statistical comments. See definitions below.
    AddMod_Date date,       -- Indicates when a value was either added to the database or last modified.
    CC char                 -- Confidence Code indicating data quality, based on evaluation of sample plan, 
                            -- sample handling, analytical method, analytical quality control, and number of samples analyzed. 
                            -- Not included in this release, but is planned for future releases.
);

DROP INDEX IF EXISTS nut_data_NDB_No;
CREATE INDEX nut_data_NDB_No on nut_data(NDB_No);



-- Nutrient Definitions

drop table if exists nutr_def;
create table nutr_def (
    Nutr_No char(3) primary key,    -- Unique 3-digit identifier code for a nutrient
    Units char(7),                  -- Units of measure (mg, g, μg, and so on).
    Tagname char(20),               -- International Network of Food Data Systems (INFOODS) Tagnames.† 
                                    -- A unique abbreviation for a nutrient/food component developed by INFOODS to aid in the interchange of data.
    NutrDesc varchar(60),           -- Name of nutrient/food component
    Num_Dec char,                   -- Number of decimal places to which a nutrient value is rounded.
    SR_Order number                 -- Used to sort nutrient records in the same order as various reports produced from SR.
);


-- Source Code File Format

drop table if exists src_cd;
create table src_cd (
    Src_Cd char(2) primary key, -- A 2-digit code indicating type of data.
    SrcCd_Desc varchar(60)      -- Description of source code that identifies the type of nutrient data.
);


-- Data Derivation Code Description File Format

drop table if exists deriv_cd;
create table deriv_cd (
    Deriv_Cd char(3) primary key,   -- Derivation Code
    Deriv_Desc varchar(120)         -- Description of derivation code giving specific information on how the value was determined.
);



-- Weights 

drop table if exists weight;
create table weight (
    NDB_No char(5),         -- 5-digit Nutrient Databank number that uniquely identifies a food item
    Seq char(2),            -- Sequence number.
    Amount  number,         -- Unit modifier (for example, 1 in “1 cup”).
    Msre_Desc varchar(84),  -- Description (for example, cup, diced, and 1-inch pieces).
    Gm_Wgt  number,         -- Gram weight.
    Num_Data_Pts  number,   -- Number of data points.
    Std_Dev number          -- Standard deviation.
);

-- Footnotes

drop table if exists footnote;
create table footnote (
    NDB_No char(5),         -- 5-digit Nutrient Databank number that uniquely identifies a food item
    Footnt_No char(4),      -- Sequence number. If a given footnote applies to more than one nutrient number, 
                            -- the same footnote number is used. As a result, this file cannot be indexed and there is no primary key
    Footnt_Typ char(1),     -- Type of footnote
                            -- D = footnote adding information to the food description;
                            -- M = footnote adding information to measure description;
                            -- N = footnote providing additional information on a nutrient value. If the Footnt_typ = N, the Nutr_No will also be filled in.
    Nutr_No char(3),        -- Unique 3-digit identifier code for a nutrient to which footnote applies.
    Footnt_Txt varchar(200) -- Footnote text.
);


-- Sources of Data Link 

drop table if exists datsrcln;
create table datsrcln (
    NDB_No char(5),     -- 5-digit Nutrient Databank number that uniquely identifies a food item
    Nutr_No char(3),    -- Unique 3-digit identifier code for a nutrient
    DataSrc_ID char(6)  -- Unique ID identifying the reference/source.
);


-- Sources of Data 

drop table if exists data_src;
create table data_src (
    DataSrc_ID char(6),     -- Unique ID identifying the reference/source.
    Authors varchar(200),   -- List of authors for a journal article or name of sponsoring organization for other documents.
    Title varchar(200),     -- Title of article or name of document, such as a report from a company or trade association.
    Year char(4),           -- Year article or document was published.
    Journal varchar(120),   -- Name of the journal in which the article was published.
    Vol_City char(16),      -- Volume number for journal articles, books, or reports; city where sponsoring organization is located.
    Issue_State char(5),    -- Issue number for journal article; State where the sponsoring organization is located.
    Start_Page char(5),     -- Starting page number of article/document.
    End_Page char(5)        -- Ending page number of article/document.
);
