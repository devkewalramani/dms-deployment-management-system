<cfset d1 = '#Form.startdate#'>
<cfset d2 = '#Form.enddate#'>

<cfoutput>
Start date - #d1#
<br />
End date - #d2#
<br />

<cfset d3=#DateDiff("d", d1, d2)#>
<cfset numofweeks=#DateDiff("ww", d1, d2)# + 1>

<cfset tempweek=#Week(d1)#>

There are #d3# days in between and spans #numofweeks# weeks
<br /><br />

<cfset bday=0>

<cfif DayOfWeek(d1) eq '1'>

<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(d1) + 5), d1)>
<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>

<cfelse>

<CFSET WeekStarttemp = DateAdd("d", -(DayOfWeek(d1) - 1), d1) + 1>
<CFSET WeekEndtemp = DateAdd("d", 6, WeekStarttemp)>

</cfif>

<cfset wkctr=1>
Week #wkctr# - #dateformat(d1,'mm/dd/yyyy')# - #dateformat(WeekEndtemp,'mm/dd/yyyy')#   
<br /> 

<cfloop from="0" to="#d3#" index="i">
<cfset d4=#d1# + #i#>

<cfif DayOfWeek(d4) eq '1'>

<CFSET WeekStart = DateAdd("d", -(DayOfWeek(d4) + 5), d4)>
<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>

<cfelse>

<CFSET WeekStart = DateAdd("d", -(DayOfWeek(d4) - 1), d4) + 1>
<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>

</cfif>
	
<cfif '#WeekStarttemp#' neq '#WeekStart#'>

<cfset #wkctr#=#wkctr#+1>

<cfif '#d2#' gt '#weekend#'>
Week #wkctr# - #dateformat(weekstart,'mm/dd/yyyy')# - #dateformat(weekend,'mm/dd/yyyy')#
<cfelseif '#d2#' lte '#weekend#'>
Week #wkctr# - #dateformat(weekstart,'mm/dd/yyyy')# - #dateformat(d2,'mm/dd/yyyy')#
</cfif>
<br />
<cfset #WeekStarttemp#=#WeekStart#>
</cfif>

<cfif dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 2 or dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 3 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 4 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 5 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 6>
<cfset bday = #bday#+1>
</cfif>

</cfloop>
</table>
<br />
There are #bday# business days in between
<br />

</cfoutput>








