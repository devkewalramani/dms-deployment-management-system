<cfquery name="tasks" datasource="SBSEFD">
select *
from dbo.OS
</cfquery>

<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfif #total.totaltasks# neq 0>

<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" format="jpg" show3d="yes" labelformat="percent" chartheight="500" chartwidth="700" title="OS Mix Report from #form.startdate# to #form.enddate#" > 
<cfchartseries type="bar" seriesColor="olive" paintStyle="plain" datalabelstyle="value" >

<cfoutput query="tasks">

<cfquery name="numoftasks" datasource="SBSEFD">
select count(OS_one) as count1
from dbo.tasklist
where (OS_one = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfquery name="numoftasks2" datasource="SBSEFD">
select count(OS_two) as count2
from dbo.tasklist
where (OS_two = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfquery name="numoftasks3" datasource="SBSEFD">
select count(OS_three) as count3
from dbo.tasklist
where (OS_three = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>

<cfset sum=(#numoftasks.count1#+#numoftasks2.count2#+#numoftasks3.count3#)>
<cfset p=(#sum#/#total.totaltasks#)>

<cfchartdata item="#tasks.projecttask#" value="#p#">

</cfoutput>
</cfchartseries>
</cfchart>

<cfelse>
No data on selected dates

</cfif>