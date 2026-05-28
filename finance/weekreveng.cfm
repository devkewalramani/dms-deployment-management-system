<!---
This generates a weekly revenue by engineer report
--->

<cfheader name="Content-Disposition" value="inline; filename=weekreveng.xls">
<cfcontent type="application/msexcel">

<style type="text/css">
<!--
.style4 {font-size: 12px;font-weight: bold; color:#000000}
.style5 {font-size: 12px;color:#000000}
.style11 {font-size: 12px;font-weight: bold;color: #FFFFFF;}
-->
</style>

<cfoutput>

<!-- DS Engineers -->
<cfquery name="se" datasource="SBSEFD">
Select *
from dbo.se
where (BU_Group='DS') and (Status='1')
Order by Type, Lname ASC
</cfquery>
<!-- End DS -->

<!--- outside output loop --->
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="3" class="style4">Recognized Revenue (Dates by week ending date) </td>
  </tr>
  <tr>
    <td class="style4">Dell Services</td>
	<td class="style4">&nbsp;</td>
	<td class="style4" align="center">Engineer</td>
	<!---Assign date fields --->

	<cfset sdate = '#Form.startdate#'>
	<cfset edate = '#Form.enddate#'>
	<!--- Date Code here --->

	<cfset totaldays=#DateDiff("d", sdate, edate)#>
	<cfset numofweeks=#DateDiff("ww", sdate, edate)# + 1>

	<cfset tempweek=#Week(sdate)#>

	<!---Special calculation for if the start date is a sunday--->

	<cfif DayOfWeek(sdate) eq '1'>

	<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(sdate) + 5), sdate)>
	<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>
	<cfset WeekEndtemp1=#DateFormat(WeekEndtemp,'mm/dd/yyyy')#>

	<cfelse>

	<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(sdate) - 1), sdate)+1>
	<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>
	<cfset WeekEndtemp1=#DateFormat(WeekEndtemp,'mm/dd/yyyy')#>
	</cfif>

	<!--- END --->

	<cfset wkctr=1>

	<!--- Intial output for first week --->
    <td bgcolor="##000000"><div align="center"><span class="style11">#WeekEndtemp1#</span></div></td>
	<!--- END --->
	<cfloop from="0" to="#totaldays#" index="i">
	<cfset currentday=#sdate# + #i#>

	<!---Special calculation for if the start date is a sunday--->
	<cfif DayOfWeek(currentday) eq '1'>
	
	<CFSET WeekStart = DateAdd("d", -(DayOfWeek(currentday) + 5), currentday)>
	<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>
	<cfset WeekStart1=#DateFormat(WeekStart,'mm/dd/yyyy')#>
	<cfset WeekEnd1=#DateFormat(WeekEnd,'mm/dd/yyyy')#>

	<cfelse>

	<CFSET WeekStart = DateAdd("d", -(DayOfWeek(currentday) - 1), currentday)+1>
	<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>
	<cfset WeekStart1=#DateFormat(WeekStart,'mm/dd/yyyy')#>
	<cfset WeekEnd1=#DateFormat(WeekEnd,'mm/dd/yyyy')#>
	</cfif>
	<!--- END --->

	<cfif '#WeekStarttemp#' neq '#WeekStart#'>
	<cfset #wkctr#=#wkctr#+1>

	<!---Recursive output for additional weeks --->
	<td bgcolor="##000000"><div align="center"><span class="style11">#WeekEnd1#</span></div></td>
	<cfset #WeekStarttemp#=#WeekStart#>
	</cfif>
	</cfloop>

	<!--- end of custom date code --->

	<!--- End inside output loop --->
    <td bgcolor="##000000"><div align="center"><span class="style11">Grand Total</span></div></td>
  </tr>
  <!--- End outside output loop --->

