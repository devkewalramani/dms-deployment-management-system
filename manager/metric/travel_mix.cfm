<!--- this report graphs regional travel and total travel by method --->

<!--- get count of total jobs that has a start date between the selected date range --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>
<!--- do if count not equal to 0 --->
<cfif #total.totaljobs# neq 0>
<!--- get the record id and project state from the schedule table --->
<cfquery name="sch_check" datasource="SBSEFD">
select Rid,ProjectState
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>

<!--- count the total of jobs in region (in_region field=y) --->
<cfquery name="total_in" datasource="SBSEFD">
select count(*) as total_inregion
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (In_Region='Y') and (Status <> 'Canceled')
</cfquery>
<!--- count the total of jobs out of region (in_region field=n) --->
<cfquery name="total_out" datasource="SBSEFD">
select count(*) as total_outregion
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (In_Region='N') and (Status <> 'Canceled')
</cfquery>
<!--- count total of internation jobs(projectstate field = international)--->
<cfquery name="total_international" datasource="SBSEFD">
select count(*) as total_inter
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (ProjectState='International') and (Status <> 'Canceled')
</cfquery>

<!--- define count variables --->
<cfset drive=0>
<cfset fly=0>
<cfset misc=0>
<cfset ne=0>
<cfset ma=0>
<cfset mw=0>
<cfset sw=0>
<cfset se=0>
<cfset w=0>
<!--- loop through query--->
<cfloop query="sch_check">
<!--- get the Flight field for all projects from the travel table for the selected date range --->
<cfquery name="travel_data" datasource="SBSEFD">
Select Flight
From dbo.travel
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (Rid='#sch_check.rid#') and (TR_Status <> 'Canceled')
</cfquery>
<!--- running total of flights and non flights --->
<cfif #travel_data.flight# eq 'Y'>
<cfset #fly#=#fly#+1>
<cfelseif #travel_data.flight# eq 'N'>
<cfset #drive#=#drive#+1>
<cfelse>
<cfset #misc#=#misc#+1>
</cfif>
<!--- get the regions from the region table--->
<cfquery name="region_check" datasource="SBSEFD">
Select Region
from dbo.Regions
Where State='#sch_check.ProjectState#'
</cfquery>
<!--- running total of the regions--->
<cfif #region_check.region# eq 'NE'>
<cfset #ne#=#ne#+1>
<cfelseif #region_check.region# eq 'MA'>
<cfset #ma#=#ma#+1>
<cfelseif #region_check.region# eq 'MW'>
<cfset #mw#=#mw#+1>
<cfelseif #region_check.region# eq 'SW'>
<cfset #sw#=#sw#+1>
<cfelseif #region_check.region# eq 'SE'>
<cfset #se#=#se#+1>
<cfelseif #region_check.region# eq 'W'>
<cfset #w#=#w#+1>
</cfif>

</cfloop>

<cfoutput>
<!--- calculate percentages--->
<cfset in_region=#total_in.total_inregion#/#total.totaljobs#>
<cfset out_region=#total_out.total_outregion#/#total.totaljobs#>
<cfset international=#total_international.total_inter#/#total.totaljobs#>
<cfset p_drive=(#drive#+#misc#)/#total.totaljobs#>
<cfset p_fly=#fly#/#total.totaljobs#>
<cfset p_ne=#ne#/#total.totaljobs#>
<cfset p_ma=#ma#/#total.totaljobs#>
<cfset p_mw=#mw#/#total.totaljobs#>
<cfset p_sw=#sw#/#total.totaljobs#>
<cfset p_se=#se#/#total.totaljobs#>
<cfset p_w=#w#/#total.totaljobs#>
<!--- graph data --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" show3d="yes" labelformat="percent" chartheight="400" chartwidth="600" title="SBS Travel Mix from #form.startdate# to #form.enddate#" showborder="yes"> 
<cfchartseries type="bar" seriescolor="green" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="In Region" value="#in_region#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="yellow" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="Out of Region" value="#out_region#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="##99CCFF" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="Foreign" value="#international#">
<cfchartdata item="North East" value="#p_ne#">
<cfchartdata item="Mid Atlantic" value="#p_ma#">
<cfchartdata item="Mid West" value="#p_mw#">
<cfchartdata item="South West" value="#p_sw#">
<cfchartdata item="South East" value="#p_se#">
<cfchartdata item="West" value="#p_w#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="yellow" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="Fly" value="#p_fly#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="green" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="Drive" value="#p_drive#">
</cfchartseries>

</cfchart>

</cfoutput>

<cfelse>
No data on selected dates
</cfif>