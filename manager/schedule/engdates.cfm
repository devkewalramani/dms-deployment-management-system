
<!--- select dates to view specifc engineer schedule--->
<cfoutput>
<form name="form" action="engschedule.cfm" method="post" >
<input type="hidden" name="EmpID" value="#URL.EmpID#">
<table width="200" border="1">
  <tr>
    <th class="maincontent" scope="row">Start Date</th>
    <td><CF_CT_DATE_INPUT NAME="sdate"></td>
  </tr>
  <tr>
    <th class="maincontent" scope="row">End Date</th>
    <td><CF_CT_DATE_INPUT NAME="edate"></td>
  </tr>
  <tr>
    <th scope="row">&nbsp;</th>
    <td><input type="submit" name="Submit" value="    Submit    "></td>
  </tr>
</table>
</form>
</cfoutput>