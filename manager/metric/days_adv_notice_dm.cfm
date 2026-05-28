<!--- Report outputs the advance notice by deployment managers in a excel format --->

<!--- count all the tasklists filled out in the date range --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- do if count is not 0 --->
<cfif #total.totaltasks# neq 0>
<!---lookup dm names  --->
<cfquery name="dm_name" datasource="SBSEFD">
Select FName, LName
from dbo.DM
</cfquery>

<cfheader name="Content-Disposition" value="inline; filename=utilreport.xls">
<cfcontent type="application/msexcel">
<!--- output headers --->
<cfoutput><font color="red">Days Advance Notice by DM<br />
Total number of jobs #total.totaltasks# from #form.startdate# to #form.enddate#</font></cfoutput>

<table width="700" border="1">
 <tr>
    <td bgcolor="#CCCCCC"><strong>DM</strong></td>
	<td bgcolor="#CCCCCC"><strong>0 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>1 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>2-3 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>4-5 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>6-7 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>8+ Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>Total less than 7 Days</strong></td>
</tr>
<!--- output results --->
<cfoutput query="dm_name">
<!---assign count variables  --->
<cfset var1=0>
<cfset var2=0>
<cfset var3=0>
<cfset var4=0>
<cfset var5=0>
<cfset var6=0>
<cfset var7=0>
<!--- concatanate DM first and last names --->
<cfset dm_nme='#LName#'&", "&'#FName#'>
<!--- lookup days adv notice from submitted task list and the DM on the project  --->
<cfquery name="task" datasource="SBSEFD">
select Days_adv, DM
from dbo.tasklist
Where DM='#dm_nme#' and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- loop through the inner query  --->
<cfloop query="task">
<!--- depending on the days advance notice assign the running count to a variable --->
<cfif #task.Days_adv# lte 0>
<cfset #var1#=#var1#+1>
</cfif>
<cfif #task.Days_adv# eq 1>
<cfset #var2#=#var2#+1>
</cfif>
<cfif #task.Days_adv# eq 2 or #task.Days_adv# eq 3>
<cfset #var3#=#var3#+1>
</cfif>
<cfif #task.Days_adv# eq 4 or #task.Days_adv# eq 5>
<cfset #var4#=#var4#+1>
</cfif>
<cfif #task.Days_adv# eq 6 or #task.Days_adv# eq 7>
<cfset #var5#=#var5#+1>
</cfif>
<cfif #task.Days_adv# gte 8>
<cfset #var6#=#var6#+1>
</cfif>
<cfif #task.Days_adv# lte 7>
<cfset #var7#=#var7#+1>
</cfif>
</cfloop>
<!--- output the DM and counts --->
<tr>
<td>#dm_nme#</td>
<td>#var1#</td>
<td>#var2#</td>
<td>#var3#</td>
<td>#var4#</td>
<td>#var5#</td>
<td>#var6#</td>
<td>#var7#</td>
</tr>

</cfoutput>
</table>

<cfelse>
No data on selected dates
</cfif>
