-- This is the main production table for SOT/OTS 
-- This is a YTD table. Dates must be changed in the where statement below once per  fiscal year

DROP TABLE SRAA_SAND.EDW_IUF_YTD;

CREATE MULTISET TABLE SRAA_SAND.EDW_IUF_YTD ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      NUMBER_SEQ INTEGER,
      DEST_PO_KEY INTEGER,
      DEST_PO_ID VARCHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      MKT_PO_ID VARCHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      BRD_KEY INTEGER,
      MKT_KEY INTEGER,
      CHNL_KEY INTEGER,
      LOC_KEY INTEGER,
      BRD_NM VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      OPR_BRD_DIV_ID INTEGER,
      BRD_DIV_DESC VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      OPR_BRD_DEPT_ID INTEGER,
      BRD_DEPT_DESC VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      OPR_BRD_CLS_ID INTEGER,
      BRD_CLS_DESC VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      OPR_BRD_SCLS_ID INTEGER,
      BRD_SCLS_DESC VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      OPR_BRD_STY_ID DECIMAL(18,0),
      BRD_STY_ITM_DESC VARCHAR(200) CHARACTER SET LATIN NOT CASESPECIFIC,
      
      OPR_GBL_STY_ID DECIMAL(18,0),
   	 OPR_STY_CLR_NBR DECIMAL(18,0), 
     BRD_STY_CLR_DESC VARCHAR(60) CHARACTER SET LATIN NOT CASESPECIFIC,
     
     BRD_STY_CLR_KEY DECIMAL(18,0),
    
      MKT_NM VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      CHNL_NM VARCHAR(50) CHARACTER SET LATIN NOT CASESPECIFIC,
      Program_Type CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      AGT_DEPT_ID INTEGER,
      AGT_DEPT_ABBR_DESC VARCHAR(15) CHARACTER SET LATIN NOT CASESPECIFIC,
      Category VARCHAR(23) CHARACTER SET UNICODE NOT CASESPECIFIC,
      GEO_GRP_ABBR_NM VARCHAR(30) CHARACTER SET LATIN NOT CASESPECIFIC,
      LOC_ABBR_NM VARCHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      ORIGIN_COUNTRY_CODE CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
      XFR_Point_Place VARCHAR(100) CHARACTER SET LATIN NOT CASESPECIFIC,
      DEST_COUNTRY_CODE VARCHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
      SALES_TERMS_CODE VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC,
      XFR_PT_COUNTRY_CODE VARCHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
      XFR_PT_PLACE_CODE VARCHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
      BUYING_AGENT_ID VARCHAR(11) CHARACTER SET LATIN NOT CASESPECIFIC,
      BUYING_AGENT_DESC VARCHAR(200) CHARACTER SET LATIN NOT CASESPECIFIC,
      BUYING_AGENT_GROUP VARCHAR(7) CHARACTER SET UNICODE NOT CASESPECIFIC,
      
      CONTAINER_ID VARCHAR(16) CHARACTER SET LATIN NOT CASESPECIFIC,
      TRLR_ID VARCHAR(16) CHARACTER SET LATIN NOT CASESPECIFIC,
      
      MasterVendorID INTEGER,
      PAR_VENDOR_ID INTEGER,
      VENDOR_ID INTEGER,
      VENDOR_LGCY_ID VARCHAR(9) CHARACTER SET LATIN NOT CASESPECIFIC,
      PAR_VENDOR_LEGAL_DESC VARCHAR(200) CHARACTER SET LATIN NOT CASESPECIFIC,
      VENDOR_LEGAL_DESC VARCHAR(200) CHARACTER SET LATIN NOT CASESPECIFIC,
      SHP_RSN_TYP_DESC VARCHAR(200) CHARACTER SET LATIN NOT CASESPECIFIC,
      SHIP_MODE_CD VARCHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      ACTL_SHP_MODE_CD VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC,
      SHP_MODE_CATG_NM CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      ORIGINAL_SHIP_CANCEL_DATE DATE FORMAT 'yyyy-mm-dd',
      CTRT_SHP_DT DATE FORMAT 'yyyy-mm-dd',
      SHIP_CANCEL_DATE DATE FORMAT 'yyyy-mm-dd',
      Shp_Cxl_WK BYTEINT,
      Shp_Cxl_YR SMALLINT,
      ORIGINAL_PLANNED_IN_DC_DATE DATE FORMAT 'yyyy-mm-dd',
      PLANNED_IN_DC_DATE DATE FORMAT 'yyyy-mm-dd',
      InDC_WK BYTEINT,
      InDC_YR SMALLINT,
      PLANNED_STOCKED_DATE DATE FORMAT 'yyyy-mm-dd',
      Planned_Stock_Week BYTEINT,
      Planned_Stock_YR SMALLINT,
      ACTUAL_X_FACTORY_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_ORIGIN_CONSOL_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_LP_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_DEST_CONSOL_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_DOM_DEPART_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_IN_DC_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ACTUAL_STOCKED_LCL_DATE DATE FORMAT 'yyyy-mm-dd',
      ORD_QTY DECIMAL(18,2),
      FCST_QTY DECIMAL(18,2),
      ACTL_STK_QTY INTEGER,
      FST_CST_USD_AMT FLOAT,
      ELC_AMT_USD FLOAT,
      Total_FCST_ELC DECIMAL(18,4),
      Total_FCST_FC DECIMAL(18,4),
      MetricShipDate DATE FORMAT 'yyyy-mm-dd',
      ShipDateChoice VARCHAR(4) CHARACTER SET LATIN NOT CASESPECIFIC,
      Trade_Lane_Type VARCHAR(13) CHARACTER SET LATIN NOT CASESPECIFIC,
      Lateness VARCHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
      Source_System VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC,
      DAYS_LATE INTEGER,
      Data_Pulled DATE FORMAT 'yyyy-mm-dd')
