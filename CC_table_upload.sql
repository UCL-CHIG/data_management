/*
MySQL script (Workbench 8) to upload raw text files as received by NHS England 

This script sets up individual level Critical Care (CC) Hospital Episode Statistics (HES) data 
This data release was approved as part of NIC-393510
Data was received as pipe-delimited flat text files for each financial year  

Editor: Linda Wijlaars
Version: 2023_1
Date: 16 January 2024
Original author: Grant Thiltgen
*/

-- create table and set variable types
CREATE TABLE hes_ons.CC_2223 (
	acardsupdays smallint,
	aressupdays smallint,
	bcardsupdays smallint,
	bestmatch smallint,
	bressupdays smallint,
	ccadmisorc smallint,
	ccadmitype smallint,
	ccapcrel smallint,
	ccdisdate date, 
	ccdisdest smallint,
	ccdisloc smallint,
	ccdisrdydate date,
	ccdisrdytime time, 
	ccdisstat smallint,
	ccdistime time, 
	cclev2days smallint,
	cclev3days smallint,
	ccsorcloc smallint,
	ccstartdate date, 
	ccstarttime time, 
	ccunitfun smallint,
	dermsupdays smallint,
	gisupdays smallint,
	liversupdays smallint,
	neurosupdays smallint,
	orgsupmax smallint,
	rensupdays smallint,
	susrecid varchar(20),
	unitbedconfig char(3)
	);


--load data into new table 
LOAD DATA LOCAL INFILE '[file path]/Data/CC/NIC393510_HES_CC_202299.txt'
INTO TABLE hes_ons.CC_2223
fields terminated by "|"
lines terminated by "\n"
ignore 1 lines
(@acardsupdays, @aressupdays, @bcardsupdays, @bestmatch, @bressupdays, @ccadmisorc, @ccadmitype, @ccapcrel, @ccdisdate, @ccdisdest, @ccdisloc, @ccdisrdydate, @ccdisrdytime, @ccdisstat, @ccdistime, 
@cclev2days, @cclev3days, @ccsorcloc, @ccstartdate, @ccstarttime, @ccunitfun, @dermsupdays, 
@gisupdays, @liversupdays, @neurosupdays, @orgsupmax, @rensupdays, @susrecid, @unitbedconfig)
SET
acardsupdays = nullif(@acardsupdays,''),
aressupdays = nullif(@aressupdays,''),
bcardsupdays = nullif(@bcardsupdays,''),
bestmatch = nullif(@bestmatch,''),
bressupdays = nullif(@bressupdays,''),
ccadmisorc = nullif(@ccadmisorc,''),
ccadmitype = nullif(@ccadmitype,''),
ccapcrel = nullif(@ccapcrel,''),
ccdisdate = nullif(@ccdisdate,''),
ccdisdest = nullif(@ccdisdest,''),
ccdisloc = nullif(@ccdisloc,''),
ccdisrdydate = nullif(@ccdisrdydate,''), 
ccdisrdytime = nullif(@ccdisrdytime,''), 
ccdisstat = nullif(@ccdisstat,''),
ccdistime = nullif(@ccdistime,''),
cclev2days = nullif(@cclev2days,''),
cclev3days = nullif(@cclev3days,''),
ccsorcloc = nullif(@ccsorcloc,''),
ccstartdate = nullif(@ccstartdate,''),
ccstarttime = nullif(@ccstarttime,''),
ccunitfun = nullif(@ccunitfun,''),
dermsupdays = nullif(@dermsupdays,''),
gisupdays = nullif(@gisupdays,''),
liversupdays = nullif(@liversupdays,''),
neurosupdays = nullif(@neurosupdays,''),
orgsupmax = nullif(@orgsupmax,''),
rensupdays = nullif(@rensupdays,''),
susrecid = nullif(@susrecid,''),
unitbedconfig = nullif(@unitbedconfig,'')
;

-- create index on record ID variable (susrecid)
CREATE INDEX susrecid on hes_ons.CC_2223 (susrecid);

-- link in patient tokenid from APC table on susrecid
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE hes_ons.CC_2223
	ADD COLUMN tokenid char(15);
;

UPDATE hes_ons.CC_2223 as dest, hes_ons.APC_2223 as newdata
SET dest.tokenid = newdata.tokenid
WHERE dest.susrecid=newdata.susrecid;
