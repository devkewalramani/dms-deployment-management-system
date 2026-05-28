<!---
This form allow to cancel a scheduled project
--->

<head>
<style type="text/css">
<!--
.style5 {font-size: 12px; }
.style6 {
	color: #FF0000;
	font-weight: bold;
}
.style7 {color: #FF0000}
-->
</style>
<head>

<body>
<!--- query the project --->
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (RID = '#URL.RID#') and (Status <> 'Canceled' OR Status <> 'Completed')
Order by StartDate ASC
</cfquery>

<cfoutput query="search">
<!--- get the project type --->
<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
Select *
From dbo.Proj_Type
Where Proj_Type_ID='#search.ProjectType#'
</cfquery>
<!--- output the form --->
<form name="form"  method="post" action="cancelscript.cfm" target="_blank" onsubmit = "return confirm('Are you sure you want to cancel this project?');"  >
<table width="100%" bgcolor="##CCCCCC">
  <tr>
    <th colspan="4" bgcolor="##FFFFFF" scope="col"><div align="left">SBS Project Code:  #search.projcode#</div></th>
    <th colspan="4" bgcolor="##FFFFFF" scope="col"><div align="left">Project Type: #Proj_Type_lookup.Type#</div></th>
    <th bgcolor="##FFFFFF" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <th width="4%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">RID</div></th>
    <th width="11%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Dexterra ID </div></th>
    <th width="10%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Omni</div></th>
	<th width="10%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">PO_Num</div></th>
    <th width="13%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Project Name </div></th>
	<th width="14%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Project Location</div></th>
	<th width="20%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Engineer</div></th>
    <th width="10%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5">Start Date </div></th>
    <th width="18%" bgcolor="##FFFFFF" scope="col"><div align="center" class="style5"><span class="style6">*</span>Cancel Reason </div></th>
  </tr>
  <tr>
    <td bgcolor="##FFFFFF"><div align="center" class="style5"><input name="rid" type="text" value="#search.RID#" size="4" maxlength="4" readonly="yes">
    </div></td>
    <td bgcolor="##FFFFFF"><div align="center" class="style5">#search.DispatchID#</div></td>
    <td bgcolor="##FFFFFF"><div align="center" class="style5">#search.OmniNum#</div></td>
	<td bgcolor="##FFFFFF"><div align="center" class="style5">#search.PO_Num#</div></td>
    <td bgcolor="##FFFFFF"><div align="center" class="style5">#search.ProjectName#</div></td>
	<td bgcolor="##FFFFFF"><div align="center" class="style5">#search.ProjectCity#, #search.ProjectState# #search.ProjectZip#</div></td>
	<td bgcolor="##FFFFFF"><div align="center" class="style5">#search.SE_Lname#,#search.SE_Fname#</div></td>
    <td bgcolor="##FFFFFF"><div align="center" class="style5">#DateFormat(search.StartDate,'mm/dd/yyyy')#</div></td>
    <td bgcolor="##FFFFFF">
        <div align="center" class="style5">
          <select name="CancelReason">
            <option value="0">Select One</option>
            <option value="Schedule Change">Schedule Change</option>
            <option value="Double Booked">Double Booked</option>
            <option value="Insufficient Skill">Insufficient Skill</option>
			<option value="Job Canceled">Job Canceled</option>
			<option value="Previous Job Run Over">Previous Job Run Over</option>
            <option value="Other">Other</option>
          </select>
        </div></td>
  </tr>
  <tr bgcolor="##FFFFFF">
  	<td colspan="2"><div align="right"><span class="style5"><strong><span class="style7">*</span> Cancel Notes:</strong></span></div></td>
    <td colspan="7">
	<input name="CancelNotes" type="text" size="125" maxlength="150">	</td>
   </tr>
</table>
<div align="center"><input name="Cancel" type="submit" value="     Submit     " >
</div>
</form>



<br><br>
</cfoutput>
</body>