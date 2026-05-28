<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='EFD' or ProjectType ='EFD/LOE') and (Status <> 'Canceled')
</cfquery>

<cfif #total.totaljobs# neq 0>

<cfquery name="statecount" datasource="SBSEFD">
SELECT ProjectState, COUNT(ProjectState) AS statecount
FROM dbo.Schedule
WHERE (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='EFD' or ProjectType ='EFD/LOE') and (Status <> 'Canceled')
GROUP BY ProjectState
Order by statecount DESC
</cfquery>

<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" format="jpg"show3d="yes" labelformat="percent" chartheight="600" chartwidth="350" title="State by Volume from #form.startdate# to #form.enddate# - #total.totaljobs# Total Jobs" > 
<cfchartseries type="bar" seriesColor="olive" paintStyle="plain" datalabelstyle="value">

<cfset p_statecount=0>

<cfloop query="statecount" startrow="1" endrow="3">
<cfoutput>

<cfset p_statecount=#statecount.statecount#/#total.totaljobs#>

<cfchartdata item="#statecount.projectstate#" value="#p_statecount#">

</cfoutput>
</cfloop>
</cfchartseries>
</cfchart>

<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" format="jpg" show3d="yes" labelformat="number" chartheight="600" chartwidth="350" title="State by Volume from #form.startdate# to #form.enddate#" > 
<cfchartseries type="bar" seriescolor="blue" paintStyle="plain" datalabelstyle="value">

<cfloop query="statecount" startrow="1" endrow="3">
<cfoutput>
<cfchartdata item="#statecount.projectstate#" value="#statecount.statecount#">
</cfoutput>
</cfloop>
</cfchartseries>
</cfchart>


<cfelse>
No data on selected dates

</cfif>