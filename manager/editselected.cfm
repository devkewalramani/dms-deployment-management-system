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
<!---
Form to update a scheduled project
--->

<!--- select everything from the schedule table for the project --->
<cfquery name="schcurrent" datasource="SBSEFD">
SELECT *
FROM dbo.schedule
WHERE RID = '#URL.RID#'
</cfquery>

<!--- select everything from the Travel table for the project --->
<cfquery name="trcurrent" datasource="SBSEFD">
SELECT *
FROM dbo.travel
WHERE RID = '#URL.RID#'
</cfquery>

<!--- lookup all the states to fill a drop down menu --->
<cfquery name="statelookup" datasource="SBSEFD">
SELECT state
FROM dbo.Regions
Order by State ASC
</cfquery>

<!--- lookup employee information to fill a drop down menu--->
<cfquery name="SE" datasource="SBSEFD">
SELECT EmpID,Lname, Fname, EmailAddress, Type
FROM dbo.SE
WHERE status = '1'
ORDER by Lname ASC
</cfquery>

<!--- lookup project type this exculdes "vacation","non vacation" and "blocks" to fill a drop down menu --->
<cfquery name="projtype" datasource="SBSEFD">
SELECT *
FROM dbo.Proj_Type
Where (Proj_Type_ID <> '58') AND (Proj_Type_ID <> '59') AND (Proj_Type_ID <> '60')
order by Type ASC
</cfquery>

<!--- lookup deployment managers to fill a drop down menu --->
<cfquery name="DM_Lookup" datasource="SBSEFD">
Select Lname, Fname
From dbo.DM
Order by Lname ASC
</cfquery>

<!--- lookup project tasks to fill a drop down menu --->
<cfquery name="task" datasource="SBSEFD">
SELECT *
FROM dbo.ProjectTask
order by Project_Task ASC
</cfquery>