PRIMARY INDEX (  DEST_PO_ID, BRD_STY_CLR_KEY  );

insert into SRAA_SAND.EDW_IUF_YTD
select
 Row_Number() over( order by a11.DEST_PO_ID)  NUMBER_SEQ,
 	a11.DEST_PO_KEY,
	trim(a11.DEST_PO_ID) DEST_PO_ID,
	trim(a11.MKT_PO_ID) MKT_PO_ID,
	a11.BRD_KEY,
	a11.MKT_KEY,
	a11.CHNL_KEY,
	a11.LOC_KEY,
	a15.BRD_NM,
	a24.OPR_BRD_DIV_ID,
	a24.BRD_DIV_DESC,
	a22.OPR_BRD_DEPT_ID,
	a22.BRD_DEPT_DESC,
	a14.OPR_BRD_CLS_ID,
	a14.BRD_CLS_DESC,
	a13.OPR_BRD_SCLS_ID,
	a13.BRD_SCLS_DESC,
	a12.OPR_BRD_STY_ID,
	a12.BRD_STY_ITM_DESC,
	
	a117.OPR_GLBL_STY_ID,
	a117.OPR_STY_CLR_NBR,
	a117.BMC_STY_CLR_DESC,

	a11.BRD_STY_CLR_KEY,
	a19.MKT_NM,
	a16.CHNL_NM,
	max(a110.CD_DTL_ABBR_NM)  Program_Type,
	a11.agt_dept_id,
	a112.AGT_DEPT_ABBR_DESC,
