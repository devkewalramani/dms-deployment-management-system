<!---
This is the task list form which all engineers must complete after a project completion
--->

<style type="text/css">
<!--
.style3 {font-size: 12px}
.style6 {color: #FF0000; font-style: italic; font-size: xx-small; }
.style7 {
	color: #FF0000;
	font-size: 10px;
}
.style9 {
	font-weight: bold;
	color: #0000FF;
	font-size: 14px;
}
.style10 {font-size: 14px}
.style11 {color: #FF0000}
.style13 {color: #FF0000; font-weight: bold; }
-->
</style>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validateForm(objForm)
{
	var returnStatus = 1;

	if (objForm.DM.selectedIndex == 0) {
		alert("Please select a DM");
		returnStatus = 0;
	};
	
	if (objForm.task_one.selectedIndex == 0) {
		alert("Please select a Project Task");
		returnStatus = 0;
	};
	
	if (objForm.Hours.selectedIndex == 0) {
		alert("Please enter how many hours you were delayed, select none if you had no delays");
		returnStatus = 0;
	};
	
	if (objForm.OS_one.selectedIndex == 0) {
		alert("Please select an OS");
		returnStatus = 0;
	};
	
	if (objForm.DWB_Adv.selectedIndex == 0) {
		alert("Please select how many days in advance you got the DWB");
		returnStatus = 0;
	};
	
	if (objForm.tamlog.value.length ==0) {
		alert("Please enter in your Tam Handoff Log #");
		returnStatus = 0;
	};
	
	if (objForm.Actual_StartDate.value.length ==0) {
		alert("Please enter the day you started the engagement");
		returnStatus = 0;
	};
	
	if (objForm.Actual_EndDate.value.length ==0) {
		alert("Please enter the date you finished the engagement");
		returnStatus = 0;
	};
	
	if (!objForm.dell_docs.checked) {
		alert("Please check that you have submitted all required Dell Documentation");
		returnStatus = 0;
	};
	
	if (returnStatus) {
		objForm.submit();
	}
}
// -->
</SCRIPT>
</head>



<body>

<!--- SQL Calls for task lookup --->
<cfquery name="task" datasource="SBSEFD">
select *
from dbo.ProjectTask
Order by Project_Task ASC
</cfquery>
<!--- end --->

<!--- SQL Calls for Project and DM lookup --->
<cfquery name="DM_Lookup" datasource="SBSEFD">
Select Lname, Fname
From dbo.DM
Order by Lname ASC
</cfquery>

<cfquery name="tasksearch" datasource="SBSEFD">
select RID, DispatchID, OmniNum, ProjectName, StartDate, EndDate, EmpID, SE_LName, SE_FName, DateAdded, Status
from dbo.schedule
where RID = #Form.RID#
</cfquery>
<!--- end --->


<cfoutput><cfset Days_Advance_Notice = #tasksearch.StartDate# - #tasksearch.DateAdded#></cfoutput>

<form name="tlform" method="post" action="./addtasklist.cfm" >
<cfoutput> <input type="hidden" name="RID" value="#tasksearch.RID#"></cfoutput>
<cfoutput><input type="hidden" name="Days_adv" value="#Days_Advance_Notice#"></cfoutput>
<table width="930" border="1" cellpadding="0" cellspacing="0">
  <col width="423">
  <col width="119">
  <tr height="20">
    <td height="23" colspan="2" bgcolor="#CCCCCC"><strong>General Information </strong></td>
    <td height="23" colspan="2" bgcolor="#CCCCCC"><strong>Project Reporting</strong></td>
    </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right">Customer:</div></td>
    <td width="293"><cfoutput><input name="ProjectName" type="text" value="#tasksearch.ProjectName#" size="50" maxlength="100" readonly="yes"></cfoutput></td>
    <td height="15" width="323"><span class="style3"><span class="style6">*</span>Which OS did the customer have <span class="style11">(U</span><span class="style11">p to 3 choices)</span></span></td>
    <td><select name="OS_one" id="OS_one">
	<option value="0">Select One</option>
	<option value="Windows">Windows</option>
	<option value="Netware">Netware</option>
	<option value="Red Hat Linux">Red Hat Linux</option> 
	<option value="SuSE Linux">SuSE Linux</option>
	<option value="HPUX">HPUX</option>
	<option value="Solaris">Solaris</option>
	<option value="AIX">AIX</option>
	<option value="WMWare">VMware</option>
    </select></td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right"><span class="style6">*</span>Start Date:</div></td>
    <td width="293"><CF_CT_DATE_INPUT NAME="Actual_StartDate"></td>
    <td height="15">&nbsp;</td>
    <td><select name="OS_two" id="OS_two">
        <option value="NA">Select One</option>
        <option value="Windows">Windows</option>
        <option value="Netware">Netware</option>
        <option value="Red Hat Linux">Red Hat Linux</option>
        <option value="SuSE Linux">SuSE Linux</option>
        <option value="HPUX">HPUX</option>
        <option value="Solaris">Solaris</option>
        <option value="AIX">AIX</option>
        <option value="WMWare">VMware</option>
    </select></td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right"><span class="style6">*</span>Complete Date:</div></td>
    <td width="293"><CF_CT_DATE_INPUT NAME="Actual_EndDate"></td>
    <td height="15">&nbsp;</td>
    <td><select name="OS_three" id="OS_three">
        <option value="NA">Select One</option>
        <option value="Windows">Windows</option>
        <option value="Netware">Netware</option>
        <option value="Red Hat Linux">Red Hat Linux</option>
        <option value="SuSE Linux">SuSE Linux</option>
        <option value="HPUX">HPUX</option>
        <option value="Solaris">Solaris</option>
        <option value="AIX">AIX</option>
        <option value="WMWare">VMware</option>
    </select></td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right">Engineers:</div></td>
    <td width="293"><cfoutput>#tasksearch.SE_LName#, #tasksearch.SE_FName# <input name="EmpID" type="hidden" value="#tasksearch.EmpID#" >
    </cfoutput>	</td>
    <td height="15" colspan="2" bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
  <tr height="20">
    <td height="20" width="174"> <div align="right"><span class="style6">*</span>DM:</div></td>
    <td width="293">
	<select name="DM">
	<option value="0">Select One</option>
	<cfoutput query="DM_Lookup">
	<option value="#LName#, #Fname#">#LName#, #Fname#</option>
	</cfoutput>
	</select>	</td>
    <td height="15" width="323"><span class="style3"><span class="style6">*</span>DWB Advance Notice Days</span></td>
    <td><select name="DWB_Adv" id="DWB_Adv">
        <option value="0">Select One</option>
        <option value="none">Never Got One</option>
        <option value="NA">Not Required</option>
		<option value="dayof">0</option>
        <option value="1-2">1-2</option>
        <option value="3-4">3-4</option>
        <option value="5-6">5-6</option>
        <option value="7-8">7-8</option>
        <option value="8+">8+</option>
    </select></td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right"><span class="style6">*</span>TAM Handoff Log #:</div></td>
    <td width="293"><label>
      <input name="tamlog" type="text" id="tam_log" size="15" maxlength="15">
      <span class="style7">(enter </span><span class="style13">none</span><span class="style7"> for non customer participation)</span></label></td>
    <td><span class="style3">Additional    work had to be performed which 
      was not on original Schedule Request</span></td>
    <td height="15"><select name="additional_work">
        <option value="NA">--</option>
        <option value="Y">Yes</option>
      </select>    </td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right">Dexterra ID</div></td>
    <td width="293"><cfoutput><input type="text" name="DispatchID" readonly="yes" value="#tasksearch.DispatchID#"></cfoutput></td>
    <td><span class="style3">DM did not    return call or make contact
      within 4 Hours (SLA)</span></td>
    <td height="15"><Select name="SLA">
        <option value="NA">--</option>
        <option value="Y">Yes</option>
      </select>    </td>
  </tr>
  <tr height="20">
    <td height="20" width="174"><div align="right">Omni Number</div></td>
    <td width="293"><cfoutput><input type="text" name="OmniNum" readonly="yes" value="#tasksearch.OmniNum#"></cfoutput></td>
    <td>&nbsp;</td>
    <td height="15">&nbsp;</td>
  </tr>
  </table>
  <br>
  <table width="930" border="1" cellpadding="0" cellspacing="0">
  <tr height="15">
    <td height="15" colspan="4" bgcolor="#CCCCCC"><strong>Project Tasks</strong></td>
    </tr>
  <tr height="15">
    <td height="15" colspan="4">      <label>
      <div align="center"><span class="style6">*</span>
        <select name="task_one">
          <option value="0">Select One</option>
          <cfoutput query="task">
		  <option value="#Project_Task#">#Project_Task#</option>
		  </cfoutput>
          </select>
      </div></label>    </td>
    </tr>
  
  <tr height="15">
    <td height="15" colspan="4">      <div align="center">
      <select name="task_two">
	  <option value="NA">Select One</option>
		  <cfoutput query="task">
		  <option value="#Project_Task#">#Project_Task#</option>
		  </cfoutput>
      </select>
    </div></td>
    </tr>
  
  <tr height="15">
    <td height="15" colspan="4">
	<div align="center">
      <select name="task_three">
	  <option value="NA">Select One</option>
		  <cfoutput query="task">
		  <option value="#Project_Task#">#Project_Task#</option>
		  </cfoutput>
      </select>
    </div></td>
    </tr>
  
  <tr height="15">
    <td height="15" colspan="4">      <div align="center">
      <select name="task_four">
	  <option value="NA">Select One</option>
	        <cfoutput query="task">
		  <option value="#Project_Task#">#Project_Task#</option>
		  </cfoutput>
      </select>
    </div></td>
    </tr>
  
  <tr height="15">
    <td height="15" colspan="4">      <div align="center">
      <select name="task_five">
	  <option value="NA">Select One</option>
	       <cfoutput query="task">
		  <option value="#Project_Task#">#Project_Task#</option>
		  </cfoutput>
      </select>
    </div></td>
    </tr>
  
  <tr height="15">
    <td height="15" colspan="4">      <label>
      <div align="center">Notes:<br> 
          <label>
              <textarea name="notes" cols="75" rows="3" id="notes"></textarea>
          </label>
      </div>
    </label>    </td>
    </tr>
  </table>
	<br>
	<table width="930" border="1" cellpadding="0" cellspacing="0">
  <tr height="15">
    <td width="204" height="15" bgcolor="#CCCCCC"><strong>Project Delays </strong></td>
    <td width="274" height="15" bgcolor="#CCCCCC">&nbsp;</td>
    <td width="213" height="15" bgcolor="#CCCCCC">&nbsp;</td>
    <td width="229" height="15" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3"><strong>Cables Missing/Wrong&nbsp;&nbsp;&nbsp;</strong></span></td>
    <td height="15">&nbsp;</td>
    <td>&nbsp;</td>
    <td height="15">&nbsp;</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">&nbsp; - Fiber Cables</span></td>
    <td><select name="Fiber">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Software Licenses Missing    or not enough.&nbsp;</span></td>
    <td><select name="Software_Lic">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="17">
    <td height="17"><span class="style3">&nbsp; - LCC (HSSDC) cables</span></td>
    <td><select name="LCC" id="LCC">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Equipment    Missing/Wrong</span></td>
    <td><select name="Equip_Miss" id="Equip_Miss">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">&nbsp; - Cross-Over    Cables&nbsp;</span></td>
    <td><select name="Cross_Over" id="Cross_Over">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Equipment has    not arrived</span></td>
    <td><select name="Equip_Not_Arrived" id="Equip_Not_Arrived">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select></td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">&nbsp; - SPS Cables&nbsp;</span></td>
    <td><select name="SPS" id="SPS">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Equipment    broken</span></td>
    <td><select name="Equip_Broken" id="Equip_Broken">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">&nbsp; - Miscellaneous Cables</span></td>
    <td><select name="Misc" id="Misc">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Equipment    damage</span></td>
    <td><select name="Equip_Damage" id="Equip_Damage">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">Network    Connectivity</span></td>
    <td><select name="Network" id="Network">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Missing Rail    Kit</span></td>
    <td><select name="Rail_Kit" id="Rail_Kit">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">Missing Power</span></td>
    <td><select name="Missing_Power" id="Missing_Power">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td width="213"><span class="style3">Waiting    on Customer to complete internal work&nbsp;</span></td>
    <td><select name="Internal_Work" id="Internal_Work">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">Out of scope    work</span></td>
    <td><select name="Out_of_Scope" id="Out_of_Scope">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td><span class="style3">Redesign</span></td>
    <td><select name="Redesign" id="Redesign">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
  </tr>
  <tr height="15">
    <td height="15"><span class="style3">Software    Missing/Wrong</span></td>
    <td><select name="Software_Miss" id="Software_Miss">
	<option value="NA">--</option>
	<option value="Y">Yes</option>
	</select>
	</td>
    <td>&nbsp; </td>
    <td>&nbsp;</td>
  </tr>
  
  <tr height="15">
    <td height="15" colspan="2"><div align="right"><span class="style3"><span class="style6">*</span>Estimated    hours lost due to Delays</span></div></td>
    <td colspan="2"><select name="Hours" id="Hours" >
        <option value="0">Select One</option>
        <option value="None">None</option>
        <option value="1-2">1-2</option>
        <option value="3-4">3-4</option>
        <option value="5-6">5-6</option>
        <option value="7-8">7-8</option>
        <option value="9-10">9-10</option>
        <option value="10-12">10-12</option>
        <option value="12-24">12-24</option>
        <option value="24-36">24-36</option>
        <option value="36-48">36-48</option>
        <option value="48+">48+</option>
      </select>
      Hours <span class="style7">(Select none if no delays)</span></td>
    </tr>
  
  <tr height="17">
    <td height="17" colspan="4"><div align="center"><span class="style3"><span class="style6">*</span><span class="style9">I have submitted the required Dell Documentations? (EOE, signoff etc) </span></span> 
        <span class="style10">
        <label>        </label>
        </span>
        <label>
        <input type="checkbox" name="dell_docs" value="Y">
      </label>
    </div></td>
    </tr>
  <tr height="17">
    <td height="17" colspan="4"><center>
        <input type="button" name="Submit" value="     Submit Task List     "  onClick="validateForm(document.tlform)" />
		</center>      </td>
    </tr>
</table>
</form>

<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
