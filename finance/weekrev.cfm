<!---
This generates a weekly revenue report
--->
<cfheader name="Content-Disposition" value="inline; filename=weekrev.xls">
<cfcontent type="application/msexcel">

<style type="text/css">
<!--
.style4 {font-size: 12px;font-weight: bold; color:#000000}
.style5 {font-size: 12px;color:#000000}
.style11 {font-size: 12px;font-weight: bold;color: #FFFFFF;}
-->
</style>

<!--- outside output loop --->
<table width="700" cellpadding="0" cellspacing="0">
  <tr>
    <td class="style4">Recognized Revenue</td>
    <td colspan="4" class="style4"><div align="center">Business Unit</div></td>
  </tr>
  <tr>
    <td><span class="style4">SBS Report Week <em>(Week Ending)</em></span></td>
    <td bgcolor="#000000"><div align="center"><span class="style11">Dell Services </span></div></td>
    <td bgcolor="#000000"><div align="center"><span class="style11">Enterprise Services </span></div></td>
    <td bgcolor="#000000"><div align="center"><span class="style11">Managed Services </span></div></td>
    <td bgcolor="#000000"><div align="center"><span class="style11">Grand Total </span></div></td>
  </tr>
  <!--- End outside output loop --->
  
  <!--- inside output loop --->
  <!---Assign date fields --->

<cfset sdate = '#Form.startdate#'>
<cfset edate = '#Form.enddate#'>

<cfoutput>


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
<!-- DS -->
<cfquery name="ds" datasource="sbsefd">
Select LOE_Price
from dbo.Schedule
Where (EndDate Between '#sdate#' and '#WeekEndtemp1#') and (ProjectType='EFD/LOE') and (LOE_Price <> '')
</cfquery>

<cfset temprev=0>

<cfloop query="ds">
<cfset temprev=#temprev# + #ds.LOE_Price#>
</cfloop>

<cfquery name="dsrates" datasource="sbsefd">
Select SUM(rate) as totalrate
from dbo.SE
Where (Type='DLE' or Type='MLT' or Type='DLA') and (Status='1')
</cfquery>

<cfset totalrev=#temprev# + #dsrates.totalrate#>
<cfset grandtotal=#totalrev#>
<!-- End DS -->
<tr>
    <td class="style5" align="right">#WeekEndtemp1#</td>
    <td class="style5" align="center">#NumberFormat(totalrev,'$9,999,999.99')#</td>
    <td class="style5">&nbsp;</td>
    <td class="style5">&nbsp;</td>
    <td class="style5">&nbsp;</td>
</tr>
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
<!-- DS -->
<cfquery name="ds" datasource="sbsefd">
Select LOE_Price
from dbo.Schedule
Where (EndDate Between '#WeekStart1#' and '#WeekEnd1#') and (ProjectType='EFD/LOE') and (LOE_Price <> '')
</cfquery>

<cfset temprev=0>

<cfloop query="ds">
<cfset temprev=#temprev# + #ds.LOE_Price#>
</cfloop>

<cfquery name="dsrates" datasource="sbsefd">
Select SUM(rate) as totalrate
from dbo.SE
Where (Type='DLE' or Type='MLT' or Type='DLA') and (Status='1')
</cfquery>

<cfset totalrev=#temprev# + #dsrates.totalrate#>
<cfset grandtotal=#grandtotal# + #totalrev#>
<!-- End DS -->
<tr>
    <td class="style5" align="right">#WeekEnd1#</td>
    <td class="style5" align="center">#NumberFormat(totalrev,'$9,999,999.99')#</td>
    <td class="style5">&nbsp;</td>
    <td class="style5">&nbsp;</td>
    <td class="style5">&nbsp;</td>
</tr>
<!--- END --->

<cfset #WeekStarttemp#=#WeekStart#>
</cfif>
</cfloop>
</cfoutput>
<!--- end of custom date code --->

<!--- End inside output loop --->
  
  <!--- outside output loop --->
  <cfoutput>
  <tr>
    <td class="style4">Grand Total </td>
    <td class="style4" align="center">#NumberFormat(grandtotal,'$9,999,999.99')#</td>
    <td class="style4" align="center">&nbsp;</td>
    <td class="style4" align="center">&nbsp;</td>
    <td class="style4" align="center">&nbsp;</td>
  </tr>
  </cfoutput>
</table>
<!--- End outside output loop --->
