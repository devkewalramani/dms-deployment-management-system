<!---
This report will run every morning to alert engineers of outstanding SBS task lists
to ensure a timely submission
--->

<cfquery name="eng" datasource="sbsefd">
select *
from dbo.se
where (type='DLE') or (type='matrix') or (type='DPS-DLE')
</cfquery>

<cfoutput query="eng">

<cfquery name="tlmiss_count" datasource="SBSEFD">
SELECT Count(*) as job_ctr
FROM dbo.Schedule
WHERE (empid='#eng.empid#') and (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status = 'Completed') AND (TL IS NULL)
</cfquery>

<cfquery name="tlmiss" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (empid='#eng.empid#') and (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status = 'Completed') AND (TL IS NULL)
ORDER BY EndDate ASC
</cfquery>

<style type="text/css">
<!--
.style4 {font-size: 12px; font-weight: bold; }
.style5 {font-size: 12px}
-->
</style>

<cfif #tlmiss_count.job_ctr# neq 0>

<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfmail from = "DellManagement@SBSPlanet.com" To = "dkewalramani@sbsplanet.com"  Subject = "Outstanding TaskList Reminder for #eng.fname# #eng.lname#">
<cfmailpart type="html">

<font color="red">TL OSR for #eng.fname# #eng.lname# - #Dateformat(todaysdate,'mm/dd/yy')#</font>

<table width="100%" bgcolor="##000000">
 <tr>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Dispatch ID</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Name</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Engineer</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Completed</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Due Date</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Days Over Due</span></div></td>
  </tr>
	<cfloop query="tlmiss">

	<cfquery name="check" datasource="SBSEFD">
	select *
	from dbo.document_tracking
	where (RID='#tlmiss.RID#') and (proj_complete_date <> '1/1/1990' OR proj_complete_date <> null)
	</cfquery>
	
   
	<cfset duedate=#check.proj_complete_date# + 3>
	
    <cfif #duedate# lt #todaysdate#>
  	<cfset overdue=#todaysdate# - #duedate#>
	</cfif>
  	<tr>
    	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dispatchid#</span></div></td>
    	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#projectname#</span></div></td>
		<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#SE_FName# #SE_LName#</span></div></td>
    	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dateformat(check.proj_complete_date,'mm/dd/yy')#</span></div>
		</td>
		<td bgcolor="##FFFFFF"><div align="center"><span class="style5"><font color="red">#dateformat(duedate,'mm/dd/yyyy')#</font></span></div>
		</td>
		<td bgcolor="##FFFFFF"><div align="center"><span class="style5"><strong>#overdue#</strong></span></div></td>
	</tr>
	</cfloop>
</table>
</cfmailpart>
</cfmail>
</cfif>
</cfoutput>