drop view SRAA_SAND.VIEW_OTS_MASTER_2013FWD;

Create VIEW SRAA_SAND.VIEW_OTS_MASTER_2013FWD AS

(Select
	a1.NUMBER_SEQ,
	a1. Dest_PO_ID,
	a2.ReportingBrand,
	a1.Category,
	a1.OPR_BRD_STY_ID,
	a1.BRD_STY_CLR_DESC,
	a1.MDSE_SEAS_TYP_NM,
	a1.PAR_VENDOR_LEGAL_DESC Parent_Vendor,
	a4.Vendor_Rank,
	a1.CTRT_SHP_DT Contract_Ship_Cancel,
	a1.PLANNED_IN_DC_DATE as cur_in_dc_dt,
	a1.PLANNED_STOCKED_DATE,
	a1.ACTUAL_IN_DC_LCL_DATE AS inDCDTe,
	a1.ACTUAL_STOCKED_LCL_DATE StkdDte,
	 a1.ORD_QTY  as Units,
		case
			--WHEN a1.ACTUAL_STOCKED_LCL_DATE is null then 'Unmeasurable'
			
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is null and (((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE)  between 4 and 45)) then 'Late' 
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is null and ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE between -45 and 3)) then 'OnTime' 
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE -  a1.PLANNED_STOCKED_DATE) between -45 and 3  then 'OnTime'
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE -  a1.PLANNED_STOCKED_DATE) between 4 and 45  then 'Late'
						WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE > 45)) THEN 'Undetermined'
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE < -(45))) THEN 'Undetermined'
		else 'OnTime' END as Lateness,
		case
			--WHEN a1.ACTUAL_STOCKED_LCL_DATE is null then 0
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE < 45)) THEN (a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE > -(45))) THEN (a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE > 45)) THEN 0
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE is NULL AND ((a1.Data_Pulled) - a1.PLANNED_STOCKED_DATE < -(45))) THEN 0
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE -  a1.PLANNED_STOCKED_DATE) > 45 then 0
			WHEN (a1.ACTUAL_STOCKED_LCL_DATE -  a1.PLANNED_STOCKED_DATE) < -(45) then 0
			ELSE  (a1.ACTUAL_STOCKED_LCL_DATE -  a1.PLANNED_STOCKED_DATE)  END AS Days_Late,
		CASE
			WHEN a1.LOC_ABBR_NM =  'UK DC' THEN 'GUK'
			ELSE a1.LOC_ABBR_NM END AS DC_NAME,
	a1.Planned_Stock_Week as Week,
	a3.MO_NBR  Month_Number,
	a1.SHP_MODE_CATG_NM,
	a1.DEST_COUNTRY_CODE AS DestCtryCD,
	a1.ACTUAL_STOCKED_LCL_DATE - a1.PLANNED_STOCKED_DATE as Varstockdate,
	a1.LOC_ABBR_NM,
	a1.AGT_DEPT_ABBR_DESC as agt_dep_desc,
	a1.AGT_DEPT_ID,
	a3.MO_DESC Fiscal_Month,
	a1.GEO_GRP_ABBR_NM as DCCampus,
	a1.ORIGIN_COUNTRY_CODE,
	a1.XFR_Point_Place,
	a1.SHIP_CANCEL_DATE,
	a1.ACTUAL_LP_LCL_DATE,
	a1.SHP_RSN_TYP_DESC,
	a1.ACTUAL_IN_DC_LCL_DATE,
	a1.Data_Pulled
	
	 
	 from SRAA_SAND.EDW_IUF_YTD a1
	 
	left join SRAA_SAND.RPT_BRD_LOOKUP a2
	ON a2.BRAND_DESC = a1.BRD_NM
	AND a2.Market_DESC = a1.MKT_NM
	and a2.Channel_DESC = a1. CHNL_NM
	
	
	left join SRAA_SAND.VRDCL_RLN_DAY_CAL_LKUP a3
	on a1.PLANNED_STOCKED_DATE = a3.FIS_CAL_DT 
	
	LEFT JOIN ((Select MasterVendorID as MasterVendorID, 
	sum(FCST_QTY) as SUM_FCST_QTY, 
	sum(Total_FCST_ELC) as Sum_Tot_ELC, 
	Row_NUMBER() Over(order by (sum(Total_FCST_ELC) )desc ) as Vendor_Rank from SRAA_SAND.EDW_IUF_YTD
	group by MasterVendorID)) a4 
		ON a4.MasterVendorID=a1.MasterVendorID
		
		where a2.ReportingBrand is not NULL);