case
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = '3P' then '3P & Lic'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'A_' then 'Accessories'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'AL' then 'IP'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'D_' then 'Denim and Woven Bottoms'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'DW' then 'Denim and Woven Bottoms'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'I_' then 'IP'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'K_' then 'Knits'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'KF' then 'Knits'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'LC' then '3P & Lic'
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'S_' then 'Sweaters'	
		when SUBSTR(a112.AGT_DEPT_ABBR_DESC, 1, 2) = 'W_' then 'Wovens'
		else 'Category Other'
		end as Category,
		
	a18.GEO_GRP_ABBR_NM,
	trim(a17.LOC_ABBR_NM) LOC_ABBR_NM,
	a111.ISO2_CNTRY_CD ORIGIN_COUNTRY_CODE,
	max(a111.UNAT_PLC_NM ) XFR_Point_Place,
	trim(a11.DEST_COUNTRY_CODE) DEST_COUNTRY_CODE,
	trim(a11.SALES_TERMS_CODE) SALES_TERMS_CODE ,
	trim(a11.XFR_PT_COUNTRY_CODE) XFR_PT_COUNTRY_CODE,
	trim(a11.XFR_PT_PLACE_CODE) XFR_PT_PLACE_CODE,
	trim(a11.BUYING_AGENT_ID) BUYING_AGENT_ID,
	trim(a116.BUYING_AGENT_DESC) BUYING_AGENT_DESC,
		CASE
			WHEN SUBSTR(a116.BUYING_AGENT_DESC,1, 3) = 'GIS' THEN 'GIS'
			WHEN SUBSTR(a116.BUYING_AGENT_DESC,1, 3) = 'GAP' THEN 'GIS'
			ELSE 'Non-GIS' 
			END AS BUYING_AGENT_GROUP,
	
	a11.CONTAINER_ID,
	a11.TRLR_ID,
	
		CASE
			WHEN a11.PAR_VENDOR_ID = (-1) THEN a11.VENDOR_ID
			ELSE a11.PAR_VENDOR_ID END AS MasterVendorID,
	a11.PAR_VENDOR_ID,
	a11.VENDOR_ID,
	a21.VENDOR_LGCY_ID,
	a21.VENDOR_LEGAL_DESC as PAR_VENDOR_LEGAL_DESC,
	b21.VENDOR_LEGAL_DESC as VENDOR_LEGAL_DESC,
	a11.SHP_RSN_TYP_DESC,
	trim(a11.SHIP_MODE_CD) SHIP_MODE_CD,
	trim(a11.ACTL_SHP_MODE_CD) ACTL_SHP_MODE_CD,
	a20.SHP_MODE_CATG_NM,
	a11.ORIGINAL_SHIP_CANCEL_DATE,
	case when CAST(a25.CTRT_SHP_DT as varchar(10)) = '1900-01-01' then a11.SHIP_CANCEL_DATE else a25.CTRT_SHP_DT  end as CTRT_SHP_DT,
	a11.SHIP_CANCEL_DATE,
	a115.WK_NBR Shp_Cxl_WK,
	a115.YR_NBR Shp_Cxl_YR,
	case when CAST(a11.ORIGINAL_PLANNED_IN_DC_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ORIGINAL_PLANNED_IN_DC_DATE END AS ORIGINAL_PLANNED_IN_DC_DATE,
	case when CAST( a11.PLANNED_IN_DC_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.PLANNED_IN_DC_DATE end AS PLANNED_IN_DC_DATE,
	a113.WK_NBR InDC_WK,
	a113.YR_NBR InDC_YR,
	a11.PLANNED_STOCKED_DATE,
	a114.WK_NBR Planned_Stock_Week,
	a114.YR_NBR Planned_Stock_YR,
	case when CAST(a11.ACTUAL_X_FACTORY_LCL_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_X_FACTORY_LCL_DATE  end AS ACTUAL_X_FACTORY_LCL_DATE,
	case when CAST(a11.ACTUAL_ORIGIN_CONSOL_LCL_DATE  AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_ORIGIN_CONSOL_LCL_DATE   end AS ACTUAL_ORIGIN_CONSOL_LCL_DATE ,
	case when CAST(a11.ACTUAL_LP_LCL_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_LP_LCL_DATE  end AS ACTUAL_LP_LCL_DATE,
	case when CAST(a11.ACTUAL_DEST_CONSOL_LCL_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_DEST_CONSOL_LCL_DATE  end AS ACTUAL_DEST_CONSOL_LCL_DATE,
	case when CAST(a11.ACTUAL_DOM_DEPART_LCL_DATE AS VARCHAR(10)) = '9999-12-31'  then NULL else a11.ACTUAL_DOM_DEPART_LCL_DATE  end AS ACTUAL_DOM_DEPART_LCL_DATE,
	case when CAST(a11.ACTUAL_IN_DC_LCL_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_IN_DC_LCL_DATE  end AS ACTUAL_IN_DC_LCL_DATE,
	case when CAST(a11.ACTUAL_STOCKED_LCL_DATE AS VARCHAR(10)) = '9999-12-31' then NULL else a11.ACTUAL_STOCKED_LCL_DATE  end AS ACTUAL_STOCKED_LCL_DATE,
	sum(a11.XPLD_LN_ORD_QTY)  ORD_QTY,
	sum(a11.FCST_QTY)  FCST_QTY,
	sum(a11.ACTL_QTY)  ACTL_STK_QTY,
	avg(a11.FST_CST_USD_AMT) FST_CST_USD_AMT,
	avg(a11.ELC_AMT_USD) ELC_AMT_USD,
	sum(ELC_AMT_USD * FCST_QTY) as Total_FCST_ELC,
	sum(FST_CST_USD_AMT*FCST_QTY) as Total_FCST_FC,
	
	  null as MetricShipDate,
      null as ShipDateChoice,
      null as Trade_Lane_Type,
      null as Lateness,
      null as Source_System,
      null as DAYS_LATE,
      Date
	
	
from VIEWORDER.VIUFF_INBND_UNT_FCST_FCT a11
	left outer join	 VIEWFNDT.TBRSD_BRD_STY_DIM	 a12
	  on 	(a11.BRD_STY_KEY = a12.BRD_STY_KEY)
	left outer join	 VIEWFNDT.TBSCD_BRD_SCLS_DIM a13
	  on 	(a12.BRD_SCLS_KEY = a13.BRD_SCLS_KEY)
	left outer join	 VIEWFNDT.TBCSD_BRD_CLS_DIM	a14
	  on 	(a13.BRD_CLS_KEY = a14.BRD_CLS_KEY)
	left outer join	 VIEWFNDT.TBRDL_BRD_LOOKUP	a15
	  on 	(a11.BRD_KEY = a15.BRD_KEY)
	left outer join	 VIEWFNDT.TCHNL_CHNL_LOOKUP	a16
	  on 	(a11.CHNL_KEY = a16.CHNL_KEY)
	left outer join	(SELECT *
		FROM VIEWFNDT.TLOCD_LOC_DIM
		WHERE CUR_REC_IND = 'Y' AND LOC_TYP_CD_ID = 76)	a17
		 on 	(a11.LOC_KEY = a17.LOC_KEY)
	left outer join 	VIEWFNDT.TGGPL_GEO_GRP_LKUP	a18
	  on 	(a11.GEO_GRP_ID = a18.GEO_GRP_ID)
	left outer join 	VIEWFNDT.TMKTL_MKT_LOOKUP	a19
	  on 	(a11.MKT_KEY = a19.MKT_KEY)
	left outer join	 VIEWFNDT.VMCLL_SHP_MODE_CAT_LOOKUP	a20
	  on 	(a11.ACTL_SHP_MODE_CATG_CD = a20.SHP_MODE_CATG_CD)
	  
	  
	left outer join	 VIEWORDER.VVLNL_VND_LEGAL_NM_LOOKUP a21
	 on (MasterVendorID = a21.VENDOR_ID)
	left outer join	 VIEWORDER.VVLNL_VND_LEGAL_NM_LOOKUP b21
	 on (a11.VENDOR_ID = b21.VENDOR_ID)
	 	 
	 
	left outer join	 VIEWFNDT.TBDPD_BRD_DEPT_DIM	a22
	  on 	(a14.BRD_DEPT_KEY = a22.BRD_DEPT_KEY)
	left outer join	 VIEWFNDT.TBDHL_BRD_DEPT_ALT_HIER_ASSN	a23
	  on 	(a14.BRD_DEPT_KEY = a23.BRD_DEPT_KEY)
	left outer join	 VIEWFNDT.TBDVD_BRD_DIV_DIM	a24
	  on 	(a23.PAR_HIER_KEY = a24.BRD_DIV_KEY)
	left outer join	 VIEWORDER.tdhpf_dest_hdr_po_fct a25
	  on 	(a11.DEST_PO_ID = a25.DEST_PO_ID)
	left outer join	(SELECT OPR_CD_ID, CD_DTL_ABBR_NM
		FROM VIEWFNDT.TCDTL_CD_DTL_LOOKUP WHERE CD_TYP_ID = 1158 GROUP BY 1,2)	a110
	 		 on 	(a11.PO_BLD_TYP_CD = a110.OPR_CD_ID)
	 left outer join	VIEWFNDT.TUNLL_UNED_NATION_LOC_LOOKUP	a111
	 	 on 	(a11.XFR_PT_COUNTRY_CODE = a111.ISO2_CNTRY_CD and 
			a11.XFR_PT_PLACE_CODE = a111.UNAT_PLC_CD)
	left outer join (Select  AGT_DEPT_ID, AGT_DEPT_ABBR_DESC  as AGT_DEPT_ABBR_DESC, SRC_LST_UPDT_DT from ViewDST.TAGDL_AGT_DEPT_LOOKUP 
		Qualify
		row_number() Over (partition by AGT_DEPT_ID order by SRC_LST_UPDT_DT desc)= 1 ) a112
			on a11.AGT_DEPT_ID = a112.AGT_DEPT_ID
	left outer join  VIEWFNDT.VRDCL_RLN_DAY_CAL_LKUP   a113
		on a113.FIS_CAL_DT = a11.PLANNED_IN_DC_DATE
	left outer join  VIEWFNDT.VRDCL_RLN_DAY_CAL_LKUP   a114
		on a114.FIS_CAL_DT = a11.PLANNED_STOCKED_DATE
	left outer join  VIEWFNDT.VRDCL_RLN_DAY_CAL_LKUP   a115
		on a115.FIS_CAL_DT = a11.SHIP_CANCEL_DATE
	left outer join VIEWORDER.VBAGL_BUYING_AGENT_LKP a116
		on a11.BUYING_AGENT_ID =  a116.BUYING_AGENT_ID
	  
	  left outer join  VIEWFNDT.VSTVH_BMC_STY_CLR_DIM_HIST a117
		on a117.MKT_KEY = a11.MKT_KEY
		and a117.CHNL_KEY = a11.CHNL_KEY
		and a117.BRD_STY_CLR_KEY = a11.BRD_STY_CLR_KEY

where ((a11.SHIP_CANCEL_DATE between DATE '2017-01-29' and CURRENT_DATE ) or (a11.PLANNED_STOCKED_DATE between DATE '2017-01-29' and CURRENT_DATE))
--where ((a11.SHIP_CANCEL_DATE between DATE '2016-01-31' and  DATE '2017-01-28'  ) or (a11.PLANNED_STOCKED_DATE between DATE '2016-01-31' and DATE '2017-01-28' ))
--where ((a11.SHIP_CANCEL_DATE between DATE '2016-01-31' and DATE '2017-02-04'  ) or (a11.PLANNED_STOCKED_DATE between DATE '2016-01-31' and DATE '2017-02-04'))
	--where (a11.ORIGINAL_SHIP_CANCEL_DATE + 45 >=  '2016-01-31')
	and  (a11.DEST_PO_ID is not null)
	--and a11.ACTL_SHP_MODE_CATG_CD not in ('O         ', 'AC        ', 'AP        ', 'M         ')
	and a11.CURRENT_EVENT not in ('CL        ')

group by
	a11.DEST_PO_KEY,	
	a11.DEST_PO_ID,
	a11.MKT_PO_ID,
	a11.BRD_KEY,
	a11.MKT_KEY,
	a11.CHNL_KEY,
	a11.LOC_KEY,
	a15.BRD_NM,
	a24.OPR_BRD_DIV_ID,
	a24.BRD_DIV_DESC,
	a22.OPR_BRD_DEPT_ID,
	a22.BRD_DEPT_DESC,
	a14.OPR_BRD_CLS_ID,
	a14.BRD_CLS_DESC,
	a13.OPR_BRD_SCLS_ID,
	a13.BRD_SCLS_DESC,
	a12.OPR_BRD_STY_ID,
	a12.BRD_STY_ITM_DESC,
	
	a117.OPR_GLBL_STY_ID,
	a117.OPR_STY_CLR_NBR,
	a117.BMC_STY_CLR_DESC,
	
	a11.BRD_STY_CLR_KEY,
	a19.MKT_NM,
	a16.CHNL_NM,
	a110.CD_DTL_ABBR_NM,
	a11.agt_dept_id,
	a112.AGT_DEPT_ABBR_DESC,
	a18.GEO_GRP_ABBR_NM,
	a17.LOC_ABBR_NM,
	a111.ISO2_CNTRY_CD ,
	a11.DEST_COUNTRY_CODE,
	a11.SALES_TERMS_CODE ,
	a11.XFR_PT_COUNTRY_CODE,
	a11.XFR_PT_PLACE_CODE,
	a11.BUYING_AGENT_ID,
	a116.BUYING_AGENT_DESC,
	a11.CONTAINER_ID,
	a11.TRLR_ID,
	MasterVendorID,
	a11.PAR_VENDOR_ID,
	a11.VENDOR_ID,
	a21.VENDOR_LGCY_ID,
	a21.VENDOR_LEGAL_DESC,
	b21.VENDOR_LEGAL_DESC,
	a11.SHP_RSN_TYP_DESC,
	a11.SHIP_MODE_CD,
	a11.ACTL_SHP_MODE_CD ,
	a20.SHP_MODE_CATG_NM,
	a11.ORIGINAL_SHIP_CANCEL_DATE,
	a11.SHIP_CANCEL_DATE,
	Shp_Cxl_WK,
	Shp_Cxl_YR,
	a11.ORIGINAL_PLANNED_IN_DC_DATE,
	a11.PLANNED_IN_DC_DATE,
	InDC_WK,
	InDC_YR,
	a11.PLANNED_STOCKED_DATE,
	Planned_Stock_Week,
	Planned_Stock_YR,
	a11.ACTUAL_X_FACTORY_LCL_DATE ,
	a11.ACTUAL_ORIGIN_CONSOL_LCL_DATE ,
	a11.ACTUAL_LP_LCL_DATE ,
	a11.ACTUAL_DEST_CONSOL_LCL_DATE,
	a11.ACTUAL_DOM_DEPART_LCL_DATE,
	a11.ACTUAL_IN_DC_LCL_DATE ,
	a11.ACTUAL_STOCKED_LCL_DATE ,
	a25.CTRT_SHP_DT,
	MetricShipDate,
    ShipDateChoice,
    Trade_Lane_Type,
     Lateness,
     Source_System,
     DAYS_LATE;
     
/*  Create a TEMP TABLE with one Category per style*/    
DROP TABLE  SRAA_SAND.STAGE_STYLE_CATEGORY;

 CREATE MULTISET  TABLE SRAA_SAND.STAGE_STYLE_CATEGORY AS  (Select OPR_BRD_STY_ID, CATEGORY from  SRAA_SAND.EDW_IUF_YTD 
 where Category is not null  
	Qualify
	row_number() Over (partition by OPR_BRD_STY_ID order by ORIGINAL_SHIP_CANCEL_DATE desc)= 1 ) WITH DATA;

--update any DPO that does not have a category if there is a style match above
UPDATE SRAA_SAND.EDW_IUF_YTD
SET CATEGORY = (SELECT STAGE_STYLE_CATEGORY.CATEGORY FROM STAGE_STYLE_CATEGORY 
	WHERE SRAA_SAND.EDW_IUF_YTD.OPR_BRD_STY_ID = STAGE_STYLE_CATEGORY.OPR_BRD_STY_ID)
	WHERE SRAA_SAND.EDW_IUF_YTD.CATEGORY = 'Category Other' ;
	
-- Start of MetricShipDate logic
-- 1) Set FOB/CFR Ocean to LP
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_LP_LCL_DATE, ShipDateChoice = 'LP'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'FOB' OR SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR')
	AND SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'O'
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_LP_LCL_DATE IS NOT NULL;

-- 2) Set FOB Air to OC
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE, ShipDateChoice = 'OC'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'FOB')
	AND SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'A'
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE IS NOT NULL;
	


-- Define Trade Lane Type
Update SRAA_SAND.EDW_IUF_YTD
Set Trade_Lane_Type = Case 
			when  SRAA_SAND.EDW_IUF_YTD.XFR_PT_COUNTRY_CODE=SRAA_SAND.EDW_IUF_YTD.DEST_COUNTRY_CODE  then 'Domestic'
			ELSE 'International' End; 

	-- 2b) Set FOB  Motor Intl  to OC
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE, ShipDateChoice = 'OC'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'FOB')
	AND SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'M'
	AND SRAA_SAND.EDW_IUF_YTD.TRADE_LANE_TYPE = 'International' 
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE IS NOT NULL;

--3) Update MetricShipDate to Dom Depart for FOB motor domestic
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_DOM_DEPART_LCL_DATE, ShipDateChoice = 'DD'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'FOB')
	AND SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'M'
	AND SRAA_SAND.EDW_IUF_YTD.TRADE_LANE_TYPE = 'Domestic'
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_DOM_DEPART_LCL_DATE IS NOT NULL;

