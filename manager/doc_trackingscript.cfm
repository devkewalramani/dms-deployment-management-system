<!---
This script posts the completion dates for CAF's,EOE's and Project Completion Dates. reffering page doc_trackingselected.cfm
--->

<head>

<title></title>

<style type="text/css">
<!--
.locheader {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #FFFFFF;
}
.maincontent {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: normal;
	color: #000000;
}
.copyrightnfo {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	font-weight: bold;
	color: #CCCCCC;
}
.pageheader {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #CC3300;
}
.style1 {	font-size: 10px;
	font-weight: normal;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #999999;
}
.style23 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: normal;}
-->
</style>

<style type="text/css">
<!--
.style24 {color: #0000FF}
-->
</style>

</head>


<body link="#333366">

    
<!--- Insert Project Completetion --->
<cfif #form.type# eq '1'>
    
<cfquery name="check" datasource="SBSEFD">
Select Count(*) as ctr
from dbo.document_tracking
where RID = '#Form.RID#'
</cfquery>
    
<cfoutput query="check">
<cfif #ctr# eq '1'>
    
<cfquery name="updateproj" datasource="SBSEFD">
Update dbo.document_tracking Set Proj_Complete_Date = '#Form.Proj_Complete_Date#' Where RID = '#Form.Rid#'
</cfquery>
<br><center>
<span class="maincontent">Project Completion updated for project #Form.RID#</span>
</center>
  
<cfelseif #ctr# eq '0'>
<!--- insert into tracking table --->    
<cfquery name="add" datasource="SBSEFD">
INSERT INTO dbo.document_tracking (RID,Proj_Complete_Date) VALUES ('#Form.RID#','#Form.Proj_Complete_Date#')
</cfquery>
<!--- update status --->
<cfquery name="updateschedule" datasource="SBSEFD">
UPDATE dbo.schedule SET Status = 'Completed' WHERE RID = '#form.RID#'
</cfquery>
<br><center>
<span class="maincontent">Project Completion added for project #Form.RID#</span>
</center>
</cfif>
</cfoutput>
</cfif>


<!--- Insert CAF Completetion --->
<cfif #form.type# eq '2'>
    
<cfquery name="check" datasource="SBSEFD">
Select Count(*) as ctr
from dbo.document_tracking
where RID = '#Form.RID#'
</cfquery>
    
<cfoutput query="check">
<cfif #ctr# eq '1'>
    
<cfquery name="updateproj" datasource="SBSEFD">
Update dbo.document_tracking Set CAF_Complete_Date = '#Form.CAF_Complete_Date#',CAF_Compliant = '#Form.CAF_Compliant#' Where RID = '#Form.Rid#'
</cfquery>
<br><center>
<span class="maincontent">CAF Completion updated for project #Form.RID#</span>
</center>
  
<cfelseif #ctr# eq '0'>
<br>
<center><span class="maincontent"><font color="##FF0000"><strong>
Project is not set to completed status.
<br>
Please Complete Project before updating the CAF completion date and time
</strong></font></span></center>
</cfif>
</cfoutput>
</cfif>


<!--- Insert EOE Completetion --->  
<cfif #form.type# eq '3'>
    
<cfquery name="check" datasource="SBSEFD">
Select Count(*) as ctr
from dbo.document_tracking
where RID = '#Form.RID#'
</cfquery>
    
<cfoutput query="check">
<cfif #ctr# eq '1'>
    
<cfquery name="updateproj" datasource="SBSEFD">
Update dbo.document_tracking Set EOE_Complete_Date = '#Form.EOE_Complete_Date#',EOE_Compliant = '#Form.EOE_Compliant#' Where RID = '#Form.Rid#'
</cfquery>
<br><center><span class="maincontent">EOE Completion updated for project #Form.RID#</span></center>
  
<cfelseif #ctr# eq '0'>
<br>
<center><span class="maincontent"><font color="##FF0000"><strong>
Project is not set to completed status.
<br>
Please Complete Project before updating the EOE completion date and time
</strong></font></span></center>
</cfif>
</cfoutput>
    
</cfif>

<!--- Insert Notes  --->  
<cfif #form.type# eq '4'>
    
<cfquery name="check" datasource="SBSEFD">
Select Count(*) as ctr
from dbo.document_tracking
where RID = '#Form.RID#'
</cfquery>
    
<cfoutput query="check">
<cfif #ctr# eq '1'>
    
<cfquery name="updateproj" datasource="SBSEFD">
Update dbo.document_tracking Set notes = '#Form.notes#' Where RID = '#Form.Rid#'
</cfquery>
<br><center><span class="maincontent">Notes updated for project #Form.RID#</span></center>
  
<cfelseif #ctr# eq '0'>
<br>
<center><span class="maincontent"><font color="##FF0000"><strong>
Project is not set to completed status.
<br>
Please Complete Project before adding Notes
</strong></font></span></center>
</cfif>
</cfoutput>
    
</cfif>
</body>