<cfloop query="se">
<tr>
	<td class="style5"></td>
    <td class="style5">#Type#</td>
    <td class="style5">#se.Lname#,#se.Fname#</td>
	<!---Assign date fields --->

	<cfset sdate = '#Form.startdate#'>
	<cfset edate = '#Form.enddate#'>
	<!--- Date Code here --->

	<cfset totaldays=#DateDiff("d", sdate, edate)#>
	<cfset numofweeks=#DateDiff("ww", sdate, edate)# + 1>

	<cfset tempweek=#Week(sdate)#>

	<!---Special calculation for if the start date is a sunday--->

	<cfif DayOfWeek(sdate) eq '1'>

	<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(sdate) + 5), sdate)>
	<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>
	<cfset WeekEndtemp1=#DateFormat(WeekEndtemp,'mm/dd/yyyy')#>

	<cfelse>

	<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(sdate) - 1), sdate)+1>
	<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>
	<cfset WeekEndtemp1=#DateFormat(WeekEndtemp,'mm/dd/yyyy')#>
	</cfif>

	<!--- END --->

	<!--- Revenue Calculation for first week--->
	<cfquery name="ds" datasource="sbsefd">
	Select LOE_Price
	From dbo.schedule
	where (EmpID='#se.EmpID#') and (EndDate Between '#sdate#' and '#WeekEndtemp1#') and (ProjectType='EFD/LOE') and (LOE_Price <> '')
	</cfquery>
	<cfset temprev=0>
	<cfloop query="ds">
	<cfset temprev=#temprev# + #ds.LOE_Price#>
	</cfloop>
	<cfset totalrev=#temprev# + #se.rate#>
	<cfset grandtotal=#totalrev#>
	<td class="style5" align="center">#totalrev#</td>

	<cfloop from="0" to="#totaldays#" index="i">
	<cfset currentday=#sdate# + #i#>

	<!---Special calculation for if the start date is a sunday--->
	<cfif DayOfWeek(currentday) eq '1'>
	
	<CFSET WeekStart = DateAdd("d", -(DayOfWeek(currentday) + 5), currentday)>
	<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>
	<cfset WeekStart1=#DateFormat(WeekStart,'mm/dd/yyyy')#>
	<cfset WeekEnd1=#DateFormat(WeekEnd,'mm/dd/yyyy')#>

	<cfelse>

	<CFSET WeekStart = DateAdd("d", -(DayOfWeek(currentday) - 1), currentday)+1>
	<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>
	<cfset WeekStart1=#DateFormat(WeekStart,'mm/dd/yyyy')#>
	<cfset WeekEnd1=#DateFormat(WeekEnd,'mm/dd/yyyy')#>
	</cfif>
	<!--- END --->

	<cfif '#WeekStarttemp#' neq '#WeekStart#'>
	
	<!---Recursive calculation for additional weeks --->
	<cfquery name="ds" datasource="sbsefd">
	Select LOE_Price
	From dbo.schedule
	where (EmpID='#se.EmpID#') and (EndDate Between '#WeekStart1#' and '#WeekEnd1#') and (ProjectType='EFD/LOE') and (LOE_Price <> '')
	</cfquery>
	<cfset temprev=0>
	<cfloop query="ds">
	<cfset temprev=#temprev# + #ds.LOE_Price#>
	</cfloop>
	<cfset totalrev=#temprev# + #se.rate#>
	<cfset grandtotal=#grandtotal# + #totalrev#>
	<td class="style5" align="center">#totalrev#</td>
	<cfset #WeekStarttemp#=#WeekStart#>
	</cfif>
	</cfloop>
	<td class="style5" align="center">#grandtotal#</td>
</tr>
</cfloop>

  <tr>
    <td bgcolor="##cccccc" class="style4">Dell Services Total </td>
	<td align="right" bgcolor="##cccccc" class="style4">&nbsp;</td>
	<td align="right" bgcolor="##cccccc" class="style4">&nbsp;</td>
	<!--- Intial output for first week --->
    <td align="center" bgcolor="##cccccc" class="style4"></td>
	<!--- END --->
	<cfloop from="2" to="#wkctr#" index="i">
	<!---Recursive output for additional weeks --->
	<td align="center" bgcolor="##cccccc" class="style4">&nbsp;</td>
	</cfloop>
	<td align="center" bgcolor="##cccccc" class="style4">&nbsp;</td>
	<!--- end of custom date code --->
  </tr>
</table>

</cfoutput>