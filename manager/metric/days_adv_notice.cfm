<!--- Days Advance Notice for engagements  ---->

<!---get a count of the total jobs --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaljobs
from dbo.schedule
Where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>

<!--- Do if count is not equal to 0 --->
<cfif #total.totaljobs# neq 0>
<!--- set variables  --->
<cfset count_one=0>
<cfset count_two=0>
<cfset count_three=0>
<cfset count_four=0>
<cfset count_five=0>
<cfset count_six=0>
<cfset count_seven=0>
<!--- project info on projects within data range --->
<cfquery name="adv" datasource="SBSEFD">
select *
from dbo.schedule
where (Startdate between '#form.startdate#' and '#form.enddate#') and (ProjectType ='1' or ProjectType ='2') and (Status <> 'Canceled')
</cfquery>
<!--- output results and set variables depending on how many days advance notice was given  --->
<cfoutput query="adv">
<cfset Days_Advance_Notice = #StartDate# - #DateAdded#>

<cfif #Days_Advance_Notice# lte 0>
<cfset count_one=count_one+1>
</cfif>
<cfif #Days_Advance_Notice# eq 1>
<cfset count_two=count_two+1>
</cfif>
<cfif #Days_Advance_Notice# eq 2 or #Days_Advance_Notice# eq 3>
<cfset count_three=count_three+1>
</cfif>
<cfif #Days_Advance_Notice# eq 4 or #Days_Advance_Notice# eq 5>
<cfset count_four=count_four+1>
</cfif>
<cfif #Days_Advance_Notice# eq 6 or #Days_Advance_Notice# eq 7>
<cfset count_five=count_five+1>
</cfif>
<cfif #Days_Advance_Notice# gte 8>
<cfset count_six=count_six+1>
</cfif>
<cfif #Days_Advance_Notice# lte 7>
<cfset count_seven=count_seven+1>
</cfif>

</cfoutput>
<!--- calculate percentages --->
<cfset p_one=#count_one#/#total.totaljobs#>
<cfset p_two=#count_two#/#total.totaljobs#>
<cfset p_three=#count_three#/#total.totaljobs#>
<cfset p_four=#count_four#/#total.totaljobs#>
<cfset p_five=#count_five#/#total.totaljobs#>
<cfset p_six=#count_six#/#total.totaljobs#>
<cfset p_seven=#count_seven#/#total.totaljobs#>

<cfoutput>
<!--- output graph --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" show3d="yes" labelformat="percent" chartheight="400" chartwidth="600" title="Days Advance Notice from #form.startdate# to #form.enddate#" showborder="yes"> 
<cfchartseries type="bar" seriescolor="yellow" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="0" value="#p_one#">
<cfchartdata item="1" value="#p_two#">
<cfchartdata item="2-3" value="#p_three#">
<cfchartdata item="4-5" value="#p_four#">
<cfchartdata item="6-7" value="#p_five#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="green" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="8+" value="#p_six#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="red" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="Total <7 Days" value="#p_seven#">
</cfchartseries>
</cfchart>

</cfoutput>

<cfelse>
No data on selected dates
</cfif>
