<cfquery name="lookup" datasource="SBSEFD">
Select *
from dbo.schedule
</cfquery>

<cfoutput query="lookup">

<cfquery name="update" datasource="SBSEFD">
update dbo.Travel set ProjectType='#lookup.ProjectType#' Where RID='#RID#'
</cfquery>


</cfoutput>