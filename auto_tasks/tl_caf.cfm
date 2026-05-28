<!---
This report will run every morning to alert management of outstanding SBS task lists
to ensure a timely submission
--->


<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfquery name="tlmiss" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status = 'Completed') AND (TL IS NULL) AND (SE_Type <> 'MLT')
ORDER BY EndDate ASC
</cfquery>

<style type="text/css">
<!--
.style4 {font-size: 12px; font-weight: bold; }
.style5 {font-size: 12px}
-->
</style>

<cfoutput>
<cfmail from = "DellManagement@SBSPlanet.com" To = "DellManagement@SBSPlanet.com" Subject = "TL OSR for #todaysdate#">
   <cfmailpart 
      type="html">

<font color="red">TL OSR for #Dateformat(todaysdate,'mm/dd/yy')#</font>

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
where (RID='#tlmiss.RID#') and (proj_complete_date <> '1/1/1990')
</cfquery>

<cfif #check.RID# eq #tlmiss.RID#>
<cfset duedate=#check.proj_complete_date# + 3>
  <cfif #duedate# lt #todaysdate#>
  <cfset overdue=#todaysdate# - #duedate#>
  <tr>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dispatchid#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#projectname#</span></div></td>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#SE_FName# #SE_LName#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dateformat(check.proj_complete_date,'mm/dd/yy')#</span></div></td>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5"><font color="red">#dateformat(duedate,'mm/dd/yyyy')#</font></span></div></td>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5"><strong>#overdue#</strong></span></div></td>
 </tr>
  </cfif>
</cfif>
</cfloop>
</table>
</cfmailpart>
</cfmail>
</cfoutput>