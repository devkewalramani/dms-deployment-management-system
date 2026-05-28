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

<cfquery name="SE" datasource="SBSEFD">
SELECT EmpID,Lname, Fname, EmailAddress, Type
FROM dbo.SE
WHERE status = '1'
ORDER by Lname ASC
</cfquery>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validateForm(objForm)
{
	var returnStatus = 1;
	
	if (objForm.dispatchid.value.length ==0) {
		alert("Please enter the Dexterra dispatch #");
		returnStatus = 0;
	};
	
	if (objForm.OmniNum.value.length ==0) {
		alert("Please enter the OMNI #");
		returnStatus = 0;
	};
	
	if (objForm.projcode.value.length ==0) {
		alert("Please enter the SBS Project Code");
		returnStatus = 0;
	};
	
	if (objForm.ProjectName.value.length ==0) {
		alert("Please enter the Project Name");
		returnStatus = 0;
	};
	
	if (objForm.ProjectCity.value.length ==0) {
		alert("Please enter the Project City");
		returnStatus = 0;
	};
	
	if (objForm.ProjectState.selectedIndex == 0) {
		alert("Please select the Project State");
		returnStatus = 0;
	};
	
	if (objForm.ProjectZip.value.length ==0) {
		alert("Please enter the Project Zip Code");
		returnStatus = 0;
	};
	
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
		alert("Please select the Project Type");
		returnStatus = 0;
	};
	
	if (objForm.Travel.selectedIndex == 0) {
		alert("Please select if a Travel Request should be sent");
		returnStatus = 0;
	};
	
	if (objForm.DirList.selectedIndex == 0) {
		alert("Please select the Directory for the Project Folder");
		returnStatus = 0;
	};
	
	if (objForm.ProjectSummary.selectedIndex == 0) {
		alert("Please select the Project Summary");
		returnStatus = 0;
	};
	
	if (objForm.ProjectNotes.value.length ==0) {
		alert("Please enter any Project Notes (Type none for no notes)");
		returnStatus = 0;
	};
	
	if (returnStatus) {
		objForm.submit();
	}
}
// -->
</SCRIPT>

