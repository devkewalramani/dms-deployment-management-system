
<!-- THREE STEPS TO INSTALL CASCADE MENU:

  1.  Copy the coding into the HEAD of your HTML document
  2.  Add the onLoad event handler into the BODY tag
  3.  Put the last coding into the BODY of your HTML document  -->

<!-- STEP ONE: Paste this code into the HEAD of your HTML document  -->

<HEAD>

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->
<!-- Original:  Arun kumar (n_arunk@hotmail.com) -->

<link href="CascadeMenu.css" rel="stylesheet">
<script language="javascript" src="CascadeMenu.js">
</script>
</HEAD>

<!-- STEP TWO: Insert the onLoad event handler into your BODY tag  -->

<BODY OnLoad="InitMenu()" Onclick="HideMenu(menuBar)" ID="Bdy" bgColor=aliceblue>

<!-- STEP THREE: Copy this code into the BODY of your HTML document  -->
<DIV Id="menuBar" class="menuBar" >
    <DIV Id="Bar1" class="Bar"  menu="menu1">Menu #1</DIV>
    <DIV Id="Bar2" class="Bar"  menu="menu2">Menu #2</DIV>
    <DIV Id="Bar3" class="Bar"  menu="menu3">Menu #3</DIV>
    <DIV Id="Bar4" class="Bar"  menu="menu4">Menu #4</DIV>
</DIV>
<!--MenuItem Definition -->
<div Id="menu1" class="menu" >
   <div Id="menuItem1_1" class="menuItem"  menu="menu6">SubMenu #1</div>
   <div Id="menuItem1_2" class="menuItem" title="JavaScripts" cmd="http://javascript.internet.com/">JavaScript Source</div>
   <div Id="menuItem1_3" class="menuItem" title="WDVL" cmd="http://www.wdvl.com">WDVL</div>
</div>
<div Id="menu2" class="menu">
   <div Id="menuItem2_1" class="menuItem">Page #1</div>
   <div Id="menuItem2_2" class="menuItem">Page #2</div>
   <div Id="menuItem2_3" class="menuItem">Page #3</div>
</div>
<div Id="menu3" class="menu">
   <div Id="menuItem3_1" class="menuItem">Page #1</div>
   <div Id="menuItem3_2" class="menuItem">Page #2</div>
   <div Id="menuItem3_3" class="menuItem">Page #3</div>
   <div Id="menuItem3_4" class="menuItem" menu="menu5">SubMenu #4</div>
</div>
<div Id="menu4" class="menu">
   <div Id="menuItem4_1" class="menuItem">Page #1</div>
   <div Id="menuItem4_2" class="menuItem">Page #2</div>
   <div Id="menuItem4_3" class="menuItem">Page #3</div>
   <div Id="menuItem4_4" class="menuItem">Page #4</div>
</div>
<div id="menu5" class="menu">
    <div Id="menuItem5_1" class="menuItem">Page #4-1</div>
    <div Id="menuItem5_2" class="menuItem">Page #4-2</div>
    <div Id="menuItem5_3" class="menuItem">Page #4-3</div>
</div>
<div id="menu6" class="menu">
    <div Id="menuItem6_1" class="menuItem">Page #1-1</div>
    <div Id="menuItem6_2" class="menuItem">Page #1-2</div>
    <div Id="menuItem6_3" class="menuItem" menu="menu7">SubMenu #1-1</div>
</div>
<div id="menu7" class="menu">
    <div Id="menuItem7_1" class="menuItem">Page #1-1-1</div>
    <div Id="menuItem7_2" class="menuItem">Page #1-1-2</div>
    <div Id="menuItem7_3" class="menuItem">Page #1-1-3</div>
</div>
