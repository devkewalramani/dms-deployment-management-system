<!---
This report will run every morning to alert management of outstanding Dell Customer Acceptance Forms
to ensure a timely delievery of the document
--->

<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfquery name="osr" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (EndDate Between '2/17/2007' and '#todaysdate#') and (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status <> 'Canceled')
ORDER BY EndDate ASC
</cfquery>
<style type="text/css">
<!--
.style4 {font-size: 12px; font-weight: bold; }
.style5 {font-size: 12px}
-->
</style>

<cfoutput>
<cfmail from = "DellManagement@SBSPlanet.com" To = "DellManagement@sbsplanet.com" Subject = "CAF OSR for #todaysdate#">
   <cfmailpart 
      type="html">
	  
<font color="red">CAF OSR for #Dateformat(todaysdate,'mm/dd/yy')#</font>

<table width="100%" bgcolor="##000000">
 <tr>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Dispatch ID</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Name</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Engineer</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Scheduled End Date</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">CAF DUE</span></div></td>
  </tr>
<cfloop query="osr">

<cfquery name="check" datasource="SBSEFD">
select *
from dbo.document_tracking
where (RID = '#osr.RID#')
</cfquery>

<cfif '#check.RID#' neq '#osr.RID#'>
<cfset duedate=#enddate# + 1>
 <tr>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dispatchid#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#projectname#</span></div></td>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#SE_FName# #SE_LName#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dateformat(enddate,'mm/dd/yy')#</span></div></td>
	<cfif #duedate# lte #todaysdate#>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5"><strong><font color="red">#dateformat(duedate,'mm/dd/yyyy')#</font></strong></span></div></td>
	<cfelseif #duedate# gt #todaysdate#>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dateformat(duedate,'mm/dd/yyyy')#</span></div></td>
	</cfif>
  </tr>  
</cfif>

</cfloop>
</table>
</cfmailpart>
</cfmail>

</cfoutput>


