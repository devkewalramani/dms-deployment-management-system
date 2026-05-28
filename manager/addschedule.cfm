<!-- InstanceBegin template="/Templates/dms_management.dwt" codeOutsideHTMLIsLocked="false" --><head>
<!-- InstanceBeginEditable name="title" -->
<title></title>
<!-- InstanceEndEditable -->
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
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
<!--
.style2 {font-size: 12px}
-->
</style>

<!-- InstanceEndEditable -->
</head>


<body link="#333366">
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="742"><img src="../pics/DMSLogoLong.jpg" width="741" height="70"></td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" height="25" bgcolor="#949DA1">&nbsp;</td>
    <td bgcolor="#949DA1" class="locheader" width="612">//<a href="http://www.sbsplanet.com/"><font color="#FFFFFF">SBS 
      Planet</font></a> //<a href="index.htm"><font color="#FFFFFF">My Planet</font></a>    </td>
  </tr>
</table>
<table width="742" height="379" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="126" height="447" align="left" valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
<!-- #BeginLibraryItem "/Library/NewNavMain.lbi" -->
<img src="../pics/scheduling.jpg" name="Image1" width="123" height="30" border="0" id="Image1"><a href="schedule.cfm" ><img src="../pics/sub_add_schedule.jpg" name="Image1a" width="123" height="17" border="0" id="Image1a"></a><a href="vacation.cfm" ><img src="../pics/sub_add_vacation.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><a href="search.cfm" ><img src="../pics/sub_search_schedule.jpg" name="Image1b" width="123" height="17" border="0" id="Image1b"></a><a href="schedule/viewschedule.cfm"><img src="../pics/sub_view_schedule.jpg" name="Image1d" width="123" height="17" border="0" id="Image1d"></a><a href="schedule/choose.cfm" target="_blank" ><img src="../pics/sub_eng_schedule.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><img src="../pics/travel.jpg" name="Image2" width="123" height="30" border="0" id="Image2"><a href="trsearch.cfm" ><img src="../pics/sub_sendtr_travel.jpg" name="Image2a" width="123" height="17" border="0" id="Image2a"></a><a href="trpipline.cfm"><img src="../pics/sub_pending_travel.jpg" name="Image2b" width="123" height="17" border="0" id="Image2b"></a><img src="../pics/tasklist.jpg" name="Image3" width="123" height="30" border="0" id="Image3"><a href="tlsearch.cfm" ><img src="../pics/sub_submit_tasklist.jpg" name="Image3a" width="123" height="17" border="0" id="Image3a"></a><a href="tasklist_tracking.cfm" target="_blank" ><img src="../pics/sub_outstanding_tasklist.jpg" name="Image3b" width="123" height="17" border="0" id="Image3b"></a><img src="../pics/reporting.jpg" name="Image4" width="123" height="30" border="0" id="Image4"><a href="cancel_dates.cfm" ><img src="../pics/sub_cancel_report.jpg" name="Image4a" width="123" height="17" border="0" id="Image4a"></a><a href="loe_dates.cfm" ><img src="../pics/sub_loe_report.jpg" name="Image4b" width="123" height="17" border="0" id="Image4b"></a><a href="utilization_daterange.cfm" ><img src="../pics/sub_util_report.jpg" name="Image4c" width="123" height="17" border="0" id="Image4c"></a><a href="daterange.cfm" ><img src="../pics/sub_bu_report.jpg" name="Image4d" width="123" height="17" border="0" id="Image4d"></a><a href="metric/index.cfm" ><img src="../pics/sub_metric_report.jpg" name="Image4e" width="123" height="17" border="0" id="Image4e"></a><a href="tam_eoe_dates.cfm" ><img src="../pics/sub_tameoe_report.jpg" name="Image4f" width="123" height="17" border="0" id="Image4f"></a><img src="../pics/admin.jpg" name="Image5" width="123" height="30" border="0" id="Image5"><a href="adddm.cfm" ><img src="../pics/sub_adddm_admin.jpg" name="Image5c" width="123" height="17" border="0" id="Image5c"></a><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<!---
This script adds the project to the schedule and travel tables
--->