<style type="text/css">
<!--
.style25 {font-size: 10px; color: #000000; font-family: Verdana, Arial, Helvetica, sans-serif;}
.style28 {
font-size: 10px;
color: #0000FF
}
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
<center>
<!--- output the query and auto fill the form with what is in the tables --->
<cfoutput query="schcurrent">

<cfquery name="Proj_Type_lookup" datasource="SBSEFD">
Select *
From dbo.Proj_Type
Where Proj_Type_ID='#schcurrent.ProjectType#'
</cfquery>


  <form name="form" method="post" action="./editscript.cfm">
  <input type="hidden" name="rid" value="#RID#">
    <table width="616" border="0">
      
      <tr>
        <th colspan="3" bgcolor="##FFFFFF" class="pageheader" scope="row">UPDATE PROJECT </th>
      </tr>
      <tr>
        <th colspan="3" bgcolor="##CCCCCC" class="pageheader" scope="row">General Dispatch Information</th>
      </tr>
      <tr>
        <th width="128" class="maincontent" scope="row"><div align="right"><strong><span class="style25">Dispatch ID:</span> </strong></div></th>
        <td colspan="2" class="maincontent"><span class="style28">
		<input name="DispatchID" value="#dispatchid#" size="10" maxlength="15" class="style28"> 
        </span><strong>OMNI Number:</strong><input name="OmniNum" value="#OmniNum#" size="10" maxlength="15" class="style28">
		<strong>Dell_PID: </strong><input name="dell_pid" value="#dell_pid#" size="10" maxlength="20" class="style28"></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>SBS Project ID: </strong></div></th>
        <td colspan="2" class="maincontent">
          <input name="projcode" value="#projcode#" size="20" maxlength="25" class="style28">
		  <strong>PO Number: </strong><input name="PO_Num" value="#PO_Num#" size="15" maxlength="20" class="style28"></td>
      </tr>
      
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Project Name: </strong></div></th>
        <td colspan="2" class="maincontent"><span class="style28"><input name="ProjectName" value="#projectname#" class="style28" size="50"></span>&nbsp;</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>City: </strong></div></th>
        <td colspan="2" class="maincontent"><span class="style28"><input name="Projectcity" value="#Projectcity#" size="50" maxlength="50" class="style28"></span>
		<strong> State:</strong><span class="style28">
		<select name="ProjectState" width="15">
					<option value="#ProjectState#" class="style28">#ProjectState#</option>
                    <option value="0">--</option>
					<option value="International">International</option>
					<cfloop query="statelookup">
                    <option value="#state#">#state#</option>
					</cfloop>  
          </select>
		</span>
		<strong>Zip Code: </strong><span class="style28"><input name="projectzip" value="#projectzip#" size="5" maxlength="5" class="style28"></span></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Start Date: </strong></div></th>
        <td width="116" class="maincontent style28"><input name="StartDate" value="#dateformat(startdate,'mm/dd/yyyy')#" size="10" maxlength="10"></td>
        <td width="515" class="maincontent"><strong>Start Time: </strong><span class="style28"><input name="StartTime" value="#timeformat(starttime,'h tt')#" size="5" maxlength="10" class="style28"></span></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>End Date: </strong></div></th>
        <td class="maincontent style28"><input name="EndDate" value="#dateformat(enddate,'mm/dd/yyyy')#" size="10" maxlength="10"></td>
        <td class="maincontent"><strong>End Time: </strong><span class="style28"><input name="EndTime" value="#timeformat(endtime,'h tt')#" size="5" maxlength="10" class="style28"></span></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>SE:</strong></div></th>
        <td colspan="2" class="maincontent">
		<span class="style28">
		<select name="EmpID">
		      <option value="#EmpID#" class="style28">#SE_Lname#,#SE_Fname#</option>
		      <option value="0">--</option>
		      <cfloop query="SE">
		      <option value="#EmpID#">#Lname#,#Fname#(#Type#)</option>
		      </cfloop>
		      </select>
		</span></td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Project Type: </strong></div></th>
        <td colspan="2" class="maincontent style28">
		<select name="ProjectType">
		    <option value="#ProjectType#" class="style28">#Proj_Type_lookup.type#</option>
            <option value="0">--</option>
            <cfloop query="projtype">
			<option value="#Proj_Type_ID#">#type#</option>
            </cfloop>
            </select>	
		<strong><font color="##000000">DM: </font></strong>
		<select name="DM">
          <option value="#DM#" class="style28">#DM#</option>
          <option value="0">--</option>
          <option value="NA">NA</option>
          <cfloop query="DM_Lookup">
            <option value="#LName#, #Fname#">#LName#, #Fname#</option>
          </cfloop>
        </select>		</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Status:</strong></div></th>
        <td colspan="2" class="maincontent style28">#Status#</td>
      </tr>
      <tr>
        <th colspan="3" bgcolor="##CCCCCC" class="pageheader" scope="row">Travel Section </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>TR Status: </strong></div></th>
        <td colspan="2" class="maincontent style28">#trcurrent.tr_status#</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row">&nbsp;</th>
        <td colspan="2" class="maincontent">
		<strong>Flight: </strong><span class="style28">#trcurrent.flight# </span>
		<strong>Hotel: </strong><span class="style28">#trcurrent.hotel#</span>
		<strong> Car Rental:</strong><span class="style28"> #trcurrent.rental#</span>
		</td>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Travel Notes: </strong></div></th>
        <td colspan="2" class="maincontent style28">#trcurrent.travelnotes#</td>
      </tr>
      <tr>
        <th colspan="3" bgcolor="##CCCCCC" class="pageheader" scope="row">LOE Information </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>LOE AMT $: </strong></div></th>
        <td colspan="2" class="maincontent"><strong>
          <input name="LOE_Price" type="text" size="10" maxlength="10"  class="style28" value="#LOE_Price#"> 
          TRAVEL $: 
          <input name="Travel_Price" type="text" size="10" maxlength="10" class="style28" value="#Travel_price#">
          TRAVEL BILLABLE? 
		  <select name="Bill_Travel">
		  <option  class="style28" value="#Bill_travel#">#Bill_travel#</option>
		  <option value="">--</option>
		    <option value="Y">Yes</option>
		    <option value="N">No</option>
		      </select>
        </strong></td>
      </tr>
      <tr>
        <th colspan="3" class="maincontent" scope="row"><strong>SE REVENUE REPORTABLE? 
            <select name="se_flag" id="se_flag">
			<option  class="style28" value="#se_flag#">#se_flag#</option>
			<option value="">--</option>
              <option value="Y">Yes</option>
              <option value="N">No</option>
              </select> 
          Are there regular Dell SKU's in addition?
          <label>
		  <select name="dell_sku">
		  <option class="style28" value="#Dell_sku#">#Dell_sku#</option>
            <option value="NA">--</option>
            <option value="Yes">Yes</option>
          </select>
          </label>
        </strong></th>
      </tr>
      <tr>
        <th colspan="3" bgcolor="##CCCCCC" class="pageheader" scope="row">Project Information </th>
      </tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Project Summary:</strong></div></th>
        <td colspan="2" class="maincontent style28">
		<select name="ProjectSummary">
		<option value="#ProjectSummary#" class="style28">#ProjectSummary#</option>
        <option value="0">--</option>
        <cfloop query="task">
        <option value="#Project_Task#">#Project_Task#</option>
	    </cfloop>
        </select>
		</td>
		</tr>
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>DWB Received by MGMT:</strong></div></th>
        <td colspan="2" class="maincontent style28">
         <select name="mgmt_dwb">
		  <option class="style28" value="#mgmt_dwb#">#mgmt_dwb#</option>
            <option value="No">No</option>
            <option value="Yes">Yes</option>
          </select>
		  </td>
        </tr>
      
      <tr>
        <th class="maincontent" scope="row"><div align="right"><strong>Project Notes:</strong></div></th>
        <td colspan="2"><textarea name="ProjectNotes" cols="60" rows="5" class="style28">#ProjectNotes#</textarea></td>
      </tr>
    </table>
    <br>
    <input type="submit" name="Submit" value="    Submit Changes   ">
    <br>
  </form>
  </cfoutput>
</center>
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