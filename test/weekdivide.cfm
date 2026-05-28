<!---Assign and concatate date fields --->
<cfset StartTime = "#Form.StartTime1# #Form.StartTime2#">
<cfset EndTime = "#Form.EndTime1# #Form.EndTime2#">

<cfset DateAdded1 = Now()>
<cfset DateAdded = #DateFormat(DateAdded1,'mm/dd/yyyy')#>

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

<!--- Intial Insert for first week --->
#sdate# #WeekEndtemp1#
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

<!---Recursive Insert for additional weeks --->
<cfif '#edate#' gt '#WeekEnd#'>

#WeekStart1# #WeekEnd1#

<cfelseif '#edate#' lte '#WeekEnd#'>

#WeekStart1# #edate#

</cfif>

<!--- END --->

<cfset #WeekStarttemp#=#WeekStart#>
</cfif>
</cfloop>

<!--- end of custom date code --->