<!--- look up region  --->
<cfquery name="region_lookup" datasource="SBSEFD">
Select Region
from dbo.regions
where State = '#form.ProjectState#'
</cfquery>

<!--- lookup employee   --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmpID, Lname, Fname, EmailAddress,Region,Type
FROM dbo.SE
WHERE EmpID = #Form.EmpID#
</cfquery>

<!---  lookup project type --->
<cfquery name="ptype" datasource="SBSEFD">
SELECT *
FROM dbo.Proj_Type
WHERE Proj_Type_ID='#form.ProjectType#'
</cfquery>

<!--- define region variables  --->
<cfif '#region_lookup.region#' is '#SE_lookup.region#'>
<cfset in_region = 'Y'>
<cfelse>
<cfset in_region = 'N'>
</cfif>

<!--- assign name variables  --->
<cfset Lname = "#SE_lookup.Lname#"> 
<cfset Fname = "#SE_lookup.Fname#">

<!--- concatanate time fields hour plus AM/PM  --->
<cfset StartTime = "#Form.StartTime1# #Form.StartTime2#">
<cfset EndTime = "#Form.EndTime1# #Form.EndTime2#">

<!--- assign project type variables  --->
<cfset projtype = '#ptype.type#'>
<cfset projtypeid = '#ptype.Proj_Type_ID#'>

<!--- assign and format date fields  --->
<cfset DateAdded1 = Now()>
<cfset DateAdded = #DateFormat(DateAdded1,'mm/dd/yyyy')#>
<cfset TRDate1 = Now()>
<cfset TRDate = #DateFormat(TRDate1,'mm/dd/yyyy')#>

<!--- check to see if the TR is being sent with urgent status and assign the accordingly  --->
<cfif #Form.Delivery# is 'Urgent'>
<cfset d_status = 'URGENT'>
<cfelse>
<cfset d_status = ''>
</cfif>

<!--- execute database post  --->
<cfoutput>

<cfif #Form.Travel# is 'Y'> <!--- if a travel request is being sent   --->
<!--- add to the schedule table  --->
<cfquery name="add" datasource="SBSEFD">
SET NOCOUNT ON
INSERT INTO dbo.Schedule (DispatchID,OmniNum,projcode,dell_pid,PO_Num,ProjectName,ProjectCity,ProjectState,ProjectZip,In_Region,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,SE_Type,ProjectType,Status,LOE_Price,Travel_Price,Bill_Travel,se_flag,dell_sku,ProjectSummary,ProjectNotes,DateAdded,DM) VALUES ('#Form.DispatchID#','#Form.OmniNum#','#Form.projcode#','#Form.dell_pid#','#Form.PO_Num#','#Form.ProjectName#','#Form.ProjectCity#','#ProjectState#','#ProjectZip#','#in_region#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#','#SE_Lookup.type#','#projtypeid#','#Form.Status#','#Form.LOE_Price#','#Form.Travel_Price#','#Form.Bill_Travel#','#Form.se_flag#','#Form.dell_sku#','#Form.ProjectSummary#','#Form.ProjectNotes#','#DateAdded#','#Form.DM#')
SELECT @@Identity AS newId      
SET NOCOUNT OFF   
</cfquery>

