drop view SRAA_SAND.VIEW_SOT_MASTER;

Create VIEW SRAA_SAND.VIEW_SOT_MASTER AS

(Select
	a1. Dest_PO_ID,
	a2.ReportingBrand,
	a1.Category,
	a1.PAR_VENDOR_LEGAL_DESC Parent_Vendor,
	a1.CTRT_SHP_DT Contract_Ship_Cancel,
	a1.SHIP_CANCEL_DATE,
	a1.ORD_QTY  as Units,
	a1.MetricShipDate,
	a1.ACTUAL_STOCKED_LCL_DATE StockedDate,
	a1.ORIGIN_COUNTRY_CODE CountryOfOrigin,
	a1.Lateness,
	a3.MO_NBR ShipCancelMonth,
	cast(a1.Shp_Cxl_WK as INTEGER) ShipCancelWeek,
  	a1.DAYS_LATE,
	a4.Vendor_Rank,
	a3.MO_DESC Fiscal_Month,
	a3.QTR_DESC Quarter,
	cast(a3.YR_NBR as INTEGER) FISCAL_YEAR,
	a1.GEO_GRP_ABBR_NM DC_GEO_LOC,
	a1.MasterVendorID,
	a1.AGT_DEPT_ID,
	a1.AGT_DEPT_ABBR_DESC AGENT_DEPT,
	a1.OPR_BRD_STY_ID,
	a1.ShipDateChoice as Category_Source,
	a1.SALES_TERMS_CODE,
	a1.SHIP_MODE_CD,
	a1.ShipDateChoice,
	a1.TRADE_LANE_TYPE,
	a1.PROGRAM_TYPE ProgramType,
	a1.BUYING_AGENT_GROUP,
	a1.XFR_PT_COUNTRY_CODE,
	a1.LOC_ABBR_NM,
	a1.SHP_MODE_CATG_NM,
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