<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='EFD' or ProjectType ='EFD/LOE') and (Status <> 'Canceled')
</cfquery>

<cfif #total.totaljobs# neq 0>


<cfset weekend_count=0>

<cfquery name="adv" datasource="SBSEFD">
select *
from dbo.schedule
where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='EFD' or ProjectType ='EFD/LOE') and (Status <> 'Canceled')
</cfquery>

<cfoutput query="adv">

<cfif #dateformat(startdate,'ddd')# is "Fri" OR #dateformat(startdate,'ddd')# is "Sat" OR #dateformat(startdate,'ddd')# is "Sun">
<cfset weekend_count=#weekend_count#+1>
</cfif>

</cfoutput>

<cfset p_weekend=#weekend_count#/#total.totaljobs#>

<cfoutput>

<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" show3d="yes" labelformat="percent" chartheight="400" chartwidth="200" title="Weekend Work from #form.startdate# to #form.enddate#" format="jpg"> 
<cfchartseries type="bar"  seriescolor="##FF6600" paintstyle="plain" datalabelstyle="value">
<cfchartdata item="Weekend" value="#p_weekend#">
</cfchartseries>
</cfchart>

</cfoutput>

<cfelse>
No data on selected dates
</cfif>