--4) Update MetricShipDate to Origin Consol
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE, ShipDateChoice = 'OC'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'FCA')
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE IS NOT NULL;

-- 5) Update MetricShipDate to DES_CONSOL for DDP/DDU Domestic
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = CASE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_DEST_CONSOL_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_DEST_CONSOL_LCL_DATE
		WHEN  SRAA_SAND.EDW_IUF_YTD.ACTUAL_DOM_DEPART_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_DOM_DEPART_LCL_DATE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE
		WHEN ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN ACTUAL_STOCKED_LCL_DATE
		END,
		
		ShipDateChoice = CASE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_DEST_CONSOL_LCL_DATE IS NOT NULL THEN 'DCON'
		WHEN  SRAA_SAND.EDW_IUF_YTD.ACTUAL_DOM_DEPART_LCL_DATE IS NOT NULL THEN 'DD'
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN 'InDC'
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN 'SD'
		END
	Where  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'DDP' OR SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'DDU')  
				AND SRAA_SAND.EDW_IUF_YTD.TRADE_LANE_TYPE = 'Domestic' ;

-- 6) Update MetricShipDate to Origin Consol for DDP/DDU International
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = CASE
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE  IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE 
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_LP_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_LP_LCL_DATE
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE
			END,
		
		ShipDateChoice = CASE
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE  IS NOT NULL THEN 'OC'
			WHEN  SRAA_SAND.EDW_IUF_YTD.ACTUAL_LP_LCL_DATE IS NOT NULL THEN 'LP'
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN 'InDC'
			WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN 'SD'
			END
	Where (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'DDP' OR SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'DDU')  
				AND SRAA_SAND.EDW_IUF_YTD.TRADE_LANE_TYPE = 'International' ;

