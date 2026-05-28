<!---
page that displays the serach results for a task list search.  This allows management to submit on behalf of the engineer
--->

<style type="text/css">
<!--
.style1 {font-size: 12px}
-->
</style>
<body>
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (DispatchID = '#FORM.search#')
</cfquery>

<cfquery name="search_count" datasource="SBSEFD">
SELECT count(*) as count
FROM dbo.Schedule
WHERE (DispatchID = '#FORM.search#')
</cfquery>

<cfoutput>
<cfif #search_count.count# neq 0>

<cfloop query="search">

<form name="form"  method="post" action="tasklist.cfm">
<input name="rid" type="hidden" value="#search.RID#">
<table width="100%" border="1">
  <tr>
    <th width="12%" scope="col"><div align="center" class="style1">Dexterra ID </div></th>
    <th width="11%" scope="col"><div align="center" class="style1">Omni</div></th>
    <th width="13%" scope="col"><div align="center" class="style1">Project Name </div></th>
	<th width="14%" scope="col"><div align="center" class="style1">Project Location</div></th>
	<th width="20%" scope="col"><div align="center" class="style1">Engineer</div></th>
    <th width="11%" scope="col"><div align="center" class="style1">Start Date </div></th>
    <th width="14%" rowspan="2" scope="col">
        <div align="center" class="style1"><input name="tasklist" type="submit" value="Tasklist" > 
        </div></th>
  </tr>
  <tr>
    <td><div align="center" class="style1">#search.DispatchID#</div></td>
    <td><div align="center" class="style1">#search.OmniNum#</div></td>
    <td><div align="center" class="style1">#search.ProjectName#</div></td>
	<td><div align="center" class="style1">#search.ProjectCity#, #search.ProjectState# #search.ProjectZip#</div></td>
	<td><div align="center" class="style1">#search.SE_Lname#,#search.SE_Fname#</div></td>
    <td><div align="center" class="style1">#DateFormat(search.StartDate,'mm/dd/yyyy')#</div></td>
    </tr>
</table>
</form>
<br><br>
</cfloop>
<cfelseif #search_count.count# eq 0>
No records found
</cfif>
</cfoutput>
</body>