<!---
This is a Dell specfic report to show engineer utilization for all EFD and MLT jobs.
--->

<!--- EFD Util queries--->
<cfquery datasource="SBSEFD" name="util">
Select *
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type='DLE' or SE_Type='Non DLE')
Order by SE_lname ASC
</cfquery>

<cfquery datasource="SBSEFD" name="util_count">
Select count(*) as count
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type='DLE' or SE_Type='Non DLE')
</cfquery>

<cfquery datasource="SBSEFD" name="distinct_count">
Select count(DISTINCT DispatchID) as count1
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type='DLE' or SE_Type='Non DLE')
</cfquery>

<cfquery datasource="SBSEFD" name="dellsku_count">
Select count(*) as count2
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (dell_sku='Yes') and (SE_Type='DLE' or SE_Type='Non DLE')
</cfquery>
<!--- End EFD --->

<!--- MLT Util queries --->
<cfquery datasource="SBSEFD" name="mlt_util">
Select *
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type = 'MLT')
Order by SE_Lname ASC
</cfquery>

<cfquery datasource="SBSEFD" name="mlt_util_count">
Select count(*) as count
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type = 'MLT')
</cfquery>

<cfquery datasource="SBSEFD" name="mlt_distinct_count">
Select count(DISTINCT DispatchID) as count1
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (SE_Type = 'MLT')
</cfquery>

<cfquery datasource="SBSEFD" name="mlt_dellsku_count">
Select count(*) as count2
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Status <> 'Canceled') and (ProjectType ='1' or ProjectType ='2') and (dell_sku='Yes') and (SE_Type = 'MLT')
</cfquery>
<!--- End MLT --->

<!--- Output all results in excel format --->
<cfheader name="Content-Disposition" value="inline; filename=utilreport.xls">
<cfcontent type="application/msexcel">

<style type="text/css">
<!--
.style1 {font-size: 9px}
.style3 {font-size: 9px; font-weight: bold; }
-->
</style>

<table width="1174" border="1">
<tr>
  <td colspan="11"><center>
    <span class="style3">DLE and Non DLE Utilization</span>
  </center></td>
</tr>
<tr>
	 <td colspan="2" bgcolor="#FFFF00"><span class="style3">Dell Week <cfoutput>#dateformat(form.startdate,'mm/dd')#</cfoutput></span></td>
	 <td colspan="9"></td>
  </tr>
     <tr>
          <th width="82" bgcolor="#66CC00"><span class="style1">Dexterra ID</span></th>
          <th width="74" bgcolor="#66CC00"><span class="style1">Omni Num</span></th>
          <th width="206" bgcolor="#66CC00"><span class="style1">Project Name</span></th>
		  <th width="187" bgcolor="#66CC00"><span class="style1">Project Location</span></th>
		  <th width="54" bgcolor="#66CC00"><span class="style1">Start Date</span></th>
		  <th width="64" bgcolor="#66CC00"><span class="style1">Start Time</span></th>
		  <th width="80" bgcolor="#66CC00"><span class="style1">End Date</span></th>
		  <th width="73" bgcolor="#66CC00"><span class="style1">End Time</span></th>
		  <th width="177" bgcolor="#66CC00"><span class="style1">Engineer</span></th>
		  <th width="177" bgcolor="#66CC00"><span class="style1">Custom W/SAN</span></th>
		  <th width="113" bgcolor="#66CC00"><span class="style1">Account</span></th>
     </tr>	
	 <cfoutput query="util"> 
	 <cfquery name="proj_type_lookup" datasource="SBSEFD">
	 Select *
	 From dbo.Proj_Type
	 Where Proj_Type_ID='#util.ProjectType#'
	 </cfquery>
     <tr>
          <td><span class="style1">#DispatchID#</span></td>
          <td><span class="style1">#OmniNum#</span></td>
          <td><span class="style1">#ProjectName#</span></td>
		  <td><span class="style1">#ProjectCity#, #ProjectState# #ProjectZip#</span></td>
		  <td><span class="style1">#StartDate#</span></td>
		  <td><span class="style1">#TimeFormat(StartTime,'h tt')#</span></td>
		  <td><span class="style1">#EndDate#</span></td>
		  <td><span class="style1">#TimeFormat(EndTime,'h tt')#</span></td>
		  <td><span class="style1">#SE_Lname#, #SE_Fname#</span></td>
		  <td><span class="style1">#dell_sku#</span></td>
		  <td><span class="style1">#proj_type_lookup.Type#</span></td>
     </tr>
	 </cfoutput>
	 <tr>
	 <td bgcolor="#FFFF00"><span class="style3"><cfoutput>#distinct_count.count1#</cfoutput></span></td>
	 <td></td>
	 <td bgcolor="#FFFF00"><div align="center" class="style3"><cfoutput>#util_count.count#</cfoutput></div></td>
	 <td colspan="6"></td>
	 <td bgcolor="#FFFF00"><div align="center" class="style3"><cfoutput>#dellsku_count.count2#</cfoutput></div></td>
	 <td></td>
	 </tr>
