/*
MySQL script (Workbench 8) to upload raw text files as received by NHS England 

This script sets up individual level civil registrations (deaths) / ONS mortality data 
This data release was approved as part of NIC-393510
Data was received as pipe-delimited flat text files for each financial year  

Editor: Linda Wijlaars
Version: 2023_1
Date: 16 January 2024
Original author: Grant Thiltgen
*/

-- create table and set up variable types
CREATE TABLE hes_ons.ons_2023 (
record_id varchar(10),
cause_of_death varchar(4),
cause_of_death_neonatal_1 varchar(5), 
cause_of_death_neonatal_2 varchar(5), 
cause_of_death_neonatal_3 varchar(5), 
cause_of_death_neonatal_4 varchar(5), 
cause_of_death_neonatal_5 varchar(5), 
cause_of_death_neonatal_6 varchar(5), 
cause_of_death_neonatal_7 varchar(5), 
cause_of_death_neonatal_8 varchar(5), 
cause_of_death_neonatal_9 varchar(5), 
cause_of_death_neonatal_10 varchar(5), 
cause_of_death_neonatal_11 varchar(5), 
cause_of_death_neonatal_12 varchar(5), 
cause_of_death_neonatal_13 varchar(5), 
cause_of_death_neonatal_14 varchar(5), 
cause_of_death_neonatal_15 varchar(5), 
cause_of_death_non_neonatal_1 varchar(5), 
cause_of_death_non_neonatal_2 varchar(5), 
cause_of_death_non_neonatal_3 varchar(5), 
cause_of_death_non_neonatal_4 varchar(5), 
cause_of_death_non_neonatal_5 varchar(5), 
cause_of_death_non_neonatal_6 varchar(5), 
cause_of_death_non_neonatal_7 varchar(5), 
cause_of_death_non_neonatal_8 varchar(5), 
cause_of_death_non_neonatal_9 varchar(5), 
cause_of_death_non_neonatal_10 varchar(5), 
cause_of_death_non_neonatal_11 varchar(5), 
cause_of_death_non_neonatal_12 varchar(5), 
cause_of_death_non_neonatal_13 varchar(5), 
cause_of_death_non_neonatal_14 varchar(5), 
cause_of_death_non_neonatal_15 varchar(5), 
communal_establishment varchar(5), 
death_record_used varchar(4), 
dod date,
dor date, 
encrypted_hesid char(32),
match_rank tinyint,
nhs_indicator tinyint,
respct varchar(5),
resstha varchar(3),
sex tinyint,
subsequent_activity char(1),
age_at_death smallint,
tokenid char(15)
);


--load text file into table
SET GLOBAL local_infile = TRUE;

LOAD DATA LOCAL INFILE '[filepath]/Data/Mortality/NIC393510_HES_ONS_202299.txt'
INTO TABLE hes_ons.ons_2023
fields terminated by "|"
lines terminated by "\n"
ignore 1 lines
(@record_id, @CAUSE_OF_DEATH, @CAUSE_OF_DEATH_NEONATAL_1, @CAUSE_OF_DEATH_NEONATAL_2, @CAUSE_OF_DEATH_NEONATAL_3, @CAUSE_OF_DEATH_NEONATAL_4, 
@CAUSE_OF_DEATH_NEONATAL_5, @CAUSE_OF_DEATH_NEONATAL_6, @CAUSE_OF_DEATH_NEONATAL_7, @CAUSE_OF_DEATH_NEONATAL_8, @CAUSE_OF_DEATH_NEONATAL_9, 
@CAUSE_OF_DEATH_NEONATAL_10, @CAUSE_OF_DEATH_NEONATAL_11, @CAUSE_OF_DEATH_NEONATAL_12, @CAUSE_OF_DEATH_NEONATAL_13, @CAUSE_OF_DEATH_NEONATAL_14, 
@CAUSE_OF_DEATH_NEONATAL_15, @CAUSE_OF_DEATH_NON_NEONATAL_1, @CAUSE_OF_DEATH_NON_NEONATAL_2, @CAUSE_OF_DEATH_NON_NEONATAL_3, @CAUSE_OF_DEATH_NON_NEONATAL_4, 
@CAUSE_OF_DEATH_NON_NEONATAL_5, @CAUSE_OF_DEATH_NON_NEONATAL_6, @CAUSE_OF_DEATH_NON_NEONATAL_7, @CAUSE_OF_DEATH_NON_NEONATAL_8, @CAUSE_OF_DEATH_NON_NEONATAL_9, 
@CAUSE_OF_DEATH_NON_NEONATAL_10, @CAUSE_OF_DEATH_NON_NEONATAL_11, @CAUSE_OF_DEATH_NON_NEONATAL_12, @CAUSE_OF_DEATH_NON_NEONATAL_13, @CAUSE_OF_DEATH_NON_NEONATAL_14, 
@CAUSE_OF_DEATH_NON_NEONATAL_15, @COMMUNAL_ESTABLISHMENT, @DEATH_RECORD_USED, @DOD, @DOR, @encrypted_hesid,
 @MATCH_RANK, @NHS_INDICATOR, @RESPCT, @RESSTHA, @SEX, @SUBSEQUENT_ACTIVITY, @age_at_death, @tokenid)
