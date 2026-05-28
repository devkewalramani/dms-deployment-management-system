<!---
This report will run every morning to inform the projects dept of all
travel requests sent the previous day to ensure the projects are created
in Tenrox (Time and Expense system)
--->

<cfset todaysdate=Now()>
<cfset yesterdate1=#todaysdate# - 1>
<cfset yesterdate=#dateformat(yesterdate1,'mm/dd/yyyy')#>

<cfquery name="travel" datasource="SBSEFD">
SELECT *
FROM dbo.Travel
WHERE TRdate='#yesterdate#' and (TR_Status ='Submitted')
Order by ProjectType ASC
</cfquery>

<style type="text/css">
<!--
.style4 {font-size: 12px; font-weight: bold; }
.style5 {font-size: 12px}
-->
</style>

<cfoutput>
<cfmail from = "Scheduling@SBSPlanet.com" To = "Projects@SBSPlanet.com" Subject = "TR's Sent on #yesterdate#">
   <cfmailpart 
      type="html">
	  
<table width="100%" bgcolor="##000000">
 <tr>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Type</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">SBS Project code</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Project Name</span></div></td>
	<td bgcolor="##CCCCCC"><div align="center"><span class="style4">Engineer</span></div></td>
    <td bgcolor="##CCCCCC"><div align="center"><span class="style4">Start Date</span></div></td>
  </tr>
<cfloop query="travel">
<cfquery name="schedule" datasource="SBSEFD">
SELECT *
FROM dbo.schedule
WHERE RID='#RID#'
</cfquery>
<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
Select *
From dbo.Proj_Type
Where Proj_Type_ID='#travel.ProjectType#'
</cfquery>
 <tr>
 	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#Proj_Type_lookup.type#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#schedule.projcode#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#projectname#</span></div></td>
	<td bgcolor="##FFFFFF"><div align="center"><span class="style5">#SE_FName# #SE_LName#</span></div></td>
    <td bgcolor="##FFFFFF"><div align="center"><span class="style5">#dateformat(startdate,'mm/dd/yy')#</span></div></td>
  </tr>  
</cfloop>
</table>
</cfmailpart>
</cfmail>
</cfoutput>


