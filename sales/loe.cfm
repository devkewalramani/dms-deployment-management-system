<!---
Page generates a excel format report with all custom work perfomed within dell services based on date selection
--->

<!--- get all custom (loe) jobs based date range from index page  --->
<cfquery datasource="SBSEFD" name="loe">
Select *
From dbo.Schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType = '2' or ProjectType = '3') and (Status <> 'Canceled')
Order by ProjectName ASC
</cfquery>
<!--- output in xls format  --->
<cfheader name="Content-Disposition" value="inline; filename=utilreport.xls">
<cfcontent type="application/msexcel">
<table border="1">
     <tr>
	 	  <th>Dispatch ID</th>
          <th>Omni Num</th>
          <th>Project Name</th>
		  <th>Start Date</th>
		  <th>Account</th>
		  <th>Engineer</th>
		  <th>Project Summary</th>
		  <th>Amount</th>
		  <th>Travel</th>
     </tr>	
	 <cfoutput query="loe"> 
	 <!--- lookup project type to convert from ID's to actual names  --->
	 <cfquery name="Proj_Type_lookup" datasource="SBSEFD">
	 Select *
	 From dbo.Proj_Type
	 Where Proj_Type_ID='#loe.ProjectType#'
	 </cfquery>
     <tr>
	 	  <td>#DispatchID#</td>
          <td>#OmniNum#</td>
          <td>#ProjectName#</td>
		  <td>#DateFormat(StartDate,'mm/dd/yyyy')#</td>
		  <td>#Proj_Type_lookup.Type#</td>
		  <td>#SE_Fname# #SE_Lname#</td>
		  <td>#ProjectSummary#</td>
		  <td>#LOE_Price#</td>
		  <td>#Travel_Price#</td>
     </tr>
	 </cfoutput>
</table>