SET
record_id = nullif(@record_id,''),
CAUSE_OF_DEATH = nullif(@CAUSE_OF_DEATH,''),
CAUSE_OF_DEATH_NEONATAL_1 = nullif(@CAUSE_OF_DEATH_NEONATAL_1,''),
CAUSE_OF_DEATH_NEONATAL_2 = nullif(@CAUSE_OF_DEATH_NEONATAL_2,''),
CAUSE_OF_DEATH_NEONATAL_3 = nullif(@CAUSE_OF_DEATH_NEONATAL_3,''),
CAUSE_OF_DEATH_NEONATAL_4 = nullif(@CAUSE_OF_DEATH_NEONATAL_4,''),
CAUSE_OF_DEATH_NEONATAL_5 = nullif(@CAUSE_OF_DEATH_NEONATAL_5,''),
CAUSE_OF_DEATH_NEONATAL_6 = nullif(@CAUSE_OF_DEATH_NEONATAL_6,''),
CAUSE_OF_DEATH_NEONATAL_7 = nullif(@CAUSE_OF_DEATH_NEONATAL_7,''),
CAUSE_OF_DEATH_NEONATAL_8 = nullif(@CAUSE_OF_DEATH_NEONATAL_8,''),
CAUSE_OF_DEATH_NEONATAL_9 = nullif(@CAUSE_OF_DEATH_NEONATAL_9,''),
CAUSE_OF_DEATH_NEONATAL_10 = nullif(@CAUSE_OF_DEATH_NEONATAL_10,''),
CAUSE_OF_DEATH_NEONATAL_11 = nullif(@CAUSE_OF_DEATH_NEONATAL_11,''),
CAUSE_OF_DEATH_NEONATAL_12 = nullif(@CAUSE_OF_DEATH_NEONATAL_12,''),
CAUSE_OF_DEATH_NEONATAL_13 = nullif(@CAUSE_OF_DEATH_NEONATAL_13,''),
CAUSE_OF_DEATH_NEONATAL_14 = nullif(@CAUSE_OF_DEATH_NEONATAL_14,''),
CAUSE_OF_DEATH_NEONATAL_15 = nullif(@CAUSE_OF_DEATH_NEONATAL_15,''),
CAUSE_OF_DEATH_NON_NEONATAL_1 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_1,''),
CAUSE_OF_DEATH_NON_NEONATAL_2 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_2,''),
CAUSE_OF_DEATH_NON_NEONATAL_3 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_3,''),
CAUSE_OF_DEATH_NON_NEONATAL_4 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_4,''),
CAUSE_OF_DEATH_NON_NEONATAL_5 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_5,''),
CAUSE_OF_DEATH_NON_NEONATAL_6 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_6,''),
CAUSE_OF_DEATH_NON_NEONATAL_7 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_7,''),
CAUSE_OF_DEATH_NON_NEONATAL_8 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_8,''),
CAUSE_OF_DEATH_NON_NEONATAL_9 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_9,''),
CAUSE_OF_DEATH_NON_NEONATAL_10 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_10,''),
CAUSE_OF_DEATH_NON_NEONATAL_11 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_11,''),
CAUSE_OF_DEATH_NON_NEONATAL_12 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_12,''),
CAUSE_OF_DEATH_NON_NEONATAL_13 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_13,''),
CAUSE_OF_DEATH_NON_NEONATAL_14 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_14,''),
CAUSE_OF_DEATH_NON_NEONATAL_15 = nullif(@CAUSE_OF_DEATH_NON_NEONATAL_15,''),
COMMUNAL_ESTABLISHMENT = nullif(@COMMUNAL_ESTABLISHMENT,''),
DEATH_RECORD_USED = nullif(@DEATH_RECORD_USED,''),
DOD = nullif(@DOD,''),
DOR = nullif(@DOR,''),
encrypted_hesid = nullif(@encrypted_hesid,''),
MATCH_RANK = nullif(@MATCH_RANK,''),
NHS_INDICATOR = nullif(@NHS_INDICATOR,''),
RESPCT = nullif(@RESPCT,''),
RESSTHA = nullif(@RESSTHA,''),
SEX = nullif(@SEX,''),
SUBSEQUENT_ACTIVITY = nullif(@SUBSEQUENT_ACTIVITY,''),
age_at_death = nullif(@age_at_death,''),
tokenid = nullif(@tokenid,'')
;

--check head of data
SELECT * FROM hes_ons.ons_2023 limit 50;

--create index on person ID variable (tokenid)
CREATE INDEX tpid on hes_ons.ons_2023 (tokenid);

--check latest available dates of death (dod) and registration (dor)
SELECT max(dod), max(dor) FROM hes_ons.ons_2023;
