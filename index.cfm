<head>
<link href="CascadeMenu.css" rel="stylesheet">
<script language="javascript" src="CascadeMenu.js">
</script>
</head>

<BODY OnLoad="InitMenu()" Onclick="HideMenu(menuBar)" ID="Bdy" bgColor=white>
<table width="813" align="center">
  <tr>
    <td width="808"><div align="center"><img src="pics/logo_new1.jpg" width="616" height="301"></div></td>
  </tr>
  <tr>
    <td align="center">
	<!-- STEP THREE: Copy this code into the BODY of your HTML document  -->
<DIV Id="menuBar" class="menuBar" align="center" >
    <DIV Id="Bar1" class="Bar"  menu="menu1">ENGINEER</DIV>
    <DIV Id="Bar2" class="Bar"  menu="menu2">CLIENT SERVICES</DIV>
    <DIV Id="Bar3" class="Bar"  menu="menu3">CORPORATE SERVICES</DIV>
    <DIV Id="Bar4" class="Bar"  menu="menu4">SKILLS MATRIX</DIV>
</DIV>
<!--MenuItem Definition -->
<div Id="menu1" class="menu">
	<div Id="menuItem1_1" class="menuItem" title="Dell" cmd="./engineer">Dell</div>
	<div Id="menuItem1_2" class="menuItem" title="Help" cmd="./helpdoc.pdf">Documentation</div>
</div>
<div Id="menu2" class="menu">
   <div Id="menuItem2_1" class="menuItem" title="Dell" cmd="./manager">Client Services</div>
</div>
<div Id="menu3" class="menu">
   <div Id="menuItem3_1" class="menuItem" title="Finance" cmd="./finance">Finance</div>
   <div Id="menuItem3_2" class="menuItem" title="Human Resources" cmd="./hr">Human Resources</div>
</div>
<div Id="menu4" class="menu">
</div>
	</td>
  </tr>
</table>


</BODY>