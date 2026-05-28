<!---
Generate a report of all cancelations on a given date range
--->

<cfquery datasource="SBSEFD" name="util">
Select *
From dbo.Schedule
Where Startdate between '#form.startdate#' and '#form.enddate#' and Status = 'Canceled'
Order by SE_Fname ASC
</cfquery>


<cfheader name="Content-Disposition" value="inline; filename=utilreport.xls">
<cfcontent type="application/msexcel">
<table border="1">
     <tr>
          <th>Dexterra ID</th>
          <th>Omni Num</th>
          <th>Project Name</th>
		  <th>Project Location</th>
		  <th>Start Date</th>
		  <th>Start Time</th>
		  <th>End Date</th>
		  <th>End Time</th>
		  <th>Engineer</th>
		  <th>Status</th>
		  <th>Cancel Date</th>
		  <th>Reason</th>
		  <th>Notes</th>
     </tr>	
	 <cfoutput query="util"> 
     <tr>
          <td>#DispatchID#</td>
          <td>#OmniNum#</td>
          <td>#ProjectName#</td>
		  <td>#ProjectCity#, #ProjectState# #ProjectZip#</td>
		  <td>#DateFormat(StartDate,'ddd m/dd/yyyy')#</td>
		  <td>#TimeFormat(StartTime,'h tt')#</td>
		  <td>#DateFormat(EndDate,'ddd m/dd/yyyy')#</td>
		  <td>#TimeFormat(EndTime,'h tt')#</td>
		  <td>#SE_Fname# #SE_Lname#</td>
		  <td>#Status#</td>
		  <td>#DateFormat(CancelDate, 'ddd m/dd/yyyy')#</td>
		  <td>#cancelreason#</td>
		  <td>#cancelnotes#</td>
     </tr>
	 </cfoutput>
</table>
