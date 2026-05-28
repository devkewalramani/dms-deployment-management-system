<cfquery name="tlmiss" datasource="SBSEFD">
select *
from dbo.schedule
where (Status = 'Completed') and (ProjectType = 'EFD' OR ProjectType = 'EFD/LOE') and (DispatchID <> 'NA') and (SE_Type <> 'MLT') and (TL is null)
Order by EndDate ASC
</cfquery>


<table width="700" border="1">
 <tr>
    <td bgcolor="#CCCCCC"><strong>Dispatch ID</strong></td>
    <td bgcolor="#CCCCCC"><strong>Project Name</strong></td>
	<td bgcolor="#CCCCCC"><strong>Engineer</strong></td>
    <td bgcolor="#CCCCCC"><strong>Scheduled End Date</strong></td>
    <td bgcolor="#CCCCCC"><strong>Status</strong></td>
	 <td bgcolor="#CCCCCC"><strong>TL</strong></td>
  </tr>
<cfoutput query="tlmiss">
<cfquery name="check" datasource="SBSEFD">
select *
from dbo.tasklist
where TL_RID='#tlmiss.RID#'
</cfquery>
<cfif #check.TL_RID# eq #tlmiss.RID#>

  <tr>
    <td>#dispatchid#</td>
    <td>#projectname#</td>
	<td>#SE_FName# #SE_LName#</td>
    <td>#dateformat(enddate,'mm/dd/yy')#</td>
	<td>#status#</td>
	<td>#TL#</td>
  </tr>
  </cfif>
</cfoutput>
</table>


