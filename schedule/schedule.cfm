<!---
This page is accessed by 4 different Tech Leads to view the Dell Services (DS) Schedule in a spreadsheet view.
--->

<style type="text/css">
<!--
.style1 {font-size: 9px}
.style3 {font-size: 9px; font-weight: bold; }
-->
</style>

<body>
<!--- lookup all engineers that are active and that belong to the DS business unit  --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT *
FROM dbo.SE
Where (status = '1') and (BU_group='DS')
Order by Fname ASC
</cfquery>
<!--- define todays date and format it  --->
<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<!--- output headers --->
<table width="100%" bgcolor="#CCCCCC">
     <tr>
          <th bgcolor="#66CC00"><span class="style1">Dexterra ID</span></th>
          <th bgcolor="#66CC00"><span class="style1">Omni Num</span></th>
          <th bgcolor="#66CC00"><span class="style1">Project Name</span></th>
		  <th bgcolor="#66CC00"><span class="style1">Project Location</span></th>
		  <th bgcolor="#66CC00"><span class="style1">Start Date</span></th>
		  <th bgcolor="#66CC00"><span class="style1">Start Time</span></th>
		  <th bgcolor="#66CC00"><span class="style1">End Date</span></th>
		  <th bgcolor="#66CC00"><span class="style1">End Time</span></th>
		  <th bgcolor="#66CC00"><span class="style1">Engineer</span></th>
		  <th bgcolor="#66CC00"><span class="style1">Project Summary</span></th>
     </tr>	
	 <!--- output results  --->
	 <cfoutput query="SE_lookup">
	 <!--- get all jobs scheduled by the engineer from todays date and forward  --->
	  <cfquery datasource="SBSEFD" name="schedule">
	  Select *
	  From dbo.Schedule
	  Where (EmpID = '#SE_lookup.EmpID#') and (Status = 'Scheduled') and (Enddate >= '#todaysdate#')
      Order by StartDate ASC
	  </cfquery>
	  <!--- ouptut the schedule if the employee id's are equal  --->
	 <cfif  #schedule.EmpID# eq #SE_lookup.EmpID#>
	 <tr>
	 <td height="18" colspan="10" bgcolor="##FFFF66"><span class="style3">#SE_lookup.Fname# #SE_lookup.Lname#&nbsp;</span></td>
	 </tr>
	 <cfloop query="schedule">
     <tr>
          <td bgcolor="##FFFFFF"><span class="style1">#DispatchID#</span></td>
          <td bgcolor="##FFFFFF"><span class="style1">#OmniNum#</span></td>
          <td bgcolor="##FFFFFF"><span class="style1">#ProjectName#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#ProjectCity#, #ProjectState# #ProjectZip#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#DateFormat(StartDate,'m/dd/yyyy')#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#TimeFormat(StartTime,'h tt')#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#DateFormat(EndDate,'m/dd/yyyy')#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#TimeFormat(EndTime,'h tt')#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#SE_Fname# #SE_Lname#</span></td>
		  <td bgcolor="##FFFFFF"><span class="style1">#ProjectSummary#</span></td>
     </tr>
	 </cfloop>
	 </cfif>
	 </cfoutput>
</table>
</body>