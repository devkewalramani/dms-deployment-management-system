<!-- InstanceBegin template="/Templates/dms_hr.dwt" codeOutsideHTMLIsLocked="false" --><head>
<!-- InstanceBeginEditable name="title" --><title>Management</title><!-- InstanceEndEditable -->
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
<img src="../pics/admin.jpg" name="Image5" width="123" height="30" border="0" id="Image5"><a href="addse.cfm" ><img src="../pics/sub_addse_admin.jpg" name="Image5a" width="123" height="17" border="0" id="Image5a"></a><a href="editse.cfm" ><img src="../pics/sub_editse_admin.jpg" name="Image5b" width="123" height="17" border="0" id="Image5b"></a><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
<td width="616" height="447" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->
<!--- index page included to facilitate login --->
<div align="center">
<cfset userid=#GetAuthUser()#>
<cfset edituser=#RemoveChars(userid,1,7)#>

<cfoutput><span class="pageheader">Welcome #edituser#</span></cfoutput>
  <p>&nbsp;</p>
  <p class="pageheader">HR Portal</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</div>
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