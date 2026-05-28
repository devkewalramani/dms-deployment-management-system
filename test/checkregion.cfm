<cfquery name="check" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
where in_region <> ''
</cfquery>

<cfoutput query="check">

<cfquery name="region_lookup" datasource="SBSEFD">
Select Region
from dbo.regions
where State = '#check.ProjectState#'
</cfquery>

<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmpID, Region
FROM dbo.SE
WHERE EmpID = #check.EmpID#
</cfquery>

<cfif '#region_lookup.region#' is '#SE_lookup.region#'>
<cfset temp = 'Y'>
<cfelse>
<cfset temp = 'N'>
</cfif>


#rid# - #region_lookup.region# - #SE_lookup.region# - #check.in_region# - #temp#
<br />


</cfoutput>




