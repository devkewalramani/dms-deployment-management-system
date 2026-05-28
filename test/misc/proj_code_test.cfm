
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.travel
WHERE TR_Status = 'Not Submitted'
Order by StartDate ASC
</cfquery>

<cfheader name="Content-Disposition" value="inline; filename=report.xls">
<cfcontent type="application/msexcel">

<table width="100%" border="1">
  <tr>
    <th scope="col">Rid</th>
    <th scope="col">Dexterra</th>
    <th scope="col">Omni</th>
    <th scope="col">Project code</th>
    <th scope="col">Project Name</th>
    <th scope="col">Engineer</th>
    <th scope="col">startdate</th>
  </tr>

<cfoutput query="search">

<cfquery name="sch" datasource="SBSEFD">
Select *
from dbo.schedule
where rid='#search.rid#'
</cfquery>

  <tr>
    <td>#sch.rid#</td>
    <td>#sch.dispatchid#</td>
    <td>#sch.omninum#</td>
    <td>#sch.projcode#</td>
    <td>#sch.ProjectName#</td>
    <td>#sch.SE_Lname#,#sch.SE_Fname#</td>
    <td>#DateFormat(sch.StartDate,'mm/dd/yyyy')#</td>
  </tr>
  
</cfoutput>
</table>