<style type="text/css">
<!--
.style10 {
	color:#FF0000; 
}
.style25 {font-size: 10px; color: #000000; font-family: Verdana, Arial, Helvetica, sans-serif;}
.style27 {color: #FF0000; font-family: Verdana, Arial, Helvetica, sans-serif; }
-->
</style>
<!-- InstanceEndEditable -->
</head>


<body link="#333366">
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="742"><img src="../../pics/DMSLogoLong.jpg" width="741" height="70"></td>
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
<img src="../../pics/scheduling.jpg" name="Image1" width="123" height="30" border="0" id="Image1"><a href="../../manager/schedule.cfm" ><img src="../../pics/sub_add_schedule.jpg" name="Image1a" width="123" height="17" border="0" id="Image1a"></a><a href="../../manager/vacation.cfm" ><img src="../../pics/sub_add_vacation.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><a href="../../manager/search.cfm" ><img src="../../pics/sub_search_schedule.jpg" name="Image1b" width="123" height="17" border="0" id="Image1b"></a><a href="../../manager/schedule/viewschedule.cfm"><img src="../../pics/sub_view_schedule.jpg" name="Image1d" width="123" height="17" border="0" id="Image1d"></a><a href="../../manager/schedule/choose.cfm" target="_blank" ><img src="../../pics/sub_eng_schedule.jpg" name="Image1g" width="123" height="17" border="0" id="Image1g"></a><img src="../../pics/travel.jpg" name="Image2" width="123" height="30" border="0" id="Image2"><a href="../../manager/trsearch.cfm" ><img src="../../pics/sub_sendtr_travel.jpg" name="Image2a" width="123" height="17" border="0" id="Image2a"></a><a href="../../manager/trpipline.cfm"><img src="../../pics/sub_pending_travel.jpg" name="Image2b" width="123" height="17" border="0" id="Image2b"></a><img src="../../pics/tasklist.jpg" name="Image3" width="123" height="30" border="0" id="Image3"><a href="../../manager/tlsearch.cfm" ><img src="../../pics/sub_submit_tasklist.jpg" name="Image3a" width="123" height="17" border="0" id="Image3a"></a><a href="../../manager/tasklist_tracking.cfm" target="_blank" ><img src="../../pics/sub_outstanding_tasklist.jpg" name="Image3b" width="123" height="17" border="0" id="Image3b"></a><img src="../../pics/reporting.jpg" name="Image4" width="123" height="30" border="0" id="Image4"><a href="../../manager/cancel_dates.cfm" ><img src="../../pics/sub_cancel_report.jpg" name="Image4a" width="123" height="17" border="0" id="Image4a"></a><a href="../../manager/loe_dates.cfm" ><img src="../../pics/sub_loe_report.jpg" name="Image4b" width="123" height="17" border="0" id="Image4b"></a><a href="../../manager/utilization_daterange.cfm" ><img src="../../pics/sub_util_report.jpg" name="Image4c" width="123" height="17" border="0" id="Image4c"></a><a href="../../manager/daterange.cfm" ><img src="../../pics/sub_bu_report.jpg" name="Image4d" width="123" height="17" border="0" id="Image4d"></a><a href="../../manager/metric/index.cfm" ><img src="../../pics/sub_metric_report.jpg" name="Image4e" width="123" height="17" border="0" id="Image4e"></a><a href="../../manager/tam_eoe_dates.cfm" ><img src="../../pics/sub_tameoe_report.jpg" name="Image4f" width="123" height="17" border="0" id="Image4f"></a><img src="../../pics/admin.jpg" name="Image5" width="123" height="30" border="0" id="Image5"><a href="../../manager/adddm.cfm" ><img src="../../pics/sub_adddm_admin.jpg" name="Image5c" width="123" height="17" border="0" id="Image5c"></a><!-- #EndLibraryItem --><img src="../../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<center>
  <form name="form" method="post" action="./addschedule.cfm">
    <table width="616" border="0">
      <tr>
        <th colspan="3" bgcolor="#FFFFFF" scope="row">
		<div align="left"><span class="maincontent style10"><strong>*</strong> - required</span>  </div>	</th>
      </tr>
      <tr>
        <th colspan="3" bgcolor="#CCCCCC" class="pageheader" scope="row">General Dispatch Information</th>
      </tr>
      <tr>
        <th width="128" class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span><span class="style25">Dispatch #:</span> </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <input name="dispatchid" type="text" size="10" maxlength="10">
          <span class="maincontent style10">*</span>OMNI Number:
           <input name="OmniNum" type="text" id="OmniNum" size="10" maxlength="10">
           <span class="style10">*</span> SBS Project Code      
           <input name="projcode" type="text" id="projcode" size="10" maxlength="10">
        </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>Project Name: </strong></div></th>
        <td colspan="2" class="maincontent"><input name="ProjectName" type="text" id="ProjectName" size="50" maxlength="50"></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>City: </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <input name="ProjectCity" type="text" id="ProjectCity" size="30" maxlength="50">
          <span class="maincontent style10">*</span>State: 
		  <select name="ProjectState" width="15">
                    <option value="0">--</option>
					<option value="International">International</option>
                    <option value="AK">AK</option>
                    <option value="AL">AL</option>
                    <option value="AR">AR</option>
                    <option value="AZ">AZ</option>
                    <option value="CA">CA</option>
                    <option value="CO">CO</option>
                    <option value="CT">CT</option>
                    <option value="DC">DC</option>
                    <option value="DE">DE</option>
                    <option value="FL">FL</option>
                    <option value="GA">GA</option>
                    <option value="HI">HI</option>
                    <option value="IA">IA</option>
                    <option value="ID">ID</option>
                    <option value="IL">IL</option>
                    <option value="IN">IN</option>
                    <option value="KS">KS</option>
                    <option value="KY">KY</option>
                    <option value="LA">LA</option>
                    <option value="MA">MA</option>
                    <option value="MD">MD</option>
                    <option value="ME">ME</option>
                    <option value="MI">MI</option>
                    <option value="MN">MN</option>
                    <option value="MO">MO</option>
                    <option value="MS">MS</option>
                    <option value="MT">MT</option>
                    <option value="NC">NC</option>
                    <option value="ND">ND</option>
                    <option value="NE">NE</option>
                    <option value="NH">NH</option>
                    <option value="NJ">NJ</option>
                    <option value="NM">NM</option>
                    <option value="NV">NV</option>
                    <option value="NY">NY</option>
                    <option value="OH">OH</option>
                    <option value="OK">OK</option>
                    <option value="OR">OR</option>
                    <option value="PA">PA</option>
                    <option value="RI">RI</option>
                    <option value="SC">SC</option>
                    <option value="SD">SD</option>
                    <option value="TN">TN</option>
                    <option value="TX">TX</option>
                    <option value="UT">UT</option>
                    <option value="VA">VA</option>
                    <option value="VT">VT</option>
                    <option value="WA">WA</option>
                    <option value="WI">WI</option>
                    <option value="WV">WV</option>
                    <option value="WY">WY</option>
          </select>
		  <span class="maincontent style10">*</span>Zip Code:
		  <input name="ProjectZip" type="text" id="ProjectZip" size="6" maxlength="6">
        </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>Start Date: </strong></div></th>
        <td width="116" class="maincontent"><CF_CT_DATE_INPUT NAME="StartDate"></td>
        <td width="515" class="maincontent"><strong>Start Time: 
            <select name="StartTime1">
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
              </select>
            <select name="StartTime2" id="StartTime2">
              <option value="AM">AM</option>
              <option value="PM">PM</option>
            </select>        
            </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>End Date: </strong></div></th>
        <td class="maincontent"><CF_CT_DATE_INPUT NAME="EndDate"></td>
        <td class="maincontent"><strong>End Time: 
          
            <select name="EndTime1">
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
                </select>
            <select name="EndTime2" id="EndTime2">
              <option value="AM">AM</option>
              <option value="PM">PM</option>
              </select>
        </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>SE:</strong></div></th>
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
        <th class="maincontent" scope="row"><div align="right"><strong><span class="maincontent style10">*</span>Project Type: </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <select name="ProjectType">
            <option value="0">Select One</option>
            <option value="EFD">EFD</option>
            <option value="DPS">DPS</option>
            <option value="EFD/LOE">EFD/LOE</option>
            <option value="CommVault">CommVault</option>
            <option value="OSSI">OSSI</option>
            <option value="EMC">EMC</option>
            <option value="Vacation">Vacation</option>
            <option value="Training">Training</option>
            <option value="Shadow">Shadow</option>
			<option value="Direct">Direct</option>
			<option value="Corp Visit">Corp Visit</option>
			<option value="Other">Other</option>
            </select>
        </strong> </td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Status:</strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <select name="Status">
            <option value="Scheduled">Scheduled</option>
            <option value="Tentative">Tentative</option>
            </select>
        </strong></td>
      </tr>
      <tr>
        <th colspan="3" bgcolor="#CCCCCC" class="pageheader" scope="row">Travel Section </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="style27">*</span>Send TR: </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <select name="Travel">
            <option value="0">Select One</option>
            <option value="Y">Yes</option>
            <option value="N">No</option>
            <option value="NA" class="style10">NA</option>
            </select>
          Delivery:
          <select name="Delivery">
              <option value="Normal">Normal</option>
              <option value="Urgent">Urgent</option>
                    </select>
        </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row">&nbsp;</th>
        <td colspan="2" class="maincontent"><strong>Flight
            <select name="Flight">
              <option value="">Select One</option>
              <option value="Y">Yes</option>
              <option value="N">No</option>
                      </select>
          Hotel
          <select name="Hotel">
              <option value="">Select One</option>
              <option value="Y">Yes</option>
              <option value="N">No</option>
                    </select>
          Car Rental 
          <select name="Rental">
              <option value="">Select One</option>
              <option value="Y">Yes</option>
              <option value="N">No</option>
                    </select>
        </strong></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Travel Notes: </strong></div></th>
        <td colspan="2" class="maincontent"><input name="TravelNotes" type="text" size="80" maxlength="100"> </td>
      </tr>
      <tr>
        <th colspan="3" bgcolor="#CCCCCC" class="pageheader" scope="row">LOE Information </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>LOE AMT $: </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <input name="LOE_Price" type="text" size="10" maxlength="10"> 
          TRAVEL $: 
          <input name="Travel_Price" type="text" size="10" maxlength="10">
          TRAVEL BILLABLE? 
		  <select name="Bill_Travel">
		    <option value="Y">Yes</option>
		    <option value="N">No</option>
		      </select>
        </strong></td>
      </tr>
      <tr>
        <th colspan="3" class="maincontent" scope="row"><strong>SE REVENUE REPORTABLE? 
            <select name="se_flag" id="se_flag">
              <option value="Y">Yes</option>
              <option value="N">No</option>
              </select> 
          Are there regular Dell SKU's in addition?
          <label>
		  <select name="dell_sku">
            <option value="NA">--</option>
            <option value="Yes">Yes</option>
          </select>
          </label>
        </strong></th>
      </tr>
      <tr>
        <th colspan="3" bgcolor="#CCCCCC" class="pageheader" scope="row">Project Information </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="style27">*</span>Project Summary:</strong></div></th>
        <td colspan="2"><select name="ProjectSummary">
          <option value="0">Select One</option>
         <option value="Add DAE or Switch">Add DAE or Switch</option>
		 <option value="Add Host">Add Host</option>
		<option value="BPR">BPR</option>
		<option value="Cascade new Switch">Cascade new Switch</option>
		<option value="Custom/LOE">Custom/LOE</option>
		<option value="DAS Imp 1-2">DAS Imp 1-2</option>
		<option value="DAS Imp 3-4">DAS Imp 3-4</option>
		<option value="DAS to SAN upgrade">DAS to SAN upgrade</option>
		<option value="Data Center Move">Data Center Move</option>
		<option value="HPCC Install">HPCC Install</option>
		<option value="Installation Validation">Installation Validation</option>
		<option value="Maintenance">Maintenance</option>
		<option value="Meta Luns">Meta Luns</option>
		<option value="Migration">Migration</option>
		<option value="Mirrorview Impl">Mirrorview Impl</option>
		<option value="Miscellaneous">Miscellaneous</option>
		<option value="PFR">PFR</option>
		<option value="CX Platform Upgrade">CX Platform Upgrade</option>
		<option value="RMSE Impl">RMSE Impl</option>
		<option value="SAN 1-2">SAN 1-2</option>
		<option value="SAN 3-4">SAN 3-4</option>
		<option value="SAN 5-7">SAN 5-7</option>
		<option value="SAN 8-15">SAN 8-15</option>
		<option value="SAN 16-24">SAN 16-24</option>
		<option value="SAN software upgrade CX">SAN software upgrade CX</option>
		<option value="SAN software upgrade FC">SAN software upgrade FC</option>
		<option value="SCSI Cluster">SCSI Cluster</option>
		<option value="Snapview Impl">Snapview Impl</option>
		<option value="Tape Library Install">Tape Library Install</option>
		<option value="VisualSAN Impl">VisualSAN Impl</option>
        </select>          
          <span class="maincontent"><strong><span class="style10">*</span> Project Folder:</strong></span> 
		  <cfcache action="flush">
			<cflock name="dir_lock" type="readonly" timeout="5">
			<cfdirectory action="list" name="dir_check" directory="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\">
			</cflock>
			<select name="DirList">
			<option value="0">Select One</option>
			<cfoutput query="dir_check">
			<option value="#dir_check.Name#">#dir_check.Name#</option>
			</cfoutput>
			</select>		  
		  </td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong><span class="style27">*</span>Project Notes:</strong></div></th>
        <td colspan="2"><textarea name="ProjectNotes" cols="60" rows="5"></textarea></td>
      </tr>
    </table>
    <br>
	<input type="reset" name="reset" value="     Clear     " >
    <input type="button" name="Submit" value="    Submit    " onClick="validateForm(document.form)">
    <br>
  </form>
</center>
<!-- InstanceEndEditable -->	</td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" bgcolor="#949DA1">&nbsp;</td>
    <td width="613" bgcolor="#949DA1"><div align="center" class="copyrightnfo"><img src="../../pics/copyright.gif" width="461" height="18" border="0" usemap="#Map">
        <map name="Map">
          <area shape="rect" coords="436,2,454,16" href="http://www.longitudegroup.com">
        </map>
    </div></td>
  </tr>
</table>
</body>
<!-- InstanceEnd -->