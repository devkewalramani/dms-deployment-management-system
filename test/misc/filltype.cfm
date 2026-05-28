<cfquery name="lookup" datasource="SBSEFD">
select rid,empid,SE_type
from dbo.schedule
</cfquery>

<cfoutput query="lookup">

<cfquery name="filltype" datasource="SBSEFD">
Select empid,type
from dbo.se
where empid = '#lookup.empid#'
</cfquery>

<cfquery name="update" datasource="SBSEFD">
UPDATE dbo.schedule SET SE_Type = '#filltype.type#' where empid='#filltype.empid#'
</cfquery>

</cfoutput>