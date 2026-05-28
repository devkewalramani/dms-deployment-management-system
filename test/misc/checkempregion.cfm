<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmpID,State,Region
FROM dbo.SE
</cfquery>

<cfoutput query="SE_Lookup">

<cfquery name="region_lookup" datasource="SBSEFD">
Select State,Region
from dbo.regions
where State = '#SE_lookup.State#'
</cfquery>


<cfif '#SE_lookup.region#' is '#region_lookup.region#' >
<cfset temp = 'Y'>
<cfelse>
<cfset temp = 'N'>
#empid# - #region_lookup.region# - #SE_lookup.region# - #temp#
</cfif>



<br />

</cfoutput>




