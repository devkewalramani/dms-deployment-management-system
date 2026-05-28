<!--- Generate BU Tracking report for Dell Services --->

<!--- search all dell jobs that started within the selected date range --->
<cfquery datasource="SBSEFD" name="dellpayment">
Select *
From dbo.Schedule
Where (Startdate between '#URL.startdate#' and '#URL.enddate#') AND (ProjectType = '1' OR ProjectType = '2' OR ProjectType = '3' OR ProjectType = '53' OR ProjectType = '45')
Order by SE_Lname ASC
</cfquery>

<!--- output report headers in excel format --->
<cfheader name="Content-Disposition" value="inline; filename=report.xls">
<cfcontent type="application/msexcel">
<table border="1">
     <tr>
	 	  <th bgcolor="#FFFF00">Business Unit</th>
		  <th bgcolor="#FFFF00">Department</th>
		  <th bgcolor="#FFFF00">Project Code</th>
		  <th bgcolor="#FFFF00">SBS Project Name </th>
		  <th bgcolor="#FFFF00">Dexterra ID</th>
          <th bgcolor="#009900">Omni Num</th>
          <th bgcolor="#009900">DO/PO</th> <!---NA to DS --->
		  <th bgcolor="#009900">SO/ProjID</th> <!---NA to DS --->
		  <th bgcolor="#009900">PAS/Wand</th> <!---NA to DS --->
          <th bgcolor="#009900">Customer</th>
		  <th bgcolor="#009900">Job Type</th> <!---NA to DS --->
		  <th bgcolor="#009900">Account/Region</th>
		  <th bgcolor="#009900">City</th>
		  <th bgcolor="#009900">State</th>
		  <th bgcolor="#009900">Zip</th>
		  <th bgcolor="#009900">Start Date</th>
		  <th bgcolor="#009900">Start Time</th>
		  <th bgcolor="#009900">Actual End Date</th>
		  <th bgcolor="#009900">Scheduled End Date</th>
		  <th bgcolor="#009900">End Time</th>
		  <th bgcolor="#009900">Duration</th>
		  <th bgcolor="#FFFF00">Billable Hours</th> <!---NA to DS --->
		  <th bgcolor="#FFFF00">Number of Days</th> <!---NA to DS --->
		  <th bgcolor="#FFFF00">Trip</th> <!---NA to DS --->
		  <th bgcolor="#009900">Engineer</th>
		  <th bgcolor="#009900">Project Summary</th>
		  <th bgcolor="#009900">Engineer Type</th>
		  <th bgcolor="#009900">Eng Functional Dept</th>
		  <th bgcolor="#009900">Dell Week</th>
		  <th bgcolor="#009900">SBS Report Week</th>
		  <th bgcolor="#009900">Revenue Month</th>
		  <th bgcolor="#009900">Days Advance Notice</th>
		  <th bgcolor="#009900">Weekend</th>
		  <th bgcolor="#009900">In Region</th>
		  <th bgcolor="#009900">LOE Y/N</th> <!---NA to DS --->
		  <th bgcolor="#009900">Phased Y/N</th> <!---NA to DS --->
		  <th bgcolor="#009900">Completed/Billable Milestone Y/N</th> <!---NA to DS --->
		  <th bgcolor="#FF00FF">Earned Value</th>
		  <th bgcolor="#FF00FF">Recongized Value</th>
		  <th bgcolor="#009900">LOE $</th>
		  <th bgcolor="#009900">LOE Consulting $</th>
		  <th bgcolor="#009900">LOE T and E $</th>
		  <th bgcolor="#009900">LOE Comments</th> <!---NA to DS --->
		  <th bgcolor="#009900">All Travel Billable Y/N</th>
		  <th bgcolor="#009900">Billable Travel (Flat Rate)</th> <!---NA to DS --->
		  <th bgcolor="#009900">Billable travel (Cap)</th> <!---NA to DS --->
     </tr>
	 <!--- output report results in excel format --->
	 <cfoutput query="dellpayment">
	 <!--- get project names from the ID's --->
	<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
	Select *
	From dbo.Proj_Type
	Where Proj_Type_ID='#dellpayment.ProjectType#'
	</cfquery>
	 <!--- get the actual start and end dates entered in the task list by the engineer --->
	 <cfquery name="tasklist" datasource="SBSEFD">
	 select TL_RID, Actual_StartDate, Actual_EndDate
	 from dbo.Tasklist
	 where TL_RID = '#dellpayment.RID#'
	 </cfquery>
	 <!--- lookup employee info --->
	 <cfquery name="emp" datasource="SBSEFD">
	 Select *
	 from dbo.se
	 where empid = '#dellpayment.empid#'
	 </cfquery>
	 <!--- figure out if the job was weekend work --->
	 <cfif #dateformat(startdate,'ddd')# is "Fri">
	 <cfset weekend = 1>
	 <cfelseif #dateformat(startdate,'ddd')# is "Sat">
	 <cfset weekend = 1> 
	 <cfelseif #dateformat(startdate,'ddd')# is "Sun">
	 <cfset weekend = 1>
	 <cfelse>
	 <cfset weekend = 0>
	 </cfif>
	  <!--- calculate the how much in advane we knew about the project --->
	 <cfset Days_Advance_Notice = #StartDate# - #DateAdded#>
	 <!--- calculate if the job is within the defined dell regions --->
	 <cfif '#In_Region#' is 'Y'>
	 <cfset region = 1>
	 <cfelse>
	 <cfset region = 0>
	 </cfif>
	 <!--- calculate how long job took --->
	 <cfset duration = #EndDate# - #StartDate#>
	 <!--- define department based on project type --->
	 <cfif #ProjectType# eq 1>
	 <cfset dept='Dell EFD'>
	 <cfelse>
	 <cfset dept='Dell Transactional'>
	 </cfif>
	 <!--- calculate the loe amounts and any travel amounts --->
	 <cfset Tot_LOE=0>
	 <cfif #LOE_Price# neq '' and #Travel_Price# neq ''>
	 <cfset Tot_LOE=#LOE_Price#+#Travel_Price#>
	 <cfelseif #LOE_Price# neq '' and #Travel_Price# eq ''>
	 <cfset Tot_LOE=#LOE_Price#>
	 <cfelseif #LOE_Price# eq '' and #Travel_Price# neq ''>
	 <cfset Tot_LOE=#Travel_Price#>
	 <cfelseif #LOE_Price# eq '' and #Travel_Price# eq ''>
	 <cfset Tot_LOE=''>
	 </cfif>
	 <!--- assign dell quarter and week based on selection from daterange.cfm --->
	 <cfset dellweek='Q' & '#URL.dq#' & 'W' & '#URL.dw#'>
	 <!--- calculate sbs week based on dell week given --->
	 <cfset sbsreportweek=#URL.EndDate# + 2>
	 
     <tr>
          <td>Dell Services</td>
		  <td>#dept#</td>
		  <td>#projcode#</td>
		  <td>#ProjectName# - #DateFormat(StartDate,'m.dd.yyyy')#</td>
		  <td>#DispatchID#</td>
		  <td>#OmniNum#</td>
          <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
          <td>#ProjectName#</td>
		  <td>&nbsp;</td>
		  <td>#Proj_Type_lookup.Type#</td>
		  <td>#ProjectCity#</td>
		  <td>#ProjectState#</td>
		  <td>#ProjectZip#</td>
		  <td>#StartDate#</td>
		  <td>#TimeFormat(StartTime,'h tt')#</td>
		  <td>#tasklist.Actual_EndDate#</td>
		  <td>#EndDate#</td>
		  <td>#TimeFormat(EndTime,'h tt')#</td>
		  <td>#duration#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#SE_Lname#, #SE_Fname#</td>
		  <td>#ProjectSummary#</td>
		  <td>#emp.type#</td>
		  <td>Dell Services</td>
		  <td>#dellweek#</td>
		  <td>#DateFormat(sbsreportweek,'m/dd/yyyy')#</td>
		  <td>#dateformat(startdate,'m')#</td>
		  <td>#Days_Advance_Notice#</td>
		  <td>#weekend#</td>
		  <td>#region#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#LOE_Price#</td>
		  <td>#LOE_Price#</td>
		  <td>#Tot_Loe#</td>
		  <td>#LOE_Price#</td>
		  <td>#Travel_Price#</td>
		  <td>&nbsp;</td>
		  <td>#Bill_Travel#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
	   </tr>
	 </cfoutput>
	
	 <!--- All retained labor output --->
	
	<!--- get all retained labor info --->
	<cfquery datasource="SBSEFD" name="retained">
	Select *
	From dbo.se
	Where (status='1') and (BU_group='DS') and (Type='DLE' OR Type='DLA' OR Type='MLT' OR Type='DPS-DLE')
	order by type,lname
	</cfquery>
	<!--- output all retained labor --->
	<cfoutput query="retained">
	<!--- calculate sbs week --->
	<cfset sbsreportweek=#URL.EndDate# + 2>
	<!--- assign department based on type of engineer --->
	<cfif '#retained.type#' eq 'DPS-DLE'>
	<cfset dept2='Dell BSG'>
	<cfelse>
	<cfset dept2='Dell EFD'>
	</cfif>
	<tr>
          <td>Dell Services</td>
		  <td>#dept2#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
          <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
          <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#retained.Lname#, #retained.Fname#</td>
		  <td>&nbsp;</td>
		  <td>#retained.type#</td>
		  <td>Dell Services</td>
		  <td>#dellweek#</td>
		  <td>#DateFormat(sbsreportweek,'m/dd/yyyy')#</td>
		  <td>#dateformat(URL.startdate,'m')#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#retained.rate#</td>
		  <td>#retained.rate#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
	  </tr>
	 </cfoutput>
</table>