-- 7) Set CFR Motor and Air
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = CASE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE
		END,
		ShipDateChoice = CASE
		WHEN  SRAA_SAND.EDW_IUF_YTD.ACTUAL_ORIGIN_CONSOL_LCL_DATE IS NOT NULL THEN 'OC'
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_IN_DC_LCL_DATE IS NOT NULL THEN 'InDC'
		WHEN SRAA_SAND.EDW_IUF_YTD.ACTUAL_STOCKED_LCL_DATE IS NOT NULL THEN 'SD'
		END
	Where  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR') AND (SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'M' OR SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD ='A') ;

-- 8) Set all EXW to XF
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_X_FACTORY_LCL_DATE, ShipDateChoice = 'XF'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'EXW')
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_X_FACTORY_LCL_DATE IS NOT NULL;

-- 9) TNR exception
UPDATE SRAA_SAND.EDW_IUF_YTD
SET MetricShipDate = SRAA_SAND.EDW_IUF_YTD.ACTUAL_X_FACTORY_LCL_DATE, ShipDateChoice = 'XF'
	WHERE  (SRAA_SAND.EDW_IUF_YTD.Program_Type = 'TNR')
	AND SRAA_SAND.EDW_IUF_YTD.ACTUAL_X_FACTORY_LCL_DATE IS NOT NULL;

