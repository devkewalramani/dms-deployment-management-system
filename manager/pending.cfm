<!---
Displays the pending Travel Request and allows for changes before submitting
--->

<style type="text/css">
<!--
.style5 {font-size: 12px; }
.style6 {color:#FF0000; }
-->
</style>
<body>
<!--- query project info (travel table) from selection on trpipline.cfm--->
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.travel
WHERE RID = '#FORM.RID#' and TR_Status = 'Not Submitted'
</cfquery>
<!--- recursive output of results --->
<cfoutput query="search">
<!--- get specfic project info from schedule table --->
<cfquery name="sch" datasource="SBSEFD">
select rid,projcode
from dbo.schedule
where rid='#search.rid#'
</cfquery>
<!--- output form--->
<form name="form"  method="post" action="submittr.cfm">
<table width="100%" border="1">
  <tr>
    <th colspan="10" bgcolor="##CCCCCC" scope="col">Project Information - SBS Project Code <input name="projcode" type="text" value="#sch.projcode#" size="10" maxlength="10" readonly="yes"></th>
    </tr>
  <tr>
    <th width="5%" scope="col"><div align="center" class="style5">RID</div></th>
    <th width="12%" scope="col"><div align="center" class="style5">Dexterra ID </div></th>
    <th width="11%" scope="col"><div align="center" class="style5">Omni</div></th>
    <th width="13%" scope="col"><div align="center" class="style5">Project Name </div></th>
	<th width="14%" scope="col"><div align="center" class="style5">Project City</div></th>
	<th width="14%" scope="col"><div align="center" class="style5">Project State</div></th>
	<th width="14%" scope="col"><div align="center" class="style5">Project Zip</div></th>
	<th width="20%" scope="col"><div align="center" class="style5">Engineer</div></th>
    <th width="11%" scope="col"><div align="center" class="style5">Start Date </div></th>
    <th width="14%" scope="col"><div align="center" class="style5">End Date</div></th>
  </tr>
  <tr>
    <td>
	<div align="center" class="style5">
	<input name="rid" type="text" value="#search.RID#" size="4" maxlength="4" readonly="yes">
    </div>	</td>
    <td><div align="center" class="style5">#search.DispatchID#</div></td>
    <td><div align="center" class="style5">#search.OmniNum#</div></td>
    <td><div align="center" class="style5">#search.ProjectName#</div></td>
	<td><div align="center" class="style5">#search.ProjectCity#</div></td>
	<td><div align="center" class="style5">#search.ProjectState#</div></td>
	<td><div align="center" class="style5">#search.ProjectZip#</div></td>
	<td><div align="center" class="style5">#search.SE_Lname#,#search.SE_Fname#</div></td>
    <td><div align="center" class="style5">#DateFormat(search.StartDate,'mm/dd/yyyy')#</div></td>
    <td><div align="center" class="style5">#DateFormat(search.EndDate,'mm/dd/yyyy')#</div></td>
  </tr>
  <tr>
    <td colspan="10" bgcolor="##CCCCCC"><div align="center"><strong>Travel Section</strong> </div></td>
    </tr>
  <tr>
    <td colspan="10"><div align="center"><strong>SE Location: </strong>
		<!--- lookup employee location info --->
          <cfquery name="emp_lookup" datasource="SBSEFD">
            select *
            from dbo.se
            where EmpID='#search.EmpID#'
            </cfquery>
          <font color="##FF0000">#emp_lookup.city#, #emp_lookup.state# #emp_lookup.zip#</font>
      
    </div></td>
  </tr>
  
  <tr>
    <td colspan="10">
	  <div align="center">
	  <strong>Delivery</strong>
	  <select name="Delivery">
          <option value="Normal">Normal</option>
          <option value="Urgent">Urgent</option>
        </select>	
	  <strong>Flight</strong> 
	    <select name="Flight">
		  <option value="#search.Flight#" class="style6">#search.Flight#</option>
	      <option value=""></option>
	      <option value="Y">Yes</option>
	      <option value="N">No</option>
	      </select>
	    <strong>Hotel</strong>
	    <select name="Hotel">
	      <option value="#search.Hotel#" class="style6">#search.Hotel#</option>
	      <option value=""></option>
	      <option value="Y">Yes</option>
	      <option value="N">No</option>
	      </select>
	    <strong>Car Rental		</strong>		
	    <select name="Rental">
	      <option value="#search.Rental#" class="style6">#search.Rental#</option>
	      <option value=""></option>
	      <option value="Y">Yes</option>
	      <option value="N">No</option>
	      </select> 
	      </div>		</td>
    </tr>
  <tr>
    <td colspan="10"><div align="center">Travel Notes
      <input name="TravelNotes" type="text" size="100" maxlength="100" value="#search.TravelNotes#"> 
    </div></td>
    </tr>
</table>
<div align="center"><input name="Submit" type="submit" value="     Submit Travel Request     " >
</div>
</form>
<br><br>
</cfoutput>
</body>