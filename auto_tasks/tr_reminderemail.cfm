<!---
This report will run every morning to alert management any queued travel requests that need to be sent out.
--->


<style type="text/css">
<!--
.style5 {font-size: 12px; }
-->
</style>
<body>
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.travel
WHERE TR_Status = 'Not Submitted'
Order by StartDate ASC
</cfquery>

<cfset date1 = Now()>
<cfset counter=0>
<cfloop query="search">
<cfset numofdays = #search.startdate# - #date1#>
<cfif #numofdays# lte 8>
<cfset #counter#=#counter#+1>
</cfif>
</cfloop>

<cfoutput>

<cfset date2 = #dateformat(date1,'mm/dd/yy')#>
<cfmail from = "Scheduling@SBSPlanet.com" To = "Scheduling@SBSPlanet.com" Subject = "Pending Travel Requests as of #date2#">
<cfmailpart type="text" wraptext="60">
There are #counter# Travel Requests to send today.
<cfmailpart type="html">
There are #counter# Travel Requests to send today.
</cfmailpart>
</cfmail>

</cfoutput>

</body>