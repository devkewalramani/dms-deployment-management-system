<!-- InstanceBegin template="/Templates/dms_management.dwt" codeOutsideHTMLIsLocked="false" --><head>
<!-- InstanceBeginEditable name="title" -->
<title></title>
<!-- InstanceEndEditable -->
<style type="text/css">
<!--
.locheader {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #FFFFFF;
}
.maincontent {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: normal;
	color: #000000;
}
.copyrightnfo {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	font-weight: bold;
	color: #CCCCCC;
}
.pageheader {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #CC3300;
}
.style1 {	font-size: 10px;
	font-weight: normal;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #999999;
}
.style23 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: normal;}
-->
</style>
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
<!--
.style24 {color: #0000FF}
-->
</style>
<!-- InstanceEndEditable -->
</head>


<body link="#333366">
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="742"><img src="../pics/DMSLogoLong.jpg" width="741" height="70"></td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" height="25" bgcolor="#949DA1">&nbsp;</td>
    <td bgcolor="#949DA1" class="locheader" width="612">//<a href="http://www.sbsplanet.com/"><font color="#FFFFFF">SBS 
      Planet</font></a> //<a href="index.htm"><font color="#FFFFFF">My Planet</font></a>    </td>
  </tr>
</table>
<table width="742" height="379" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="126" height="447" align="left" valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
<!-- #BeginLibraryItem "/Library/NewNavMain.lbi" -->
<img src="../pics/scheduling.jpg" name="Image1" width="123" height="30" border="0" id="Image1"><a href="schedule.cfm" ><img src="../pics/sub_add_schedule.jpg" name="Image1a" width="123" height="17" border="0" id="Image1a"></a><a href="vacation.cfm" ><img src="../pics/sub_add_vacation.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><a href="search.cfm" ><img src="../pics/sub_search_schedule.jpg" name="Image1b" width="123" height="17" border="0" id="Image1b"></a><a href="schedule/viewschedule.cfm"><img src="../pics/sub_view_schedule.jpg" name="Image1d" width="123" height="17" border="0" id="Image1d"></a><a href="schedule/choose.cfm" target="_blank" ><img src="../pics/sub_eng_schedule.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><img src="../pics/travel.jpg" name="Image2" width="123" height="30" border="0" id="Image2"><a href="trsearch.cfm" ><img src="../pics/sub_sendtr_travel.jpg" name="Image2a" width="123" height="17" border="0" id="Image2a"></a><a href="trpipline.cfm"><img src="../pics/sub_pending_travel.jpg" name="Image2b" width="123" height="17" border="0" id="Image2b"></a><img src="../pics/tasklist.jpg" name="Image3" width="123" height="30" border="0" id="Image3"><a href="tlsearch.cfm" ><img src="../pics/sub_submit_tasklist.jpg" name="Image3a" width="123" height="17" border="0" id="Image3a"></a><a href="tasklist_tracking.cfm" target="_blank" ><img src="../pics/sub_outstanding_tasklist.jpg" name="Image3b" width="123" height="17" border="0" id="Image3b"></a><img src="../pics/reporting.jpg" name="Image4" width="123" height="30" border="0" id="Image4"><a href="cancel_dates.cfm" ><img src="../pics/sub_cancel_report.jpg" name="Image4a" width="123" height="17" border="0" id="Image4a"></a><a href="loe_dates.cfm" ><img src="../pics/sub_loe_report.jpg" name="Image4b" width="123" height="17" border="0" id="Image4b"></a><a href="utilization_daterange.cfm" ><img src="../pics/sub_util_report.jpg" name="Image4c" width="123" height="17" border="0" id="Image4c"></a><a href="daterange.cfm" ><img src="../pics/sub_bu_report.jpg" name="Image4d" width="123" height="17" border="0" id="Image4d"></a><a href="metric/index.cfm" ><img src="../pics/sub_metric_report.jpg" name="Image4e" width="123" height="17" border="0" id="Image4e"></a><a href="tam_eoe_dates.cfm" ><img src="../pics/sub_tameoe_report.jpg" name="Image4f" width="123" height="17" border="0" id="Image4f"></a><img src="../pics/admin.jpg" name="Image5" width="123" height="30" border="0" id="Image5"><a href="adddm.cfm" ><img src="../pics/sub_adddm_admin.jpg" name="Image5c" width="123" height="17" border="0" id="Image5c"></a><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<!---
This page does database updates after a scheduled project is updated
--->

<!--- lookup employee info --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmpID, Lname, Fname, EmailAddress,Region,Type
FROM dbo.SE
WHERE EmpID = #Form.EmpID#
</cfquery>

<!--- update schedule travel --->
<cfquery name="update" datasource="SBSEFD">
UPDATE dbo.schedule SET DispatchID='#Form.DispatchID#', OmniNum='#Form.OmniNum#', projcode='#Form.projcode#', dell_pid='#Form.dell_pid#',PO_Num='#PO_Num#',ProjectName='#Form.ProjectName#',ProjectCity='#Form.ProjectCity#',ProjectState='#Form.ProjectState#',ProjectZip='#Form.ProjectZip#',StartDate='#Form.StartDate#',StartTime='#Form.StartTime#',EndDate='#Form.EndDate#',EndTime='#Form.EndTime#',SE_LName='#SE_lookup.LName#',SE_FName='#SE_lookup.FName#',ProjectType='#Form.ProjectType#',DM='#Form.DM#',LOE_Price='#Form.LOE_Price#', Travel_Price='#Form.Travel_price#', Bill_Travel='#Form.Bill_travel#', se_flag='#Form.se_flag#', dell_sku='#Form.Dell_sku#',ProjectSummary='#Form.ProjectSummary#',mgmt_dwb='#Form.mgmt_dwb#' WHERE RID='#FORM.RID#'
</cfquery>

<!--- update travel table --->
<cfquery name="updatetr" datasource="SBSEFD">
UPDATE dbo.Travel SET DispatchID='#Form.DispatchID#',OmniNum='#Form.OmniNum#', ProjectName='#Form.ProjectName#',ProjectCity='#Form.ProjectCity#',ProjectState='#Form.ProjectState#',ProjectZip='#Form.ProjectZip#',StartDate='#Form.StartDate#',StartTime='#Form.StartTime#',EndDate='#Form.EndDate#',EndTime='#Form.EndTime#',SE_LName='#SE_lookup.LName#',SE_FName='#SE_lookup.FName#',ProjectType='#Form.ProjectType#',ProjectSummary='#Form.ProjectSummary#' WHERE RID='#FORM.RID#'
</cfquery>

<cfoutput>
<br><br>
<center>
<span class="pageheader">SBS Project Number #Form.projcode# has been updated!</span>
<br><br>
</center>
</cfoutput><!-- InstanceEndEditable -->	</td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" bgcolor="#949DA1">&nbsp;</td>
    <td width="613" bgcolor="#949DA1"><div align="center" class="copyrightnfo"><img src="../pics/copyright.gif" width="461" height="18" border="0" usemap="#Map">
        <map name="Map">
          <area shape="rect" coords="436,2,454,16" href="http://www.longitudegroup.com">
        </map>
    </div></td>
  </tr>
</table>
</body>
<!-- InstanceEnd -->