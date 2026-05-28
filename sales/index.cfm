<!-- InstanceBegin template="/Templates/dms_basic.dwt" codeOutsideHTMLIsLocked="false" --><head>
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
<div align="center">
  <table width="616" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="616"><img src="../pics/DMSLogoLong.jpg" width="616" height="70"></td>
    </tr>
  </table>
  <table width="616" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="25" bgcolor="#949DA1">&nbsp;</td>
    </tr>
  </table>
  <table width="616" height="350" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="616" height="354" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
      <!-- InstanceBeginEditable name="body" -->
<!---
This page was created to allow Scott Anchetta and Larry Larson to generate LOE reports and reconcile against their records.
Index page allows for date selection
--->


	<span class="pageheader">Enter date range to generate the LOE tracking report</span><br>
<form name="form" action="loe.cfm" method="post" target="_blank">
<table width="200" border="1">
  <tr>
    <th class="maincontent" scope="row">Start Date</th>
    <td><CF_CT_DATE_INPUT NAME="StartDate"></td>
  </tr>
  <tr>
    <th class="maincontent" scope="row">End Date</th>
    <td><CF_CT_DATE_INPUT NAME="EndDate"></td>
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
  <table width="616" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="126" height="19" bgcolor="#949DA1">&nbsp;</td>
      <td width="613" bgcolor="#949DA1"><div align="center" class="copyrightnfo"><img src="../pics/copyright.gif" width="461" height="18" border="0" usemap="#Map">
        <map name="Map">
          <area shape="rect" coords="436,2,454,16" href="http://www.longitudegroup.com">
          </map>
      </div></td>
    </tr>
  </table>
</div>
</body>
<!-- InstanceEnd -->