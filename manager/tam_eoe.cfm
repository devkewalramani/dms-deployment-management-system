<!---
This report outputs all the completion dates for EOE's, project completion and CAF's
--->

<!--- get all data between selected date range --->
<cfquery name="report" datasource="SBSEFD">
Select *
From dbo.document_tracking
where (proj_complete_date between '#Form.startdate#' and '#Form.EndDate#')
Order by proj_complete_date ASC
</cfquery>


<cfheader name="Content-Disposition" value="inline; filename=report.xls">
<cfcontent type="application/msexcel">

<style type="text/css">
<!--
.style3 {font-size: 12px; font-weight: bold; }
.style4 {font-size: 12px}
-->
</style>

<table width="100%" border="1"> 
  <tr>
    <td bgcolor="#FF9900"><div align="center" class="style3">Dexterra</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Engineer</div></td>
	<td bgcolor="#FF9900"><div align="center" class="style3">Type</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Customer</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Completetion Date</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Time</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">TAM/CAF Submission</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Signoff Time</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">TAM/CAF SLA</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Time to Submit</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">TAM/CAF Accuracy</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">EOE Submission Date</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">EOE SLA</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">EOE Accuracy</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Notes</div></td>
    <td bgcolor="#FF9900"><div align="center" class="style3">Action</div></td>
  </tr>
<cfoutput query="report"> 
<!--- get project info from schedule table --->
<cfquery name="schedule" datasource="SBSEFD">
select DispatchID,SE_Lname, SE_Fname,ProjectName,SE_Type
From dbo.schedule
where RID='#report.RID#'
</cfquery> 
<!--- do if the CAF submission date is the dummy date of 1/1/1990' --->
<cfif '#dateformat(CAF_complete_date,'mm/dd/yyyy')#' eq '1/1/1990'>
<!--- Define CAF variables --->
<cfset caf_sla='NA'>
<cfset cafdate='NA'>
<cfset caf_over=''>
<!--- do if the caf date is not null and not the dummy date --->
<cfelseif '#dateformat(CAF_complete_date,'mm/dd/yyyy')#' neq '1/1/1990' AND '#dateformat(CAF_complete_date,'mm/dd/yyyy')#' neq ''>
<!--- format date and time variables --->
<cfset projdate=#dateformat(proj_complete_date,'mm/dd/yyyy')#>
<cfset projtime=#timeformat(proj_complete_time,'hh:mm:ss tt')#>
<cfset projdatetime='#projdate#' & ' ' & '#projtime#'>

<cfset cafdate=#dateformat(CAF_complete_date,'mm/dd/yyyy')#>
<cfset caftime=#timeformat(CAF_complete_time,'hh:mm:ss tt')#>
<cfset cafdatetime='#cafdate#' & ' ' & '#caftime#'>
<!--- calculates the difference between proj completion and caf submission and flagged if over 26 hours --->
<cfset caf_sla_diff=#DateDiff("h", projdatetime, cafdatetime)#>

	<cfif #caf_sla_diff# lte 26>
	<cfset caf_sla='Y'>
	<cfset caf_over=''>
	<cfelseif #caf_sla_diff# gt 26>
	<cfset caf_sla='N'>
	<cfset caf_over=#caf_sla_diff# - 26>
	</cfif>

<cfelse>

<cfset caf_sla=''>
<cfset cafdate=''>
<cfset caf_over=''>
	
</cfif>
<!--- do if EOE date is the dummy date --->
<cfif '#dateformat(EOE_complete_date,'mm/dd/yyyy')#' eq '1/1/1990'>
<!--- set eoe variables --->
<cfset eoe_sla='NA'>
<cfset eoedate='NA'>
<!--- do if eoe date is not null and not the dummy date --->
<cfelseif '#dateformat(EOE_complete_date,'mm/dd/yyyy')#' neq '1/1/1990' AND '#dateformat(EOE_complete_date,'mm/dd/yyyy')#' neq ''>
<!--- format date and time variables--->
<cfset eoeprojdate=#dateformat(proj_complete_date,'mm/dd/yyyy')#>
<cfset eoedate=#dateformat(EOE_complete_date,'mm/dd/yyyy')#>
<!--- calculate the difference in days between the submission and due date --->
<cfset eoe_sla_diff=#eoedate# - #eoeprojdate#>

	<cfif #eoe_sla_diff# lte 3>
	<cfset eoe_sla='Y'>
	<cfelseif #eoe_sla_diff# gt 3>
	<cfset eoe_sla='N'>
	</cfif>

<cfelse>

<cfset eoe_sla=''>
<cfset eoedate=''>

</cfif>

  <tr>
    <td><div align="center" class="style4">#schedule.DispatchID#</div></td>
    <td><div align="center" class="style4">#schedule.SE_Fname# #schedule.SE_Lname#</div></td>
	<td><div align="center" class="style4">#schedule.SE_type#</div></td>
    <td><div align="center" class="style4">#schedule.ProjectName#</div></td>
    <td><div align="center" class="style4">#dateformat(proj_complete_date,'mm/dd/yyyy')#</div></td>
    <td><div align="center" class="style4">#timeformat(proj_complete_time,'hh:mm tt')#</div></td>
	<td><div align="center" class="style4">#cafdate#</div></td>
    <td><div align="center" class="style4">#timeformat(CAF_complete_time,'hh:mm tt')#</div></td>
    <td><div align="center" class="style4">#caf_sla#</div></td>
    <td><div align="center" class="style4">#caf_over#&nbsp;</div></td>
    <td><div align="center" class="style4">#CAF_Compliant#</div></td>
    <td><div align="center" class="style4">#eoedate#</div></td>
    <td><div align="center" class="style4">#eoe_sla#</div></td>
    <td><div align="center" class="style4">#EOE_Compliant#</div></td>
    <td><div align="center" class="style4">#notes#</div></td>
    <td><div align="center" class="style4">&nbsp;</div></td>
  </tr>
</cfoutput>  
</table>
