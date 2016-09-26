CREATE MULTISET TABLE SRAA_SAND.RPT_BRD_LOOKUP
(
	Brand_DESC varchar(30),
	Market_DESC varchar(30),
	Channel_DESC varchar(30),
	ReportingBrand varchar(30));
	
	insert into SRAA_SAND.RPT_BRD_LOOKUP
	VALUES (?,?,?,?);
	
	select * from SRAA_SAND.RPT_BRD_LOOKUP;