<center><font color="##0000FF" class="style2">#Form.DispatchID# #Form.ProjectName# for #SE_lookup.Lname#,#SE_lookup.Fname# has been added!</font></center>
<br>
<!--- add to the travel table according the record id (RID) created on the schedule insert above  --->
<cfquery name="addtravel" datasource="SBSEFD">
INSERT INTO dbo.Travel (RID,DispatchID,OmniNum,ProjectName,ProjectCity,ProjectState,ProjectZip,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,TravelNotes,ProjectSummary,TR_Status,Flight,Hotel,Rental,ProjectType,TRDate) VALUES ('#add.newId#','#Form.DispatchID#','#Form.OmniNum#','#Form.ProjectName#','#Form.ProjectCity#','#Form.ProjectState#','#Form.ProjectZip#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#','#TravelNotes#','#Form.ProjectSummary#','Submitted','#Form.Flight#','#Form.Hotel#','#Form.Rental#','#projtypeid#','#TRDate#')
</cfquery>
<!--- send travel request email  --->
<cfmail from = "Scheduling@SBSPlanet.com" To = "travel@sbsplanet.com,#SE_lookup.EmailAddress#" cc="Scheduling@SBSPlanet.com"
Subject = "#d_status# Travel Request - #Form.ProjectName# - #Form.StartDate# ">
   <cfmailpart 
      type="html">
<br>
<strong>Project Type</strong> #projtype#
<br>	  
<strong>SBS Project Code:</strong> #Form.projcode#
<br>
<table width="100%" border="1">
  <tr>
    <th bgcolor="##FFCC66" class="style2" scope="col">Dexterra ID </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Omni</th>
	<th bgcolor="##FFCC66" class="style2" scope="col">PO Number</th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Client Name </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">City</th>
    <th bgcolor="##FFCC66" class="style2" scope="col">State</th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Zip</th>	
    <th bgcolor="##FFCC66" class="style2" scope="col">Start Date </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Start Time </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Return Date </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Site Departure Date </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Consultant</th>
	<th bgcolor="##FFCC66" class="style2" scope="col">Type</th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Flight requird </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Hotel Rquired </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Rental Car Required </th>
    <th bgcolor="##FFCC66" class="style2" scope="col">Project Summary </th>
  </tr>
  <tr>
    <td class="style2">#Form.DispatchID#</td>
    <td class="style2">#Form.OmniNum#</td>
	<td class="style2">#Form.PO_Num#</td>
    <td class="style2">#Form.ProjectName#</td>
    <td class="style2">#Form.ProjectCity#</td>
	<td class="style2">#Form.ProjectState#</td>
	<td class="style2">#Form.ProjectZip#</td>
    <td class="style2">#Form.StartDate#</td>
    <td class="style2">#StartTime#</td>
    <td class="style2">#Form.EndDate#</td>
    <td class="style2">#EndTime#</td>
    <td class="style2">#Fname# #Lname#</td>
	<td class="style2">#SE_Lookup.type#</td>
    <td class="style2">#Form.Flight#</td>
    <td class="style2">#Form.Hotel#</td>
    <td class="style2">#Form.Rental#</td>
    <td class="style2">#Form.ProjectSummary#</td>
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

<center><font color="##0000FF" class="style2">Travel Request has been Submitted</font></center>
<br>

<!--- create project directory code as long as NA was not selected --->
<cfif '#Form.DirList#' neq 'NA'>
	<cfset dirdate=#dateformat(Form.StartDate,'mm.dd.yyyy')#>
	<cfset dirname=#Form.ProjectName# & '-' & #dirdate# & '-' & #Form.projcode#>

	<cfcache action="flush">
	<cfset projdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\' & #dirname#>
	<cfset chdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\'>

	<cflock name="dir_lock" type="readonly" timeout="5">
	  <cfdirectory action="list" name="dir_check" directory="#chdir#">
	</cflock>
 
	<!--- Check to see if the directory exists --->
	<cfset dir_exists='n'>

	<cfloop query="dir_check">
 	 <cfif dir_check.Name eq #dirname#>
   	 <cfset dir_exists='y'>
   	<center><span class="style2">Project Directory already existes and was not re-created</span></center>
  	</cfif>
	</cfloop>

	<cfif dir_exists eq 'n'>
  	<cflock name="dir_lock" type="exclusive" timeout="5">
   	 <cfdirectory action="create" directory="#projdir#">
 	 </cflock>
 	<center><span class="style2">Project Directory Created</span></center>
	</cfif>
</cfif>

</cfif>

