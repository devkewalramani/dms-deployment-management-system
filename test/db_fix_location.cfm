<cfquery name="sched" datasource="SBSEFD">
select *
from dbo.schedule_NEW
</cfquery>

<cfoutput query="sched">

<cfquery name="update_sched" datasource="SBSEFD">
update dbo.schedule set ProjectCity ='#sched.ProjectCity#',ProjectZip ='#sched.ProjectZip#' where RID='#sched.RID#'
</cfquery>

<cfquery name="update_travel" datasource="SBSEFD">
update dbo.travel set ProjectCity ='#sched.ProjectCity#',ProjectState ='#sched.ProjectState#',ProjectZip ='#sched.ProjectZip#' where RID='#sched.RID#'
</cfquery>

</cfoutput>