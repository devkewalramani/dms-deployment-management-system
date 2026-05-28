<cfset d1 = '#Form.startdate#'>
<cfset d2 = '#Form.enddate#'>

<cfoutput>
Start date - #d1#
<br />
End date - #d2#
<br />

<cfset d3=#DateDiff("d", d1, d2)#>
<cfset numofweeks=#DateDiff("ww", d1, d2)#>
<cfset tempweek=#Week(d1)#>

There are #d3# days in between and #numofweeks# weeks
<br />

<cfset bday=0>

<table width="100%" bgcolor="##CCCCCC">
  <tr>
    <th scope="col"><div align="center">Day Number</div></th>
    <th scope="col"><div align="center">Date</div></th>
    <th scope="col"><div align="center">Week of the Year</div></th>
    <th scope="col"><div align="center">Dates for Given Week</div></th>
  </tr>
  
<cfloop from="0" to="#d3#" index="i">
<cfset d4=#d1# + #i#>

<CFSET WeekStart = DateAdd("d", -(DayOfWeek(d4) - 1), d4)>
<CFSET WeekEnd = DateAdd("d", 6, WeekStart)>


<tr>
<td bgcolor="##FFFFFF"><div align="center">Day #i#</div></td>
<td bgcolor="##FFFFFF"><div align="center">#dateformat(d4,'mm/dd/yyyy')#</div></td>
<td bgcolor="##FFFFFF"><div align="center">week #Week(d4)#</div></td>
<cfif #tempweek# eq #Week(d4)#>
<td bgcolor="##FFFFFF"><div align="center">#dateformat(weekstart,'mm/dd/yyyy')# - #dateformat(weekend,'mm/dd/yyyy')#</div></td>
<cfelse>
<td bgcolor="##FFFFFF"><div align="center">NA</div></td>
</cfif>
</tr>





<cfif dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 2 or dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 3 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 4 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 5 OR dayofweek(#dateformat(d4,'mm/dd/yyyy')#) eq 6>
<cfset bday = #bday#+1>
</cfif>

</cfloop>
</table>
<br />
There are #bday# business days in between
<br />

</cfoutput>








