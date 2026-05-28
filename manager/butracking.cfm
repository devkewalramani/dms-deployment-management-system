<!--- Generate BU Tracking report for Enterprise Services --->

<!--- search all dell jobs that started within the selected date range --->
<cfquery datasource="SBSEFD" name="BUTracking">
Select *
From dbo.Schedule
Where (Startdate between '#URL.startdate#' and '#URL.enddate#') AND (Status <> 'Canceled') AND (ProjectType <> '1' AND ProjectType <> '2' AND ProjectType <> '3' AND ProjectType <> '53' AND ProjectType <> '45' AND ProjectType <> '58' AND ProjectType <> '59' AND ProjectType <> '60') 
Order by ProjectType ASC
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
          <th bgcolor="#009900">DO/PO</th> 
		  <th bgcolor="#009900">SO/ProjID</th> 
		  <th bgcolor="#009900">PAS/Wand</th>
          <th bgcolor="#009900">Customer</th>
		  <th bgcolor="#009900">Job Type</th> 
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
		  <th bgcolor="#FFFF00">Billable Hours</th> 
		  <th bgcolor="#FFFF00">Number of Days</th> 
		  <th bgcolor="#FFFF00">Trip</th> 
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
		  <th bgcolor="#009900">LOE Y/N</th> 
		  <th bgcolor="#009900">Phased Y/N</th> 
		  <th bgcolor="#009900">Completed/Billable Milestone Y/N</th> 
		  <th bgcolor="#FF00FF">Earned Value</th>
		  <th bgcolor="#FF00FF">Recongized Value</th>
		  <th bgcolor="#009900">LOE $</th>
		  <th bgcolor="#009900">LOE Consulting $</th>
		  <th bgcolor="#009900">LOE T and E $</th>
		  <th bgcolor="#009900">LOE Comments</th> 
		  <th bgcolor="#009900">All Travel Billable Y/N</th>
		  <th bgcolor="#009900">Billable Travel (Flat Rate)</th> 
		  <th bgcolor="#009900">Billable travel (Cap)</th> 
     </tr>
	 <!--- output report results in excel format --->
	 <cfoutput query="BUTracking">
	 <!--- get project names from the ID's --->
	<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
	Select *
	From dbo.Proj_Type
	Where Proj_Type_ID='#BUTracking.ProjectType#'
	</cfquery>
	  <!--- lookup employee info --->
	 <cfquery name="emp" datasource="SBSEFD">
	 Select *
	 from dbo.se
	 where empid = '#BUTracking.empid#'
	 </cfquery>
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
	 
	 
     <tr>
          <td>Enterprise Services</td>
		  <td>#Proj_Type_lookup.dept#</td>
		  <td>#projcode#</td>
		  <td>#ProjectName#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
          <td>#PO_Num#</td>
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
		  <td>&nbsp;</td>
		  <td>#EndDate#</td>
		  <td>#TimeFormat(EndTime,'h tt')#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#SE_Lname#, #SE_Fname#</td>
		  <td>#ProjectSummary#</td>
		  <td>#emp.type#</td>
		  <td>Enterprise Services</td>
		  <td>&nbsp;</td>
		  <td>#URL.EndDate#</td>
		  <td>#dateformat(startdate,'m')#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>#LOE_Price#</td>
		  <td>#LOE_Price#</td>
		  <td>#Tot_Loe#</td>
		  <td>#LOE_Price#</td>
		  <td>#Travel_Price#</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
	   </tr>
	 </cfoutput>
</table>
