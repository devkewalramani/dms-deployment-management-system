<!--- Days advance notice for the Design Workbook from Dell --->

<!--- count how many task lists submitted have a startdate between the selected date range --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#') and (DWB_adv <> 'NA')
</cfquery>
<!--- do if count is not 0 --->
<cfif #total.totaltasks# neq 0>
<!--- 
lookup the DWB advance notice field on the all the tasklists submitted that have a startdate between the selected start date 
--->
<cfquery name="task" datasource="SBSEFD">
select DWB_adv
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#') and (DWB_adv <> 'NA')
</cfquery>
<!--- define count variables  --->
<cfset var1=0>
<cfset var2=0>
<cfset var3=0>
<cfset var4=0>
<cfset var5=0>
<cfset var6=0>
<cfset var7=0>

<!--- output query --->
<cfloop query="task">
<!--- keep a running count of all the adv notice catagories --->
<cfif #task.DWB_adv# eq 'none'>
<cfset #var1#=#var1#+1>
<cfelseif #task.DWB_adv# eq 'dayof'>
<cfset #var2#=#var2#+1>
<cfelseif #task.DWB_adv# eq '1-2'>
<cfset #var3#=#var3#+1>
<cfelseif #task.DWB_adv# eq '3-4'>
<cfset #var4#=#var4#+1>
<cfelseif #task.DWB_adv# eq '5-6'>
<cfset #var5#=#var5#+1>
<cfelseif #task.DWB_adv# eq '7-8'>
<cfset #var6#=#var6#+1>
<cfelseif #task.DWB_adv# eq '8+'>
<cfset #var7#=#var7#+1>
</cfif>

</cfloop>

<cfoutput>
<!--- calculate percentages  --->
<cfset p_var1=#var1#/#total.totaltasks#>
<cfset p_var2=#var2#/#total.totaltasks#>
<cfset p_var3=#var3#/#total.totaltasks#>
<cfset p_var4=#var4#/#total.totaltasks#>
<cfset p_var5=#var5#/#total.totaltasks#>
<cfset p_var6=#var6#/#total.totaltasks#>
<cfset p_var7=#var7#/#total.totaltasks#>

<!--- output graph --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" show3d="yes" labelformat="percent" chartheight="400" chartwidth="600" title="DWB delievery before engagement from #form.startdate# to #form.enddate#" showborder="yes"> 
<cfchartseries type="bar" seriescolor="red" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="No DWB" value="#p_var1#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="yellow" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="0 Days" value="#p_var2#">
<cfchartdata item="1-2 Days" value="#p_var3#">
<cfchartdata item="3-4 Days" value="#p_var4#">
</cfchartseries>
<cfchartseries type="bar" seriescolor="green" paintStyle="plain" datalabelstyle="value">
<cfchartdata item="5-6 Days" value="#p_var5#">
<cfchartdata item="7-8 Days" value="#p_var6#">
<cfchartdata item="8+" value="#p_var7#">
</cfchartseries>

</cfchart>


</cfoutput>

<cfelse>
No data on selected dates
</cfif>