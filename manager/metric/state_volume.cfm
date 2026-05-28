<!--- This report graphs the top 3 states by volume in percentage and number of jobs --->

<!--- get the total number of jobs between the selected dates  --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>
<!--- do if the count is not 0--->
<cfif #total.totaljobs# neq 0>
<!--- get the project state and the count of the project state --->
<cfquery name="statecount" datasource="SBSEFD">
SELECT ProjectState, COUNT(ProjectState) AS statecount
FROM dbo.Schedule
WHERE (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
GROUP BY ProjectState
Order by statecount DESC
</cfquery>
<!--- draw graph --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" showborder="yes" show3d="yes" labelformat="percent" chartheight="600" chartwidth="350" title="State by Volume from #form.startdate# to #form.enddate# - #total.totaljobs# Total Jobs" > 
<cfchartseries type="bar" seriesColor="olive" paintStyle="plain" datalabelstyle="value">
<!--- assign count variable--->
<cfset p_statecount=0>
<!---loop through query --->
<cfloop query="statecount" startrow="1" endrow="3">
<cfoutput>
<!--- percentage calculation--->
<cfset p_statecount=#statecount.statecount#/#total.totaljobs#>
<!--- graph data point --->
<cfchartdata item="#statecount.projectstate#" value="#p_statecount#">

</cfoutput>
</cfloop>
</cfchartseries>
</cfchart>
<!--- second graph for total jobs  --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" showborder="yes" show3d="yes" labelformat="number" chartheight="600" chartwidth="350" title="State by Volume from #form.startdate# to #form.enddate#" > 
<cfchartseries type="bar" seriescolor="blue" paintStyle="plain" datalabelstyle="value">
<!--- loop through same query--->
<cfloop query="statecount" startrow="1" endrow="3">
<cfoutput>
<!---graph data point as number --->
<cfchartdata item="#statecount.projectstate#" value="#statecount.statecount#">
</cfoutput>
</cfloop>
</cfchartseries>
</cfchart>


<cfelse>
No data on selected dates

</cfif>