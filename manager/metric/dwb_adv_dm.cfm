<!--- This report shows how many days in advance a Design Work Book was sent and the DM's associated on the project  --->

<!--- get a count of the number of jobs from the tasklist table --->
<cfquery name="total" datasource="SBSEFD">
select count(*) as totaltasks
from dbo.tasklist
Where (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- do if that above count is not 0--->
<cfif #total.totaltasks# neq 0>
<!--- get the names of all the DM's in the DM Table --->
<cfquery name="dm_name" datasource="SBSEFD">
Select FName, LName
from dbo.DM
</cfquery>

<cfheader name="Content-Disposition" value="inline; filename=utilreport.xls">
<cfcontent type="application/msexcel">
<!--- output headers --->
<cfoutput><font color="red">DWB Advance Notice by DM<br />
Total number of jobs #total.totaltasks# from #form.startdate# to #form.enddate#</font></cfoutput>

<table width="700" border="1">
 <tr>
    <td bgcolor="#CCCCCC"><strong>DM</strong></td>
    <td bgcolor="#CCCCCC"><strong>No DWB</strong></td>
	<td bgcolor="#CCCCCC"><strong>0 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>1-2 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>3-4 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>5-6 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>7-8 Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>8+ Days</strong></td>
	<td bgcolor="#CCCCCC"><strong>Not Required</strong></td>
</tr>
<!--- output query--->
<cfoutput query="dm_name">
<!--- define count variables --->
<cfset var1=0>
<cfset var2=0>
<cfset var3=0>
<cfset var4=0>
<cfset var5=0>
<cfset var6=0>
<cfset var7=0>
<cfset var8=0>
<!--- concatanate DM first and last name--->
<cfset dm_nme='#LName#'&", "&'#FName#'>
<!--- lookup the DWB adv notice and DM fields fron the task list table--->
<cfquery name="task" datasource="SBSEFD">
select DWB_adv, DM
from dbo.tasklist
Where DM='#dm_nme#' and (Actual_Startdate between '#form.startdate#' and '#form.enddate#')
</cfquery>
<!--- loop through inner query --->
<cfloop query="task">
<!--- keep a running count of all the different days advance notice catagories--->
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
<cfelseif #task.DWB_adv# eq 'NA'>
<cfset #var8#=#var8#+1>
</cfif>

</cfloop>
<!--- output DM's and total counts --->
<tr>
<td>#dm_nme#</td>
<td>#var1#</td>
<td>#var2#</td>
<td>#var3#</td>
<td>#var4#</td>
<td>#var5#</td>
<td>#var6#</td>
<td>#var7#</td>
<td>#var8#</td>
</tr>

</cfoutput>
</table>

<cfelse>
No data on selected dates
</cfif>