<cfif #Form.Travel# is 'N'> <!--- if we are going to queue travel and not send out just yet  --->
<!--- add to the schedule table  --->
<cfquery name="add" datasource="SBSEFD">
SET NOCOUNT ON
INSERT INTO dbo.Schedule (DispatchID,OmniNum,projcode,dell_pid,PO_Num,ProjectName,ProjectCity,ProjectState,ProjectZip,In_Region,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,SE_Type,ProjectType,Status,LOE_Price,Travel_Price,Bill_Travel,se_flag,dell_sku,ProjectSummary,ProjectNotes,DateAdded,DM) VALUES ('#Form.DispatchID#','#Form.OmniNum#','#Form.projcode#','#Form.dell_pid#','#Form.PO_Num#','#Form.ProjectName#','#Form.ProjectCity#','#Form.ProjectState#','#Form.ProjectZip#','#in_region#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#','#SE_Lookup.type#','#projtypeid#','#Form.Status#','#Form.LOE_Price#','#Form.Travel_Price#','#Form.Bill_Travel#','#Form.se_flag#','#Form.dell_sku#','#Form.ProjectSummary#','#Form.ProjectNotes#','#DateAdded#','#Form.DM#')
SELECT @@Identity AS newId      
SET NOCOUNT OFF
</cfquery>

<center><span class="style2"><font color="##FF0000">#Form.DispatchID# #Form.ProjectName# for #SE_lookup.Lname#,#SE_lookup.Fname# has been added!</font></span></center>
<br>

<!--- add to the travel table according the record id (RID) created on the schedule insert above  --->
<cfquery name="addtravel" datasource="SBSEFD">
INSERT INTO dbo.Travel (RID,DispatchID,OmniNum,ProjectName,ProjectCity,ProjectState,ProjectZip,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,TravelNotes,ProjectSummary,TR_Status,Flight,Hotel,Rental,ProjectType) VALUES ('#add.newId#','#Form.DispatchID#','#Form.OmniNum#','#Form.ProjectName#','#Form.ProjectCity#','#Form.ProjectState#','#Form.ProjectZip#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#', '#TravelNotes#', '#Form.ProjectSummary#','Not Submitted', '#Form.Flight#','#Form.Hotel#','#Form.Rental#', '#projtypeid#')
</cfquery>

<center>
  <span class="style2"><font color="##FF0000">Travel Request has been <strong>NOT SUBMITTED!</strong></font></span>
</center>
<br>

<!--- create project directory code as long as NA was not selected --->
<cfif '#Form.DirList#' neq 'NA'>
	<cfset dirdate=#dateformat(Form.StartDate,'mm.dd.yyyy')#>
	<cfset dirname=#Form.ProjectName# & '-' & #dirdate# & '-' & #Form.projcode#>

	<cfcache action="flush">
	<cfset projdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\' & #dirname#>
	<cfset chdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\'>

	<cflock name="dir_lock" type="readonly" timeout="5">
 	 <cfdirectory action="list" name="dir_check" directory="#chdir#">
	</cflock>
 
	<!--- Check to see if the directory exists --->
	<cfset dir_exists='n'>

	<cfloop query="dir_check">
 	 <cfif dir_check.Name eq #dirname#>
  	  <cfset dir_exists='y'>
  	  <center><span class="style2">Project Directory already existes and was not re-created</span></center>
  	</cfif>
	</cfloop>

	<cfif dir_exists eq 'n'>
 	 <cflock name="dir_lock" type="exclusive" timeout="5">
   	 <cfdirectory action="create" directory="#projdir#">
  	</cflock>
 	 <center><span class="style2">Project Directory Created</span></center>
	</cfif>
</cfif>

</cfif>

<cfif #Form.Travel# is 'NA'> <!--- If travel is not applicable but we still want to schedule --->

