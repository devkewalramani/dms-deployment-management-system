<!-- InstanceBegin template="/Templates/dms_eng.dwt" codeOutsideHTMLIsLocked="false" --><head>
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
.style24 {color: #000000}
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
      Planet</font></a> //<a href="../Templates/index.htm"><font color="#FFFFFF">My Planet</font></a>    </td>
  </tr>
</table>
<table width="742" height="350" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="126" height="354" align="left" valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
<!-- #BeginLibraryItem "/Library/NewNavMain.lbi" -->
<img src="../pics/reporting.jpg" name="Image1" width="123" height="30" border="0" id="Image1"><img src="../pics/sub_placeholder_index.jpg" name="Image2a" width="123" height="17" border="0" id="Image2a"><img src="../pics/sub_placeholder_index.jpg" name="Image2b" width="123" height="17" border="0" id="Image2b"><!-- #EndLibraryItem --><img src="../pics/leftmenubottom.jpg" width="123" height="34" border="0"></td>
    <td width="616" height="354" colspan="2" align="left" valign="top" class="style23"><img src="../pics/dms_header.jpg" width="616" height="111"><br>
    <!-- InstanceBeginEditable name="body" -->

<!---
Shows the pipeline of task lists awaiting completion
--->

<style type="text/css"><!--div.scroll {	height: 200px;	width: 600px;	overflow: auto;}--></style>

<!--- 
parses user id entered during login 
--->
<cfset userid=#GetAuthUser()#>
<cfset edituser=#RemoveChars(userid,1,7)#>

<!---
query to lookup employee info
--->
<cfquery name="getempid" datasource="SBSEFD">
select empid,lname,fname
from dbo.SE
where username='#edituser#'
</cfquery>

<cfoutput><span class="pageheader">Welcome #getempid.lname#, #getempid.fname#</span></cfoutput>
<br>
<!---
search the schedule table for jobs that require a Task list completed. this is flagged by the TL field
--->
<cfquery name="search" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE Empid = ('#getempid.empid#') and (Status = 'Completed') and (ProjectType = '1' OR ProjectType = '2') and (DispatchID <> 'NA') and (TL is null)
Order by EndDate ASC
</cfquery>

<div class="scroll">
<table width="575" border="1">
  <tr>
    <th width="12%" class="maincontent" scope="col"><div align="center" class="style1 style24">Dexterra ID </div></th>
    <th width="11%" class="maincontent" scope="col"><div align="center" class="style1 style24">Omni</div></th>
    <th width="13%" class="maincontent" scope="col"><div align="center" class="style1 style24">Project Name </div></th>
	<th width="11%" class="maincontent" scope="col"><div align="center" class="style1 style24">Start Date </div></th>
    <th width="14%" scope="col"></th>
  </tr>
<cfoutput query="search">
<form name="form"  method="post" action="tasklist.cfm" >
<input name="rid" type="hidden" value="#search.RID#">
  <tr class="maincontent">
    <td><div align="center" class="style1 style24">#search.DispatchID#</div></td>
    <td><div align="center" class="style1 style24">#search.OmniNum#</div></td>
    <td><div align="center" class="style1 style24">#search.ProjectName#</div></td>
	<td><div align="center" class="style1 style24">#DateFormat(search.StartDate,'mm/dd/yyyy')#</div></td>
    <th width="14%" scope="col"><div align="center" class="style1"><input name="tasklist" type="submit" value="Tasklist" > 
        </div></th>
  </tr>
  </form>
  </cfoutput>
</table>
</div>
<!-- InstanceEndEditable -->	</td>
  </tr>
</table>
<table width="742" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="126" height="19" bgcolor="#949DA1">&nbsp;</td>
    <td width="613" bgcolor="#949DA1"><div align="center" class="copyrightnfo"><img src="../pics/copyright.gif" width="461" height="18" border="0" usemap="#Map">
        <map name="Map">
          <area shape="rect" coords="436,2,454,16" href="http://www.longitudegroup.com">
        </map>
    </div></td>
  </tr>
</table>
</body>
<!-- InstanceEnd -->