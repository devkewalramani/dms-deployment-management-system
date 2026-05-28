<!--- graph shows percentage of delays by delay catagory --->

<!--- get a count of total tasklists that had jobs that started between the selected date range --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- do if count is not 0 --->
<cfif #total.totaltasks# neq 0>
<!--- get the record id of the tasklists that had jobs that started between the selected date range --->
<cfquery name="tasks" datasource="SBSEFD">
select TL_Rid
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- assgin count variables --->
<cfset var1=0>
<cfset var2=0>
<cfset var3=0>
<cfset var4=0>
<cfset var5=0>
<cfset var6=0>
<cfset var7=0>
<cfset var8=0>
<cfset var9=0>
<cfset var10=0>
<cfset var11=0>
<cfset var12=0>
<cfset var13=0>
<cfset var14=0>
<!--- output query  --->
<cfoutput query="tasks">
<!--- lookup up all the delays from the delays table that match the record id from the task list table --->
<cfquery name="tasklist" datasource="SBSEFD">
Select *
from dbo.Delays
where (TL_Rid='#tasks.TL_Rid#')
</cfquery>
<!--- keep a running count of all the different delays --->
<cfif #tasklist.Fiber# eq 'Y' OR #tasklist.LCC# eq 'Y' OR #tasklist.Cross_Over# eq 'Y' OR #tasklist.SPS# eq 'Y' OR #tasklist.Misc# eq 'Y'>
<cfset #var1#=#var1#+1>
<cfelseif #tasklist.Network# eq 'Y'>
<cfset #var2#=#var2#+1>
<cfelseif #tasklist.Missing_Power# eq 'Y'>
<cfset #var3#=#var3#+1>
<cfelseif #tasklist.Out_of_Scope# eq 'Y'>
<cfset #var4#=#var4#+1>
<cfelseif #tasklist.Software_Miss# eq 'Y'>
<cfset #var5#=#var5#+1>
<cfelseif #tasklist.Software_Lic# eq 'Y'>
<cfset #var6#=#var6#+1>
<cfelseif #tasklist.Equip_Miss# eq 'Y'>
<cfset #var7#=#var7#+1>
<cfelseif #tasklist.Equip_Not_Arrived# eq 'Y'>
<cfset #var8#=#var8#+1>
<cfelseif #tasklist.Equip_Broken# eq 'Y'>
<cfset #var9#=#var9#+1>
<cfelseif #tasklist.Equip_Damage# eq 'Y'>
<cfset #var10#=#var10#+1>
<cfelseif #tasklist.Rail_Kit# eq 'Y'>
<cfset #var11#=#var11#+1>
<cfelseif #tasklist.Internal_Work# eq 'Y'>
<cfset #var12#=#var12#+1>
<cfelseif #tasklist.Redesign# eq 'Y'>
<cfset #var13#=#var13#+1>
<cfelseif #tasklist.hours# eq 'None'>
<cfset #var14#=#var14#+1>
</cfif>

</cfoutput>


<cfoutput>
<!--- calculate percentages --->
<cfset totaldelays=#total.totaltasks#-#var14#>
<cfset p_q1=#var1#/#totaldelays#>
<cfset p_q2=#var2#/#totaldelays#>
<cfset p_q3=#var3#/#totaldelays#>
<cfset p_q4=#var4#/#totaldelays#>
<cfset p_q5=#var5#/#totaldelays#>
<cfset p_q6=#var6#/#totaldelays#>
<cfset p_q7=#var7#/#totaldelays#>
<cfset p_q8=#var8#/#totaldelays#>
<cfset p_q9=#var9#/#totaldelays#>
<cfset p_q10=#var10#/#totaldelays#>
<cfset p_q11=#var11#/#totaldelays#>
<cfset p_q12=#var12#/#totaldelays#>
<cfset p_q13=#var13#/#totaldelays#>
<cfset p_q14=#var14#/#total.totaltasks#>
<cfset p_q15=(#var1#+#var2#+#var3#+#var4#+#var5#+#var6#+#var7#+#var8#+#var9#+#var10#+#var11#+#var12#+#var13#)/#total.totaltasks#>

<!--- output graph --->
<cfchart font="Arial" showXGridlines="yes" showYGridlines="yes" showborder="yes" show3d="yes" labelformat="percent" chartheight="500" chartwidth="1000" title="Delays from #form.startdate# to #form.enddate#" >
<cfchartseries type="bar" seriescolor="##33CCFF" paintStyle="plain" datalabelstyle="value" >
<cfchartdata item="Cables Missing" value="#p_q1#">
<cfchartdata item="Network Connectivity" value="#p_q2#">
<cfchartdata item="Missing Power" value="#p_q3#">
<cfchartdata item="Out Of Scope" value="#p_q4#">
<cfchartdata item="Software Missing" value="#p_q5#">
<cfchartdata item="Software License Missing" value="#p_q6#">
<cfchartdata item="Equipment Missing" value="#p_q7#">
<cfchartdata item="Equipment Not Arrived" value="#p_q8#">
<cfchartdata item="Equipment Broken" value="#p_q9#">
<cfchartdata item="Equipment Damaged" value="#p_q10#">
<cfchartdata item="Missing Rail Kit" value="#p_q11#">
<cfchartdata item="Customer Internal Work" value="#p_q12#">
<cfchartdata item="Redesign" value="#p_q13#">
<cfchartdata item="Total Delays" value="#p_q15#">
<cfchartdata item="No Delays" value="#p_q14#">
</cfchartseries>
</cfchart>

</cfoutput>


<cfelse>
No data on selected dates

</cfif>