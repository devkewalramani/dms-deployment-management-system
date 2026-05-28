<!-- InstanceBegin template="/Templates/dms_hr.dwt" codeOutsideHTMLIsLocked="false" --><head>
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
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
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
<img src="../pics/admin.jpg" name="Image5" width="123" height="30" border="0" id="Image5"><a href="addse.cfm" ><img src="../pics/sub_addse_admin.jpg" name="Image5a" width="123" height="17" border="0" id="Image5a"></a><a href="editse.cfm" ><img src="../pics/sub_editse_admin.jpg" name="Image5b" width="123" height="17" border="0" id="Image5b"></a><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<!--- lookup employee based on selection from editse.cfm --->
<cfquery name="editse" datasource="SBSEFD">
select *
from dbo.se
where EmpID='#Form.EmpID#'
</cfquery>
<!--- output on a form for updating --->
<cfoutput query="editse">
<form action="./edit_se_script.cfm" method="post" name="form">
<input name="EmpID" type="hidden" value="#Form.EmpID#">   
<table width="602">
  <tr>
    <td width="210" bgcolor="##CCCCCC" class="pageheader"><div align="center">First Name </div></td>
    <td width="213" bgcolor="##CCCCCC" class="pageheader"><div align="center">Last Name </div></td>
    <td width="163" bgcolor="##CCCCCC" class="pageheader"><div align="center">Type</div></td>
    </tr>
  <tr>
    <td>
      <div align="center">
        <input name="fname" type="text" id="fname" size="35" maxlength="50" value="#Fname#">    
      </div></td>
    <td>
      <div align="center">
        <input name="lname" type="text" id="lname" size="35" maxlength="50" value="#Lname#">    
      </div></td>
    <td><select name="type">
	<option value="#type#">#type#</option>
	<option value="">--</option>
	<option value="DLE">DLE</option>
	<option value="DLA">DLA</option>
	<option value="DPS DLE">DPS DLE</option>
	<option value="MLT">MLT</option>
	<option value="Matrix">Matrix</option>
	<option value="Resident">Resident</option>
	<option value="EMC">EMC</option>
	<option value="HP">HP</option>
	<option value="HDS">HDS</option>
	<option value="SUN">SUN</option>
	</select></td>
    </tr>
  <tr>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">City</div></td>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">State</div></td>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Zip code </div></td>
    </tr>
  <tr>
    <td><div align="center">
      <input name="city" type="text" id="city" size="35" maxlength="50" value="#city#">    
    </div></td>
    <td><div align="center"><strong>
      <select name="state" id="state" width="15">
	    <option value="#state#">#state#</option>
        <option value="0">--</option>
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
    </strong></div></td>
    <td><div align="center">
      <input name="zip" type="text" id="zip" size="5" maxlength="5" value="#zip#">    
    </div></td>
    </tr>
  <tr>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Email Address </div></td>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Cell Phone Number </div></td>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Employee Type </div></td>
  </tr>
  <tr>
    <td><input name="email" type="text" id="email" size="15" maxlength="50" value="#username#">
      <span class="maincontent">@sbsplanet.com</span></td>
    <td><div align="center">
      <input name="cellphone" type="text" id="cellphone" size="15" maxlength="15" value="#cellphone#">
    </div></td>
    <td><select name="EmpType">
        <option value="#EmpType#">#EmpType#</option>
        <option value="">--</option>
        <option value="FT">FT (Full Time)</option>
        <option value="1099">1099 (Contract)</option>
        <option value="FT-RTH">FT (Full-Right to Hire)</option>
      </select>    </td>
  </tr>
  <tr>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Current Status </div></td>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Current Region </div></td>
	<td width="163" bgcolor="##CCCCCC" class="pageheader"><div align="center">Business Unit</div></td>
  </tr>
  <tr>
    <td><div align="center">
      <select name="status">
	   <cfif #status# eq '1'>
        <option value="#status#">Active</option>
		<cfelseif #status# eq '0'>
        <option value="#status#">Not Active</option>
		</cfif>
        <option value="">--</option>
        <option value="1">Active</option>
        <option value="0">Not Active</option>
      </select>
    </div></td>
    <td><div align="center">
      <input name="region" type="text"  value="#Region#" size="5" maxlength="5" readonly="yes">
    </div></td>
	<td><select name="bu">
		<option value="#BU_Group#">#BU_Group#</option>
        <option value="">--</option>
        <option value="DS">Dell Services</option>
        <option value="ES">Enterprise Services</option>
        <option value="MS">Managed Services</option>
      </select>    </td>
  </tr>
  <tr>
    <td bgcolor="##CCCCCC" class="pageheader"><div align="center">Weekly Rate <span class="maincontent"><em>if applicable</em></span> </div></td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
    </tr>
  <tr>
    <td><div align="center">
        <input name="rate" type="text" id="rate" size="10" maxlength="10" value="#rate#">
    </div></td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
    </tr>
  <tr>
    <td colspan="3"><center><input type="submit" name="submit" value="Update"></center></td>
    </tr>
</table>
</form>
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