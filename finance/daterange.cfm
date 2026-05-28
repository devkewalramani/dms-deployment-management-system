<!-- InstanceBegin template="/Templates/dms_finance.dwt" codeOutsideHTMLIsLocked="false" --><head>
<!-- InstanceBeginEditable name="title" -->
<title>BU Report</title>
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
<img src="../pics/reporting.jpg" name="Image4" width="123" height="30" border="0" id="Image4"><a href="daterange.cfm" ><img src="../pics/sub_bu_report.jpg" name="Image4d" width="123" height="17" border="0" id="Image4d"></a><a href="revdates.cfm" ><img src="../pics/sub_week_rev.jpg" name="Image4c" width="123" height="17" border="0" id="Image4c"></a><a href="revdateseng.cfm" ><img src="../pics/sub_week_rev_eng.jpg" name="Image4d" width="123" height="17" border="0" id="Image4d"></a><img src="../pics/tools.jpg" name="Image5" width="123" height="30" border="0" id="Image4"><a href="es_pipe.cfm" ><img src="../pics/sub_es_pipe.jpg" name="Image5a" width="123" height="17" border="0" id="Image5a"></a><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<!--- select dates and business unit to run report --->	
	
	<span class="pageheader">Enter date range to generate the BU tracking report</span><br>
<form name="form" action="BUoptions.cfm" method="post" target="_blank">
<table width="300" border="1">
  <tr>
    <th class="maincontent" scope="row">BU ? </th>
    <td>
	<select name="BU">
    <option value="">Select one</option>
	<option value="DS">Dell Services</option>
    <option value="ES">Enterprise Services</option>
	</select>
	</td>
  </tr>
  <tr>
    <th class="maincontent" scope="row">Start Date</th>
    <td><CF_CT_DATE_INPUT NAME="StartDate"></td>
  </tr>
  <tr>
    <th class="maincontent" scope="row">End Date</th>
    <td><CF_CT_DATE_INPUT NAME="EndDate"></td>
  </tr>
  <tr>
    <th class="maincontent" scope="row">Dell Quarter</th>
    <td>
	<select name="dq">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	</select>
	<span class="maincontent">Dell Week</span>	
	<select name="dw">
	<option value="01">01</option>
	<option value="02">02</option>
	<option value="03">03</option>
	<option value="04">04</option>
	<option value="05">05</option>
	<option value="06">06</option>
	<option value="07">07</option>
	<option value="08">08</option>
	<option value="09">09</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	</select>	</td>
  </tr>
  <tr>
    <th scope="row">&nbsp;</th>
    <td><input type="submit" name="Submit" value="    Submit    "></td>
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