<!---
Script submits a travel request selected from the TR pipline
--->

<head>
<style type="text/css">
<!--
.style2 {font-size: 12px}
-->
</style>

</head>

<body>
<!--- get project info from travel table--->
<cfquery name="joblookup" datasource="SBSEFD">
SELECT *
FROM dbo.travel
WHERE RID = '#Form.RID#'
</cfquery>
<!--- get project info from schedule table--->
<cfquery name="schlookup" datasource="SBSEFD">
SELECT *
FROM dbo.schedule
WHERE RID = '#Form.RID#'
</cfquery>
<!--- get employee info --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmailAddress,type
FROM dbo.SE
WHERE EmpID = #joblookup.EmpID#
</cfquery>

<!--- set date variables --->
<cfset TRDate1 = Now()>
<cfset TRDate = #DateFormat(TRDate1,'mm/dd/yyyy')#>
<cfset StartDate = #DateFormat(joblookup.StartDate,'mm/dd/yy')#>

<!---figure out if the TR is being sent with urgent status or not--->
<cfif #Form.Delivery# is 'Urgent'>
<cfset d_status = 'URGENT'>
<cfelse>
<cfset d_status = ''>
</cfif>

<cfoutput>
<!--- lookup porject type from project id--->
<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
Select *
From dbo.Proj_Type
Where Proj_Type_ID='#joblookup.ProjectType#'
</cfquery>
<!--- update travel table --->
<cfquery name="updatetravel" datasource="SBSEFD">
Update dbo.travel set Flight='#form.flight#', Hotel='#form.hotel#', Rental='#form.rental#', TravelNotes='#form.TravelNotes#', TRDate='#TRDate#', TR_Status='Submitted' where RID='#form.RID#'
</cfquery>
<!--- email travel request --->
<cfmail from = "Scheduling@SBSPlanet.com" To = "travel@sbsplanet.com,#SE_lookup.EmailAddress#" cc="Scheduling@SBSPlanet.com"
Subject = "#d_status# Travel Request - #joblookup.ProjectName# - #StartDate# ">
   <cfmailpart 
      type="html">
<br>	  
<strong>Project Type:</strong> #Proj_Type_lookup.Type#
<br>	  
<strong>SBS Project Code:</strong> #Form.projcode#
<br>
<table width="100%" border="1">
  <tr>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Dexterra ID </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Omni</span></th>
	<th bgcolor="##FFCC66" scope="col"><span class="style2">PO Number</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Client Name </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">City</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">State</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Zip</span></th>	
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Start Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Start Time </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Return Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Site Departure Date </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Consultant</span></th>
	<th bgcolor="##FFCC66" scope="col"><span class="style2">Type</span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Flight requird </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Hotel Rquired </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Rental Car Required </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Project Summary </span></th>
  </tr>
  <tr>
    <td><span class="style2">#joblookup.DispatchID#</span></td>
    <td><span class="style2">#joblookup.OmniNum#</span></td>
	<td><span class="style2">#schlookup.PO_Num#</span></td>
    <td><span class="style2">#joblookup.ProjectName#</span></td>
    <td><span class="style2">#joblookup.ProjectCity#</span></td>
	<td><span class="style2">#joblookup.ProjectState#</span></td>
	<td><span class="style2">#joblookup.ProjectZip#</span></td>
    <td><span class="style2">#Dateformat(joblookup.StartDate,'mm/dd/yy')#</span></td>
    <td><span class="style2">#Timeformat(joblookup.StartTime,'h tt')#</span></td>
    <td><span class="style2">#DateFormat(joblookup.EndDate,'mm/dd/yy')#</span></td>
    <td><span class="style2">#TimeFormat(joblookup.EndTime,'h tt')#</span></td>
    <td><span class="style2">#joblookup.SE_FName# #joblookup.SE_LName#</span></td>
	<td><span class="style2">#SE_lookup.type#</span></td>
    <td><span class="style2">#Form.Flight#</span></td>
    <td><span class="style2">#Form.Hotel#</span></td>
    <td><span class="style2">#Form.Rental#</span></td>
    <td><span class="style2">#joblookup.ProjectSummary#</span></td>
  </tr>
</table>
<table width="100%" border="1">
  <tr>
    <td width="83">Travel Notes </td>
    <td width="501">#Form.TravelNotes#</td>
  </tr>
</table>
   </cfmailpart>
</cfmail>
<center><font color="##0000FF">#joblookup.ProjectName# for #joblookup.SE_LName#,#joblookup.SE_FName# has been added!
<br>
Travel Request has been Submitted</font>
<br><br>
<A href="javascript: self.close ()">CLOSE WINDOW</A> 
</center>
</cfoutput>