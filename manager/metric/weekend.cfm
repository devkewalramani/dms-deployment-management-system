<!--- Graphs the percentage of weekend work--->

<!--- count the total of jobs from the schedule table within the selected date range --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>
<!---  do if the count is not 0--->
<cfif #total.totaljobs# neq 0>
<!--- define count variable--->
<cfset weekend_count=0>
<!--- get all projects within the date range --->
<cfquery name="adv" datasource="SBSEFD">
select *
from dbo.schedule
where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>
<!--- output query--->
<cfoutput query="adv">
<!--- running total if the start date is either a friday, saturday or sunday --->
<cfif #dateformat(startdate,'ddd')# is "Fri" OR #dateformat(startdate,'ddd')# is "Sat" OR #dateformat(startdate,'ddd')# is "Sun">
<cfset weekend_count=#weekend_count#+1>
</cfif>

</cfoutput>
<!---calculate the percentage --->
<cfset p_weekend=#weekend_count#/#total.totaljobs#>

<cfoutput>
<!--- graph data --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" show3d="yes" labelformat="percent" chartheight="400" chartwidth="200" title="Weekend Work from #form.startdate# to #form.enddate#" showborder="yes"> 
<cfchartseries type="bar"  seriescolor="##FF6600" paintstyle="plain" datalabelstyle="value">
<cfchartdata item="Weekend" value="#p_weekend#">
</cfchartseries>
</cfchart>

</cfoutput>

<cfelse>
No data on selected dates
</cfif>
