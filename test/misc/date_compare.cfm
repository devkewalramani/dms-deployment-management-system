

<cfquery name="report" datasource="SBSEFD">
Select *
From dbo.document_tracking
where (proj_complete_date between '3/3/2007' and '3/9/2007')
Order by proj_complete_date ASC
</cfquery>


<table width="600" border="1">
<cfoutput query="report">

<cfset projdate=#dateformat(proj_complete_date,'mm/dd/yyyy')#>
<cfset projtime=#timeformat(proj_complete_time,'hh:mm:ss tt')#>
<cfset projdatetime='#projdate#' & ' ' & '#projtime#'>

<cfset cafdate=#dateformat(CAF_complete_date,'mm/dd/yyyy')#>
<cfset caftime=#timeformat(CAF_complete_time,'hh:mm:ss tt')#>
<cfset cafdatetime='#cafdate#' & ' ' & '#caftime#'>
  <tr>
    <td>#projdatetime#</td>
    <td>#cafdatetime#</td>
    <td>#DateDiff("h", projdatetime, cafdatetime)#</td>
  </tr>
  </cfoutput>
</table>



