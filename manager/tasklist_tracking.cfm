<!---
This report is for management to check on outstanding SBS task lists
to ensure a timely submission
--->

<cfquery name="tlmiss" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status = 'Completed') AND (TL IS NULL) AND (SE_Type <> 'MLT')
ORDER BY EndDate ASC
</cfquery>

<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfheader name="Content-Disposition" value="inline; filename=report.xls">
<cfcontent type="application/msexcel">



<table width="700" border="1">
<tr>
<td colspan="6"> <cfoutput><font color="red">TL OSR for #Dateformat(todaysdate,'mm/dd/yy')#</font></cfoutput></td>
</tr>
 <tr>
    <td bgcolor="#CCCCCC"><strong>Dispatch ID</strong></td>
    <td bgcolor="#CCCCCC"><strong>Project Name</strong></td>
	<td bgcolor="#CCCCCC"><strong>Engineer</strong></td>
    <td bgcolor="#CCCCCC"><strong>Project Completed</strong></td>
    <td bgcolor="#CCCCCC"><strong>Due Date</strong></td>
	<td bgcolor="#CCCCCC"><strong>Days Over Due</strong></td>
  </tr>
<cfoutput query="tlmiss">

<cfquery name="check" datasource="SBSEFD">
select *
from dbo.document_tracking
where (RID='#tlmiss.RID#') and (proj_complete_date <> '1/1/1990')
</cfquery>

<cfif #check.RID# eq #tlmiss.RID#>
<cfset duedate=#check.proj_complete_date# + 3>
  <cfif #duedate# lt #todaysdate#>
  <cfset overdue=#todaysdate# - #duedate#>
  <tr>
    <td>#dispatchid#</td>
    <td>#projectname#</td>
	<td>#SE_FName# #SE_LName#</td>
    <td>#dateformat(check.proj_complete_date,'mm/dd/yy')#</td>
	<td bgcolor="##FFFFFF"><font color="red">#dateformat(duedate,'mm/dd/yyyy')#</font></td>
	<td><strong>#overdue#</strong></td>
   </cfif>
  </tr>
</cfif>
</cfoutput>
</table>