--add ShipCancelStatus 
Update SRAA_SAND.EDW_IUF_YTD
Set Lateness = 'Unmeasured';

/*UPDATE SRAA_SAND.EDW_IUF_YTD
SET Lateness= CASE
		WHEN  (SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'A' 
				AND SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR') 
				AND (SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.Ship_Cancel_Date >2) 
			THEN 'Late'
			
		WHEN not (SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'A' 
				AND SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR') 
				AND (SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.CTRT_SHP_DT >2) 
			THEN 'Late'
		Else 'OnTime' 
END
		
	where SRAA_SAND.EDW_IUF_YTD.MetricShipDate is not null;*/
	
	
UPDATE SRAA_SAND.EDW_IUF_YTD
SET Lateness= CASE
				when (SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.CTRT_SHP_DT >2) 
			THEN 'Late'
		Else 'OnTime' 
END
		
	where SRAA_SAND.EDW_IUF_YTD.MetricShipDate is not null;

-- Add Source System		
UPDATE SRAA_SAND.EDW_IUF_YTD
SET Source_System = CASE
		WHEN trim(SRAA_SAND.EDW_IUF_YTD.DEST_PO_ID) between '0' and '9999999'THEN 'SCMS'
		WHEN trim(SRAA_SAND.EDW_IUF_YTD.DEST_PO_ID) not between '0' and '9999999'THEN 'PROMPT'
		END
	where SRAA_SAND.EDW_IUF_YTD.DEST_PO_ID is not null;
		
