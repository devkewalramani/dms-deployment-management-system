<!---
This report will run every morning to alert management of outstanding Dell End of engagement forms
to ensure a timely delievery of the document
--->

<style type="text/css">
<!--
.style4 {font-size: 12px; font-weight: bold; }
.style5 {font-size: 12px}
-->
</style>

<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>

<cfquery name="osr" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (EndDate Between '02/17/2007' and '#todaysdate#') and (ProjectType = '1' OR ProjectType = '2') AND (DispatchID <> 'NA') AND (Status = 'Completed')
ORDER BY EndDate ASC
</cfquery>
	  
<cfoutput>

<cfmail from = "DellManagement@SBSPlanet.com" To = "DellManagement@SBSPlanet.com" Subject = "EOE OSR for #todaysdate#">
   <cfmailpart 
      type="html">
<font color="red">EOE OSR for #Dateformat(todaysdate,'mm/dd/yyyy')#</font>

<table width="700" bgcolor="##000000">
 <tr>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Dispatch ID</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Name</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Engineer</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Completed</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">EOE DUE</span></div></td>
  </tr>
  
<cfloop query="osr">

<cfquery name="check" datasource="SBSEFD">
select *
from dbo.document_tracking
where (RID = '#osr.RID#') and (eoe_complete_date is null) and (proj_complete_date <> '1/1/1990')
</cfquery>
<cfif #check.RID# eq #osr.RID#>
<cfset duedate=#check.proj_complete_date# + 2>
 <tr>
    <td bgcolor="##FFFFFF"><span class="style5">#dispatchid#</span></td>
    <td bgcolor="##FFFFFF"><span class="style5">#projectname#</span></td>
	<td bgcolor="##FFFFFF"><span class="style5">#SE_FName# #SE_LName#</span></td>
    <td bgcolor="##FFFFFF"><span class="style5">#dateformat(check.proj_complete_date,'mm/dd/yyyy')#</span></td>
	<cfif #duedate# lte #todaysdate#>
	<td bgcolor="##FFFFFF"><span class="style5"><strong><font color="red">#dateformat(duedate,'mm/dd/yyyy')#</font></strong></span></td>
	</cfif>
	<cfif #duedate# gt #todaysdate#>
	<td bgcolor="##FFFFFF"><span class="style5">#dateformat(duedate,'mm/dd/yyyy')#</span></td>
	</cfif>
 </tr>  
 </cfif>
</cfloop>

</table>

</cfmailpart>
</cfmail>

</cfoutput>



