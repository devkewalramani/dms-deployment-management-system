<!---
This script posts all the data entered on the task list form to the database
--->

<head>
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-style: italic;
}
.style2 {
	color: #0000FF;
	font-weight: bold;
}
-->
</style>
</head>
<body >
<cfif isValid("integer", #form.tamlog#) or #form.tamlog# eq 'none'>

<!--- Set a variable equal to todays date --->
<cfset datefinished1 = Now()>
<cfset datefinished = #DateFormat(datefinished1,'mm/dd/yyyy')#>


<!--- lookup SE email address --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT EmailAddress, LName, FName
FROM dbo.SE
WHERE EmpID=#form.EmpID#
</cfquery>

<!--- add to task table --->
<cfquery name="addtask" datasource="SBSEFD">
INSERT INTO dbo.Tasklist (TL_RID, ProjectName, Actual_StartDate, Actual_EndDate, SE_Lname, SE_Fname, DM, TAM_Handoff, DispatchID, OmniNum, OS_one, OS_two, OS_three,Days_adv, DWB_Adv, Additional_Work, DM_SLA, Task_one, Task_two, Task_three, Task_four, Task_five, Notes, Completed_Date, Dell_Docs) VALUES ('#form.RID#', '#form.ProjectName#', '#form.Actual_StartDate#', '#form.Actual_EndDate#', '#SE_lookup.Lname#', '#SE_lookup.Fname#', '#form.DM#', '#form.tamlog#', '#form.DispatchID#', '#form.OmniNum#', '#form.OS_one#', '#form.OS_two#', '#form.OS_three#', '#form.Days_Adv#','#form.DWB_Adv#', '#form.Additional_Work#', '#form.SLA#', '#form.Task_one#', '#form.Task_two#', '#form.Task_three#', '#form.Task_four#', '#form.Task_five#', '#form.Notes#', '#datefinished#','#form.dell_docs#')
</cfquery>

<!--- add to delays table --->
<cfquery name="delays" datasource="SBSEFD">
INSERT INTO dbo.Delays (TL_RID, Fiber, LCC, Cross_Over, SPS, Misc, Network, Missing_Power, Out_of_Scope, Software_Miss, Software_Lic, Equip_Miss, Equip_Not_Arrived, Equip_Broken, Equip_Damage, Rail_Kit, Internal_Work, Redesign, Hours) VALUES ('#form.RID#', '#form.Fiber#', '#form.LCC#', '#form.Cross_Over#', '#form.SPS#', '#form.Misc#', '#form.Network#', '#form.Missing_Power#', '#form.Out_of_Scope#', '#form.Software_Miss#', '#form.Software_Lic#', '#form.Equip_Miss#', '#form.Equip_Not_Arrived#', '#form.Equip_Broken#', '#form.Equip_Damage#', '#form.Rail_Kit#', '#form.Internal_Work#', '#form.Redesign#', '#form.Hours#')
</cfquery>

<!--- update TL status --->
<cfquery name="updatestatus" datasource="SBSEFD">
UPDATE dbo.schedule SET TL ='Y' WHERE RID='#Form.RID#'
</cfquery>

<!--- check for additional SE's on and change project status to completed table --->
<cfquery name="count_additional" datasource="SBSEFD">
SELECT count(*) as ctr_add
FROM dbo.Schedule
WHERE (DispatchID = '#form.DispatchID#') and (RID <> '#Form.RID#') and (Status <> 'Canceled')
</cfquery>

<cfoutput>
<cfif #count_additional.ctr_add# gt 0>
<!--- check for additional SE's on and change project status to completed table --->
<cfquery name="search_additional" datasource="SBSEFD">
SELECT *
FROM dbo.Schedule
WHERE (DispatchID = '#form.DispatchID#') and (RID <> '#Form.RID#') and (Status <> 'Canceled')
</cfquery>

<cfloop query="search_additional">
<!--- update TL status if any additional ones exist with the same dexterra dispatch--->
<cfquery name="updatestatus" datasource="SBSEFD">
UPDATE dbo.schedule SET TL='Y' WHERE RID='#search_additional.RID#'
</cfquery>

</cfloop>

</cfif>
</cfoutput>


<!--- Email SE confirmation --->
<cfmail from = "Dellmanagement@sbsplanet.com" To = "#SE_lookup.EmailAddress#" cc="DellManagement@SBSPlanet.com"
Subject = "Task List Submitted - (#Form.DispatchID#) #Form.OmniNum# - #Form.ProjectName# ">
   <cfmailpart 
      type="html">
	Thank you for submitting your Task List
   </cfmailpart>
</cfmail>
<center>
<br><br><br>
Thank you for submitting your Task list. You will recieve email confirmation shortly.
<br>
<a href="index.cfm">Engineer Portal Main</a>
</center>
<cfelse>
<br>
<center>
<span class="style2">Please correct the Tam Log field</span>.  <br>
Either enter the Tam Log Number or type in <span class="style1">none </span>if the customer declined.
<br>
<a href="javascript:history.go(-1)">GO BACK</a>
</center>
</cfif>

</body>

