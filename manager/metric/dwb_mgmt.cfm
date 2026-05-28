<!--- Report shows which projects a DWB was recieved by the Dell mgmt --->

<!--- get all jobs within the selected date range where the project type is either EFD and EFD/LOE--->
<cfquery name="dwb" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status <> 'Canceled') and (DM <> 'Null')
ORDER BY StartDate ASC
</cfquery>
<!--- define,assign and format the current days date--->
<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfheader name="Content-Disposition" value="inline; filename=report.xls">
<cfcontent type="application/msexcel">
<!--- output headers--->
<table width="700" border="1">
 <tr>
    <td bgcolor="#CCCCCC"><strong>Dispatch ID</strong></td>
    <td bgcolor="#CCCCCC"><strong>Project Name</strong></td>
	<td bgcolor="#CCCCCC"><strong>Engineer</strong></td>
    <td bgcolor="#CCCCCC"><strong>Start Date</strong></td>
    <td bgcolor="#CCCCCC"><strong>DM</strong></td>
	<td bgcolor="#CCCCCC"><strong>Project Summary</strong></td>
	<td bgcolor="#CCCCCC"><strong>DWB Recived by MGMT</strong></td>
  </tr>
<!--- output results--->
<cfoutput query="dwb">
  <tr>
    <td>#dispatchid#</td>
    <td>#projectname#</td>
	<td>#SE_FName# #SE_LName#</td>
    <td>#dateformat(StartDate,'mm/dd/yy')#</td>
	<td>#DM#</td>
	<td>#ProjectSummary#</td>
	<td>#mgmt_dwb#</td>
  </tr>
</cfoutput>
</table>