</table>
<br />
<br />
<table width="1174" border="1">
<tr>
  <td colspan="13"><center>
    <span class="style3">MLT Utilization</span>
  </center></td>
</tr>
<tr>
	 <td colspan="2" bgcolor="#FFFF00"><span class="style3">Dell Week <cfoutput>#dateformat(form.startdate,'mm/dd')#</cfoutput></span></td>
	 <td colspan="11"></td>
  </tr>
     <tr>
          <th width="82" bgcolor="#66CC00"><span class="style1">Dexterra ID</span></th>
          <th width="74" bgcolor="#66CC00"><span class="style1">Omni Num</span></th>
          <th width="206" bgcolor="#66CC00"><span class="style1">Project Name</span></th>
		  <th width="187" bgcolor="#66CC00"><span class="style1">Project Location</span></th>
		  <th width="54" bgcolor="#66CC00"><span class="style1">Start Date</span></th>
		  <th width="64" bgcolor="#66CC00"><span class="style1">Start Time</span></th>
		  <th width="80" bgcolor="#66CC00"><span class="style1">End Date</span></th>
		  <th width="73" bgcolor="#66CC00"><span class="style1">End Time</span></th>
		  <th width="177" bgcolor="#66CC00"><span class="style1">Engineer</span></th>
		  <th width="177" bgcolor="#66CC00"><span class="style1">Custom W/SAN</span></th>
		  <th width="113" bgcolor="#66CC00"><span class="style1">Account</span></th>
          <th width="113" bgcolor="#66CC00" class="style1">Week Days onsite </th>
          <th width="113" bgcolor="#66CC00" class="style1">AWS Days onsite </th>
     </tr>	
	 <cfoutput query="mlt_util"> 
	 <cfquery name="proj_type_lookup" datasource="SBSEFD">
	 Select *
	 From dbo.Proj_Type
	 Where Proj_Type_ID='#mlt_util.ProjectType#'
	 </cfquery>
     <tr>
          <td><span class="style1">#DispatchID#</span></td>
          <td><span class="style1">#OmniNum#</span></td>
          <td><span class="style1">#ProjectName#</span></td>
		  <td><span class="style1">#ProjectCity#, #ProjectState# #ProjectZip#</span></td>
		  <td><span class="style1">#StartDate#</span></td>
		  <td><span class="style1">#TimeFormat(StartTime,'h tt')#</span></td>
		  <td><span class="style1">#EndDate#</span></td>
		  <td><span class="style1">#TimeFormat(EndTime,'h tt')#</span></td>
		  <td><span class="style1">#SE_Lname#,#SE_Fname#</span></td>
		  <td><span class="style1">#dell_sku#</span></td>
		  <td><span class="style1">#proj_type_lookup.Type#</span></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
     </tr>
	 </cfoutput>
	 <tr>
	 <td bgcolor="#FFFF00"><span class="style3"><cfoutput>#mlt_distinct_count.count1#</cfoutput></span></td>
	 <td></td>
	 <td bgcolor="#FFFF00"><div align="center" class="style3"><cfoutput>#mlt_util_count.count#</cfoutput></div></td>
	 <td colspan="6"></td>
	 <td bgcolor="#FFFF00"><div align="center" class="style3"><cfoutput>#mlt_dellsku_count.count2#</cfoutput></div></td>
	 <td></td>
	 <td bgcolor="#FFFF00"></td>
	 <td bgcolor="#FFFF00"></td>
	 </tr>
</table>

