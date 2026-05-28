<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfif #total.totaltasks# neq 0>

<cfquery name="dm_count" datasource="SBSEFD">
Select count(*) as dm_ctr
from dbo.DM
</cfquery>

<cfquery name="dm_name" datasource="SBSEFD">
Select FName, LName
from dbo.DM
</cfquery>

<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" showborder="yes" show3d="yes" chartwidth="1000"  title="from #form.startdate# to #form.enddate#"> 
<cfchartseries type="bar" seriescolor="green" paintStyle="plain" datalabelstyle="value" >


<cfoutput query="dm_name">

<cfset var1=0>
<cfset var2=0>
<cfset var3=0>
<cfset var4=0>
<cfset var5=0>
<cfset var6=0>
<cfset var7=0>

<cfset dm_nme='#LName#'&", "&'#FName#'>

<cfquery name="task" datasource="SBSEFD">
select DWB_adv, DM
from dbo.tasklist
Where DM='#dm_nme#' and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfloop query="task">

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

<cfchartdata value="#var1#">
<cfchartdata value="#var2#">
<cfchartdata value="#var3#">
<cfchartdata value="#var4#">
<cfchartdata value="#var5#">
<cfchartdata value="#var6#">
<cfchartdata value="#var7#">


</cfoutput>
</cfchartseries>
</cfchart>

<cfelse>
No data on selected dates
</cfif>
