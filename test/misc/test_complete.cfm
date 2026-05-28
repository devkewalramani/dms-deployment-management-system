<cfset todaysdate=Now()>
<cfset newdate=#todaysdate# - 7>
<cfset newdateformated=#dateformat(newdate,'mm/dd/yyyy')#>

<cfoutput>

<cfquery name="test" datasource="SBSEFD">
select *
from dbo.schedule
where (Enddate < '#newdateformated#') and (Status='Scheduled') and (DispatchId = 'NA')
</cfquery>

</cfoutput>

<cfoutput query="test">
<cfquery name="update" datasource="SBSEFD">
Update dbo.schedule set Status='Completed' where RID='#RID#'
</cfquery>
</cfoutput>