<!--- add to the schedule table  --->
<cfquery name="add" datasource="SBSEFD">
SET NOCOUNT ON
INSERT INTO dbo.Schedule (DispatchID,OmniNum,projcode,dell_pid,PO_Num,ProjectName,ProjectCity,ProjectState,ProjectZip,In_Region,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,SE_Type,ProjectType,Status,LOE_Price,Travel_Price,Bill_Travel,se_flag,dell_sku,ProjectSummary,ProjectNotes,DateAdded,DM) VALUES ('#Form.DispatchID#','#Form.OmniNum#','#Form.projcode#','#Form.dell_pid#','#Form.PO_Num#','#Form.ProjectName#','#Form.ProjectCity#','#Form.ProjectState#','#Form.ProjectZip#','#in_region#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#','#SE_Lookup.type#','#projtypeid#','#Form.Status#','#Form.LOE_Price#','#Form.Travel_Price#','#Form.Bill_Travel#','#Form.se_flag#','#Form.dell_sku#','#Form.ProjectSummary#','#Form.ProjectNotes#','#DateAdded#','#Form.DM#')
SELECT @@Identity AS newId      
SET NOCOUNT OFF
</cfquery>

<center>
  <span class="style2"><font color="##FF0000">#Form.DispatchID# #Form.ProjectName# for #SE_lookup.Lname#,#SE_lookup.Fname# has been added!</font></span>
</center>
<br>

<!--- add to the travel table according the record id (RID) created on the schedule insert above  --->
<cfquery name="addtravel" datasource="SBSEFD">
INSERT INTO dbo.Travel (RID,DispatchID,OmniNum,ProjectName,ProjectCity,ProjectState,ProjectZip,StartDate,StartTime,EndDate,EndTime,EmpID,SE_Lname,SE_Fname,ProjectSummary,TR_Status,ProjectType) VALUES ('#add.newId#','#Form.DispatchID#','#Form.OmniNum#','#Form.ProjectName#','#Form.ProjectCity#','#Form.ProjectState#','#Form.ProjectZip#','#Form.StartDate#','#StartTime#','#Form.EndDate#','#EndTime#','#Form.EmpID#','#Lname#','#Fname#','#Form.ProjectSummary#','NA','#projtypeid#')
</cfquery>

<center>
  <span class="style2"><font color="##FF0000">Travel Request has been <strong>NOT SUBMITTED!</strong></font></span>
</center>
<br>
<!--- create project directory code as long as NA was not selected --->
<cfif '#Form.DirList#' neq 'NA'>
	<cfset dirdate=#dateformat(Form.StartDate,'mm.dd.yyyy')#>
	<cfset dirname=#Form.ProjectName# & '-' & #dirdate# & '-' & #Form.projcode#>

	<cfcache action="flush">
	<cfset projdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\' & #dirname#>
	<cfset chdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.DirList# & '\'>

	<cflock name="dir_lock" type="readonly" timeout="5">
 	 <cfdirectory action="list" name="dir_check" directory="#chdir#">
	</cflock>
 
	<!--- Check to see if the directory exists --->
	<cfset dir_exists='n'>

	<cfloop query="dir_check">
 	 <cfif dir_check.Name eq #dirname#>
  	  <cfset dir_exists='y'>
  	  <center><span class="style2">Project Directory already existes and was not re-created</span></center>
  	</cfif>
	</cfloop>

	<cfif dir_exists eq 'n'>
 	 <cflock name="dir_lock" type="exclusive" timeout="5">
   	 <cfdirectory action="create" directory="#projdir#">
  	</cflock>
 	 <center><span class="style2">Project Directory Created</span></center>
	</cfif>
	</cfif>
</cfif>


</cfoutput>
<!-- InstanceEndEditable -->	</td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" bgcolor="#949DA1">&nbsp;</td>
    <td width="613" bgcolor="#949DA1"><div align="center" class="copyrightnfo"><img src="../pics/copyright.gif" width="461" height="18" border="0" usemap="#Map">
        <map name="Map">
          <area shape="rect" coords="436,2,454,16" href="http://www.longitudegroup.com">
        </map>
    </div></td>
  </tr>
</table>
</body>
<!-- InstanceEnd -->