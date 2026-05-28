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

<SCRIPT LANGUAGE="JavaScript">
<!--
function validateForm(objForm)
{
	var returnStatus = 1;
	
	if (objForm.StartDate.value.length ==0) {
		alert("Please enter the Start Date");
		returnStatus = 0;
	};
	
	if (objForm.EndDate.value.length ==0) {
		alert("Please enter the End Date");
		returnStatus = 0;
	};
	
	if (objForm.EmpID.selectedIndex == 0) {
		alert("Please select the Storage Engineer");
		returnStatus = 0;
	};
	
	if (objForm.ProjectType.selectedIndex == 0) {
		alert("Please select the Vacation Type");
		returnStatus = 0;
	};
	
	if (returnStatus) {
		objForm.submit();
	}
}
// -->
</SCRIPT>


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
<!--- form allows to select an engineer to schedule a vaction--->

<cfquery name="SE" datasource="SBSEFD">
SELECT EmpID,Lname, Fname, EmailAddress, Type
FROM dbo.SE
WHERE status = '1'
ORDER by Lname ASC
</cfquery>

<cfquery name="lookup" datasource="SBSEFD">
select *
from dbo.Proj_Type
Where (Proj_Type_ID='58') OR (Proj_Type_ID='59') OR (Proj_Type_ID='60')
</cfquery>

  <form name="form" method="post" action="./addvacation.cfm">
    <table width="400" border="0">
      
      <tr>
        <th colspan="3" bgcolor="#CCCCCC" class="pageheader" scope="row">Vacation Scheduling </th>
      </tr>
      <tr>
        <th width="103" class="maincontent" scope="row"><div align="right"><strong>Start Date: </strong></div></th>
        <td width="152" class="maincontent"><CF_CT_DATE_INPUT NAME="StartDate"></td>
        <td width="131" class="maincontent">&nbsp;</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>End Date: </strong></div></th>
        <td class="maincontent"><CF_CT_DATE_INPUT NAME="EndDate"></td>
        <td class="maincontent">&nbsp;</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>SE:</strong></div></th>
        <td colspan="2" class="maincontent">
		  <strong>
		  <select name="EmpID">
		      <option value="0">Select One</option>
		      <cfoutput query="SE">
		          <option value="#EmpID#">#Lname#,#Fname#(#Type#)</option>
		          </cfoutput>
		      </select>
		  </strong> </td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Type of time off:</strong></div></th>
        <td colspan="2" class="maincontent">
		<select name="ProjectType">
		<option value="0">Select One</option>
		<cfoutput query="lookup">
		<option value="#lookup.Proj_Type_ID#">#lookup.Type#</option>
		</cfoutput>
		</select>
		</td>
      </tr>
      <tr>
        <th colspan="3" class="maincontent" scope="row">
		<input type="button" name="Submit" value="    Submit    " onClick="validateForm(document.form)">
		</th>
        </tr>
    </table>
  </form>

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