--Calculate Days Late 
/*UPDATE SRAA_SAND.EDW_IUF_YTD
SET DAYS_LATE= CASE
		WHEN  (SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'A' 
				AND SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR') Then SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.Ship_Cancel_Date 
		WHEN not (SRAA_SAND.EDW_IUF_YTD.SHIP_MODE_CD = 'A' 
				AND SRAA_SAND.EDW_IUF_YTD.SALES_TERMS_CODE = 'CFR') THEN SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.CTRT_SHP_DT
		END
	where SRAA_SAND.EDW_IUF_YTD.MetricShipDate is not null;*/
	
UPDATE SRAA_SAND.EDW_IUF_YTD
SET DAYS_LATE =  SRAA_SAND.EDW_IUF_YTD.MetricShipDate - SRAA_SAND.EDW_IUF_YTD.CTRT_SHP_DT
	where SRAA_SAND.EDW_IUF_YTD.MetricShipDate is not null;


	-- 9) Missing Stocked date fix
UPDATE SRAA_SAND.EDW_IUF_YTD
SET ACTUAL_STOCKED_LCL_DATE = ACTUAL_IN_DC_LCL_DATE + 2
	WHERE ACTUAL_STOCKED_LCL_DATE is null
	AND ACTUAL_IN_DC_LCL_DATE IS NOT NULL
	AND ACTUAL_IN_DC_LCL_DATE < (Data_Pulled -2);