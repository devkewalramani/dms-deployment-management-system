<!---
This scripts cancels the project selected
--->
<head>
<title>Canceled</title>
</head>
<body>
<!--- find the current status of the travel request --->
<cfquery name="checkTR" datasource="SBSEFD">
SELECT TR_Status
FROM dbo.Travel
WHERE RID = '#FORM.RID#'
</cfquery>

<!--- set date variables --->
<cfset CancelDate1 = Now()>
<cfset CancelDate = #DateFormat(CancelDate1,'mm/dd/yyyy')#>

<cfoutput>
<!--- update schedule table and set status to canceled --->
<cfquery name="cancel" datasource="SBSEFD">
UPDATE dbo.schedule SET LOE_Price='', Travel_Price='', Status='Canceled', CancelReason='#FORM.CancelReason#', CancelNotes='#FORM.CancelNotes#',CancelDate='#CancelDate#' WHERE RID='#FORM.RID#'
</cfquery>
<!--- check to see if a TR was orginally sent. If so send a cancelation TR --->
<cfif '#checkTR.TR_Status#' is 'Submitted'>
<!--- update travel table and set status to canceled --->
<cfquery name="canceltravel" datasource="SBSEFD">
UPDATE dbo.Travel SET TR_Status='Canceled', CancelReason='#FORM.CancelReason#', CancelNotes='#FORM.CancelNotes#',CancelDate='#CancelDate#' WHERE RID='#FORM.RID#'
</cfquery>

<cfquery name="CancelTR" datasource="SBSEFD">
SELECT *
FROM dbo.Travel
WHERE RID = '#FORM.RID#'
</cfquery>

<cfquery name="schinfo" datasource="SBSEFD">
SELECT projcode,PO_Num
FROM dbo.schedule
WHERE RID = '#FORM.RID#'
</cfquery>

<cfquery name="se" datasource="SBSEFD">
select EmailAddress
from dbo.SE
where EmpID = #CancelTR.EmpID#
</cfquery>

<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
Select *
From dbo.Proj_Type
Where Proj_Type_ID='#CancelTR.ProjectType#'
</cfquery>

<cfmail from = "Scheduling@sbsplanet.com" To = "travel@sbsplanet.com,#se.EmailAddress#" cc="Scheduling@SBSPlanet.com"
Subject = "CANCEL Travel Request - #CancelTR.ProjectName# - #Dateformat(CancelTR.StartDate,'mm/dd/yyyy')# ">
   <cfmailpart 
      type="html">
<br>
<strong>Project Code:</strong> #schinfo.projcode#
<br>
<strong>Project Type:</strong> #Proj_Type_lookup.Type#
<br>	  
<strong>Reason for canceling:</strong> #CancelTR.CancelReason#
<br>
<strong>Cancelation Notes:</strong> #CancelTR.CancelNotes#
<br>
<table width="100%" border="1">
  <tr>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Dexterra ID </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Omni</span></th>
	<th bgcolor="##FFCC66" scope="col"><span class="style2">PO_Num</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Client Name </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">City</span></th>
	<th bgcolor="##FFCC66" scope="col"><span class="style2">State</span></th>
	<th bgcolor="##FFCC66" scope="col"><span class="style2">Zip</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Start Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Start Time </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Return Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Site Departure Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Consultant</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Flight requird </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Hotel Rquired </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Rental Car Required </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Project Summary </span></th>
  </tr>
  <tr>
    <td><span class="style2">#CancelTR.DispatchID#</span></td>
    <td><span class="style2">#CancelTR.OmniNum#</span></td>
	<td><span class="style2">#schinfo.PO_Num#</span></td>
    <td><span class="style2">#CancelTR.ProjectName#</span></td>
    <td><span class="style2">#CancelTR.ProjectCity#</span></td>
	<td><span class="style2">#CancelTR.ProjectState#</span></td>
	<td><span class="style2">#CancelTR.ProjectZip#</span></td>
    <td><span class="style2">#Dateformat(CancelTR.StartDate,'mm/dd/yyyy')#</span></td>
    <td><span class="style2">#Timeformat(CancelTR.StartTime,'h tt')#</span></td>
    <td><span class="style2">#Dateformat(CancelTR.EndDate,'mm/dd/yyyy')#</span></td>
    <td><span class="style2">#Timeformat(CancelTR.EndTime,'h tt')#</span></td>
    <td><span class="style2">#CancelTR.SE_Fname# #CancelTR.SE_Lname#</span></td>
    <td><span class="style2">#CancelTR.Flight#</span></td>
    <td><span class="style2">#CancelTR.Hotel#</span></td>
    <td><span class="style2">#CancelTR.Rental#</span></td>
    <td><span class="style2">#CancelTR.ProjectSummary#</span></td>
  </tr>
</table>
<table width="100%" border="1">
  <tr>
    <td width="83">Travel Notes </td>
    <td width="501">#CancelTR.TravelNotes#</td>
  </tr>
</table>
   </cfmailpart>
</cfmail>

</cfif>
<!--- if TR was not submitted then set status to cancel --->
<cfif '#checkTR.TR_Status#' is 'Not Submitted'>

<cfquery name="canceltravel" datasource="SBSEFD">
UPDATE dbo.Travel SET TR_Status='Canceled', CancelReason='#FORM.CancelReason#', CancelNotes='#FORM.CancelNotes#',CancelDate='#CancelDate#' WHERE RID='#FORM.RID#'
</cfquery>

</cfif>

</cfoutput>

<!--- do a lookup again on the same project and make sure the project was canceled. output to screen--->
<cfquery name="check" datasource="SBSEFD">
SELECT RID, DispatchID, OmniNum, ProjectName, ProjectCity, ProjectState, ProjectZip, Status
FROM dbo.Schedule
WHERE RID = '#FORM.RID#'
</cfquery>

<cfoutput query="check">
#DispatchID#, #OmniNum#, #ProjectName#, #ProjectCity#,#ProjectState# #ProjectZip# - #Status#
</cfoutput>

</body>
</html>
