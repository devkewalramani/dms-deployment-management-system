<!--- This report graphs the percentage that each operating system over a date range --->

<!--- select all the OS's from the os table --->
<cfquery name="tasks" datasource="SBSEFD">
select *
from dbo.OS
</cfquery>
<!---get count of all task lists submitted that have a start date between the selected dates --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!---do if count is not 0 --->
<cfif #total.totaltasks# neq 0>
<!--- draw main graph --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" showborder="yes" show3d="yes" labelformat="percent" chartheight="500" chartwidth="700" title="OS Mix Report from #form.startdate# to #form.enddate#" > 
<cfchartseries type="bar" seriesColor="olive" paintStyle="plain" datalabelstyle="value" >
<!--- output results--->
<cfoutput query="tasks">
<!--- get the total count of the first OS field in the task list--->
<cfquery name="numoftasks" datasource="SBSEFD">
select count(OS_one) as count1
from dbo.tasklist
where (OS_one = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- get the total count of the 2nd OS field in the task list--->
<cfquery name="numoftasks2" datasource="SBSEFD">
select count(OS_two) as count2
from dbo.tasklist
where (OS_two = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!---get the total count of the 3rd OS field in the task list --->
<cfquery name="numoftasks3" datasource="SBSEFD">
select count(OS_three) as count3
from dbo.tasklist
where (OS_three = '#tasks.projecttask#') and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!---calculate totals and percentage --->
<cfset sum=(#numoftasks.count1#+#numoftasks2.count2#+#numoftasks3.count3#)>
<cfset p=(#sum#/#total.totaltasks#)>
<!--- graph data points --->
<cfchartdata item="#tasks.projecttask#" value="#p#">

</cfoutput>
</cfchartseries>
</cfchart>

<cfelse>
No data on selected dates

</cfif>