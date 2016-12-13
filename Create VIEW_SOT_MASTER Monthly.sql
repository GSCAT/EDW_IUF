drop view SRAA_SAND.VIEW_SOT_MASTER_MONTHLY;

Create VIEW SRAA_SAND.VIEW_SOT_MASTER_MONTHLY AS

(Select
	a1.NUMBER_SEQ,
		case
	when a1.DEST_PO_ID BETWEEN '1' AND '9999999' THEN a1.DEST_PO_ID
	WHEN a1.DEST_PO_ID NOT BETWEEN '1' AND  '9999999'  THEN SUBSTR(a1.DEST_PO_ID, 1,5) || '-' || SUBSTR(a1.DEST_PO_ID, 6,2)
	END AS DPO,
	a1. Dest_PO_ID,
	a2.ReportingBrand,
	a1.Category as Total_Category,
	a1.PAR_VENDOR_LEGAL_DESC as Vendor,
	a1.CTRT_SHP_DT as ContractualshipCancelDate,
	a1.SHIP_CANCEL_DATE as ShipCancelDate,
	a1.ORD_QTY  as Units,
	a1.MetricShipDate,
	a1.ACTUAL_STOCKED_LCL_DATE as StockedDate,
	a1.ORIGIN_COUNTRY_CODE as CountryOfOrigin,
	a1.Lateness,
	a3.MO_NBR as "Month Number",
	cast(a1.Shp_Cxl_WK as INTEGER) as Week,
  	a1.DAYS_LATE,
	a4.Vendor_Rank as Rank2013,
	a3.MO_DESC as "Fiscal Month",
	SUBSTR(a3.QTR_DESC, 1,2) as Quarter,
	cast(a3.YR_NBR as INTEGER) "Fiscal Year",
	a1.GEO_GRP_ABBR_NM as DCCampus,
	a1.MasterVendorID as ParentVendorID,
	a1.AGT_DEPT_ID,
	a1.AGT_DEPT_ABBR_DESC as agnt_dep_desc,
	a1.OPR_BRD_STY_ID as OPR_BRD_STY_ID,
	a1.ShipDateChoice as Category_Source,
	a1.SALES_TERMS_CODE,
	a1.SHIP_MODE_CD,
	a1.ShipDateChoice,
	a1.TRADE_LANE_TYPE AS BorderCross,
	a1.PROGRAM_TYPE as ProgramType,
	a1.BUYING_AGENT_GROUP as "Buying Agent",
	a1.XFR_PT_COUNTRY_CODE,
	a1.LOC_ABBR_NM,
	a1.SHP_MODE_CATG_NM,
	a1.SHP_RSN_TYP_DESC,
	a1.Data_Pulled
	
	 
	 from SRAA_SAND.EDW_IUF_YTD a1
	 
	left join SRAA_SAND.RPT_BRD_LOOKUP a2
	ON a2.BRAND_DESC = a1.BRD_NM
	AND a2.Market_DESC = a1.MKT_NM
	and a2.Channel_DESC = a1. CHNL_NM
	
	
	left join SRAA_SAND.VRDCL_RLN_DAY_CAL_LKUP a3
	on a1.SHIP_CANCEL_DATE = a3.FIS_CAL_DT 
	
	LEFT JOIN ((Select MasterVendorID as MasterVendorID, 
	sum(FCST_QTY) as SUM_FCST_QTY, 
	sum(Total_FCST_ELC) as Sum_Tot_ELC, 
	Row_NUMBER() Over(order by (sum(Total_FCST_ELC) )desc ) as Vendor_Rank from SRAA_SAND.EDW_IUF_YTD
	group by MasterVendorID)) a4 
		ON a4.MasterVendorID=a1.MasterVendorID
		
		where a2.ReportingBrand is not NULL);