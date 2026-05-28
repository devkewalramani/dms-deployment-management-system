<cfquery name="fixdays" datasource="SBSEFD">
select *
from dbo.tasklist
</cfquery>

<cfoutput query="fixdays">

<cfquery name="getdate" datasource="SBSEFD">
select RID,StartDate,DateAdded
from dbo.schedule
where Rid='#fixdays.TL_Rid#'
</cfquery>

<cfset Days_Advance_Notice = #getdate.StartDate# - #getdate.DateAdded#>

<cfquery name="update" datasource="SBSEFD">
Update dbo.tasklist set Days_adv='#Days_Advance_Notice#' where TL_RID='#fixdays.TL_Rid#'
</cfquery>


</cfoutput>